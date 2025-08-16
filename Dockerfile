FROM golang:1.25-alpine AS builder

RUN ["mkdir", "-p", "/app"]
WORKDIR /app

# Cache dependencies
COPY go.mod go.sum ./
RUN ["go", "mod", "download"]

# Build the application
COPY . .
RUN ["go", "build", "-o", "/app/imdb", "./cmd/app.go"]


FROM alpine:latest AS runtime

RUN ["mkdir", "-p", "/app"]
WORKDIR /app

COPY --from=builder /app/imdb ./
COPY ./templates ./templates

LABEL org.opencontainers.image.source=https://github.com/alvi-se/sps-project

ENTRYPOINT ["/app/imdb"]

