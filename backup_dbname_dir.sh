#!/bin/sh
# Create a shell script which takes the database name and back up directory
# as parameters and backs up the database as dbname_date.sql
# in the backup directory. If the database doesn’t exist,
# it should display appropriate message. If the backup dir doesn’t exist,
# it should create one.


# Create variable to store database name
dbname=$(mysql -e "SELECT SCHEMA_NAME FROM information_schema.SCHEMATA WHERE SCHEMA_NAME = '$1'" | grep $1)

# Create backup directory if it's not exist
if [ ! -d $2 ]; then
    mkdir $2
fi

# Store backup to destination directory with format db_name-date.sql
if [ "$1" = "$dbname" ]; then
    sqlfile=$2/$1-$(date +%d-%m-%Y).sql
    if mysqldump $1 > $sqlfile ; then
    echo 'Sql dump created'
    else
        echo 'Error creating backup!'
    fi
else
    echo "Database doesn't exist"
fi