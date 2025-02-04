# Create the Spark Session
from pyspark.sql import SparkSession
from pyspark.sql.functions import col

spark = SparkSession \
    .builder \
    .appName("Streaming from Kafka") \
    .config("spark.streaming.stopGracefullyOnShutdown", True) \
    .config('spark.jars.packages', 'org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.0') \
    .config("spark.sql.shuffle.partitions", 4) \
    .getOrCreate()


df = spark \
  .readStream \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "192.168.1.166:9091,192.168.1.166:9092,192.168.1.166:9093") \
  .option("subscribe", "topic1") \
  .option("auto.offset.reset", "earliest") \
  .option("kafka.group.id", "ai-community-v01") \
  .load()

df = df.selectExpr("CAST(key AS STRING) as key_str", "CAST(value AS STRING) as val_str", "timestamp", "timestampType", "offset", "key", "value")
df.writeStream \
        .format("console") \
        .outputMode("append") \
        .start() \
        .awaitTermination()
