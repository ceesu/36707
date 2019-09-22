##########################################
##### HW4 data
# Elements of Statistical Learning, exercise 7.9.
# Q4 http://rosmarus.refsmmat.com/datasets/datasets/false-positive/
# Cathy Su

##########################################
# Q3 Carry out the best subset linear regression analysis
# Elements of Statistical Learning, exercise 7.9.

#import hte data
prostate <- read.csv("~/36707/data/prostate.data", sep = "\t")
head(prostate)
# AIC

# BIC

# five fold CV

# 10fold CV


##########################################
# Q4 scatterplot

  # http://rosmarus.refsmmat.com/datasets/datasets/false-positive/
  # Build a regression model to predict feelold using all variables that should not be related (so
  #                                                                                             
# don’t include the subject’s actual age or their parents’ ages, for instance). Don’t get too picky

#  Add all two-way interactions of the variables you chose.
# Now use forward stepwise regression, subset selection, and the lasso to find a sets of covariates
# you believe are the best predictors of feelold. Use only Study 1 data for this part. Estimate
# 
# the prediction error of your each model (stepwise, subset selection, and lasso) by using cross-
#   validation.
# 
# Now load the data from Study 2. Using the same models and same coefficients you used in Study
# 1, make predictions and get the test errors. (The predict function will be useful.) How do
# they compare to your estimates? Were your estimates biased, and if so, why? Do you actually
# believe the relationships you found?

study1 <- read.csv("~/36707/data/study-1.csv")
head(study1)
study2 <- read.csv("~/36707/data/study-2.csv")
head(study2)