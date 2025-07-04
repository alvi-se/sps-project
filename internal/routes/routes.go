package routes

import (
	"github.com/gin-gonic/gin"
)

func AddRoutes(r *gin.Engine) {
	r.GET("/", Home)
	r.GET("/search", Search)
}

func Home(c *gin.Context) {
	c.HTML(200, "pages/index.tmpl", gin.H{})
}

func Search(c *gin.Context) {
	if query := c.Query("q"); query != "" {
		c.HTML(200, "pages/search.tmpl", gin.H{"query": query})
	} else {
		c.Redirect(302, "/")
	}
}
