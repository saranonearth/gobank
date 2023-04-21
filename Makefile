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
server:
	npx kill-port 8080 && go run main.go
mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/saranonearth/gobank/db/sqlc Store
docker_build:
	docker rmi gobank && docker build -t gobank:latest .
docker_run:
	npx kill-port 8080 && docker run --network gobank-network -p 8080:8080 -e GIN_MODE=release  gobank:latest
compose_up:
	npx kill-port 8080 && docker compose up --build

.PHONY: compose_up dockerrun postgres createdb dropdb migrateup migratedown sqlc test server mock