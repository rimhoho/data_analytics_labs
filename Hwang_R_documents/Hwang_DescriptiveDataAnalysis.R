install.packages("gapminder")

library(tidyverse)
library(dplyr)
library(gapminder)

??gapminder
summary(gapminder)
glimpse(gapminder)

head(gapminder)
tail(gapminder)
sum(is.na(gapminder))

gp_cnt_life <- select(gapminder, country, lifeExp)
gp_cnt_life

gp_no_pop <- select(gapminder, -pop)
gp_no_pop

gp_1957 <- gapminder %>% filter(year == "1957")
head(gp_1957)
glimpse(gp_1957)

gp_us <- gapminder %>% filter(country == "United States")
head(gp_us)

gp_1957_asia <- gapminder %>% filter(year == "1957", continent == "Asia")
head(gp_1957_asia, 15)

write.csv(gp_1957_asia, '/Users/hh/Documents/Pratt/Data_Analytics/data_analytics_labs/Hwang_R_documents/gapminder1957Asia.csv ')

gapminder %>% arrange(pop)

gapminder %>% arrange(desc(pop))

gapminder %>% filter(year == '1957') %>% arrange(desc(pop))

gapminder %>% mutate(popMil = pop/1000000)
head(gapminder)

gapminder %>% mutate(gdp = pop * gdpPercap)

gapminder %>%
  mutate(gdp = pop * gdpPercap) %>%
  filter(year == '1957') %>%
  arrange(desc(gdp))

gapminder %>% summarize(meanLifeExp = mean(lifeExp))


gapminder %>%
  filter(year == '2007') %>% 
  summarize(meanLifeExp = mean(lifeExp))

gapminder %>%
  filter(year == '1957') %>% 
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(as.numeric(pop)))

gapminder %>%
  filter(year == '1957') %>% 
  group_by(continent) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(as.numeric(pop)))

gapminder %>%
  group_by(continent, year) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(as.numeric(pop)))

gapminder %>%
  group_by(continent, year) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(as.numeric(pop)),
            meanGDP = mean(as.numeric(pop * gdpPercap))
            )

by_year <- gapminder %>%
  group_by(year) %>%
  summarize(totalPop = sum(as.numeric(pop)),
            meanLifeExp = mean(lifeExp))
head(by_year)

ggplot(by_year, aes(x = year, y = totalPop)) + 
  geom_point()

ggplot(by_year, aes(x = year, y = totalPop)) + 
  geom_point() +
  expand_limits(y = 0)

by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(totalPop = sum(as.numeric(pop)),
            meanLifeExp = mean(lifeExp))
head(by_year_continent)

ggplot(by_year_continent, aes(x = year, y = totalPop, color = continent)) + 
  geom_point() +
  expand_limits(y = 0)

by_year_continent_GDPCap <- gapminder %>%
  group_by(year, continent) %>%
  summarize(totalPop = sum(as.numeric(pop)),
            meanLifeExp = mean(lifeExp),
            meanGDPCAP = mean(gdpPercap))
head(by_year_continent_GDPCap)

ggplot(by_year_continent_GDPCap, aes(x = year, y = meanGDPCAP, color = continent)) +
  geom_point() +
  expand_limits(y = 0)

gap2007 <- gapminder %>% filter(year == '2007')

gap2007[which.min(gap2007$lifeExp),]
gap2007[which.min(gap2007$pop),]
gap2007[which.min(gap2007$gdpPercap),]

start_year <- min(gapminder['year'])
end_year <- max(gapminder['year'])
start_pop <- min(gapminder['pop'])
end_pop <- max(gapminder['pop'])

pop_growth_rate <- (end_pop - start_pop)/(end_year - start_year)
pop_growth_rate

gap_grouped <- gapminder %>%
  group_by(year, continent) %>%
  summarize(totalPop = sum(as.numeric(pop)),
            meanLifeExp = mean(lifeExp),
            meanGDPCAP = mean(gdpPercap))
summary(gap_grouped)

ggplot(gap_grouped, aes(x = year, y = totalPop, color = continent)) + 
  geom_point()
ggplot(gap_grouped, aes(x = year, y = meanLifeExp, color = continent)) + 
  geom_point()
ggplot(gap_grouped, aes(x = year, y = meanGDPCAP, color = continent)) + 
  geom_point()

my_continent <- c('Africa', 'Asia','Europe','Oceania')
sapply(my_continent, function(cont){gapminder %>% filter(continent == cont) %>% summary()})
