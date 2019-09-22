##########################################
##### HW3 data
# Weisberg, Applied Linear Regression, 3rd ed., problem 5.5, page 113. 
# https://onlinelibrary.wiley.com/doi/book/10.1002/0471704091
# Cathy Su

##########################################
#install.packages("alr3")
library(alr3)
help(snowgeese)
head(snowgeese)
##########################################
# scatterplot
pairs(snowgeese, pch = 19, lower.panel = NULL)
library(car)
model1<- lm(photo~obs1,data=snowgeese)
summary(model1)
linearHypothesis(model1, "obs1 = 1")
##########################################
# scatterplot
model1 <- 
model2<- lm(sqrt(photo)~sqrt(obs1),data=snowgeese)
summary(model2)

> pval <- 1- pf(f, 2, d)
> pval
[1] 0.01143571
# square root: stabilize the error variance
model3<- lm(sqrt(photo)~sqrt(obs1),data=snowgeese)
summary(model2)

# square root: stabilize the error variance
model3<- lm(sqrt(photo)~sqrt(obs1),data=snowgeese)

# obs1x sigma^2 variance
model4 <- lm(photo~obs1, weights = 1/obs1, data=snowgeese)
summary(model4)
# average
summary(lm(sqrt(photo)~sqrt(obs2),data=snowgeese))

# diff
summary(lm(sqrt(photo)~sqrt(obs2),data=snowgeese))
