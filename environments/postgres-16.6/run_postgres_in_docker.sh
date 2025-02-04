#! /bin/bash

docker run -d \
	--name postgres \
	-e POSTGRES_USER=airflow \
	-e POSTGRES_PASSWORD=airflow \
	-e PGDATA=/var/lib/postgresql/data/pgdata \
	-v ./mnt:/var/lib/postgresql/data \
	-p 5432:5432 \
	postgres:16.6
