# docker-wiki-family
Docker image hosting a [wiki family](https://www.mediawiki.org/wiki/Manual:Wiki_family) using Mediawiki and MySql

Sponsored by [FFA Private Bank](http://www.ffaprivatebank.com/)

## Usage
1. Edit `build/wiki/nginx-default.conf` port number as desired
  * mirror in `docker-compose.yml/wiki/ports`
2. Edit the `wgServer` variable in `build/wiki/LocalSettings.php`
3. Copy `docker-compose.yml` to `docker-compose.override.yml` with only the env var sections with your own values
4. `docker-compose up`
5. Browse to `http://localhost:port`

## Features
* emails via smtp/swiftmailer
* user `Shadi Akiki` is created by default, with email `s.akiki@ffaprivatebank.com`

## Testing
`bash tests.sh` and travis
