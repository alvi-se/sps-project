------------------------------------------------------------------------
-- The full DB is ~20GB, I created this file for development purposes --
------------------------------------------------------------------------

INSERT INTO title_basics (tconst, title_type, primary_title, original_title, is_adult, start_year, end_year, runtime_minutes, genres) VALUES
('tt0000001', 'short', 'Carmencita', 'Carmencita', FALSE, 1894, NULL, 1, 'Documentary,Short'),
('tt0000002', 'short', 'Le clown et ses chiens', 'Le clown et ses chiens', FALSE, 1892, NULL, 5, 'Animation,Short'),
('tt0000003', 'short', 'Pauvre Pierrot', 'Pauvre Pierrot', FALSE, 1892, NULL, 4, 'Animation,Comedy,Short'),
('tt0000004', 'short', 'Un bon bock', 'Un bon bock', FALSE, 1892, NULL, 12, 'Animation,Short'),
('tt0000005', 'short', 'Blacksmith Scene', 'Blacksmith Scene', FALSE, 1893, NULL, 1, 'Comedy,Short'),
('tt0041038', 'tvSeries', 'The Twilight Zone', 'The Twilight Zone', FALSE, 1959, NULL, NULL, 'Fantasy,Horror,Sci-Fi'),
('tt0041102', 'tvEpisode', 'Where Is Everybody?', 'Where Is Everybody?', FALSE, 1959, NULL, 30, 'Fantasy,Horror,Sci-Fi'),
('tt0041109', 'tvEpisode', 'One for the Angels', 'One for the Angels', FALSE, 1959, NULL, 30, 'Fantasy,Horror,Sci-Fi'),
('tt0041116', 'tvEpisode', 'Mr. Denton on Doomsday', 'Mr. Denton on Doomsday', FALSE, 1959, NULL, 30, 'Fantasy,Horror,Sci-Fi'),
('tt0041123', 'tvEpisode', 'The Sixteen-Millimeter Shrine', 'The Sixteen-Millimeter Shrine', FALSE, 1959, NULL, 30, 'Fantasy,Horror,Sci-Fi'),
('tt0041130', 'tvEpisode', 'Walking Distance', 'Walking Distance', FALSE, 1959, NULL, 30, 'Fantasy,Horror,Sci-Fi');

INSERT INTO title_ratings (tconst, average_rating, num_votes) VALUES
('tt0000001', 5.8, 1400),
('tt0000002', 6.5, 117),
('tt0000003', 6.6, 797),
('tt0000004', 6.4, 78),
('tt0000005', 6.2, 163),
('tt0041038', 8.5, 50000),
('tt0041102', 8.1, 2000),
('tt0041109', 8.0, 1800),
('tt0041116', 8.3, 1900),
('tt0041123', 8.2, 1700),
('tt0041130', 8.4, 2100);

INSERT INTO name_basics (nconst, primary_name, birth_year, death_year, primary_profession, known_for_titles) VALUES
('nm0000001', 'Fred Astaire', 1899, 1987, 'actor,soundtrack,producer', 'tt0053133,tt0050419,tt0031983,tt0043044'),
('nm0000002', 'Lauren Bacall', 1924, 2014, 'actress,soundtrack', 'tt0038355,tt0071877,tt0046808,tt0117057'),
('nm0000003', 'Brigitte Bardot', 1934, NULL, 'actress,soundtrack,music_department', 'tt0057345,tt0049189,tt0054452,tt0060399'),
('nm0000004', 'John Belushi', 1949, 1982, 'actor,writer,soundtrack', 'tt0078723,tt0072562,tt0077975,tt0080455'),
('nm0000005', 'Ingmar Bergman', 1918, 2007, 'director,writer,actor', 'tt0050986,tt0069467,tt0083922,tt0060827'),
('nm0005690', 'Rod Serling', 1924, 1975, 'writer,director,creator', 'tt0041038,tt0052520,tt0053868,tt0055184'),
('nm1588970', 'Carmencita Performer', 1870, NULL, 'actor', 'tt0000001'),
('nm0721526', 'Clown Actor', 1880, NULL, 'actor', 'tt0000002,tt0000003');

INSERT INTO title_akas (title_id, ordering, title, region, language, types, attributes, is_original_title) VALUES
('tt0000001', 1, 'Carmencita', 'US', NULL, 'imdbDisplay', NULL, TRUE),
('tt0000001', 2, 'Carmencita - spanyol tánc', 'HU', NULL, 'alternative', NULL, FALSE),
('tt0000002', 1, 'Le clown et ses chiens', 'FR', NULL, 'imdbDisplay', NULL, TRUE),
('tt0000002', 2, 'Palhaços Doidos', 'BR', NULL, 'alternative', NULL, FALSE),
('tt0000003', 1, 'Pauvre Pierrot', 'FR', NULL, 'imdbDisplay', NULL, TRUE),
('tt0041038', 1, 'The Twilight Zone', 'US', NULL, 'imdbDisplay', NULL, TRUE),
('tt0041102', 1, 'Where Is Everybody?', 'US', NULL, 'imdbDisplay', NULL, TRUE),
('tt0041109', 1, 'One for the Angels', 'US', NULL, 'imdbDisplay', NULL, TRUE),
('tt0041116', 1, 'Mr. Denton on Doomsday', 'US', NULL, 'imdbDisplay', NULL, TRUE),
('tt0041123', 1, 'The Sixteen-Millimeter Shrine', 'US', NULL, 'imdbDisplay', NULL, TRUE),
('tt0041130', 1, 'Walking Distance', 'US', NULL, 'imdbDisplay', NULL, TRUE);

INSERT INTO title_crew (tconst, directors, writers) VALUES
('tt0000001', 'nm0005690', NULL),
('tt0000002', 'nm0005690', NULL),
('tt0000003', 'nm0005690', NULL),
('tt0000004', 'nm0005690', NULL),
('tt0000005', 'nm0005690', NULL);

INSERT INTO title_episode (tconst, parent_tconst, season_number, episode_number) VALUES
('tt0041102', 'tt0041038', '1', '1'),
('tt0041109', 'tt0041038', '1', '2'),
('tt0041116', 'tt0041038', '1', '3'),
('tt0041123', 'tt0041038', '1', '4'),
('tt0041130', 'tt0041038', '1', '5');

INSERT INTO title_principals (tconst, ordering, nconst, category, job, characters) VALUES
('tt0000001', 1, 'nm1588970', 'actor', NULL, 'Self'),
('tt0000001', 2, 'nm0005690', 'director', NULL, NULL),
('tt0000002', 1, 'nm0721526', 'actor', NULL, 'Clown'),
('tt0000002', 2, 'nm0005690', 'director', NULL, NULL),
('tt0000003', 1, 'nm0721526', 'actor', NULL, 'Pierrot');
