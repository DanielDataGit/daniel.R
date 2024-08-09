
getwd()

install.packages("sqldf")
library(sqldf)
install.packages("ggplot2")
library(ggplot2)
library(tidyr)
install.packages('FSA')
library(FSA)
install.packages("stats")
library(stats)

data <- read.csv("C:/Users/dtafm/Downloads/WHO-COVID-19-global-data.csv") # reads .csv file into R

USData <- na.omit(sqldf("SELECT Date_reported, New_cases, New_deaths FROM data WHERE Country LIKE 'United States of America'")) # selects all observations and columns where country is US

USData$relation <- USData$New_deaths/USData$New_cases


#Lets analyze differences between the years of america

data2020 <- as.vector(sqldf("SELECT relation FROM USData WHERE date_reported LIKE '2020%'"))
data2021 <- as.vector(sqldf("SELECT relation FROM USData WHERE date_reported LIKE '2021%'"))
data2022 <- as.vector(sqldf("SELECT relation FROM USData WHERE date_reported LIKE '2022%'"))
data2023 <- as.vector(sqldf("SELECT relation FROM USData WHERE date_reported LIKE '2023%'"))

max_length <- length(data2021$relation)

USdf <- data.frame(us2020 = c(data2020$relation, rep(NA, max_length - length(data2020$relation))),
                   us2021 = c(data2021$relation, rep(NA, max_length - length(data2021$relation))),
                   us2022 = c(data2022$relation, rep(NA, max_length - length(data2022$relation))),
                   us2023 = c(data2023$relation, rep(NA, max_length - length(data2023$relation))))

newdfus <- data.frame(Group = rep(c("us2020","us2021", "us2022", "us2023"),each=52),
                 data = c(USdf$us2020, USdf$us2021, USdf$us2022,USdf$us2023 ))
                 



# I have 4 samples and will either use anova or two sample t tests. However, my datasets are not "true" equally sized, not equal variance, and not normally distributed

boxplot(USdf)

# The boxplot shows that the variances are not equal and that the distributions vary. 
# I could use many two sample tests to compare each set. But it is more efficient to 
# use the nonparametic Kruskal wallis test

kruskal.test(data~Group, data = newdfus)

dunnTest(data~Group, data = newdfus)


#Given the P-value of 0.4854 we accept the null hypothesis that the medians are not statistically different
# This means the case to death ratio did not show signifcant variation between 2020 through 2023

# time series for data visualization
USdataTS <-ts(USData$relation, frequency = 52, start=c(2020,10), end = c(2023, 21))
plot(USdataTS)

mean(USdataTS)

# From our plot, we can see that the death to case ratio spiked in early 2020 at 0.081.
# It proceeded to quickly decrease by midyear at about 0.02. After midyear, the ratio
# maintained volatility between 0.0025 and 0.037.

# The volatility confuses me. I would assume that as time goes on the ratio would decrease.
# New findings, methods, and technologies should show a continual decrease of the ratio
# However, the graph shows us that the US may be doing something wrong. To test this, we should compare
# our ratio to our more liberal/safe brother up north, Canada!

CanData <- na.omit(sqldf("SELECT Date_reported, New_cases, New_deaths FROM data WHERE Country LIKE 'Canada'"))

CanData$New_deaths <- abs(CanData$New_deaths) # one of the values is negative. I am assuming it was meant to be positive
 
CanData$relation <- CanData$New_deaths/CanData$New_cases


Cdata2020 <- as.vector(sqldf("SELECT relation FROM CanData WHERE date_reported LIKE '2020%'"))
Cdata2021 <- as.vector(sqldf("SELECT relation FROM CanData WHERE date_reported LIKE '2021%'"))
Cdata2022 <- as.vector(sqldf("SELECT relation FROM CanData WHERE date_reported LIKE '2022%'"))
Cdata2023 <- as.vector(sqldf("SELECT relation FROM CanData WHERE date_reported LIKE '2023%'"))

max_lengthc<- length(Cdata2021$relation)

Candf <- data.frame(can2020 = c(Cdata2020$relation, rep(NA, max_lengthc - length(Cdata2020$relation))),
                   can2021 = c(Cdata2021$relation, rep(NA, max_lengthc - length(Cdata2021$relation))),
                   can2022 = c(Cdata2022$relation, rep(NA, max_lengthc - length(Cdata2022$relation))),
                   can2023 = c(Cdata2023$relation, rep(NA, max_lengthc - length(Cdata2023$relation))))

newdfcan <- data.frame(Group = rep(c("can2020","can2021", "can2022", "can2023"),each=52),
                      data = c(Candf$can2020, Candf$can2021, Candf$can2022,Candf$can2023 ))
boxplot(Candf)
kruskal.test(data~Group, data = newdfcan)



dunnTest(data~Group, data = newdfcan)

#data visualization

CanDataTS <-ts(CanData$relation, frequency = 52, start=c(2020,10), end = c(2023, 21))

plot(CanDataTS, yaxt = "n")
axis(side=2, at=seq(0,.15,by = .02))

mean(CanDataTS)-mean(USdataTS)
mean(USdataTS)+mean(CanDataTS)/2

0.003802461/0.02592177


#From our plot, we can see that the canada ratio has a similar beginning. A Large spike in early 
#2020 at 0.15 followed by a quick descent to 0.01. After this, some volatility occured between .0008 and 
# 0.035

# lets use a paired t-test to see if they are similar
# I chose to do a T-test because I have two datasets which I will trim to have the same number of rows.
#The Canada data includes case data past june 2023, which the US data does not.
# I chose do to paired because I am examining the case ratios in a timeline matter.

# Null Hypothesis: there is no significant difference in the means of the datasets
# alternative Hypothesis: there is a significant difference in the means of the datasets

trimmed <- data.frame(USData[3:168,4] ,CanData[1:166, 4])
colnames(trimmed) <- c("USratio", "Canratio")

boxplot(trimmed)
plot(trimmed)

# data has similar distribution and variance, thus i will use a paired t test

Tres <- t.test(data = trimmed, trimmed$USratio, trimmed$Canratio)
print(Tres)




# Our T-test tells us that there is a significant difference in the means. 
#I will set up an two way anova to get more information


allDF <- data.frame(Country = rep(c("US", "Canda"), each = 208),
                       year = rep(c("us2020","us2021", "us2022", "us2023","can2020","can2021", "can2022", "can2023"),each=52),
                       data = c(USdf$us2020, USdf$us2021, USdf$us2022,USdf$us2023, Candf$can2020, Candf$can2021, Candf$can2022,Candf$can2023 ))

model <- aov(data ~ Country * year, data = allDF)
summary(model)


TukeyHSD(model)




