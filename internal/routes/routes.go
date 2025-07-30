package routes

import (
	"context"
	"errors"
	"fmt"
	"log"

	"github.com/alvi-se/sps-project/pkg/models"
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
)

type RouteController struct {
	db *pgx.Conn
}

var controller *RouteController

func InitController(db *pgx.Conn) error {
	if db == nil {
		return fmt.Errorf("database connection is nil")
	}

	controller = &RouteController{db: db}
	return nil
}

func AddRoutes(r *gin.Engine) {
	r.GET("/", controller.Home)
	r.GET("/search", controller.Search)
	r.GET("/movies/:id", controller.Movie)
}

func (rc *RouteController) Home(c *gin.Context) {
	c.HTML(200, "pages/index.tmpl", gin.H{})
}

func (rc *RouteController) Search(c *gin.Context) {
	if query := c.Query("q"); query != "" {
		rows, err := controller.db.Query(context.Background(), `
			SELECT * FROM title_basics WHERE primary_title ILIKE '%' || $1 || '%'
			`, query)

		if err != nil {
			log.Println("Error searching titles:", err)
			c.HTML(500, "pages/500.tmpl", gin.H{})
			return
		}

		titles, err := pgx.CollectRows(rows, pgx.RowToStructByPos[models.TitleBasic])

		for _, value := range titles {
			log.Println(value)
		}

		if err != nil {
			log.Println("Error searching titles:", err)
			c.HTML(500, "pages/500.tmpl", gin.H{})
			return
		}

		c.HTML(200, "pages/search.tmpl", gin.H{"query": query, "titles": titles})
	} else {
		c.Redirect(302, "/")
	}
}

func (rc *RouteController) Movies(c *gin.Context) {
	// TODO
	log.Fatalln("Not implemented yet")
}

func (rc *RouteController) Movie(c *gin.Context) {
	id := c.Param("id")

	rows, err := rc.db.Query(
		context.Background(),
		"SELECT * FROM title_basics WHERE tconst = $1",
		id)

	if err != nil {
		log.Println("Error querying title:", err)
		c.HTML(500, "pages/500.tmpl", gin.H{})
		return
	}

	title, err := pgx.CollectExactlyOneRow(rows, pgx.RowToStructByPos[models.TitleBasic])

	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			c.HTML(404, "pages/404.tmpl", gin.H{})
		} else {
			log.Println("Error collecting title:", err)
			c.HTML(500, "pages/500.tmpl", gin.H{})
		}
		return
	}

	c.HTML(200, "pages/movie.tmpl", gin.H{"title": title})
}
