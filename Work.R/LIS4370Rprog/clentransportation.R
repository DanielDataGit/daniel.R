library(readxl)
library(writexl)

path <- "C:/Users/dtafm/Downloads/Monthly_Modal_Time_Series-1-1-1.xlsx"
data <- as.data.frame(read_excel(path))

getcols <- data[,c("Year", "Ridership", "Collisions with Motor Vehicle", "Collisions with Person")]


df_summarized <- data %>%
    group_by(Year) %>%
    summarise(
    
      vehicleCollisions = sum(`Collisions with Motor Vehicle`),
      personCollisions = sum(`Collisions with Person`),     
      )

write_xlsx(df_summarized, "C:/Users/dtafm/Downloads/cleantimeseriesv3.xlsx")

ggplot(df_summarized, aes())