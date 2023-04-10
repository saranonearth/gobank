package main

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
	"github.com/saranonearth/gobank/api"
	db "github.com/saranonearth/gobank/db/sqlc"
	"github.com/saranonearth/gobank/utils"
)

func main() {
	config, err := utils.LoadConfig(".")
	if err != nil {
		log.Fatal("Can not load config", err)
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("Can not connect to DB")
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(config.ServerAddress)

	if err != nil {
		log.Fatal("Can not start server", err)
	}

}
