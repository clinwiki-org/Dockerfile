from postgres:11.4

ENV BASE_URL=https://aact.ctti-clinicaltrials.org/static/static_db_copies/daily/
ENV SHELL bash

# SEE https://hub.docker.com/_/postgres/
# section: initialization scripts
COPY download_aact_snapshot.sh /
copy apply_snapshot.sh /docker-entrypoint-initdb.d/

run apt update && \
    apt install curl unzip && \
    apt clean

