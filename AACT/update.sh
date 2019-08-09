#!/bin/bash
docker exec -w /scripts/ aact /scripts/apply_snapshot.sh 2>&1 | tee log.txt
