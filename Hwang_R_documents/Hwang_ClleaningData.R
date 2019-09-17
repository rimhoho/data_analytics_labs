install.packages("lubridate")
install.packages("dplyr")

library(dplyr)
library(lubridate)
library(tidyverse)

meals <- read.csv("/Users/hh/Documents/Pratt/Data_Analytics/info640/DataSets/mealplan.csv", skip=3, header=TRUE, check.names = FALSE)
class(meals)
dim(meals)
names(meals)
str(meals)
glimpse(meals)
summary(meals)
head(meals)
tail(meals)
meals1 <- gather(meals, date, value, -Meal, -Location)
head(meals1)
meals1 <- separate(meals1, value, c('entree', 'price'), sep=',')
head(meals1)
glimpse(meals1)
meals1$date <- mdy(meals1$date)
glimpse(meals1)

meals1$price <- gsub("\\$", "", meals1$price)
head(meals1)

meals1$price <- as.numeric(meals1$price)
glimpse(meals1)
summary(meals1)

hist(meals1$price)
unique(meals1$price)
meals1$price[meals1$price == 400] <- 4.00

hist(meals1$price)
summary(meals1)

meals1$Meal <- str_trim(meals1$Meal)
meals1$entree <- str_trim(meals1$entree)
meals1$Location <- str_trim(meals1$Location)

summary(meals1)
head(meals1)

unique(meals1$Meal)
unique(meals1$Location)

meals1$Meal[meals1$Meal == ''] <- "NA"
meals1$Location[meals1$Location == ''] <- "NA"

glimpse(meals1)

meals2 <- meals1[,]
head(meals2)
names(meals2) <- tolower(names(meals2))
head(meals2)
meals1$entree <- tolower(meals1$entree)
summary(meals2)

mean(meals2$price, na.rm=TRUE)
maxprice <- max(meals2$price, na.rm=TRUE)
print(maxprice)

meals2$price_imputed <- meals2$price
meals2$price_imputed[is.na(meals2$price_imputed)] <- maxprice

sum(meals2$price_imputed)
