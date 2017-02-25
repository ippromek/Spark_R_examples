devtools::install_github('apache/spark@v2.0.1', subdir='R/pkg')
library(SparkR)

if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/home/spark")
}

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(master = "spark://10.136.126.35:7077", sparkConfig = list(spark.driver.memory = "1g", spark.executor.cores="2"))

sqlContext <- sparkRSQL.init(sc)


df <- as.DataFrame(faithful)
SparkR::registerTempTable(df,"faithful");
SparkR::createOrReplaceTempView(df,"faithful")
df_avg <- sql("SELECT eruptions, avg(waiting) FROM faithful group by eruptions ")
head(df_avg)

###########################################
# CONVERT SPARK DF TO LOCAL DATA.FRAME IN MEMORY OF R-SERVER EDGE NODE
###########################################
trip_fare_featSampledDF <- as.data.frame(trip_fare_featSampled);

###########################################
# SAVE DATAFRANE AS PARQUET file
###########################################
write.df(df=trip_fare_featSampled, 
         path='/HdiSamples/HdiSamples/NYCTaxi/JoinedParquetSampledFile2', source="parquet", mode="overwrite")



people <- read.df("./examples/src/main/resources/people.json", source = "com.databricks.spark.csv", header = "true", inferSchema = "true"))

df <- read.df(csvPath, "csv", header = "true", inferSchema = "true", na.strings = "NA")

# Displays the first part of the SparkDataFrame
head(df)

sparkR.session(sparkPackages = "com.databricks:spark-avro_2.11:3.0.0")
sparkR.session.stop()
