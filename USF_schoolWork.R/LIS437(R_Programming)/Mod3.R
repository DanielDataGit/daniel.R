library(ggplot2)

#create vectors to fill dataframe

Name <- c("Jeb", "Donald", "Ted", "Marco", "Carly", "Hillary", "Berine")

ABC <- c(4, 62, 51, 21, 2, 14, 15)

CBS  <- c(12, 75, 43, 19, 1, 21, 19) 

# fill df with vectors

df <- data.frame(Name, ABC, CBS, ABC+CBS)
df <- df[order(-df$ABC...CBS), ]


ggplot(df, aes(x = reorder(Name, -ABC...CBS), y = ABC...CBS)) +
  geom_col() 
  
