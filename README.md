# docker-ffa-wiki-family
WIP
Docker image hosting a [wiki family](https://www.mediawiki.org/wiki/Manual:Wiki_family) in FFA Private Bank

## Usage
1. Edit `build/wiki/default.conf` (nginx config) port number as desired
  * mirror in `docker-compose.yml/wiki/ports`
2. Edit the `wgServer` variable in `build/wiki/LocalSettings.php`
3. `docker-compose up`
