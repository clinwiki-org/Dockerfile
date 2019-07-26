#!/bin/bash

# docker run -it --rm postgres:11.4 psql -h [hostname] -U postgres

if [ ! -f "clinical_trials.zip" ]; then
    ./download_aact_snapshot.sh
fi
if [ ! -f "clinical_trials.zip" ]; then
    echo "Failed to download zip"
    exit
fi

rm -rf /tmp/cdub/
mkdir -p /tmp/cdub/
cp clinical_trials.zip /tmp/cdub/
cd /tmp/cdub/
unzip clinical_trials.zip

# echo "DROP DATABASE aact; CREATE DATABASE aact; CREATE DATABASE aact_back" | psql -U postgres

pg_restore -e -v -O -x -U postgres -w --clean postgres_data.dmp
# --single-transaction

echo "alter role postgres in database aact set search_path=ctgov,public;" | psql -U postgres
