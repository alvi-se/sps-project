package main

import (
	"context"
	"log"
	"os"
	"time"

	"github.com/alvi-se/sps-project/internal/routes"
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
)

func main() {
	dbUrl := os.Getenv("POSTGRES_URL")

	log.Println("Connecting to database...")
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	db, err := pgx.Connect(ctx, dbUrl)

	if err != nil {
		log.Fatalln("Error connecting to the database:", err)
	} else {
		log.Println("Connected to the database")
	}

	router := gin.Default()
	router.LoadHTMLGlob("templates/**/*")

	routes.InitController(db)
	routes.AddRoutes(router)

	log.Println("Starting server on port 8080")
	router.Run()
}
