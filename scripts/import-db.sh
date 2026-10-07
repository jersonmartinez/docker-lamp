#!/usr/bin/env bash
#
# import-db.sh — robust, non-destructive database import for a running
# docker-lamp stack.
#
# Fixes the known friction points when restoring a mysqldump:
#   * nested / arbitrarily-named dump paths  -> auto-resolved (newest *.sql)
#   * a MySQL-8 dump restored on MariaDB     -> collation normalised so FKs form
#   * the app recreating tables mid-import   -> web service quiesced during load
#   * "did it actually load?"                -> table count + row report validated
#
# NON-DESTRUCTIVE: this script issues NO `DROP DATABASE` / `DROP TABLE`. A
# mysqldump already carries its own `DROP TABLE IF EXISTS` per table, so running
# it is an idempotent restore of exactly the objects it defines — nothing else
# is touched. Collation rewriting is anchored on the `COLLATE=` keyword, so it
# only ever changes DDL, never row content.
#
# Usage:
#   scripts/import-db.sh [--dump PATH] [--project NAME]
#                        [--db-service db] [--web-service www]
#                        [--expect-tables N] [--no-stop-web]
#
# Defaults come from ./.env (MYSQL_DATABASE, MYSQL_ROOT_PASSWORD) and the
# compose project name (defaults to the directory name; pass --project for a
# stack started with `docker compose -p <name>`).
set -euo pipefail

here="$(cd "$(dirname "$0")/.." && pwd)"
cd "$here"

# --- defaults ---------------------------------------------------------------
PROJECT="${COMPOSE_PROJECT_NAME:-$(basename "$here")}"
DB_SERVICE="db"
WEB_SERVICE="www"
DUMP=""
EXPECT_TABLES=""
STOP_WEB=1

env_get() { grep -E "^$1=" .env 2>/dev/null | tail -1 | cut -d= -f2-; }
DB_NAME="$(env_get MYSQL_DATABASE)"
ROOT_PW="$(env_get MYSQL_ROOT_PASSWORD)"

while [ $# -gt 0 ]; do
  case "$1" in
    --dump) DUMP="$2"; shift 2;;
    --project) PROJECT="$2"; shift 2;;
    --db-service) DB_SERVICE="$2"; shift 2;;
    --web-service) WEB_SERVICE="$2"; shift 2;;
    --expect-tables) EXPECT_TABLES="$2"; shift 2;;
    --no-stop-web) STOP_WEB=0; shift;;
    -h|--help) sed -n '2,33p' "$0"; exit 0;;
    *) echo "unknown arg: $1" >&2; exit 2;;
  esac
done

[ -n "$DB_NAME" ] || { echo "ERROR: MYSQL_DATABASE not found in .env" >&2; exit 1; }

dc() { docker compose -p "$PROJECT" "$@"; }
cid() { dc ps -q "$1" 2>/dev/null; }

# --- 1. resolve the dump (flatten nested paths) -----------------------------
if [ -z "$DUMP" ]; then
  DUMP="$(find dump -type f -name '*.sql' -printf '%T@ %p\n' 2>/dev/null \
          | sort -nr | head -1 | cut -d' ' -f2-)"
fi
[ -n "$DUMP" ] && [ -f "$DUMP" ] || {
  echo "ERROR: no dump found under ./dump — pass --dump PATH." >&2; exit 1; }

DBID="$(cid "$DB_SERVICE")"
[ -n "$DBID" ] || {
  echo "ERROR: db service '$DB_SERVICE' not running under project '$PROJECT'." >&2
  echo "       start the stack first:  docker compose -p $PROJECT up -d" >&2
  exit 1; }

# pick the client that exists in the db image (mariadb or mysql)
CLIENT=""
for b in mariadb mysql; do
  if docker exec -i "$DBID" sh -c "command -v $b" >/dev/null 2>&1; then CLIENT="$b"; break; fi
done
[ -n "$CLIENT" ] || { echo "ERROR: neither mariadb nor mysql client in db container." >&2; exit 1; }

q() { docker exec -i "$DBID" "$CLIENT" -uroot -p"$ROOT_PW" -N "$@" 2>/dev/null; }

echo "dump:      $DUMP ($(du -h "$DUMP" | cut -f1))"
echo "database:  $DB_NAME"
echo "project:   $PROJECT"
echo "client:    $CLIENT"

# --- 2. detect engine + target collation ------------------------------------
VER="$(q -e 'SELECT VERSION();')"
case "$VER" in
  *MariaDB*) COLL="utf8mb4_uca1400_ai_ci" ;;  # MariaDB native UCA collation
  *)         COLL="" ;;                        # MySQL: dump collation is native
esac
echo "engine:    $VER"
if [ -n "$COLL" ]; then
  echo "normalise: COLLATE=utf8mb4_0900_* -> $COLL (MySQL-8 dump on MariaDB)"
else
  echo "normalise: none (native engine)"
fi

# --- 3. quiesce the web app so it cannot recreate tables mid-import ----------
RESTART_WEB=0
if [ "$STOP_WEB" = 1 ] && [ -n "$(cid "$WEB_SERVICE")" ]; then
  echo "stopping:  $WEB_SERVICE (prevents table re-creation during load)"
  dc stop "$WEB_SERVICE" >/dev/null
  RESTART_WEB=1
fi

# --- 4. import (collation-normalised, idempotent via the dump's own DROPs) ---
echo "importing... (this can take a while for large dumps)"
err="$(mktemp)"
if [ -n "$COLL" ]; then
  sed -e 's/COLLATE=utf8mb4_0900_ai_ci/COLLATE=utf8mb4_uca1400_ai_ci/g' \
      -e 's/COLLATE=utf8mb4_0900_as_cs/COLLATE=utf8mb4_uca1400_as_cs/g' \
      -e 's/COLLATE=utf8mb4_0900_bin/COLLATE=utf8mb4_bin/g' "$DUMP" \
    | docker exec -i "$DBID" "$CLIENT" -uroot -p"$ROOT_PW" "$DB_NAME" 2>"$err"
else
  docker exec -i "$DBID" "$CLIENT" -uroot -p"$ROOT_PW" "$DB_NAME" <"$DUMP" 2>"$err"
fi
if [ -s "$err" ]; then
  echo "IMPORT ERRORS:" >&2; sed 's/^/  /' "$err" | head -20 >&2
  rm -f "$err"
  [ "$RESTART_WEB" = 1 ] && dc start "$WEB_SERVICE" >/dev/null
  exit 1
fi
rm -f "$err"

# --- 5. restart web ---------------------------------------------------------
[ "$RESTART_WEB" = 1 ] && { echo "starting:  $WEB_SERVICE"; dc start "$WEB_SERVICE" >/dev/null; }

# --- 6. validate ------------------------------------------------------------
TBLS="$(q -e "SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME';")"
echo
echo "RESULT: $TBLS table(s) in '$DB_NAME'"
q "$DB_NAME" -e "SELECT TABLE_NAME, TABLE_ROWS FROM information_schema.TABLES \
                 WHERE TABLE_SCHEMA='$DB_NAME' ORDER BY TABLE_NAME;" \
  | awk 'NF{printf "  %-34s ~%s rows\n",$1,$2}'
if [ -n "$EXPECT_TABLES" ] && [ "$TBLS" != "$EXPECT_TABLES" ]; then
  echo "WARNING: expected $EXPECT_TABLES tables, found $TBLS" >&2
  exit 1
fi
echo "OK"
