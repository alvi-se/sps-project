package main

import "fmt"
import "gorm.io/gorm"
import "gorm.io/driver/postgres"
import "github.com/alvi-se/sps-project/pkg/models"

func main() {
	db, dbErr := gorm.Open(
		postgres.Open("host=localhost user=postgres password=postgres dbname=imdb port=5432 sslmode=disable TimeZone=Europe/Rome"),
		&gorm.Config{},
	)

	if dbErr != nil {
		fmt.Println("Error connecting to the database:", dbErr)
		return
	}

	var title models.TitleBasic
	db.First(&title)

	fmt.Println("Title:", title.OriginalTitle)
}
