# docker-wiki-family
Docker image hosting a [wiki family](https://www.mediawiki.org/wiki/Manual:Wiki_family) using Mediawiki and MySql

Sponsored by [FFA Private Bank](http://www.ffaprivatebank.com/)

## Usage
1. Copy `docker-compose.yml` to `docker-compose.override.yml` and override the `environment` and `volumes`
  * `wiki` service `environment`:
    * `NGINX_HOST` variable: _external_ hostname seen by the wiki users
    * `NGINX_PORT`: external port number seen by the wiki users
      * The nginx port number is hardcoded to be 80
      * This variable should be the same as in the `ports` section of the docker-compose file
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

## Adding a wiki to the family

Instructions below exemplified in [commit fdfe8f60](https://github.com/shadiakiki1986/docker-wiki-family/commit/fdfe8f604c4f999aa01f65c7f4ad043d3b3a02e8)

1. Add images folder
```
cd /data/docker-wiki-family/images/
sudo mkdir ffa_pb_kyc
sudo chown www-data:www-data ffa_pb_kyc -R
```

2. append to `initdb` service
  -  `cd build && echo 'create_db wiki_ffa_pb_kyc' >> initdb/entry.sh`
  - add to `initdb/docker-healthcheck` DBNAMES variable: `wiki_ffa_pb_kyc`
3. add in `wiki` service

  1. an entry to wiki/wiki-family-entrance-index.html
  2. `cp wiki/LocalSettings_ffa_pb_pnp.php wiki/LocalSettings_ffa_pb_kyc.php`
  3. Edit `wiki/LocalSettings_ffa_pb_kyc.php`
  4. Add to wiki/Dockerfile:
    - `cp LocalSettings_ffa_pb_kyc.php /usr/share/nginx/html/`
    - logo if different: `cp logo-ffa-pb.gif /usr/share/nginx/html/resources/assets/`
  5. Add to wiki/LocalSettings.php section about `LocalSettings_ffa_pb_kyc.php`
  6. Add to wiki/nginx-default.conf section for location of `ffa_pb_kyc`
    - Note two embeded locations there

4. Re-build services

```
./docker-compose.sh build initdb wiki
./docker-compose.sh up -d initdb
./docker-compose.sh up -d wiki
```

5. When done, run `bash tests.sh 8001`

## Import database
~~For a wiki without any images, it's easy to just use the `Import XML dump` method.~~
~~Otherwise, use the `Import db dump` method.~~

EDIT:

While migrating from mediawiki 1.21 to 1.28, I used the xml dump method, copied the images folder, and didn't see any images in the wiki.
So I resorted to the mysql db dump method.
However, I now realize that my problem was simply that I should have run `php wikifolder/maintenance/importImages.php wikifolder_backup/images --wiki wiki_ffa_pb_pnp` after copying the images files.
Anyway, keeping the import with the db dump import since it also imports the users with their passwords.

### Import XML dump
[docs](https://www.mediawiki.org/wiki/Manual:Restoring_a_wiki_from_backup#From_an_XML_dump)
```
CONTAINERID=`docker ps|grep wikifamily_wiki|awk '{print $1}'`
docker cp file.xml $CONTAINERID:/home/
./docker-compose.sh exec wiki bash
cd /usr/share/nginx/html/maintenance
php importDump.php --dbpass password --dbuser user --wiki wiki_ffa_pb_pmo /home/file.xml 
```

If the wiki database name does not start with `wiki_`, check the note in `LocalSettings.php` about "simulating calling url"

Even though `rebuildrecentchanges.php` does not take `--wiki wiki_dbname`, add it so that the command can tell which wiki family member to use.
- Otherwise, an error will be generated:
- `DBConnectionError from line 748 of /usr/share/nginx/html/includes/libs/rdbms/database/Database.php: Cannot access the database: Unknown database 'my_wiki' (db)`
- `php rebuildrecentchanges.php --wiki wiki_ffa_pb_pmo`

Open the wiki `Main Page`, go to history, and revert the most recent edit to see the most recent `Main Page` from the imported wiki

### Import mysql db dump
Follow instructions in [docs](https://www.mediawiki.org/wiki/Manual:Restoring_a_wiki_from_backup)
until `update.php`, which should be run as `php wikifolder/maintenance/update.php --wiki wiki_ffa_pn_pnp`
so that the proper wiki family member is selected.

## Access restrictions
Use [Extension:Restrict access by category and group](https://www.mediawiki.org/wiki/Extension:Restrict_access_by_category_and_group)

## Database backups
The docker images that already do this
- [nickbreen/docker-mysql-backup-cron](https://github.com/nickbreen/docker-mysql-backup-cron)
  - only does s3 backups
- [CANDY-LINE/docker-mysql-backup-cron](https://github.com/CANDY-LINE/docker-mysql-backup-cron)
  - this is fork of nickbreen's repo
  - does s3 as well as local and other options
- [fradelg/docker-mysql-cron-backup](https://github.com/fradelg/docker-mysql-cron-backup)
  - does local backups only
  - this seems to be the simplest of all, with 11 commits, so I will go with this
  - also has travis CI testing
  - docker image based on alpine
