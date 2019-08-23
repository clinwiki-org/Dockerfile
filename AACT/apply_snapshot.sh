#!/bin/bash

# docker run -it --rm postgres:11.4 psql -h [hostname] -U postgres

if [ ! -f "clinical_trials.zip" ]; then
    ./download_aact_snapshot.sh
fi
if [ ! -f "clinical_trials.zip" ]; then
    echo "Failed to download zip"
    exit
fi

if zipinfo clinical_trials.zip > /dev/null; then
   echo Valid
else
   echo Invalid zip
   exit
fi

rm -rf /tmp/cdub/
mkdir -p /tmp/cdub/
mv clinical_trials.zip /tmp/cdub/
cd /tmp/cdub/
unzip clinical_trials.zip

# echo "DROP DATABASE aact; CREATE DATABASE aact; CREATE DATABASE aact_back" | psql -U postgres
echo "select pg_terminate_backend(pid) from pg_stat_activity where datname='aact';DROP DATABASE aact; CREATE DATABASE aact;" | psql -U clinwiki

time pg_restore -e -v -O -x -U clinwiki -w -d aact postgres_data.dmp
# --single-transaction

echo "alter role clinwiki in database aact set search_path=ctgov,public;" | psql -U clinwiki
