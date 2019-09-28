install.packages("lubridate")
install.packages("dplyr")
install.packages("ggthemes")

library(dplyr)
library(lubridate)
library(tidyverse)
library(ggthemes)

sets_df <- read.csv("/Users/hh/Downloads/sets.csv", header=TRUE, check.names = FALSE)
inv_df <- read.csv("/Users/hh/Downloads/inventories.csv", header=TRUE, check.names = FALSE)
invPart_df <- read.csv("/Users/hh/Downloads/inventory_parts.csv", header=TRUE, check.names = FALSE)
col_df <- read.csv("/Users/hh/Downloads/colors.csv", header=TRUE, check.names = FALSE)

names(sets_df)
names(sets_df)[2] <- 'sets_name'

names(inv_df)
names(inv_df)[1] <- 'inventory_id'
names(inv_df)[2] <- 'version'

names(invPart_df)

names(col_df)
names(col_df)[1] <- 'color_id'
names(col_df)[2] <- 'color_name'

merged_df <- sets_df %>% 
  left_join(inv_df, by = c("set_num")) %>%
  left_join(invPart_df, by = c("inventory_id")) %>%
  left_join(col_df, by = c("color_id")) %>%
  select(sets_name, year, quantity, is_spare, color_id, color_name, rgb, is_trans)
merged_df <- na.omit(merged_df)

summary(merged_df)

# Analyze 1: Changes in sets

by_setname <- summarise(group_by(merged_df,year, sets_name),count =n()) %>% arrange(desc(count))
by_setname

by_setname_count <- ggplot(by_setname, aes(x = year, y = count)) + 
  geom_jitter(color="blue", alpha = .6) +
  stat_smooth(method='lm', se=FALSE, col="grey")
by_setname_count

target_year <- c(1960, 1970, 1980, 1990, 2000, 2010, 2019)
target_set <- c('Fire Station', 'Universal Building Set', 'Basic Building Set', 'Sandcrawler', 'Hogwarts Castle', 'Death Star', 'UCS Millennium Falcon')
by_set <- merged_df %>% filter(sets_name %in% target_set) %>% group_by(year, sets_name) %>% summarize(quantity_of_sets = sum(as.numeric(quantity))) %>% arrange(desc(quantity_of_sets))
glimpse(by_set)
summary(by_set)

by_set_gr <- ggplot(by_set, aes(x = year, y = quantity_of_sets, color = sets_name)) + 
  geom_point(size = 4, alpha = 0.6) +
  facet_grid(.~sets_name) +
  labs(title = "Changes in quantity of sets") 
# by_set_gr + theme_economist(horizontal=FALSE) + scale_colour_economist()
by_set_gr + theme_stata(scheme = "s2mono")

# Analyze 2: Changes in colors producing bricks over time
by_color_name <- summarise(group_by(merged_df,year, color_name),count =n()) %>% arrange(desc(count))
by_color_name

by_color_count <- ggplot(by_color_name, aes(x = year, y = count)) + 
  geom_jitter(color="#009999", alpha = .6)+
  stat_smooth(method='lm', se=FALSE, col="grey") +
  labs(title = "Changes in colors producing bricks over time")
by_color_count

target_set <- c('Black', 'Light Bluish Grey', 'White', 'Dark Bluish Gray', 'Red', 'Reddish Brown', 'Tan', 'Yellow')
by_set <- merged_df %>% filter(sets_name %in% target_set) %>% group_by(year, sets_name) %>% summarize(quantity_of_sets = sum(as.numeric(quantity))) %>% arrange(desc(quantity_of_sets))
glimpse(by_set)
summary(by_set)

by_set_gr <- ggplot(by_set, aes(x = year, y = quantity_of_sets, color = sets_name)) + 
  geom_point(size = 4, alpha = 0.6) +
  facet_grid(.~sets_name) +
  labs(title = "Changes in quantity of sets") 
# by_set_gr + theme_economist(horizontal=FALSE) + scale_colour_economist()
by_set_gr + theme_stata(scheme = "s2mono")

