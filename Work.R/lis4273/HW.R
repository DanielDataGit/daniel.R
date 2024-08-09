9.1. I revised this question, so please follow my description only.
Conduct ANOVA (analysis of variance) and Regression coefficients to the data from cystfibr
(> data (" cystfibr ") database. 
You can choose any variable you like. in your report, you need to state the result of
Coefficients (intercept) to any variables you like both under ANOVA and multivariate analysis. 
I am specifically looking at your interpretation of R results. 

library(ISwR)
data <- (cystfibr)
  
x <- lm(formula = cystfibr$pemax ~ age + weight + bmp + fev1, data=cystfibr)
x
anova(x)         

Analysis of Variance Table

Response: cystfibr$pemax
           Df  Sum Sq Mean Sq F value    Pr(>F)    
age        1 10098.5 10098.5 18.4385 0.0003538 ***
weight     1   945.2   945.2  1.7258 0.2038195    
bmp        1  2379.7  2379.7  4.3450 0.0501483 .  
fev1       1  2455.6  2455.6  4.4836 0.0469468 *  
Residuals 20 10953.7   547.7   


In the given model, we are testing the statistical signifigance between pemax to the other groups.
Given the low P-values, we can say that age and fev1 are significantly related to pemax. However, given the high p-values, 
we can say weight and bmp do not have a significant relation to pemax

Coefficients:
  (Intercept)          age       weight          bmp         fev1  
      179.296       -3.418        2.688       -2.066        1.088 
      
For every unit increase in age, the pemax goes down 3.418 units.      
For every unit increase in weight, the pemax goes up 2.688 units.
For every unit increase in bmp, the pemax goes down 2.066 units.
For every unit increase in fev1, the pemax goes up 1.088 units.

This tell us that an increase in age or body mass has a negative affect on maximum respritory pressure. Adjusted for the other 3 terms in the model
That an increase in weight or fev1 has a positive affect on maximum respritory pressure. Adjusted for the other 3 terms in the model

9.2 
How much is gained by using both diameters in a prediction equation? The sum of the two 
regression coefficients is almost identical and equal to 3.
Can this be given a nice interpretation to our analysis?
Please provide step by step on your analysis and code you use to find out the result. 

data2 <- secher

bwtlog <- log(secher$bwt)
bpdlog <- log(secher$bpd)
adlog <- log(secher$ad)

model <- lm(bwtlog~bpdlog + adlog)
summary(model)

Call:
  lm(formula = bwtlog ~ bpdlog + adlog)

Residuals:
  Min       1Q   Median       3Q      Max 
-0.35074 -0.06741 -0.00792  0.05750  0.36360 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -5.8615     0.6617  -8.859 2.36e-14 ***
  bpdlog        1.5519     0.2294   6.764 8.09e-10 ***
  adlog         1.4667     0.1467   9.998  < 2e-16 ***
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.1068 on 104 degrees of freedom
Multiple R-squared:  0.8583,	Adjusted R-squared:  0.8556 
F-statistic: 314.9 on 2 and 104 DF,  p-value: < 2.2e-16

model2 <- lm(bwtlog~adlog)
summary(model2)

Call:
  lm(formula = bwtlog ~ adlog)

Residuals:
  Min       1Q   Median       3Q      Max 
-0.58560 -0.06609  0.00184  0.07479  0.48435 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -2.4446     0.5103  -4.791 5.49e-06 ***
  adlog         2.2365     0.1105  20.238  < 2e-16 ***
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.1275 on 105 degrees of freedom
Multiple R-squared:  0.7959,	Adjusted R-squared:  0.794 
F-statistic: 409.6 on 1 and 105 DF,  p-value: < 2.2e-16

Both show statistical signifgance between birthweight and (bpd + ad) or (ad).
However,the use of both bpd and ad offers more precise analysis. The coefficients add to 3.0186 which
tells us that for every unit increase in ad and bpd, the btw increases by 3.0186
When only analyzing ad, we see that for every unit increase in ad, the btw increases by 2.365
                       
     


