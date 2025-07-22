package main

import (
	"log"

	"github.com/alvi-se/sps-project/internal/routes"
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
		log.Fatalln("Error connecting to the database:", dbErr)
	}

	router := gin.Default()
	router.LoadHTMLGlob("templates/**/*")

	routes.InitController(db)
	routes.AddRoutes(router)

	router.Run()
}
