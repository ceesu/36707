##########################################
##### HW3 data
# Weisberg, Applied Linear Regression, 3rd ed., problem 5.5, page 113. 
# https://onlinelibrary.wiley.com/doi/book/10.1002/0471704091
# Cathy Su

##########################################
# install.packages("alr3")
library(alr3)
help(snowgeese)
head(snowgeese)
##########################################
# scatterplot
pairs(snowgeese, pch = 19, lower.panel = NULL)
model1<- lm(photo~obs1,data=snowgeese)
summary(model1)
##########################################
# scatterplot
model2<- lm(sqrt(photo)~sqrt(obs1),data=snowgeese)
summary(model2)

# square root: stabilize the error variance
model3<- lm(sqrt(photo)~sqrt(obs1),data=snowgeese)
summary(model2)

# square root: stabilize the error variance
model3<- lm(sqrt(photo)~sqrt(obs1),data=snowgeese)

# obs1x sigma^2 variance

# average
summary(lm(sqrt(photo)~sqrt(obs2),data=snowgeese))

# diff
summary(lm(sqrt(photo)~sqrt(obs2),data=snowgeese))
