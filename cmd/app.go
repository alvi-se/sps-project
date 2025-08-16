package main

import (
	"context"
	"log"
	"os"

	"github.com/alvi-se/sps-project/internal/routes"
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
)

func main() {
	dbUrl := os.Getenv("POSTGRES_URL")

	db, err := pgx.Connect(context.Background(), dbUrl)

	if err != nil {
		log.Fatalln("Error connecting to the database:", err)
	}

	router := gin.Default()
	router.LoadHTMLGlob("templates/**/*")

	routes.InitController(db)
	routes.AddRoutes(router)

	router.Run()
}
