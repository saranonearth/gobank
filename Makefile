postgres: 
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_PASSWORD=root -e POSTGRES_USER=root -d postgres:12-alpine
createdb:
	docker exec -it postgres12 createdb --username=root --owner=root gobank
dropdb:
	docker exec -it postgres12 dropdb
migrateup:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/gobank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/gobank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test