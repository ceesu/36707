##########################################
##### HW4 data
# Elements of Statistical Learning, exercise 7.9.
# Q4 http://rosmarus.refsmmat.com/datasets/datasets/false-positive/
# Cathy Su

##########################################
# Q3 Carry out the best subset linear regression analysis
# Elements of Statistical Learning, exercise 7.9.
library(tidyverse)
library(caret)
#install.packages("caret")
#install.packages("leaps")
library(leaps)
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
# perform best subsets
# how to choose k involves the tradeoff between bias and variance
#http://www.sthda.com/english/articles/37-model-selection-essentials-in-r/155-best-subsets-regression-essentials-in-r/
# they 
models <- regsubsets(lpsa~., data = train, nvmax = 2)
summary(models)

model <- lm(lpsa ~ lcavol + lweight, data = swiss)
# AIC to select

# BIC

# five fold CV
# seee http://www.sthda.com/english/articles/38-regression-model-validation/157-cross-validation-essentials-in-r/


# 10fold CV

## Now do best subset regression.


##########################################
# Q4 scatterplot

  # http://rosmarus.refsmmat.com/datasets/datasets/false-positive/
                                                                                           

study1 <- read.csv("~/36707/data/study-1.csv")
head(study1)

# Build a regression model to predict feelold 
# using all variables that should not be related (so
# don’t include the subject’s actual age or their parents’ ages, 
# for instance). Don’t get too picky.


#  Add all two-way interactions of the variables you chose.


# Now use forward stepwise regression, subset selection, and the lasso to find a sets of covariates
# you believe are the best predictors of feelold. Use only Study 1 data for this part. 



#Estimate the prediction error of your each model 
# (stepwise, subset selection, and lasso) by using cross-
#   validation.


# Now load the data from Study 2. Using the same models and same coefficients you used in Study
# 1, make predictions and get the test errors. (The predict function will be useful.) How do
# they compare to your estimates? Were your estimates biased, and if so, why? Do you actually
# believe the relationships you found?
study2 <- read.csv("~/36707/data/study-2.csv")
head(study2)