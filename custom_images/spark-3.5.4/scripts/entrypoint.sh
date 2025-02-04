#!/bin/bash

SPARK_COMPONENT=$1


echo "SPARK_COMPONENT: $SPARK_COMPONENT"

if [ "$SPARK_COMPONENT" == "master" ];
then
  if [[ -z "${SPARK_MASTER_PORT}" ]]; then
      echo "Spark Master Port is not defined. Setting as default (7077) "
      export SPARK_MASTER_PORT=7077
  fi
  start-master.sh --port $SPARK_MASTER_PORT
elif [ "$SPARK_COMPONENT" == "worker" ];
then
  if [[ -z "${SPARK_MASTER}" ]]; then
    echo "Spark Master is not defined. Please check environment variable: SPARK_MASTER"
    echo -e "Must be set as below: \nexport SPARK_MASTER=spark-master:7077"
    exit 1
  fi
  start-worker.sh ${SPARK_MASTER}
elif [ "$SPARK_COMPONENT" == "history-server" ];
then
  start-history-server.sh
else
  echo "There is no way out with '${SPARK_COMPONENT}'"
fi
