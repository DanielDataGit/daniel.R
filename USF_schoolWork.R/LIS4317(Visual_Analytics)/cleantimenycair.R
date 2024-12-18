library(writexl)
library(dplyr)

path <- "C:/Users/dtafm/Downloads/Air_quality.csv"

data <- data.frame(read.csv(path))

ozone <- data[data$Name == "Ozone (O3)",]

ozone <- ozone[order(ozone$Start_Date), ]

ozone <- ozone[,c("Start_Date", "Data.Value")]

cleaned <- ozone %>%
  group_by(Start_Date) %>%
  summarise(total_value = mean(Data.Value))


write_xlsx(cleaned, 'C:\\Users\\dtafm\\Downloads\\clean_qir_quality.xlsx')