from pyspark.sql import SparkSession

spark = SparkSession.builder.config("spark.jars.packages", "org.postgresql:postgresql:42.6.0").getOrCreate()

df = spark.sql("SELECT 'Hello World' as column_1")
df.show()

"""
df_titles = spark.read.format("jdbc") \
        .option("url", "jdbc:postgresql://192.168.1.166:5432/employees") \
        .option("dbtable", "employees.title") \
        .option("user", "airflow") \
        .option("password", "airflow") \
        .option("driver", "org.postgresql.Driver") \
        .load()

df_titles.show()


df_employee = spark.read.format("jdbc") \
        .option("url", "jdbc:postgresql://192.168.1.166:5432/employees") \
        .option("dbtable", "employees.employee") \
        .option("user", "airflow") \
        .option("password", "airflow") \
        .option("driver", "org.postgresql.Driver") \
        .load()

df_employee.show()


joined_df = df_titles.join(df_employee, df_titles.employee_id  ==  df_employee.id,"inner")

joined_df.show(truncate=False)

joined_df.write.option('driver', 'org.postgresql.Driver').jdbc("jdbc:postgresql://192.168.1.166:5432/employees", "employees.joined_version", "overwrite", {"user": "airflow", "password":"airflow", "driver":"org.postgresql.Driver"})

spark.sql("select * from semetey").show()
"""
