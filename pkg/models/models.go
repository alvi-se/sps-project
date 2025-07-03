package models

// CREATE TABLE title_basics (tconst TEXT, titleType TEXT, primaryTitle TEXT, originalTitle TEXT, isAdult BOOLEAN, startYear SMALLINT, endYear SMALLINT, runtimeMinutes INTEGER, genres TEXT);

type Ratings struct {
	Tconst        string `gorm:"primaryKey;column:tconst"`
	AverageRating float32
	NumVotes      int
}

type TitleBasic struct {
	Tconst         string  `gorm:"primaryKey"`
	TitleType      string 
	PrimaryTitle   string
	OriginalTitle  string
	IsAdult        bool
	StartYear      int  
	EndYear        int  
	RuntimeMinutes int  
	Genres         string 
	Ratings        Ratings `gorm:"foreignKey:Tconst"`
}
