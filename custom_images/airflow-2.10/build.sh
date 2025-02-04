#!/bin/bash

#docker build -f docker-files/Dockerfile  -t semetey/airflow:2.10.0-with-spark3.5.2-v0.1 .
SPARK_VERSION=3.5.4
AIRFLOW_VERSION=2.10

docker build -f docker-files/Dockerfile --build-arg SPARK_VERSION=3.5.4 --build-arg AIRFLOW_VERSION=2.10 -t semetey/airflow:${AIRFLOW_VERSION}-with-spark${SPARK_VERSION}-v0.1 .
