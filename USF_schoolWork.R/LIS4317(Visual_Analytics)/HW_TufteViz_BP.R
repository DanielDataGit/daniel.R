library(ggplot2)
library(ggthemes)
library(readxl)

data <- read_xlsx("C:\\Users\\dtafm\\OneDrive\\Desktop\\data.science\\R\\Work.R\\lis4370\\daniel.R\\sumyty.xlsx")

ggplot(data, aes(factor(exchange), value)) +
  theme_clean() +
  geom_tufteboxplot(outlier.colour="transparent", aes(color = factor(exchange))) + 
  labs(title = "Boxplots by exchange from 2014 - 2024",
       x = "Exchange Name",
       y = "Cumulative YTY returns") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1), legend.position = "none")


  