#input/output r dplyr

#install.packages("pryr")
library(pryr)

#install.packages("plyr")
library(plyr)

library(tidyverse)

#install.packages("openxlsx")
library(openxlsx)

# Step 1)

Student <- read.csv("C:\\Users\\dtafm\\OneDrive\\Desktop\\data.science\\R\\Work.R\\lis4370\\daniel.R\\week8\\Assignment 6 Dataset.txt")

means <- Student %>%
  group_by(Sex) %>%
  summarise(across(c(Age, Grade), mean))

write.xlsx(means, "C:\\Users\\dtafm\\OneDrive\\Desktop\\data.science\\R\\Work.R\\lis4370\\daniel.R\\week8\\week8xlsx")

# Step 2)

i_students <- subset(Student, grepl("[iI]", Student$Name, ignore.case=T))
write.table(i_students,"C:\\Users\\dtafm\\OneDrive\\Desktop\\data.science\\R\\Work.R\\lis4370\\daniel.R\\week8\\DataSubset_i_names",sep=",")

