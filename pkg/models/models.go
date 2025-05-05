package models

// CREATE TABLE title_basics (tconst TEXT, titleType TEXT, primaryTitle TEXT, originalTitle TEXT, isAdult BOOLEAN, startYear SMALLINT, endYear SMALLINT, runtimeMinutes INTEGER, genres TEXT);

type Ratings struct {
	Tconst        string
	AverageRating float32
	NumVotes      int
}

type TitleBasic struct {
	Tconst         string `gorm:"primaryKey"`
	TitleType      string `gorm:"column:titletype"`
	PrimaryTitle   string `gorm:"column:primarytitle"`
	OriginalTitle  string `gorm:"column:originaltitle"`
	IsAdult        bool   `gorm:"column:isadult"`
	StartYear      int
	EndYear        int
	RuntimeMinutes int
	Genres         string
	// Ratings			Ratings
}
