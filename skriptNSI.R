##  NSI SKRIPT


rm(list = ls())
getwd()
#setwd("C:/Users/computer/Desktop/data")
library(Hmisc)
library(fields)
library(devtools)  #source_gist(4676064)


Sys.setlocale("LC_CTYPE", "russian")
data08 = read.csv("EHIS_BG_2008_anon.csv")
class(data08)
save.image(file = "data08.RData")
load("data08.RData")


row.names(data08) <- NULL
data08 <- data08[,-(1)]  # drop unused index




#handle missings
t(stats(data))
utils::View(data)
describe(data08)
names(data08)





dataValid <- data08[colSums(is.na(data08)) < 500]
t(stats(dataValid))
str(dataValid)
View(dataValid)
rm(dataValid)
cor(dataValid)
cor(dataValid, use = "pairwise.complete.obs")





