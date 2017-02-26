Sys.getenv()
sessionInfo()
Sys.getenv('HADOOP_HOME')
Sys.getenv('SPARK_HOME')


devtools::install_github("rstudio/sparklyr")

options("sparklyr.verbose")


library(sparklyr)
library(dplyr)



config = list(
  default = list(
    spark.submit.deployMode= "client",
    spark.executor.instances= 20, 
    spark.executor.memory= "2G",
    spark.executor.cores= 2,
    spark.driver.memory= "4G"))


config = list(
  default = list(
    spark.executor.memory= "1G",
    spark.executor.cores=2))



config[["sparklyr.defaultPackages"]] <- NULL
sc <- spark_connect(master = "spark://10.136.126.35:7077", version = "2.0.1",
                    spark_home = Sys.getenv('SPARK_HOME'))


config <- spark_config()
config$spark.executor.cores<-1

sc <- spark_connect(master = "spark://10.136.126.35:7077",version = "2.0.1", config = config)



spark_web(sc)
spark_log(sc)



install.packages(c("nycflights13", "Lahman"))

library(dplyr)
iris_tbl <- copy_to(sc, iris)
flights_tbl <- copy_to(sc, nycflights13::flights, "flights")
batting_tbl <- copy_to(sc, Lahman::Batting, "batting")
src_tbls(sc)

flights_tbl %>% filter(dep_delay == 2)


delay <- flights_tbl %>% 
  group_by(tailnum) %>%
  summarise(count = n(), dist = mean(distance), delay = mean(arr_delay)) %>%
  filter(count > 20, dist < 2000, !is.na(delay)) %>%
  collect


spark_disconnect(sc)
