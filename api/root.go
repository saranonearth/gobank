package api

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

func (server *Server) root(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, gin.H{"status": "up", "timestamp": time.Now()})
}
