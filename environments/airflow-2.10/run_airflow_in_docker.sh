#!/bin/bash

source build_script.env

mkdir ${MNT_VOL_FULL_PATH} -p && chmod 777 ${MNT_VOL_FULL_PATH}
mkdir ${MNT_VOL_FULL_PATH}/dags -p && chmod 777 ${MNT_VOL_FULL_PATH}/dags
mkdir ${MNT_VOL_FULL_PATH}/codes -p && chmod 777 ${MNT_VOL_FULL_PATH}/codes
mkdir ${MNT_VOL_FULL_PATH_CONF} -p && chmod 777 ${MNT_VOL_FULL_PATH_CONF}


docker run \
        --name ${CONTAINER_NAME} -d \
        --hostname airflow \
        --volume ${MNT_VOL_FULL_PATH}:/usr/local/airflow \
	--network spark-354_spark-network \
        --volume ${MNT_VOL_FULL_PATH_CONF}/spark-defaults.conf:/opt/spark/conf/spark-defaults.conf \
        --env-file ./airflow_container.env \
        --publish $HOST_PORT:8080 \
	--publish '4046:4040' \
	--publish '4047:4041' \
	--publish '4048:4042' \
	--publish '4049:4043' \
	--publish '4050:4044' \
        semetey/airflow:2.10-with-spark3.5.4-v0.1  webserver
