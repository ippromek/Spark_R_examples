devtools::install_github('apache/spark@v2.0.1', subdir='R/pkg')
library(SparkR)

if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/home/spark")
}
library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sparkR.session(master = "spark://10.136.126.35:7077", sparkConfig = list(spark.driver.memory = "2g"))

df <- as.DataFrame(faithful)

# Displays the first part of the SparkDataFrame
head(df)

sparkR.session(sparkPackages = "com.databricks:spark-avro_2.11:3.0.0")
sparkR.session.stop()
