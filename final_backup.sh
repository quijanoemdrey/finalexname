#!/bin/sh

#To start the final backup
echo "starting final backup"
day="$(date +'%A')"
db_backup="mydb_${day}.sql"
sudo mysqldump  -udbuser -pdbpass --no-tablespaces dbname  >/home/${db_backup}
echo "final backup complete"