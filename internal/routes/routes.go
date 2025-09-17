package routes

import (
	"context"
	"errors"
	"fmt"
	"log"
	"strconv"
	"time"

	"github.com/alvi-se/sps-project/internal/models"
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

type RouteController struct {
	db *pgxpool.Pool
}

var controller *RouteController

func InitController(db *pgxpool.Pool) error {
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
		page := c.DefaultQuery("page", "1")
		pageInt, err := strconv.Atoi(page)

		if err != nil {
			log.Println("Error parsing page number:", err)
			c.HTML(400, "pages/400.tmpl", gin.H{})
			return
		}

		offset := (pageInt - 1) * 10

		ctx, cancel := context.WithTimeout(context.Background(), 10 * time.Second)
		defer cancel()

		rows, err := controller.db.Query(ctx, `
			SELECT * FROM title_basics
			WHERE primary_title % $1
			ORDER BY SIMILARITY(primary_title, $1) DESC
			LIMIT 10
			OFFSET $2
			`, query, offset)

		if err != nil {
			log.Println("Error searching titles:", err)
			c.HTML(500, "pages/500.tmpl", gin.H{})
			return
		}

		titles, err := pgx.CollectRows(rows, pgx.RowToStructByPos[models.TitleBasic])

		if err != nil {
			log.Println("Error searching titles:", err)
			c.HTML(500, "pages/500.tmpl", gin.H{})
			return
		}

		c.HTML(200, "pages/search.tmpl", gin.H{
			"query":    query,
			"titles":   titles,
			"page":     pageInt,
			"prevPage": pageInt - 1,
			"nextPage": pageInt + 1,
		})
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
