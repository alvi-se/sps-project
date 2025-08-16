FROM golang:1.25-alpine AS builder

RUN ["go", "build", "-o /bin/imdb" "./cmd/main.go"]


FROM alpine:latest AS runtime

COPY --from=builder /bin/imdb /bin/imdb

LABEL org.opencontainers.image.source=https://github.com/alvi-se/sps-project

ENTRYPOINT ["/bin/imdb"]

