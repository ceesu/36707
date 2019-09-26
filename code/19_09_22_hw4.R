##########################################
##### HW4 data
# Elements of Statistical Learning, exercise 7.9.
# Q4 http://rosmarus.refsmmat.com/datasets/datasets/false-positive/
# Cathy Su

##########################################
# Q3 Carry out the best subset linear regression analysis
# Elements of Statistical Learning, exercise 7.9.
# Ex. 7.9 For the prostate data of Chapter 3, carry out a best-subset linear
# regression analysis, as in Table 3.3 (third column from left). Compute the
# AIC, BIC, five- and tenfold cross-validation estimates
# of prediction error. Discuss the results.

library(tidyverse)
library(caret)
#install.packages("caret")
#install.packages("leaps")
#install.packages("bestglm")
library(bestglm)
library(leaps)
library(glmnet)

#import hte data
# The data for this example come from a study by Stamey et al. (1989). They
# examined the correlation between the level of prostate-specific antigen and
# a number of clinical measures in men who were about to receive a radical
# prostatectomy.
# The variables are log cancer volume (lcavol), log prostate
# weight (lweight), age, log of the amount of benign prostatic hyperplasia
# (lbph), seminal vesicle invasion (svi), log of capsular penetration (lcp),
# Gleason score (gleason), and percent of Gleason scores 4 or 5 (pgg45).
# both lcavol and lcp show a strong relationship with the
# response lpsa, and with each other.
prostate <- read.csv("~/36707/data/prostate.data", sep = "\t")
head(prostate)
train <- prostate[prostate$train == TRUE, 2:10] # 67 obs
test <- prostate[prostate$train == FALSE, 2:10] # 30 obs
train_dat <- train
colnames(train_dat)[9] <- "y"
test_dat <- test
colnames(test_dat)[10] <- "y"
data <- prostate[2:10]
colnames(data)[9] <- "y"
# perform best subsets
# how to choose k involves the tradeoff between bias and variance
#http://www.sthda.com/english/articles/37-model-selection-essentials-in-r/155-best-subsets-regression-essentials-in-r/
# they 

library(leaps)
models <- regsubsets(lpsa~., data = prostate)
summary(models)
subsets_res

# AIC to select
library(bestglm)
res.bestglm <- bestglm(data, IC="AIC")
summary(res.bestglm$BestModel)
# BIC
# subsets_res$bic
# choice <- which.min(subsets_res$bic)
res.bestglm <- bestglm(data, IC="BIC")
summary(res.bestglm$BestModel)
# five fold CV following approach from variable-selection-code.Rmd
cvfit <- cv.glmnet(as.matrix(prostate[,-9]), prostate[, 9], nfolds=5, type.measure="mse")
cvfit$cvm[cvfit$lambda == cvfit$lambda.min] 
coef(cvfit, s = "lambda.min")

# 10fold CV
cvfit <- cv.glmnet(as.matrix(prostate[,-9]), prostate[, 9], nfolds=10, type.measure="mse")
cvfit$cvm[cvfit$lambda == cvfit$lambda.min] 
coef(cvfit, s = "lambda.min")

###### TEST ERRORS?
# five fold CV MSE
fit5 <-cv.glmnet(as.matrix(train[,-9]), train[, 9], nfolds=5, 
                 type.measure="mse")
yhat <- predict(fit5, s=fit5$lambda.1se, newx=as.matrix(test[,-9]))
mse <- mean((test[, 9] - yhat)^2)

# 10 fold CV MSE
fit10 <-cv.glmnet(as.matrix(train[,-9]), train[, 9], nfolds=10, 
                 type.measure="mse")
yhat <- predict(fit10, s=fit10$lambda.1se, newx=as.matrix(test[,-9]))
mse <- mean((test[, 9] - yhat)^2)

##########################################
# Q4 scatterplot

  # http://rosmarus.refsmmat.com/datasets/datasets/false-positive/
                                                                                           

study1 <- read.csv("~/36707/data/study-1.csv")
head(study1)

# Build a regression model to predict feelold 
# using all variables that should not be related (so
# don’t include the subject’s actual age or their parents’ ages, 
# for instance). Don’t get too picky.

vars <- colnames(study1)[4:12, 13]
lm(a ~ (b + c + d)^2)
#  Add all two-way interactions of the variables you chose.
# https://stackoverflow.com/questions/47144532/how-to-include-all-possible-two-way-interaction-terms-in-a-linear-model-in-r


# Now use forward stepwise regression, subset selection, and the lasso to find a sets of covariates
# you believe are the best predictors of feelold. Use only Study 1 data for this part. 



#Estimate the prediction error of your each model 
# (stepwise, subset selection, and lasso) by using cross-validation.
# 5-fold? on the study1 data only (is this not the 'wrong' way?)


# Now load the data from Study 2. Using the same models and same coefficients you used in Study
# 1, make predictions and get the test errors. (The predict function will be useful.) How do
# they compare to your estimates? Were your estimates biased, and if so, why? Do you actually
# believe the relationships you found?
study2 <- read.csv("~/36707/data/study-2.csv")
head(study2)