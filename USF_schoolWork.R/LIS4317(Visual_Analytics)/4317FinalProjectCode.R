library(ggplot2)
library(gganimate)
library(readxl)
library(tidyverse)
library(viridisLite)
library(ggrepel)
library(ggthemes)

data <- read_excel("lis4317finalproj\\exchangedata.xlsx")

###preprocess data for percent changes for region and exchange time series

# normalize value and separate caps and companies 
data$Value <- (as.numeric(data$Value)/1000000)
listedNum <- subset(data, `Indicator Name` == "Total Equity Market - Number of listed companies (Total)")
capNum <- subset(data, `Indicator Name` == "Total Equity Market - Market Capitalisation")

# left join to link the dfs
animdata <- left_join(capNum, listedNum, by = c("ExchangeName", "Year"))

#subset and clean necessary columns
cleanedSub <- data.frame(animdata$Year, animdata$Region.x, animdata$ExchangeName,
                       animdata$Value.x, animdata$YTD.y)

cleanedSub <- cleanedSub[-(377: nrow(cleanedSub)), ]
colnames(cleanedSub) <- c("Year", "Region", "Name", "Cap", "Company")

###manually replace nas

#replace missing saudi caps
cleanedSub$Cap <- replace(cleanedSub$Cap, c(9, 20, 51, 65, 91), c(.306, .650, .327, .519, .264))

#replace missing japan caps and companies. Change name to Tokyo Stock Exchange (more specific)
cleanedSub$Cap <- replace(cleanedSub$Cap, c(36, 55, 74, 93, 112, 131, 150, 169, 188), c(4.57, 4.82, 4.49, 3.12, 3.48, 4.11, 3.32, 3.31, 4.5))
cleanedSub$Company <- replace(cleanedSub$Company, c(36, 55, 74, 93, 112, 131, 150, 169, 188), c(2206, 2153, 2206, 2351, 2416, 2414, 2389, 2334, 3423))
cleanedSub <- cleanedSub %>%
mutate(Name = case_when(Name == "Japan Exchange Group" ~ "Tokyo Stock Exchange", TRUE ~ Name))

#replace LSE  nas
cleanedSub$Cap <- replace(cleanedSub$Cap, c(226, 245, 264, 283, 301, 321), c(4.4, 4.1, 4.5, 4.3, 4.2, 3.7))
cleanedSub$Company <- replace(cleanedSub$Company, c(226, 245, 264, 283, 301, 321), c(2200, 2100, 2100, 2000, 1900, 1800))

#replace Euronext amsterdam nas
cleanedSub$Cap <- replace(cleanedSub$Cap, c(244, 263, 282, 302, 320, 340, 359), c(.8117, .9183, 1, 1.2, 1.4, 1.6, 1.8))
cleanedSub$Company <- replace(cleanedSub$Company, c(244, 263, 282, 302, 320, 340, 359), c(129, 130, 130, 130, 130, 130, 130))
cleanedSub$Company <- as.numeric(cleanedSub$Company)

#widen and fill new nas
cleanedSubWide <- pivot_wider(cleanedSub, id_cols = c(Name, Region), names_from = Year, values_from = Cap)
cleanedSubWide[18, 3] <- .6636
cleanedSubWide[19, 3] <- 4.57
cleanedSubWide[2, 22] <- 1.66
cleanedSubWide[6, 22] <- 3.04
names <- cleanedSubWide$Name
widevalues <- cleanedSubWide[, 3:22]

#inverse for column wise summing
widevalues <- as.data.frame(t(widevalues))

#calculate column wise cumulative differences as percentages
percentChangedf <- widevalues %>%
       mutate(across(everything(), ~ c(0, cumsum(diff(.x) / .x[-length(.x)] * 100)), .names = "cumulative_percent_{col}"))

#subset cumulative columns
percentChangedf <- percentChangedf[, 20:38]
colnames(percentChangedf) <- names

#pivot longer for ggplot
percentChangedf <- pivot_longer(
          percentChangedf,
          cols = everything(),  
          names_to = "exchange",       
          values_to = "value"      
         )
 
# add year column
percentChangedf$year <- rep(2004:2023, each = 19)

#Repeat previous steps to add listed company sum to the df. 
cleanedSubWideCompany <- pivot_wider(cleanedSub, id_cols = c(Name, Region), names_from = Year, values_from = Company)
cleanedSubWideCompany[18, 3] <- 509
cleanedSubWideCompany[19, 3] <- 3958
cleanedSubWideCompany[2, 22] <- 139
cleanedSubWideCompany[6, 22] <- 1977
cleanedSubWideCompany <- cleanedSubWideCompany[, 3:22]
cleanedSubWideCompany <- as.data.frame(t(cleanedSubWideCompany))

cleanedSubWideCompany <- pivot_longer(
           cleanedSubWideCompany,
           cols = everything(),  
           names_to = "exchange",      
           values_to = "value"      
         )
percentChangedf$companies <- cleanedSubWideCompany$value

# use left join to link name to region
colnames(percentChangedf)[1] <- "Name"
nameJoin <- cleanedSub %>%
      distinct(Name, Region)

percentChangedf <- percentChangedf %>%
        left_join(nameJoin, by = "Name")

