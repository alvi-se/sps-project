set dotenv-load

run:
    go run cmd/app.go

dev:
    docker compose -f docker-compose.dev.yaml up -d

prod:
    docker compose up -d

minikube:
    eval $(minikube docker-env)

kube:
    helm upgrade --install sps-project ./helm-chart

download:
    ./scripts/download-dataset.sh

build:
    docker buildx build -t ghcr.io/alvi-se/sps-project:latest .

publish:
    docker push ghcr.io/alvi-se/sps-project:latest

