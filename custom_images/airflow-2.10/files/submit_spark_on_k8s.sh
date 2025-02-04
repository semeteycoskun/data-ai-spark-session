#!/bin/bash

########
while [[ "$#" -gt 0 ]]
  do
    case $1 in
      --deployment-code) DEPLOYMENT_CODE="$2"; shift;;
      --driver-memory) DRIVER_MEM="$2"; shift;;
      --driver-cores) DRIVER_CORES="$2"; shift;;
      --num-executors) NUMBER_OF_EXECUTORS="$2"; shift;;
      --executor-memory) EXECUTOR_MEM="$2"; shift;;
      --executor-cores) EXECUTOR_CORES="$2"; shift;;
      --python-input) PYTHON_INPUT="$2"; shift;;
      --name) NAME="$2"; shift;;
    esac
    shift
done

SPARK_SUBMIT_PARAMETERS="--executor-memory $EXECUTOR_MEM \
                         --driver-memory $DRIVER_MEM  \
                         --num-executors $NUMBER_OF_EXECUTORS  \
                         --driver-cores $DRIVER_CORES  \
                         --executor-cores $EXECUTOR_CORES \
			 --conf "spark.cores.max=4"  \
                         --name $NAME \
			 --conf spark.driver.host=airflow \
			 "


# Set submission log file name dynamically
LOG_DIR="/tmp/"
log_file_name="$LOG_DIR$NAME""_"`date "+%Y%m%d%H%M%S"`".log"
echo "Spark Driver submission log file: $log_file_name"

########
# Step 3
########
# Spark Job Submission
$SPARK_HOME/bin/spark-submit   $SPARK_SUBMIT_PARAMETERS $DEPLOYMENT_CODE $PYTHON_INPUT 
