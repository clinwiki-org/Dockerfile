#!/bin/bash

# docker run -it --rm postgres:11.4 psql -h [hostname] -U postgres

if [ ! -f "clinical_trials.zip" ]; then
    ./download_aact_snapshot.sh
fi

echo "DROP DATABASE aact; CREATE DATABASE aact" | psql -U postgres
unzip clinical_trials.zip

pg_restore -e -v -O -x --dbname=aact --no-owner --clean --create postgres_data.dmp

echo "alter role postgres in database aact set search_path=ctgov,public;" | psql -U postgres
