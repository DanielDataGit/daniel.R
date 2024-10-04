# goal: visualize which quarter has best earning 

library(datasets)
library(ggplot2)


# as.data.frame does not remove time-series
data <- as.data.frame(as.numeric(JohnsonJohnson))
data$quarter <- rep(1:4) 
data$year <- rep(1960:1980, each = 4)
colnames(data)[1] <- "value"


ggplot(data, aes(x = year, y = value, color = factor(quarter))) +
    geom_line() +
    geom_smooth(aes(group = 1), method = "lm", se = FALSE) +
    labs(title = "Johnson & Johnson Quarterly Earnings by Year", 
         x = "Year", 
         y = "Earnings",
         color = "Quarter") +
    ylim(0, 16.5)

ggplot(data, aes(factor(quarter), value)) +
    geom_boxplot() +
    labs(title = "Johnson & Johnson Quarterly Earnings from 1960 - 1980",
         x = "Quarter")

