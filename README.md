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
# Runs the webapp
just prod
```

## Reduced DB
The performance test of the app has been carried on a reduced version of
the database, whose dump can be found in `./db/prod_reduced/`. The file
`docker-compose.yaml` will use this one by default.

## Kubernetes Cluster
If the app is to be deployed in a Kubernetes environment, then Helm has to be used.
If the cluster has many nodes, then one has to be specified for the DB data, through
the label `db=true`:
```sh
kubectl label nodes <your-node-name> db=true
```

⚠️ Before creating the cluster, change and set a secure password in the `./helm-chart/values.yaml` file, at `postgres.password` and `postgres.url`.

Run the following command to deploy
the cluster:
```sh
just kube
```
The Postgres pod will create an empty `imdb` database. To fill it with production data (assuming that it has been downloaded as described above) we can port-forward the Postgres service to the host machine:
```sh
kubectl port-forward services/postgres-service 5432:5432
```
And then run the script on the host machine, in order to import the dataset on the host:
```sh
cd ./db/prod/
# Apply table models
psql -U postgres -h localhost -d imdb -f 00-model.sql
# Import data. This will take some minutes
POSTGRES_USER=postgres POSTGRES_DB=imdb PGPASSWORD=password ./01-init.sh ./dataset
```
