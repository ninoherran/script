#!/bin/bash

pg_host=$1
GREEN='\033[0;32'

cd script

while ! pg_isready -h $pg_host 
do
    printf "."
    sleep 0.5
done

PGPASSWORD=test psql -h $pg_host -U postgres < ./migration/01_create_database.sql
PGPASSWORD=test psql -h $pg_host -U postgres -d testdb < ./migration/02_add_user.sql
PGPASSWORD=test psql -h $pg_host -U postgres -d testdb < ./migration/03_grant.sql
PGPASSWORD=test psql -h $pg_host -U testuser -d testdb < ./migration/04_create_table.sql

printf ">> Database migration has been completed"

exit 0