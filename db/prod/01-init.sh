#!/bin/bash

# This script is supposed to run in the Postgres Docker container

echo "[+] Script starting at $(date)"

dataset_dir="$1"

if [[ -z "$dataset_dir" ]]; then
    dataset_dir="/docker-entrypoint-initdb.d/dataset/"
    echo "[+] Dataset directory not specified, using default"
fi

echo "[+] Using dataset directory: $dataset_dir"

if [[ -z "$POSTGRES_USER" ]] || [[ -z "$POSTGRES_DB" ]]; then
    echo "[!] Environment variables POSTGRES_USER and POSTGRES_DB must be set"
    exit 1
fi

cmd="psql --username $POSTGRES_USER -d $POSTGRES_DB -h localhost"

echo "Using command $cmd"

echo "[*] Inserting data into tables"
$cmd -c "\d"
$cmd -c "\COPY title_basics FROM '$dataset_dir/title.basics.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
$cmd -c "\COPY name_basics FROM '$dataset_dir/name.basics.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
$cmd -c "\COPY title_ratings FROM '$dataset_dir/title.ratings.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
$cmd -c "\COPY title_akas FROM '$dataset_dir/title.akas.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
$cmd -c "\COPY title_crew FROM '$dataset_dir/title.crew.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
$cmd -c "\COPY title_episode FROM '$dataset_dir/title.episode.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
$cmd -c "\COPY title_principals FROM '$dataset_dir/title.principals.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"

echo "[+] Done!"
printf "[+] Script done at %s. \n" "$(date)"
