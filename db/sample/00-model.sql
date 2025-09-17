/*
Movies and TV Shows

title_type can be:
- movie
- short
- tvEpisode
- tvMiniSeries
- tvMovie
- tvSeries
- tvShort
- tvSpecial
- video
- videoGame

For tvSeries and tvMiniSeries, the end_year ca be NOT NULL. Also they can be joined with title_episode to get the episodes.
*/

-- Trigrams, to allow fuzzy search
CREATE EXTENSION pg_trgm;

CREATE TABLE title_basics (
    tconst TEXT PRIMARY KEY,
    title_type TEXT,
    primary_title TEXT,
    original_title TEXT,
    is_adult BOOLEAN,
    start_year SMALLINT,
    end_year SMALLINT,
    runtime_minutes INTEGER,
    genres TEXT
);

-- Actors
CREATE TABLE name_basics (
    nconst VARCHAR(10) PRIMARY KEY,
    primary_name TEXT,
    birth_year SMALLINT,
    death_year SMALLINT,
    primary_profession TEXT,
    known_for_titles TEXT
);

-- Reviews
CREATE TABLE title_ratings (
    tconst VARCHAR(10) PRIMARY KEY,
    average_rating NUMERIC,
    num_votes INTEGER,
    FOREIGN KEY (tconst) REFERENCES title_basics(tconst) ON DELETE CASCADE
);

-- Alternative titles for movies and TV shows
CREATE TABLE title_akas (
    title_id TEXT,
    ordering INTEGER,
    title TEXT,
    region TEXT,
    language TEXT,
    types TEXT,
    attributes TEXT,
    is_original_title BOOLEAN,
    FOREIGN KEY (title_id) REFERENCES title_basics(tconst) ON DELETE CASCADE
);

-- Crew
CREATE TABLE title_crew (
    tconst TEXT PRIMARY KEY,
    directors TEXT,
    writers TEXT,
    FOREIGN KEY (tconst) REFERENCES title_basics(tconst) ON DELETE CASCADE
);

-- Episodes of TV shows
CREATE TABLE title_episode (
    tconst TEXT PRIMARY KEY,
    parent_tconst TEXT,
    season_number INTEGER,
    episode_number INTEGER,
    FOREIGN KEY (parent_tconst) REFERENCES title_basics(tconst) ON DELETE CASCADE
);

-- Actors
CREATE TABLE title_principals (
    tconst TEXT,
    ordering INTEGER,
    nconst TEXT,
    category TEXT,
    job TEXT,
    characters TEXT,
    FOREIGN KEY (tconst) REFERENCES title_basics(tconst) ON DELETE CASCADE,
    FOREIGN KEY (nconst) REFERENCES name_basics(nconst) ON DELETE CASCADE
);
