
library(readxl)
library(tidyverse)
library(ggplot2)

install.packages("forecast")
library(forecast)

data <- read_excel("mod10\\report2.xlsx")

#get subset
yty <- data.frame(data$Year,data$ExchangeName, data$`% Change (YTY)`)

#fill na
yty[ 7, 3] <- "-0.4"

#clean data
colnames(yty) <- c("year","name", "value")
yty$value <- as.numeric(yty$value)

#pivot wider for some reason
yty <- pivot_wider(yty, names_from = year, values_from = value)

#inverse so that mutate thing i found online works
yty <- as.data.frame(t(yty))

names <- yty[1, ]
yty <- yty[-1, ]

sumyty <- yty %>%
  mutate(across(everything(), ~ cumsum(.x), .names = "cumulative_{col}"))

#subset cumulative columns
sumyty <- sumyty[, 9:16]
colnames(sumyty) <- names
sumyty <- sumyty[, -3] #skews data

#pivot longer for ggplot
sumytyLong <- pivot_longer(
  sumyty,
  cols = everything(),  # Select all columns that start with "YoY_Sum"
  names_to = "exchange",       # New column for the names of the YoY sum columns
  values_to = "value"      # New column for the values
)

# add year column
sumytyLong$year <- rep(2014:2023, each = 7)


# plot time series in ggplot
ggplot(sumytyLong, aes(x = year, y = value, col = exchange)) +
  geom_line() +
  labs(title = "Exchange Growth 2014-2023",
       y = "Cumulative YOY % Change")

#turn euronext data into 
test <- ts(sumyty[,1 ], start = 2014)

cast <- snaive(test, h = 5)

autoplot(cast) 