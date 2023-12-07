#!/bin/sh
# Write a shell script which takes the database name and the script file as
# parameters and restores the database from the sql file.


if [ -f $2 ]; then
    dbname=$(mysql -e "SELECT SCHEMA_NAME FROM information_schema.SCHEMATA WHERE SCHEMA_NAME = '$1'" | grep $1)
    # Create database if it doesn't exist
    if [ "$1" != "$dbname" ]; then
        echo "Created DB as it didn't exist"
        mysql -e "Create database $1"
    fi
    # Restore database from sql file
    mysql -e "use $1"
    mysql $1 < $2
else
    echo "File doesn't exist"
fi