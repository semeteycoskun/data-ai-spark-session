#!/bin/bash

DEPLOYMENT_CODE="spark-streaming-json.py"
DRIVER_MEM="2G"
DRIVER_CORES="2"
NUMBER_OF_EXECUTORS="2"
EXECUTOR_MEM="2G"
EXECUTOR_CORES="2"
NAME="spark-streaming-json-parsing"

SPARK_SUBMIT_PARAMETERS="--executor-memory $EXECUTOR_MEM \
                         --driver-memory $DRIVER_MEM  \
                         --num-executors $NUMBER_OF_EXECUTORS  \
                         --driver-cores $DRIVER_CORES  \
                         --executor-cores $EXECUTOR_CORES \
			 --conf "spark.cores.max=4"  \
                         --name $NAME \
			 --conf spark.driver.host=airflow \
			 --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.4 \
			 "


$SPARK_HOME/bin/spark-submit   $SPARK_SUBMIT_PARAMETERS $DEPLOYMENT_CODE
