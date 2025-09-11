package models

import "database/sql"

// CREATE TABLE title_basics (tconst TEXT, titleType TEXT, primaryTitle TEXT, originalTitle TEXT, isAdult BOOLEAN, startYear SMALLINT, endYear SMALLINT, runtimeMinutes INTEGER, genres TEXT);

type TitleRatings struct {
	Tconst        string
	AverageRating float32
	NumVotes      int
}

type TitleBasic struct {
	Tconst         string
	TitleType      string
	PrimaryTitle   string
	OriginalTitle  string
	IsAdult        bool
	StartYear      sql.NullInt64
	EndYear        sql.NullInt64
	RuntimeMinutes sql.NullInt64
	Genres         sql.NullString
}
