FROM apache/spark:3.5.4-scala2.12-java17-python3-r-ubuntu

ENV  PATH="${PATH}:/opt/spark/sbin/"
USER root
COPY ./scripts/entrypoint.sh /tmp/entrypoint.sh
COPY ./files/postgresql-42.7.5.jar $SPARK_HOME/jars/
RUN export PATH="${PATH}:$SPARK_HOME/sbin/" && mv /tmp/entrypoint.sh $SPARK_HOME/sbin/entrypoint.sh && chmod +x $SPARK_HOME/sbin/entrypoint.sh && chown spark:spark $SPARK_HOME/sbin/entrypoint.sh
ENV PATH=$PATH:$SPARK_HOME
USER spark

ENTRYPOINT ["entrypoint.sh"]
