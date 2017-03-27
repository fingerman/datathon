# load  data 
rm(list = ls())
setwd("C:/Users/computer/Desktop/data") # dir
library(Hmisc)
library(fields)
library(devtools)  #source_gist(4676064)


Sys.setlocale("LC_CTYPE", "russian")
data08 = read.csv("EHIS_BG_2008_anon.csv")
row.names(data08) <- NULL
data08 <- data08[,-(1)]  # drop unused index
save.image(file = "data.RData")
load("data.RData")
keep columns < 500 NA
data <- data[colSums(is.na(data)) < 500]

# t(stats(data))  # check missings

## rename variables
data$health <- data$HS01      # health status
data$age <- data$AgeGroup_85  # age
data$edu <- data$HH07_gr      # education
data$hshold <- data$HHACT_gr  # household size
data$income <- data$IN05      # income
data$smoker <- data$SK01      # smoker
data$attGood <- data$SF04      # life attitude
data$feelTired <- data$SF08   # general exhaustion
data$female <- data$SEX





data<-subset(data, !(health>5))
table(data$female)
table(data$health)
table(data$age)
table(data$hshold)
table(data$income)
table(data$smoker)  # delete 9
data<-subset(data, !(smoker>8))
table(data$attGood)  # delete 8, 9
data<-subset(data, !(attGood>7))
table(data$feelTired)  # delete 8, 9
data<-subset(data, !(feelTired>7))
data<-subset(data, !(edu>7))




# recode

data$female <-ifelse(data$female==2,1,0) # female = 1, male = 0
data$female<-factor(data$female)



data$health <- mapvalues(data$health, from = c("1", "2", "4", "5"), to = c("5", "4", "2", "1"))
data$logHealth <- log(data$health)



# correlations

data$health <- as.numeric(data$health)
data$femaleNum <- as.numeric(data$female)

round(cor(data[c("health", "femaleNum", "age", "income", "hshold", "smoker", "attGood", "feelTired")], 
          use="pairwise.complete.obs"), 2)


View(data)
table(data$health)
class(data$health)
data$health <- as.numeric(data$health)
data$femaleNum <- as.numeric(data$female)
rm(fit)


