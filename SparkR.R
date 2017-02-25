

if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/home/spark")
}
library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sparkR.session(master = "spark://10.136.126.35:7077", sparkConfig = list(spark.driver.memory = "2g"))

df <- as.DataFrame(faithful)

# Displays the first part of the SparkDataFrame
head(df)