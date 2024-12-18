#Question 1)
x <- c(16, 17, 13, 18, 12, 14, 19, 11, 11, 10)
y <- c(63, 81, 56, 91, 47, 57, 76, 72, 62, 48)

# Y = a + bX +e


#1.1 Define the relationship model between the predictor and the response variable:

model <- lm(y~x) # R equation for x,y relationship. Y is target, x is predictor
# Relationship Model :  Y = 19.206 + 3.269X + 10.48, the relationship has a positive correlation

plot(x,y)        # Plots x and y variables
abline(lm(y~x))  # Creates linear regression line

#1.2 Calculate the coefficients?

 summary(model) # gives information about relatioship model
# coefficients: regression coefficient = 3.269 intercept coefficient = 19.206

# question 2)
discharge <- c(3.600,1.800,3.333,2.283,4.533,2.883)
waiting <- c(79,54,74,62,85,55)

abline(lm(discharge~waiting))

visit <- data.frame(discharge, waiting)

model2 <- lm(discharge ~ waiting, data=visit)
summary(model2)

# Relationship Model : Y= -1.53317 + 0.06756X + 0.4724, the relationship has a positive correlation

coeffs = coefficients(model2); coeffs # extracts coefficients of model2
#(Intercept)     waiting 
#-1.53317418  0.06755757 

waitingnew <- 80
duration <- coeffs[1] + coeffs [2]*waitingnew
durationE <- coeffs[1] + coeffs [2]*waitingnew + .4724
# without error = 3.871431; with error = 4.343831. With 80 waiting, discharge would be between 3.871431 to 4.343831 minutes

#question 3)
input <- mtcars[,c("mpg","disp","hp","wt")]
print(head(input))
model3 <- lm(formula = mpg ~ disp + hp + wt, data = input)
summary(model3)

# The model evaluates how disp, hp, and wt affect mpg. The coefficients are all negative and p-value is low, meaning
# an increase in disp, hp, or weight is definetely associated to a decrease in MPG. Weight has the greatest effect
# on mpg, where a change of 1 mpg was noted by a change of -3.8 in weight. following is hp which saw
# a correlation of -.03, and disp which saw a correlation of -.0006.

#question 4)
install.packages(ISwR)
library(ISwR)
print(rmr)

model4<- lm(metabolic.rate~body.weight,data=rmr)

plot(rmr)
abline(model4)

coeffs = coefficients(model4); coeffs

newWeight <- 70

metabolic.rateNew1 <- coeffs[1] + coeffs [2]*newWeight
metabolic.rateNew2 <- coeffs[1] + coeffs [2]*newWeight + 157.9

# not including error = 1305.394
# including error = 1463.294
# The metabolic rate of a 70 kg person should fall within 1305.394 to 1463.294

sqrt(mean(modsum1$residuals^2))