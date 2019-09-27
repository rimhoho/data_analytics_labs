library(ggthemes)
library(tidyverse)
library(dplyr)
library(lubridate)

??ChickWeight 
data("ChickWeight")

summary(ChickWeight)

chicks <- ggplot(ChickWeight, aes(x = ChickWeight$weight))
chicks + geom_histogram()

diff(range(ChickWeight$weight))/40

chicks + geom_histogram(binwidth = 8.45)

ggplot(ChickWeight, aes(x = weight, fill = factor(Diet))) + 
  geom_histogram(aes(y = ..count../sum(..count..)), binwidth = 8.45, position= 'fill')

ggplot(ChickWeight, aes(x = weight, fill = factor(Diet))) + 
  geom_histogram(aes(y = ..count../sum(..count..)), binwidth = 8.45)

ggplot(ChickWeight,aes(x=Time, y=weight)) + geom_jitter(alpha=.6)
ggplot(ChickWeight,aes(x=Time, y=weight, color = Diet)) + geom_jitter(alpha=.6)
ggplot(ChickWeight,aes(x=Time, y=weight, color = Diet)) + geom_jitter(alpha=.6) + stat_smooth(method='lm', se=FALSE, col='grey')

ggplot(ChickWeight,aes(x=Time, y=weight, color = Diet)) + 
  geom_jitter(alpha=.6) + 
  facet_grid(.~Diet) +
  stat_smooth(method='lm', se=FALSE, col='grey')
