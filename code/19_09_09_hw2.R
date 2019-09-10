##########################################
##### 
# FOR HW 2 
# Cathy Su
##########################################
library(MASS)
help(cats)
graphics.off()

###### PART A 
# Fit the regression model and give a summary (e.g. with summary()) 
# showing the model parameters.
# Syntax: lm(y~x, data)
lm.fit = lm( Hwt~Bwt , data =cats)
summary(lm.fit)
###### PART B
# Build an analysis of variance table to test the model
# When testing an hypothesis with a categorical explanatory variable and a 
# quantitative response variable, the tool normally used in statistics is 
# Analysis of Variances, also called ANOVA.
anova(lm.fit)
###### PART C
# Obtain a 95% confidence interval for β1, using the R regression output.