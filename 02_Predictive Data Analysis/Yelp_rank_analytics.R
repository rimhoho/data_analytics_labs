install.packages("broom")
install.packages("GGally")

library(tidyverse)
library(lubridate)
library(broom)
library(GGally)

raw_ny <- read.csv("/Users/hh/Documents/Pratt/Data_Analytics/Data_analytics_labs/02_Predictive Data Analysis/1. Gathering & Cleaning Data/Dataset/Yelp_Ranking_NY.csv", header=TRUE, check.names = FALSE)
raw_sf <- read.csv("/Users/hh/Documents/Pratt/Data_Analytics/Data_analytics_labs/02_Predictive Data Analysis/1. Gathering & Cleaning Data/Dataset/Yelp_Ranking_SF.csv", header=TRUE, check.names = FALSE)
raw_chi <- read.csv("/Users/hh/Documents/Pratt/Data_Analytics/Data_analytics_labs/02_Predictive Data Analysis/1. Gathering & Cleaning Data/Dataset/Yelp_Ranking_CHI.csv", header=TRUE, check.names = FALSE)



## 1 --- Using raw_ny dataset, pick two variables "price" and "num_review" --- ##
ny <- raw_ny[, c(1, 3, 4, 5)]
glimpse(ny)

lm_ny <- lm(price ~ ranking, data=ny)
summary(lm_ny)

fitted_ny <- fitted.values(lm_ny)
fitted_ny
residuals_ny <- residuals(lm_ny)
residuals_ny

lm_matrix_ny <- broom::augment(lm_ny)
head(lm_matrix_ny)
lm_matrix_ny$.resid_abs <- abs(lm_matrix_ny$.resid)
lm_matrix_ny %>% arrange(desc(.resid_abs)) %>% head()

new_ny <- data.frame("ranking" = 1)
new_ny
predict(lm_ny, newdata=new_ny)

myny <- broom::augment(lm_ny, newdata = new_ny)
myny

ggplot(data=ny, aes(x=ranking, y=price)) + geom_point() +
  geom_smooth(method = 'lm') + geom_point(data=myny, aes(y=.fitted), size = 3, color = 'red') +
  labs(title='Median Price by Ranking with predict model')

ggpairs(data = ny, columns = 1:4)
cor(ny$ranking, ny$price)



## --- 2 Using raw_sf dataset, pick two variables "price" and "num_review" --- ##
sf <- raw_sf[, c(1, 3, 4, 5)]
glimpse(sf)

lm_sf <- lm(price ~ ranking, data=sf)
summary(lm_sf)

fitted_sf <- fitted.values(lm_sf)
fitted_sf
residuals_sf <- residuals(lm_sf)
residuals_sf

lm_matrix_sf <- broom::augment(lm_sf)
head(lm_matrix_sf)
lm_matrix_sf$.resid_abs <- abs(lm_matrix_sf$.resid)
lm_matrix_sf %>% arrange(desc(.resid_abs)) %>% head()

new_sf <- data.frame("ranking" = 1)
new_sf
predict(lm_sf, newdata=new_sf)

mysf <- broom::augment(lm_sf, newdata = new_sf)
mysf

ggplot(data=sf, aes(x=ranking, y=price)) + geom_point() +
  geom_smooth(method = 'lm') + geom_point(data=mysf, aes(y=.fitted), size = 3, color = 'red') +
  labs(title='Median Price by Ranking with predict model')

ggpairs(data = sf, columns = 1:4)
cor(sf$ranking, sf$price)



## --- 3 Using raw_sf dataset, pick two variables "price" and "num_review" --- ##
chi <- raw_chi[, c(1, 3, 4, 5)] 
glimpse(chi)

lm_chi <- lm(price ~ ranking, data=chi)
summary(lm_chi)

fitted_chi <- fitted.values(lm_chi)
fitted_chi
residuals_chi <- residuals(lm_chi)
residuals_chi

lm_matrix_chi <- broom::augment(lm_chi)
head(lm_matrix_chi)
lm_matrix_chi$.resid_abs <- abs(lm_matrix_chi$.resid)
lm_matrix_chi %>% arrange(desc(.resid_abs)) %>% head()

new_chi <- data.frame("ranking" = 1)
new_chi
predict(lm_chi, newdata=new_chi)

mychi <- broom::augment(lm_chi, newdata = new_chi)
mychi

ggplot(data=chi, aes(x=ranking, y=price)) + geom_point() +
  geom_smooth(method = 'lm') + geom_point(data=mychi, aes(y=.fitted), size = 3, color = 'red') +
  labs(title='Median Price by Ranking with predict model')

ggpairs(data = chi, columns = 1:4)
cor(chi$ranking, chi$num_review)
