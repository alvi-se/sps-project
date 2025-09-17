/*
A separate file is to make indexes after the big amount of data is imported,
making it faster
*/

-- We're going to search only on primary_title for simplicity
CREATE INDEX idx_title_basics_primary_title ON title_basics (primary_title);

-- To make joins faster, we create an index for each foreign key
-- Also it's to make deletion faster, because of ON DELETE CASCADE
CREATE INDEX idx_title_ratings_tconst ON title_ratings (tconst);
CREATE INDEX idx_title_akas_title_id ON title_akas (title_id);
CREATE INDEX idx_title_crew_tconst ON title_crew (tconst);
CREATE INDEX idx_title_episode_parent_tconst ON title_episode (parent_tconst);
CREATE INDEX idx_title_principals_tconst ON title_principals (tconst);

