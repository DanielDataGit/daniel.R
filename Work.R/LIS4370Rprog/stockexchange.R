library(readxl)
library(tidyverse)
library(ggplot2)
library(ggrepel)

data <- read_excel("mod9\\report.xlsx")
data2 <- read_excel("mod9\\report1.xlsx")

data$Value[data$Value == "n/a"] <- NA
data <- data[!is.na(data$Value), ]

data2$Value[data2$Value == "n/a"] <- NA
data2 <- data2[!is.na(data2$Value), ]
data2 <- subset(data2, Year == 2023)

data23 <- subset(data, Year == 2023)
data23$Value <- (as.numeric(data23$Value)/1000000)
data23$`% Change (YTY)` <- as.numeric(data23$`% Change (YTY)`)

data23 <- data23 %>%
  full_join(data2, by =  "ExchangeName")

data23$Value.y <- as.numeric(data23$Value.y)

ggplot(data23, aes(`% Change (YTY).x`, Value.x, color = as.factor(Region.x))) +
  geom_point(aes(size = Value.y)) +
  geom_text_repel(aes(label = ExchangeName), size = 4) +
  scale_x_continuous(breaks = pretty(data23$`% Change (YTY).x`, labels = pretty(data23$`% Change (YTY).x` )))+
  scale_y_continuous(breaks = pretty(data23$Value.x, labels = pretty(data23$Value.x ))) +
  labs(title = "Exchange Value vs YTY change (2023)",
       y = "Market Cap (in Trillions)",
       x = "% Change YTY",
       color = "Region",
       size = "Number of Companies") 
  