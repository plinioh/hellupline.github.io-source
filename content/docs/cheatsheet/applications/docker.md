---
title: Nginx
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## Run Container

```bash
docker container run --rm --interactive --tty --name=stuff \
    --volume="${PWD}:/data" \
    --network="my_net" \
    --publish="8080:80" \
    --env="CONFIG_VALUE=my-app" \
    --env-file="prod.env" \
    --workdir="/data" \
    alpine
```

## Build

```bash
docker build --tag my_registry/my_app:my_version --file ./Dockerfile ./
docker push my_registry/my_app:my_version

docker tag my_registry/my_app:my_version my_registry/my_app:latest
docker push my_registry/my_app:latest
```


### Multi-Stage Dockerfile

```dockerfile
FROM golang:1.13 as build

WORKDIR /app
COPY ./ ./
RUN go build -o my_app

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=builder /app/my_app ./
CMD ["./my_app"]
```


## Volumes

```bash
docker volume create my_volume
docker volume ls
docker volume rm my_volume
```


## Network

```bash
docker network create my_net
docker network ls
docker network rm my_net
```


## Running containers

```bash
docker container ls
docker container logs my_container
docker container exec -it my_container my_command
docker container attach my_container
```


## System

```bash
docker system events
docker system info
docker system prune --volumes --all
```


## Login to AWS ECR
```bash
$(aws ecr get-login --no-include-email)
```
