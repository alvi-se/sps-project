package main

import (
	"fmt"

	"github.com/alvi-se/sps-project/internal/routes"
	"github.com/alvi-se/sps-project/pkg/models"
	"github.com/gin-gonic/gin"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

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
	db.First(&title).Preload("Ratings")

	fmt.Println("Title:", title.OriginalTitle)
	fmt.Println("Rating:", title.Ratings.AverageRating)



	router := gin.Default()
	router.LoadHTMLGlob("templates/**/*")

	routes.AddRoutes(router)

	router.Run()
}
