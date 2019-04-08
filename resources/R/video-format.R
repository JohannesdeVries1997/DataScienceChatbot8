#!/usr/bin/Rscript

# install.packages("RMySQL")
#library(RMySQL)

#con <- dbConnect(MySQL(), dbname="imdb", user="imdb", password="imdb")
#values <- dbGetQuery(con, "select movie_info.info as format, count(*) as freq from movie_info, info_type where info_type.info = 'LD picture format' and info_type_id = info_type.id group by movie_info.info")
setwd("C:/Users/sjimm/Documents")
crimepubs <- read.csv("crimepubs.csv")
jpeg("rplot.jpg", width = 350, height = 350)
plot(crimepubs)
dev.off()

