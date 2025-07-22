package routes

import (
	"errors"
	"fmt"
	"log"

	"github.com/alvi-se/sps-project/pkg/models"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type RouteController struct {
	db *gorm.DB
}

var controller *RouteController

func InitController(db *gorm.DB) error {
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
	// TODO implement real search
	if query := c.Query("q"); query != "" {
		c.HTML(200, "pages/search.tmpl", gin.H{"query": query})
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

	var title *models.TitleBasic
	result := rc.db.First(&title, "tconst = ?", id)


	if result.Error != nil {
		// If the error is not a "record not found" error, log it
		if !errors.Is(result.Error, gorm.ErrRecordNotFound) {
			log.Printf("Error fetching movie with ID %s: %v", id, result.Error)
		}

		c.HTML(404, "pages/404.tmpl", gin.H{})
		return
	}

	c.HTML(200, "pages/movie.tmpl", gin.H{"title": title})
}
