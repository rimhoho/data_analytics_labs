# Confidence
# CI (confidence interval): range of confidence that 95% of the data should fit here

install.packages("gmodels")

library(gmodels) #ci function to calculate confidence interval of a normally 
library(tidyverse)

bodytemp <- rnorm(10000, mean=97.82, sd=.69)
glimpse(bodytemp)
# num [1:10000] 97.1 95.5 99.4 98.1 99.1 ...
hist(bodytemp)

set.seed(1234)
# randomly select the sample

bodysample <- sample(bodytemp, 10)
mean(bodysample)
# [1] 97.94743

bodysample <- sample(bodytemp, 100)
mean(bodysample)
# [1] 97.86553

bodysample <- sample(bodytemp, 1000)
mean(bodysample)
# [1] 97.81215

our_sample <- numeric(10000)
for(i in 1:10000) {
  a_sample <- sample(bodytemp, 50) 
  our_sample[i] <- mean(a_sample)
}

hist(our_sample, breaks = 50)

# range of likely values 

temp_mean <- mean(bodytemp)
temp_stdev <- sd(bodytemp, na.rm = TRUE)
sample_size <- length(bodytemp)

temp_mean
# [1] 97.8145
temp_stdev
# [1] 0.6893587
sample_size # gscore is available over 100! if your dataset is under 100 use t-test.
# [1] 10000 

# Find CI in manually : asume that this is normal dstribution and use q-norm 
error_n <- qnorm(.975)*temp_stdev/sqrt(sample_size)
left_n <- temp_mean - error_n
right_n <- temp_mean + error_n

print(left_n) # 97.80098
print(right_n) # 97.82801

# 
help(ci.estimable)
ci(bodytemp, confidence = .95)
#   Estimate     CI lower     CI upper   Std. Error 
# 97.808597402 97.795074418 97.822120386  0.006898773 


realtemps <- read.csv("~/Documents/Pratt/Data_Analytics/Data_analytics_labs/DataSets/Normtemp.csv", header=TRUE)
glimpse(realtemps)
# Observations: 130
# Variables: 3
# $ Body.Temp  <dbl> 96.3, 96.7, …
# $ Gender     <int> 2, 2, 2, 2, …
# $ Heart.Rate <int> 70, 71, 74, …

realtemps$Gender <- as.factor(realtemps$Gender)
summary(realtemps)
hist(realtemps$Body.Temp)

real_mean <- mean(realtemps$Body.Temp)

#t-test to get ci
t.test(realtemps$Body.Temp, mu = real_mean, conf.level = .95)

# One Sample t-test

# data:  realtemps$Body.Temp
# t = 0, df = 129, p-value = 1
# alternative hypothesis: true mean is not equal to 98.24923
# 95 percent confidence interval:
#   98.12200 98.37646
# sample estimates:
#   mean of x 
# 98.24923 

