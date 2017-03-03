#!/bin/bash

# If the FFA RE database and archive table exist, then exit
echo "select 1 from archive limit 1;" | mysql -u root --password="$MYSQL_ROOT_PASSWORD" -h db -D wiki_ffa_re_pnp
if [ $? -eq 0 ]; then
  echo "It seems that the wiki family databases already exist .. aborting creation of databases/tables"
  exit 1
fi

# proceed with creation
mysql -u root --password="$MYSQL_ROOT_PASSWORD" -h db                    < /usr/src/initdb/create_mediawiki_databases.sql
mysql -u root --password="$MYSQL_ROOT_PASSWORD" -h db -D wiki_ffa_re_pnp < /usr/src/initdb/create_mediawiki_tables.sql
mysql -u root --password="$MYSQL_ROOT_PASSWORD" -h db -D wiki_ffa_pb_pnp < /usr/src/initdb/create_mediawiki_tables.sql
