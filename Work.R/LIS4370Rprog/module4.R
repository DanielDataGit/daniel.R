#install.packages("patchwork")
#install.packages("ggplot2")

library(ggplot2)
library(patchwork)

# provided data as a csv string
data <- 
  '"0.6","103","1","0","0"
     "0.3","87","1","0","1"
     "0.4","32","1","1","0"
     "0.4","42","1","1","1"
     "0.2","59","0","0","0"
     "0.6","109","0","0","1"
     "0.3","78","0","1","0"
     "0.4","205","0","1","1"
     "0.9","135","1","1","1"
     "0.2","176","1","1","1"'


#reads data into dataframe
df <- read.csv(text = data, header = FALSE, col.names = c("Freq","bloodp","first",
                                                          "second", "finaldecision"))

# ggplot box plot comparing freq~finaldecision
p1 <- ggplot(df, aes(x = as.factor(finaldecision), y = Freq))+
  geom_boxplot()

# ggplot box plot comparing bloodp~finaldecision
p2 <- ggplot(df, aes(x = as.factor(finaldecision), y = bloodp))+
  geom_boxplot()

p1+p2

ggplot(df, aes(Freq))+
  geom_histogram()

ggplot(df, aes(bloodp, fill = as.factor(finaldecision), color = as.factor(finaldecision)))+
  geom_histogram(binwidth = 50, alpha = .5)
