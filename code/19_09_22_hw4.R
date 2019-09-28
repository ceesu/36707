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
cvfit <- cv.glmnet(as.matrix(data[,-9]), data[, 9], nfolds=5, type.measure="mse")
cvfit$cvm[cvfit$lambda == cvfit$lambda.min] 
coef(cvfit, s = "lambda.min")

# 10fold CV
cvfit <- cv.glmnet(as.matrix(data[,-9]), data[, 9], nfolds=10, type.measure="mse")
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
study1$cond <- as.factor(as.character(study1$cond))
study1$political<- as.factor(study1$political)
study1$bird<- as.factor(study1$bird)
study1$quarterback<- as.factor(study1$quarterback)
study1$root <- as.factor(study1$root)
head(study1)

# Build a regression model to predict feelold 
# using all variables that should not be related (so
# don’t include the subject’s actual age or their parents’ ages, 
# for instance). Don’t get too picky.

# https://stackoverflow.com/questions/5251507/how-to-succinctly-write-a-formula-with-many-variables-from-a-data-frame
vars <- colnames(study1)[c(4:8, 10:12, 14:16)]
fmla <- as.formula(paste("feelold ~ ", paste(vars, collapse= "+")))
fmla <- as.formula(paste("feelold ~ (", paste(vars, collapse= "+"), " )^2"))
fit <- lm(fmla, data = study1)
#  Add all two-way interactions of the variables you chose.
# https://stackoverflow.com/questions/47144532/how-to-include-all-possible-two-way-interaction-terms-in-a-linear-model-in-r

# Now use forward stepwise regression, subset selection, and the lasso to find a sets of covariates
# you believe are the best predictors of feelold. Use only Study 1 data for this part. 

## Stepwise regression
fit <- lm(feelold ~ 0., data = study1)
step_m <- step(fit, fmla, direction="forward")

##### Subset selection
library(leaps)
models <-leaps(study1[,c(4:8, 10:12, 14:16)], 
      study1[, c(13)], method = "forward")
models <- regsubsets(fmla, data = study1, nbest =1,
                     method = "forward")
res <-summary(models)
which.max(res$adjr2)
temp<-res$which[7,]
coef <- coef(models, 7)
paste(names(coef)[2: length(mod)], collapse= " + ")
mod <- res$which[7,]
names(mod)
paste(names(mod), collapse= "+")
plot(models, scale = "adjr2", main = "Adjusted R^2")

##### LASSO
library(glmnet)
predictors <- as.matrix(sapply(study1[,c(4:8, 10:12, 14:16)], as.numeric))  
# transform dataframe to matrices as required by glmnet
# https://stackoverflow.com/questions/27580267/how-to-make-all-interactions-before-using-glmnet
x <- model.matrix(fmla, study1)[, -1]
y <- as.matrix(study1[, c(13)], ncol=1)

#  decide which lambda to use
# must include a multi factor model
cvfit <- cv.glmnet(x, y)
cvfit$lambda.min
temp <-coef(cvfit, s = "lambda.min")
sub <- temp[temp[,1] > 0.0,0]  
lasso_fit <- glmnet(x, y)

# specify the models.
m_step <- "feelold ~ cond + bird + diner + quarterback + cond:bird + 
    bird:quarterback - 1"
m_subset <- paste("feelold ~ ", paste(names(mod)[2: length(mod)], collapse= " + "))
m_subset
m_lasso <- paste("feelold ~ ", paste(rownames(sub)[2:4], collapse= " + "))
m_lasso

#Estimate the prediction error of your each model 
# (stepwise, subset selection, and lasso) by using cross-validation.
# models


# Now load the data from Study 2. Using the same models and same coefficients you used in Study
# 1, make predictions and get the test errors. (The predict function will be useful.) How do
# they compare to your estimates? Were your estimates biased, and if so, why? Do you actually
# believe the relationships you found?
study2 <- read.csv("~/36707/data/study-2.csv")
head(study2)
colnames(study2)[12] <- "kalimba"

##########  PREDICTIONS 
test.mat <- model.matrix(fmla, study2)[,-1]
## stepwise
coefi= coef(step_m, id = 7)

## best subset
coef <- coef(models, 7)
pred_subs <-test.mat[,names(coef)]%*%coef

pred=test.mat[,names(coef)[2:8]]%*%coef[2:8] + coef[1]
mean((study2$feelold- pred)^2) 
## lasso
pred_lasso <-predict(lasso_fit, newx = test.mat, s=cvfit$lambda.min, type="response")
mean((study2$feelold- pred_lasso)^2) # 0.6011047

coefi= coef(step_m, id = 7)
names(coefi)[7] <- "bird:condcontrol"
names(coefi)[8] <- "bird:condpotato"
names(coefi)[1] <- "condcontrol"
pred=test.mat[,names(coefi)[2:9]]%*%coefi[2:9]+coefi[1]
mean((study2$feelold- pred)^2) 

predict(step_m, newdata = study2)
