#!/bin/bash

echo "initdb for wiki family databases"

create_db() {
  DBNAME=$1

  # If the database and archive table exist, then abort
  echo "select 1 from archive limit 1;" | mysql -u root --password="$MYSQL_ROOT_PASSWORD" -h db -D $DBNAME >> /dev/null
  if [ $? -eq 0 ]; then
    echo "Database for $DBNAME already exists .. skipping"
  else
    echo "Create database for $DBNAME ..."
    echo "CREATE DATABASE IF NOT EXISTS $DBNAME;" | mysql -u root --password="$MYSQL_ROOT_PASSWORD" -h db
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -h db -D $DBNAME < /usr/src/initdb/create_mediawiki_tables.sql
    echo " ... Done"
  fi
}

create_db wiki_ffa_re_pnp
create_db wiki_ffa_pb_pnp
create_db wiki_ffa_pb_kyc
