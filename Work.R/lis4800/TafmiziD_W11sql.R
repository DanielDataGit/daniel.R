#Install and activate (“library()”) the sqldf package in RStudio. With any new package it is
#possible to run into installation issues depending on your platform and the versions of 
#software you are running, so monitor your diagnostic messages carefully.

getwd() # check working directory
#install.packages("sqldf")
library(sqldf)

#Review online documentation for sqldf so that you are familiar with the basic concepts and
#usage of the package and its commands.

?sqldf # Seems solid. I wonder if you can implement relationships with this.

#(a) Make sure the built-in “airquality” dataset is available for use in subsequent 
#commands (hint: print head(airquality)). It would be wise to reveal the first few records 
#of air quality with head() to make sure that air quality is available. This will also show 
#you the names of the columns of the air quality dataframe which you will need to use in 
#SQL commands.(b) assign airquality to an object “air” (c) what is the data type of air? You must use 
#a simple command to reveal the data type.

head(airquality) #airquality is present
air <- airquality
str(air) # Data frame with 153 obs of 6 vars. All integer values except for wind which is numeric. NA's present in ozone and solar column.

#(a) Using sqldf(), run an SQL select command that calculates the average level of ozone 
#across all records. Assign the resulting value into a variable (average_ozone) and
#(b) print it out in the console.

average_ozone <- sqldf("SELECT AVG(Ozone) FROM air") # cool that it automatically omits NA's
print(average_ozone)


#Again using sqldf(), run another SQL command that selects all of the records from air 
#quality where the value of ozone is higher than the average. Note that it is possible 
#to combine steps 4 and 5 into a single SQL command – those who are familiar with SQL
#syntax and usage should attempt to do so (1 point).

sqldf("SELECT * FROM air WHERE Ozone > (SELECT AVG(Ozone) FROM air)")
# I think I combined the steps. I could not think of a different way to do it.

#(a) Refine step 5 to write the result table into a new R data object called “newAQ.” 

newAQ <- sqldf("SELECT * FROM air WHERE Ozone > (SELECT AVG(Ozone) FROM air)")


#(b) Then run a command to reveal what type of object newAQ is, (c) another command to 
#show what its dimensions are (i.e., how many rows and columns), and (d) a head() command 
#to show the first few rows.

dim(newAQ)

str(newAQ) 

head(newAQ)

# data frame with 44 obs and 6 vars. Integers except num for wind.Numeric class

#Steps above was done using a SQL way. Now, repeat steps 4, 5 and 6 in an R way, using
#R commands including str, mean, head, dim, which, and tapply, which is a more “R” like
#way to do the analysis ("a" through "g" below)).


# Repeat step 4: calculates the average level of ozone across all records.

#(a) Exclude Missing Values from calculating "Ozone" mean and assign the result to "average_ozone": Hint:use na.rm


# (b) print the result (average_ozone)


average_ozone2 <- mean(air$Ozone, na.rm = T)
print(average_ozone2)

# Repeat step 5

# (c) select rows with bigger values than the average ozone value
######wrong approach: data$Ozone > meanOzone
#[1] FALSE FALSE FALSE FALSE    NA FALSE FALSE FALSE FALSE    NA FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#[23] FALSE FALSE
###################

# original submission: ozrows <-air[(air$Ozone > average_ozone2),]
#original submission :ozrows <- na.omit(ozrows)
#newAQ2 <- ozrows


x <- row.names(air[which(air$Ozone > average_ozone2),])

# this gets the row numbers where ozone is greater than average.

# (d) Repeat step 6
# only keep the rows in which the Ozone values are higher than the average, and write the result table into a new R data object called "newAQ2"

newAQ2 <- air[which(air$Ozone > average_ozone2),]


# (e) reveal what type of object newAQ2 is
# (f) reveal the number of rows, then reveal the number of columns
# (g) show the first few rows of "newAQ2"

str(newAQ2) # data frame with 42 obs of 6 vars

dim(newAQ2)

head(newAQ2)

# It seems that newAQ2 differs from newAQ. In v2, I used na.omit to remove all rows that have NA's, which
# I did not do in V1 (the sqldf function does this automatically but only to the selected column) . To fix this I would use na.omit(ozrows$Ozone). This generates a list of all present ozone
# data rows. I would use the list of row nums to define the air data set. This would generate
# the same result as V1

# Scratch that. After taking the quiz I see my mistake. I could swear that was how I attempted it at first
#but i must have missed something.
