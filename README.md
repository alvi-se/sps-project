# Software Performance and Scalability Project
Author: Alvise Favero -- 888851

Academic Year: 2024/2025

## Build Requirements
- curl
- Go
- Docker
  - Docker Compose
  - Docker Buildx
- [just](https://github.com/casey/just)

If the app is to be deployed on Kubernetes, then a Kubernetes environment is needed.
In this case then, further build requirements are:
- kubectl
- Helm

## Development
Run the following commands to have the development app running:
```sh
# Development DB
just dev
# Go app
just run
```

## Production
The production version downloads the full IMDb dataset and imports it into a Postgres container.
The dataset is downloaded on the host machine (`./scripts/download-dataset.sh`). This is to allow caching it.
Then the folder in which it is downloaded is bind mounted into the Postgres Docker container,
which will import the files using the `COPY FROM` command on the first run (`./db/prod/01-init.sh`).

⚠️Change the Postgres and PgAdmin credentials in the .env file.

```sh
# Downloads the dataset and puts it into ./db/prod/dataset
# WARNING -- THIS WILL DOWNLOAD ABOUT 8 GB OF DATA
just download
# Runs the DB
just prod
# Go app
just run
```

## Kubernetes Cluster
If the app is to be deployed in a Kubernetes environment, then Helm has to be used. Run the following command to deploy
the cluster:
```sh
just kube
```

