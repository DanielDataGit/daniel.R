# cleaning trail data for tableau visualization

getwd()

install.packages('readxl')
library(readxl)

install.packages('stringr')
library(stringr)

install.packages('dplyr')
library(dplyr)

install.packages("writexl")
library(writexl)

# paths to data files
path1<- "C:/Users/dtafm/Downloads/us-county-boundaries.xlsx"
path2<- "C:/Users/dtafm/Downloads/florida-existing-trails.csv"

# read paths
flcounty <- data.frame(read_excel(path1))
fltrail <- read.csv(path2)

# Check results
str(flcounty)
str(fltrail)

# initialize dataframe for necessary data
data <- data.frame(matrix(ncol = 3, nrow = 67))

flcounty <- flcounty[order(flcounty$NAME), ]

#move county names to data uppercase
data$countyName <-toupper(flcounty$NAME)

# seperates flcounty geo coordinate column then adds to data
flcounty[c('latitude', 'longitude')] <- str_split_fixed(flcounty$Geo.Point, ',', 2)

data$latitude <- flcounty$latitude
data$longitude <- flcounty$longitude

#check if any na's in fltrail county gismiles
print(sum(is.na(fltrail$COUNTY)))
print(sum(is.na(fltrail$GIS_MILES)))

# some trails go through muiltiple counties, for simplicity I kept the first listed county
fltrail$COUNTY <- sub(",.*", "", fltrail$COUNTY)

#check if lengths equal
print(length(unique(fltrail$COUNTY)))
print(length(unique(flcounty$NAME)))

#since not equal and short I will view df
trailnames <- sort(unique(fltrail$COUNTY))
countynames <- sort(unique(flcounty$NAME))

#remove blanks
trailnames <- trailnames[-1]

df <- data.frame(trailnames, toupper(countynames))


# fix differences
fltrail$COUNTY[fltrail$COUNTY == "DADE"] <- "MIAMI-DADE"
fltrail$COUNTY[fltrail$COUNTY == "ORANGE/SEMINOLE"] <- "ORANGE"

#sort to make same for computer  
trailnames <- sort(unique(fltrail$COUNTY))
countynames <- sort(unique(flcounty$NAME))


#final check for differences
print(which(df$trailnames != df$countynames))

#get trails per county
trail_count_per_county <- fltrail %>%
  group_by(COUNTY) %>%
  summarise(trail_count = n())
trail_count_per_county <- trail_count_per_county[-1,]

mileage_count_perCounty <- fltrail %>%
  group_by(COUNTY) %>%
  summarise(total_miles = sum(GIS_MILES, na.rm = TRUE))

mileage_count_perCounty <- mileage_count_perCounty[-1,]

data$trailCount <- trail_count_per_county$trail_count
data$mileage <- mileage_count_perCounty$total_miles

data <- data[,-1:3]

write_xlsx(data, 'C:\\Users\\dtafm\\Downloads\\flTrailData.xlsx')
