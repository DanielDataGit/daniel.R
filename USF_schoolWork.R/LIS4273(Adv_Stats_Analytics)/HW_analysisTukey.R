# Question 1)
# We are comparing three groups by stress level,
# I need a qualitative(group name)and quantative(level data) set
Null Hypothesis: The means of each group are the same
Alternative Hypothesis: atleast one mean is different from the rest
groups <- rep(c("High", "Mod", "Low"), each = 6) #Creates vector where each variable holds 6 data

meansStress <- c(c(10,9,8,9,10,8),c(8,10,6,7,8,8),c(4,6,6,4,2,2)) #combines stress data

datafr <- data.frame(groups, meansStress) 

ggplot(datafr) + aes(x=groups, y=meansStress) + geom_jitter() #cool visual, checks that R is processing data correctly

fit <- aov(meansStress ~ groups, data = datafr) #runs anova analysis
summary(fit) 

             Df Sum Sq Mean Sq F value   Pr(>F)    
groups       2  82.11   41.06   21.36 4.08e-05 ***
Residuals   15  28.83    1.92   

Interpretation of results
Df: is 2, groups-1. DF is the number of values that can vary in a data set
Sum Sq: is 82.11, n(groupmean-totalmean)^2 + repeat on next group. Measures dispersion of all data and how it fits the model.
Mean Sq: is 41.06, Sum sq/DF. Measures average variability between group means.
F value: is 21.36, Mean sq/DF. Helps determine if there are significant differences of groups
Pr(>F):is .0000408, Uses f ratio to quantify the difference amongst the groups.
Since the P value is tiny (less than .05), there is sufficient evidence that at least one groups mean is different from the others.Thus we reject the null hypothesis
This is to be expected given the different values of stress in high, moderate, and low.

Question 2)

print(zelazo)

active <-c(9.00,9.50,9.75,10.00,13.00)
passive <-c(11.00,10.00,10.00,11.75,10.50)
none<-c(11.50,12.00,9.00,11.50,13.25)
ctr.8w <-c(13.25,11.50,12.00,13.50,11.50)


df <- data.frame(active, passive, none, ctr.8w)
null hypothesis: No variation between groups
alternative hypothesis: Variation between groups

t.test(active,none)

P-value is .2595, thus we do not reject null hypothesis. We conclude that their is not significant difference between training or not training.

t.test(active, ctr.8w)

P_value is .04075, thus we reject null hypothesis. We conclude that their is a significant difference between the trained babies and those tested only at 8 weeks. Stage fright?

t.test(active, passive)

P-value is .6278, thus we do not reject null hypothesis.We conclude that their is not significant difference between trained babies and passively trained babies.All you need in life is a positive attitude.

#for anova testing We replicate what we did above for stress
groups2<- rep(c("active", "passive", "none", "ctr.8w"), each = 5)
babydata<-c(c(9.00,9.50,9.75,10.00,13.00),c(11.00,10.00,10.00,11.75,10.50),c(11.50,12.00,9.00,11.50,13.25),c(13.25,11.50,12.00,13.50,11.50))

df2<- data.frame(groups2,babydata)

fit2 <- aov(babydata ~ groups2, data=df2)
summary(fit2)

p-value is .0796, since it is greater than .05 there is not sufficient evidence that the group means differ from eachother.
For further analysis I will do a post-hoc test to see if any of the groups are different


TukeyHSD(fit2)

           diff        lwr       upr     p adj
ctr.8w-active   2.1 -0.1821005 4.3821005 0.0769086
none-active     1.2 -1.0821005 3.4821005 0.4578266
passive-active  0.4 -1.8821005 2.6821005 0.9575505
none-ctr.8w    -0.9 -3.1821005 1.3821005 0.6780327
passive-ctr.8w -1.7 -3.9821005 0.5821005 0.1854081
passive-none   -0.8 -3.0821005 1.4821005 0.7499347

All adj P-values are greater than .05, thus we accept the null hypothesis for all comparisons
