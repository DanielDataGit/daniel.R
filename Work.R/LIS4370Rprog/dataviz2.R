
library(tidyverse)
library(scales)

# Create a column for car names
data <- mtcars %>% 
  mutate(car_name = rownames(mtcars)) %>%
  arrange(-mpg)
  

# Pivot longer by car names
  mtcars_long <- data %>% 
  pivot_longer(cols = -car_name, 
               names_to = "attribute", 
               values_to = "value")

# scale the data
mtcars_long <- mtcars_long %>% 
  group_by(attribute)%>%
  mutate(scaled_value = rescale(value, to = c(0, 1))) %>%
  ungroup()

#create factor to order car_names by mpg as in original data  
mtcars_long$car_name <- factor(mtcars_long$car_name, levels = data$car_name)

#create factor to order attributes
mtcars_long$attribute <- factor(mtcars_long$attribute, levels = c("mpg", "disp", "hp", "wt" , "drat", "qsec", "vs" , "am"  , "cyl" ,"gear",  "carb"))


labels <-  c("MPG", "Displacement", "Horsepower", "Weight", "Rear Axle Ratio", "Quarter-mile time", "0 = V, 1 = straight", "0 = auto, 1 = manual", "# of Cylinders", "# of Foward Gears", "# of Carbs")

#create heatmap using rescaled values
ggplot(mtcars_long, aes(attribute, car_name, )) +
     geom_tile(aes(fill = scaled_value), color = "black") +
     scale_fill_gradient(low = "lightblue", high = "blue") +
     labs(title = "Scaled Mtcars ordered by mpg",
          y = "Car",
          x = "Attribute",
          fill = "Scale") +
  scale_x_discrete(labels= labels)+
 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) 






