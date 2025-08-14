#!/bin/bash

echo "[+] Script starting at $(date)"

$dataset_dir="$1"

if [[ -z "$dataset_dir" ]]; then
    echo "[+] Dataset directory not specified, using ./prod/dataset/"
    dataset_dir="./prod/dataset"
    mkdir -p "$dataset_dir"
else
    echo "[+] Using dataset directory: $dataset_dir"
fi

echo "[*] Downloading datasets from https://datasets.imdbws.com"
cd $dataset_dir
curl -O https://datasets.imdbws.com/name.basics.tsv.gz
curl -O https://datasets.imdbws.com/title.akas.tsv.gz
curl -O https://datasets.imdbws.com/title.basics.tsv.gz
curl -O https://datasets.imdbws.com/title.crew.tsv.gz
curl -O https://datasets.imdbws.com/title.episode.tsv.gz
curl -O https://datasets.imdbws.com/title.principals.tsv.gz
curl -O https://datasets.imdbws.com/title.ratings.tsv.gz

echo "[*] Unzipping datasets..."

gzip -dk *.gz

echo "[*] Removing .gz files..."
rm *.gz

echo "[+] Script finished at $(date)"
