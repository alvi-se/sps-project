# Original script: https://gist.github.com/IllusiveMilkman/2a7a6614193c74804db7650f6d3c2bd2
#
#
# This script was intended to get raw IMDB datasets into Postgres
# The script worked on my mac setup.
#
# You may have to update your psql command with appropriate -U and -d flags and may have to 
# provide appropriate permissions to new folders.
#
# Customise as you see fit and for your setup.
#
# Tables are NOT optomised, nor have any indexes been created
# The point is to "just get the data into Postgres"
#
# Remember to allow execution rights before trying to run it:
# chmod 755 imdb_postgres_setup.sh
#
# Just for interest's sake, below are the terminal commands for my Linux box:
# su - postgres
# curl -O https://gist.githubusercontent.com/IllusiveMilkman/2a7a6614193c74804db7650f6d3c2bd2/raw/c8c0b4dbac00cf7539dd5cc9670fe00b38430f7d/imdb_postgres_setup.sh
# chmod 755 imdb_postgres_setup.sh
# ./imdb_postgres_setup.sh
#
# If you don't know the password for postgres (new install, some default VM setups, etc)
# sudo passwd postgres
# set a new password, then continue above
#

printf "Script starting at %s. \n" "$(date)"

printf "Removing old folders \n"
rm -rf imdb-datasets/

printf "Creating new folders \n"
mkdir imdb-datasets/

printf "Downloading datasets from https://datasets.imdbws.com \n"
cd imdb-datasets
curl -O https://datasets.imdbws.com/name.basics.tsv.gz
curl -O https://datasets.imdbws.com/title.akas.tsv.gz
curl -O https://datasets.imdbws.com/title.basics.tsv.gz
curl -O https://datasets.imdbws.com/title.crew.tsv.gz
curl -O https://datasets.imdbws.com/title.episode.tsv.gz
curl -O https://datasets.imdbws.com/title.principals.tsv.gz
curl -O https://datasets.imdbws.com/title.ratings.tsv.gz

printf "Unzipping datasets... \n"
gzip -dk *.gz
cd ..

cmd=(psql -U postgres)

printf "Creating Database \n"
cmd -d 'postgres' -c "DROP DATABASE IF EXISTS imdb;"
cmd -d 'postgres' -c "CREATE DATABASE imdb;"

printf "Creating tables in imdb database \n"
cmd -d imdb -c "CREATE TABLE title_ratings (tconst VARCHAR(10), average_rating NUMERIC, num_votes INTEGER);"
cmd -d imdb -c "CREATE TABLE name_basics (nconst VARCHAR(10), primary_name TEXT, birth_year SMALLINT, death_year SMALLINT, primary_profession TEXT, known_for_titles TEXT);"
cmd -d imdb -c "CREATE TABLE title_akas (title_id TEXT, ordering INTEGER, title TEXT, region TEXT, language TEXT, types TEXT, attributes TEXT, is_original_title BOOLEAN);"
cmd -d imdb -c "CREATE TABLE title_basics (tconst TEXT, title_type TEXT, primary_title TEXT, original_title TEXT, is_adult BOOLEAN, start_year SMALLINT, end_year SMALLINT, runtime_minutes INTEGER, genres TEXT);"
cmd -d imdb -c "CREATE TABLE title_crew (tconst TEXT, directors TEXT, writers TEXT);"
cmd -d imdb -c "CREATE TABLE title_episode (tconst TEXT, parent_tconst TEXT, season_number TEXT, episode_number TEXT);"
cmd -d imdb -c "CREATE TABLE title_principals (tconst TEXT, ordering INTEGER, nconst TEXT, category TEXT, job TEXT, characters TEXT);"

printf "Inserting data into tables \n"
cmd -d imdb -c "COPY title_ratings FROM '$(pwd)/imdb-datasets/title.ratings.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
cmd -d imdb -c "COPY name_basics FROM '$(pwd)/imdb-datasets/name.basics.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
cmd -d imdb -c "COPY title_akas FROM '$(pwd)/imdb-datasets/title.akas.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
cmd -d imdb -c "COPY title_basics FROM '$(pwd)/imdb-datasets/title.basics.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
cmd -d imdb -c "COPY title_crew FROM '$(pwd)/imdb-datasets/title.crew.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
cmd -d imdb -c "COPY title_episode FROM '$(pwd)/imdb-datasets/title.episode.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
cmd -d imdb -c "COPY title_principals FROM '$(pwd)/imdb-datasets/title.principals.tsv' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"

printf "Done! \n"
printf "Script done at %s. \n" "$(date)"
