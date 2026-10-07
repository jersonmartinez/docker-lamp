# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- `DB_IMAGE` variable to select the database engine image without editing the
  compose file (defaults to `mysql:8.0`; set `mariadb:11.4` for MariaDB apps)
- `MYSQL_HOST` to `.env.example` (it was referenced by `docker-compose.yml`
  but missing from the example — environment drift)
- Apache `AllowOverride All` + `Require all granted` for `/var/www/html/` and a
  global `ServerName`, so `.htaccess` rewrite rules of hosted apps are honored
- README "Serving Your Own Application" section (code location, bind mount,
  `:ro` vs `:rw`, DB connection mapping, MySQL vs MariaDB, DB seeding)
- Inline note on the `www` docroot mount explaining `:ro` vs `:rw`

### Changed
- Removed the obsolete top-level `version:` key from `docker-compose.yml`
  (deprecated in Compose v2+ and emits a warning)

### Fixed
- Dropped the `--default-authentication-plugin=mysql_native_password` command
  from the `db` service — it is MySQL-only and prevents the service from
  starting under a MariaDB image

## [1.1.0] - 2025-02-26

### Added
- Dark/Light mode toggle with smooth transitions
- Modern UI with Bootstrap 5.3
- Social media links (GitHub and YouTube)
- Tooltips for better user experience
- Professional documentation with screenshots
- Infrastructure diagram
- Author attribution with LinkedIn profile
- Responsive design improvements

### Changed
- Updated PHP version to 8.2.27
- Enhanced README.md with comprehensive documentation
- Improved code organization and structure
- Translated interface to English
- Modernized status cards design
- Enhanced table styling for person records

### Fixed
- Database connection status indicator
- Service status icons alignment
- Mobile responsiveness issues
- Theme persistence across page reloads

## [1.0.0] - Initial Release

### Added
- Basic LAMP stack implementation
- Docker configuration
- MySQL database integration
- PHPMyAdmin setup
- Basic web interface
