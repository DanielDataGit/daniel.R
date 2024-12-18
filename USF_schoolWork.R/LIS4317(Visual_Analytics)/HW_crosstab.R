# Module # 8 Correlation Analysis and ggplot2
# goal: create a pretty crosstab display of mtcars

library(ggplot2)
library(reshape2)
#install.packages("corrgram")
library(corrgram)
#install.packages("ggpubr")
library(ggpubr)
data <- mtcars

# Melt the data we need

dataMelt <- melt(data, id.vars = c("wt", "am"), measure.vars = c("mpg", "hp", "disp"))

# create crosstab, https://r-charts.com/ggplot2/facets/, https://rpkgs.datanovia.com/ggpubr/reference/stat_cor.html

ggplot(dataMelt, aes(wt, value)) +
  geom_point() +
  geom_smooth(method = "lm", color = "darkblue") +
  stat_cor()+
  facet_grid(variable ~ am, scales = "free", space = "free_x", labeller = labeller(am = c("0" = "Automatic", "1" = "Manual"))) +
  labs(title = "Crosstab of MPG, HP, and disp by Weight, Split by Transmission Type", 
       x = "Weight (1000 lbs)", y = "Value") +
  theme(strip.text = element_text(size = 15),
        strip.background = element_blank(),
        panel.border = element_rect(fill = "transparent", color = "black", linewidth = 1)) 
 


