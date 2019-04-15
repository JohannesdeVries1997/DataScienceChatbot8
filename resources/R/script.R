#Rscript voor: Worden films in <country> gemaakt in <language>?
args = commandArgs(trailingOnly=TRUE)
country = args[1]
language = args[2]

setwd("D:/Documents/GitHub/DataScienceChatbot8/resources/R")

simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}

language = simpleCap(language)

# install.packages("RPostgreSQL")
library(RPostgreSQL)
drv = dbDriver("PostgreSQL")
con = dbConnect(drv, dbname = "MovieIMDB", host = "localhost", port = 5432, user = "postgres", password = 1234)
query = paste0("SELECT DISTINCT country.title, country.year, country.country, language.language FROM public.country LEFT JOIN language ON country.title = language.title WHERE country.title IS NOT NULL AND country.year IS NOT NULL AND country.country ILIKE '", country, "' AND language.language IS NOT NULL;")
data = dbGetQuery(con, query)

data$language = as.factor(data$language == language)
table = table(data$language)
title = paste0("Spoken language is ", language, "")
invisible(jpeg('rplot.jpg'))
barplot(table, main = title, ylab = "Number of movies")
invisible(dev.off())
