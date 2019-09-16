GOPATH:=$(shell go env GOPATH)
v ?= latest

.PHONY: build
build: 
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main main.go

.PHONY: docker
docker: build
	docker build . -t amazing_wiki:latest

.PHONY: push
push: build
	docker tag amazing_wiki hellodudu86/amazing_wiki:$(v)
	docker push hellodudu86/amazing_wiki:$(v)

.PHONY: run
run:
	docker run -it \
		-p 8181:8181 \
		-p 3306 \
		-e AMAZING_RUN_MODE=prod \
		-e AMAZING_DB_ADAPTER=mysql \
		-e AMAZING_DB_DATABASE=amazing_wiki \
		-e AMAZING_DB_HOST=host.docker.internal \
		-e AMAZING_DB_PASSWORD=  \
		-e AMAZING_CACHE=true \
		-e AMAZING_CACHE_PROVIDER=file \
		-e AMAZING_ENABLE_EXPORT=false \
		-v $(shell pwd)./conf/:/app/conf \
		-v $(shell pwd)./data/:/app/data \
		-v $(shell pwd)./uploads/:/app/uploads \
		-v $(shell pwd)./database/:/app/database \
		amazing_wiki