# summarize avg change by summing each region for each year and dividing by exchanges in that region
sumRegion <- percentChangedf %>%
       group_by(Region, year) %>%
       summarize(
            capChange = sum(value),
            compChange = sum(companies),
            numExchanges = n(),
            capAvgChange = capChange / numExchanges,
            compAvgChange = compChange/numExchanges,
            .groups = "drop"
          )
# order region
sumRegion$Region <- factor(sumRegion$Region, levels = c("Asia - Pacific", "Europe - Africa - Middle East", "Americas"))

# region graph
ggplot(sumRegion, aes(year, capAvgChange, group = Region, color = Region)) +
  geom_line() +
  geom_point(aes(group = seq_along(year))) + 
  scale_color_manual(values = c("#FF0000", "#008000", "#FFD700")) +
  transition_reveal(year) +
  view_follow(fixed_x = TRUE) +
  labs(title = "Percent Change for Region (Exchanges with Market Cap > $1 Trillion): 2004 - 2023",
       x = "Year", y = "Percent Change", caption = "Data retrieved from World-Exchanges.org Statistics Portal")+
  theme_minimal() +
  theme(plot.caption = element_text(hjust = .5), plot.title = element_text(hjust = .5, size = 10),
        plot.margin = margin( l = 30, unit = "pt"))


anim_save("C:\\Users\\dtafm\\OneDrive\\Desktop\\data.science\\R\\Work.R\\lis4370\\daniel.R\\lis4317finalproj\\regionAnimation.gif")

# exchange graph. http://127.0.0.1:29105/graphics/plot_zoom_png?width=990&height=358
ggplot(percentChangedf, aes(year, value, group = Name, color = Name)) +
        geom_line() +
        geom_point(aes(group = seq_along(year))) +
        scale_color_manual(values = c(
             "#FF0000",  # Red
             "#008000",  # Green
             "#FFD700",  # Gold
             "pink",  # White
             "#000000",  # Black
             "#800000",  # Maroon
             "#228B22",  # Forest Green
             "#B22222",  # Firebrick
             "#FFFF00",  # Yellow
             "#FF6347",  # Tomato
             "#C71585",  # Medium Violet Red
             "#32CD32",  # Lime Green
             "#D2691E",  # Chocolate
             "#A52A2A",  # Brown
             "#ADD8E6",  # Light Blue
             "#8A2BE2",  # Blue Violet
             "#FF4500",  # Orange Red
             "#7FFF00",  # Chartreuse
             "#FFD700"   # Gold (repeated for contrast)
          )) +
    labs(title = "Percent Change for Stock Exchanges (Market Cap > $1 Trillion): 2004 - 2023", x = "Year", y = "Percent Change",
    caption = "Data retrieved from World-Exchanges.org Statistics Portal")+
    theme_minimal() +
    theme(plot.caption = element_text(hjust = .5), plot.title = element_text(hjust = .5)) 

percentChangedf$Name <- reorder(percentChangedf$Name, percentChangedf$value, FUN = max)

ggplot(percentChangedf, aes(factor(Name), value)) +
  theme_clean() +
  geom_tufteboxplot(outlier.colour="transparent", aes(color = factor(Region)),  size = 3) + 
  scale_color_manual(values = c( "#FFD700", "#FF0000", "#008000")) +
  labs(title = "Percent Change for Stock Exchanges (Market Cap > $1 Trillion): 2004 - 2023", x = "Exchange Name", y = "Percent Change",
       caption = "Data retrieved from World-Exchanges.org Statistics Portal", color = "Region")+
  theme_minimal() +
  theme(plot.caption = element_text(hjust = .5), plot.title = element_text(hjust = .5)) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1), legend.position = "bottom", 
        plot.margin = margin( l = 55, unit = "pt"))



# preprocess data for market cap scatterplot
data2 <- read_excel("lis4317finalproj\\exchangedata.xlsx")
data2 <- data2[-(753:nrow(data2)),]

# subset 2023 data for initial scatter plot
scatter <- subset(data2, Year == 2023)
scatter$Value <- (as.numeric(scatter$Value)/1000000)
listedNum2 <- subset(scatter, `Indicator Name` == "Total Equity Market - Number of listed companies (Total)")
scatter <- subset(scatter, `Indicator Name` == "Total Equity Market - Market Capitalisation")
scatter <- scatter %>%
full_join(listedNum2, by =  "ExchangeName")
scatter$YTD.y <- as.numeric(scatter$YTD.y)
 
ggplot(scatter, aes(YTD.y, Value.x, color = as.factor(Region.x))) +
         geom_point() +
         geom_text_repel(aes(label = ExchangeName), size = 4, max.overlaps = 15) +
         scale_x_continuous(breaks = pretty(scatter$YTD.y, labels = pretty(scatter$YTD.y )))+
         scale_y_continuous(breaks = pretty(scatter$Value.x, labels = pretty(scatter$Value.x ))) +
        scale_color_manual(values = c("#FF0000", "#008000", "#FFD700")) +
         labs(title = "Market Capitalization of Major Stock Exchanges (> $1 Trillion) 2023", x = "Listed Companies", y = "Market Cap (in Trillions)",
                       caption = "Data retrieved from World-Exchanges.org Statistics Portal", color = "Region")+
         theme_minimal() +
         theme(plot.caption = element_text(hjust = .5), plot.title = element_text(hjust = .5, vjust = 1), plot.title.position = "panel") 
