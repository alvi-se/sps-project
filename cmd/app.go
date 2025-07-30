package main

import (
	"context"
	"log"

	"github.com/alvi-se/sps-project/internal/routes"
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
)

func main() {
	db, err := pgx.Connect(context.Background(), "host=localhost user=postgres password=postgres dbname=imdb port=5432 sslmode=disable TimeZone=Europe/Rome")

	if err != nil {
		log.Fatalln("Error connecting to the database:", err)
	}

	router := gin.Default()
	router.LoadHTMLGlob("templates/**/*")

	routes.InitController(db)
	routes.AddRoutes(router)

	router.Run()
}
