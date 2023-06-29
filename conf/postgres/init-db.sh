#!/bin/bash

export PGPASSWORD=testpassword

echo "Starting init-db.sh..."

# Create databases
echo "Creating databases..."
psql -h wso2am-postgresql-db-service -U postgres -c "CREATE DATABASE shared_db;"
psql -h wso2am-postgresql-db-service -U postgres -c "grant all privileges on database shared_db to postgres;"
psql -h wso2am-postgresql-db-service -U postgres -c "CREATE DATABASE apim_db;"
psql -h wso2am-postgresql-db-service -U postgres -c "grant all privileges on database apim_db to postgres;"

# Execute db scripts to create tables on PostgreSQL database
echo "Creating tables..."
psql -h wso2am-postgresql-db-service -U postgres -d shared_db -f /config/postgres_shared.sql
wait 10
psql -h wso2am-postgresql-db-service -U postgres -d apim_db -f /config/postgres_apim.sql

echo "Finished init-db.sh..."