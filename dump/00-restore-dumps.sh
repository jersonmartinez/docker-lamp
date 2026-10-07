#!/bin/sh
# docker-entrypoint-initdb.d wrapper — runs ONCE, inside the DB container, only
# when the data volume is empty (standard initdb behaviour). It restores every
# *.sql found under ./dump/sql, normalising MySQL-8 collations to the engine's
# native collation so foreign keys form when a MySQL dump is loaded on MariaDB.
#
# Why a wrapper instead of dropping dumps straight into this directory:
#   * the entrypoint runs top-level *.sql verbatim and does NOT recurse into
#     subdirectories, so a nested path silently never loads;
#   * a MySQL-8 dump (utf8mb4_0900_ai_ci) fails on MariaDB with errno 150
#     ("foreign key incorrectly formed") because MariaDB's native collation is
#     utf8mb4_uca1400_ai_ci — the parent/child column collations differ.
# Putting dumps in ./dump/sql/ (ignored by the entrypoint) and importing them
# through this single controlled script fixes both at once.
#
# NON-DESTRUCTIVE: no DROP DATABASE/TABLE here. A mysqldump already carries its
# own `DROP TABLE IF EXISTS` per table (idempotent restore of its own objects).
# Collation rewriting is anchored on `COLLATE=`, so only DDL changes, never row
# content.
set -eu

SQL_DIR=/docker-entrypoint-initdb.d/sql
DB="${MYSQL_DATABASE:-${MARIADB_DATABASE:-}}"
[ -n "$DB" ] || { echo "[restore] no MYSQL_DATABASE set; skipping"; exit 0; }
[ -d "$SQL_DIR" ] || { echo "[restore] $SQL_DIR absent; nothing to import"; exit 0; }

# client + native collation (MariaDB needs UCA; MySQL keeps the dump's own)
BIN=mysql; command -v mariadb >/dev/null 2>&1 && BIN=mariadb
COLL=""
case "$("$BIN" --version 2>/dev/null)" in *MariaDB*) COLL=utf8mb4_uca1400_ai_ci ;; esac

# init scripts connect as root over the local socket (no password needed here)
found=0
for f in $(find "$SQL_DIR" -type f -name '*.sql' | sort); do
  found=1
  echo "[restore] importing $f -> $DB"
  if [ -n "$COLL" ]; then
    sed -e "s/COLLATE=utf8mb4_0900_ai_ci/COLLATE=$COLL/g" \
        -e 's/COLLATE=utf8mb4_0900_as_cs/COLLATE=utf8mb4_uca1400_as_cs/g' \
        -e 's/COLLATE=utf8mb4_0900_bin/COLLATE=utf8mb4_bin/g' "$f" | "$BIN" "$DB"
  else
    "$BIN" "$DB" <"$f"
  fi
done
[ "$found" = 1 ] || echo "[restore] no *.sql under $SQL_DIR"
echo "[restore] done"
