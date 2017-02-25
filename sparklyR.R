Sys.getenv()
sessionInfo()
Sys.getenv('HADOOP_HOME')
Sys.getenv('SPARK_HOME')


devtools::install_github("rstudio/sparklyr")
options("sparklyr.verbose")


library(sparklyr)
library(dplyr)
config <- spark_config()
config[["sparklyr.defaultPackages"]] <- NULL
sc <- spark_connect(master = "spark://10.136.126.35:7077", version = "2.0.1",
                    spark_home = spark_home_dir())


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
