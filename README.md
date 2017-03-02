# docker-wiki-family
Docker image hosting a [wiki family](https://www.mediawiki.org/wiki/Manual:Wiki_family) using Mediawiki and MySql

Sponsored by [FFA Private Bank](http://www.ffaprivatebank.com/)

## Usage
1. Copy `docker-compose.yml` to `docker-compose.override.yml` and override the `environment` and `volumes`
  * `wiki` service `environment`:
    * `NGINX_*` variables: hostname and port number to be used by nginx
    * `SMTP_*`: configuration to use for SMTP emails from the wikis
    * `MYSQL_ROOT_PASSWORD`: should be the same as the `db` service
    * `MW_SECRET`: this is mediawiki's [$wgSecretKey](https://www.mediawiki.org/wiki/Manual:$wgSecretKey). Set to a secret random string. Check the documentation for more info
  * `db` and `initdb` environment variable `MYSQL_ROOT_PASSWORD`: should be the same. Check documentation of the [mysql docker page](https://hub.docker.com/_/mysql/)
  * `db` volumes: folder to store database data permanently. Also check documentation of the [mysql docker page](https://hub.docker.com/_/mysql/)
2. `docker-compose up`
3. Wait a minute (or monitor the logs) while the database boots up
4. Browse to `http://hostname:port`

## Features
* emails via smtp/swiftmailer
* user `Shadi Akiki` is created by default, with email `s.akiki@ffaprivatebank.com`

## Testing
`bash tests.sh` and travis
