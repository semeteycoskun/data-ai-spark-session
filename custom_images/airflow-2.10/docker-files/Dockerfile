FROM python:3.10.6-slim-buster
# Airflow
ARG AIRFLOW_VERSION
ARG AIRFLOW_USER_HOME=/usr/local/airflow
ARG UNAME=airflow
ARG SPARK_VERSION
ENV AIRFLOW_HOME=${AIRFLOW_USER_HOME}
ENV SPARK_HOME=/opt/spark

RUN useradd -m -s /bin/bash $UNAME -d ${AIRFLOW_USER_HOME}

RUN apt update -y \
    && apt install -y  --no-install-recommends build-essential wget netcat libsasl2-dev libssl-dev libffi-dev libpq-dev git default-jre procps libaio1 unzip curl

COPY ./files/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt
RUN pip3 install apache-airflow[postgres,jdbc]==${AIRFLOW_VERSION} && \ 
    pip3 install apache-airflow-providers-ssh

USER root
RUN apt-get purge --auto-remove -yqq $buildDeps \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

RUN wget --no-check-certificate https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz
RUN tar -xvzf spark-${SPARK_VERSION}-bin-hadoop3.tgz \
    && mkdir -p ${SPARK_HOME} \
    && mv spark-${SPARK_VERSION}-bin-hadoop3/* ${SPARK_HOME} \
    && rm spark-${SPARK_VERSION}-bin-hadoop3.tgz

COPY ./files/entrypoint.sh /entrypoint.sh
# COPY ./files/spark-defaults.conf  /opt/spark/conf/
COPY ./files/submit_spark_on_k8s.sh /usr/local/bin/
COPY ./files/postgresql-42.7.5.jar $SPARK_HOME/jars/
RUN chmod 755 -R ${AIRFLOW_HOME} && chmod +x /entrypoint.sh

RUN mkdir ${AIRFLOW_HOME}/dags
RUN mkdir ${AIRFLOW_HOME}/logs
RUN chmod 755 -R ${AIRFLOW_HOME}
RUN chown -R ${UNAME}:${UNAME} ${AIRFLOW_USER_HOME}
RUN chmod +x /usr/local/bin/submit_spark_on_k8s.sh
EXPOSE 8080

USER $UNAME
WORKDIR ${AIRFLOW_USER_HOME}
ENTRYPOINT ["/entrypoint.sh"]

