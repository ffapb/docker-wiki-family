#!/bin/bash
mysql -u root --password="$MYSQL_ROOT_PASSWORD" -h db                    < /usr/src/initdb/create_mediawiki_databases.sql
mysql -u root --password="$MYSQL_ROOT_PASSWORD" -h db -D wiki_ffa_re_pnp < /usr/src/initdb/create_mediawiki_tables.sql
mysql -u root --password="$MYSQL_ROOT_PASSWORD" -h db -D wiki_ffa_pb_pnp < /usr/src/initdb/create_mediawiki_tables.sql
