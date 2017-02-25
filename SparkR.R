devtools::install_github('apache/spark@v2.0.1', subdir='R/pkg')
library(SparkR)

if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/home/spark")
}

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(master = "spark://10.136.126.35:7077", sparkConfig = list(spark.driver.memory = "1g", spark.executor.cores="2"))
sparkR.session(sparkPackages = "com.databricks:spark-avro_2.11:3.0.0")

sqlContext <- sparkRSQL.init(sc)

##########################################
spark_env = list('spark.executor.memory' = '4g', 
                 'spark.executor.instances' = '4', 
                 'spark.executor.cores' = '4',
                 'spark.driver.memory' = '4g')
sc <- sparkR.init(master = "yarn-client", appName = "SparkR", sparkEnvir = spark_env, 
                  sparkJars=c("/home/dmitry.selivanov/packages/spark-csv_2.10-1.3.0.jar", 
                              "/home/dmitry.selivanov/packages/commons-csv-1.2.jar"))

sqlContext <- sparkRHive.init(sc)

sdf <- read.df(sqlContext, path = "/user/dmitry.selivanov/csv/test_spark.csv", 
               source = "com.databricks.spark.csv", inferSchema = "true")
# first we cache
cache(sdf)
# and trigger computation
nrow(sdf)
# now our sdf is materialized and in RAM
# lets collect it to local df
system.time(sdf_local <- collect(sdf))
# 130.927
############################################


tripDF <- read.df(sqlContext, "C:\\Users\\oleg.baydakov\\Downloads\\trip_data_12.csv", source = "com.databricks.spark.csv", header = "true", inferSchema = "true")

csvPath="C:\\Users\\oleg.baydakov\\Downloads\\trip_data_12.csv"
tripDF1 <- read.df(csvPath, "csv", header = "true", inferSchema = "true", na.strings = "NA")


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



people <- read.df("./examples/src/main/resources/people.json", source = "com.databricks.spark.csv", header = "true", inferSchema = "true")

df <- read.df(csvPath, "csv", header = "true", inferSchema = "true", na.strings = "NA")

# Displays the first part of the SparkDataFrame
head(df)

sparkR.session(sparkPackages = "com.databricks:spark-avro_2.11:3.0.0")
sparkR.session.stop()
