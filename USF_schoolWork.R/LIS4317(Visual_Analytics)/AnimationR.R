library(ggplot2)
library(readxl)

#install.packages("gganimate")
library(gganimate)


data <- read_excel("C:\\Users\\dtafm\\OneDrive\\Desktop\\data.science\\R\\Work.R\\lis4370\\daniel.R\\sumyty.xlsx")

#source  https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/

p <- ggplot(data, aes(year, value, group = ExchangeName, color = Region)) +
  geom_line() +
  labs(title = "YOY Percentage Change 2014 - 2024", x = "Year", y = "YOY Percent Change",
       caption = "Data retrieved from World-Exchanges.org Statistics Portal")

p + 
  geom_point(aes(group = seq_along(year))) +
  transition_reveal(year) +
  theme_minimal() +
  theme(
    plot.caption = element_text(vjust = -8)
  )

anim_save("C:\\Users\\dtafm\\OneDrive\\Desktop\\data.science\\R\\Work.R\\lis4370\\daniel.R\\animation.gif")