#Rscript voor: Heeft de lengte van de flim invloed op de rating?
args = commandArgs(trailingOnly=TRUE)
duration = args[1]

setwd("D:/Documents/GitHub/DataScienceChatbot8/resources/R")

# install.packages("RPostgreSQL")
library(RPostgreSQL)
drv = dbDriver("PostgreSQL")
con = dbConnect(drv, dbname = "MovieIMDB", host = "localhost", port = 5432, user = "postgres", password = 1234)
query = paste0("SELECT DISTINCT title, duration, rating FROM public.movie WHERE duration = '", duration, "' AND rating IS NOT NULL")
data = dbGetQuery(con, query)

data$negative = as.factor(data$rating < 7.0)

table = table(data$negative)
title = paste0("Is a movie that is ", duration, " minutes long a good movie?")
invisible(jpeg('rplot2.jpg'))
barplot(table, main = title, ylab = "Number of movies")
invisible(dev.off())
