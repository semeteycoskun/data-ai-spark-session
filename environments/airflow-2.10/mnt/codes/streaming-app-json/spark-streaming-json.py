# Create the Spark Session
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, from_json
from pyspark.sql.types import StructType, StructField, StringType

spark = SparkSession \
    .builder \
    .appName("Streaming from Kafka") \
    .config("spark.streaming.stopGracefullyOnShutdown", True) \
    .config('spark.jars.packages', 'org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.0') \
    .config("spark.sql.shuffle.partitions", 4) \
    .getOrCreate()


schema = StructType([
        StructField("name", StringType(), True),
        StructField("title" , StringType(), True),
        ])


df = spark \
  .readStream \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "192.168.1.166:9091,192.168.1.166:9092,192.168.1.166:9093") \
  .option("subscribe", "topic2") \
  .option("auto.offset.reset", "earliest") \
  .option("kafka.group.id", "ai-community-v01") \
  .load() \
  .select(from_json(col("value").cast("string"), schema).alias("parsed_value")) \
  .select(col("parsed_value.name"), col("parsed_value.title"))

df.writeStream \
        .format("console") \
        .outputMode("append") \
        .start() \
        .awaitTermination()
