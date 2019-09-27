install.packages("ggthemes")

library(ggthemes)
library(tidyverse)
library(dplyr)
library(lubridate)

?iris

data(iris)
summary(iris)
glimpse(iris)

sum(is.na(iris))

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + geom_point()
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + geom_jitter(alpha = .6)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + geom_jitter(alpha = .6)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + geom_jitter(alpha = .6) + labs(title = "Wepal Length by Sepal Width in Iris Dataset")

# Make Facets
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
  geom_jitter(alpha = .6) + 
  facet_grid(.~Species) + 
  labs(title = "Wepal Length by Sepal Width in Iris Dataset")

# Make a Trend line
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
  geom_jitter(alpha = .6) + 
  facet_grid(.~Species) + 
  stat_smooth(method = "lm", se = FALSE, col = "grey") +
  labs(title = "Wepal Length by Sepal Width in Iris Dataset")

# Make above codes into object 
iris_plot <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species))

iris_plot + geom_point()
iris_plot + geom_jitter(alpha = .6)
iris_plot + geom_line()

# Make a new point styling
posn <- position_jitter(width = .1)
iris_plot + geom_point(position = posn)

# Make a new dataset which contain a mean of each species
iris_summary <- aggregate(iris[1:4], list(iris$Species), mean)
names(iris_summary)[1] <- "Species"
iris_summary

# Make a circle containing the mean of each species
iris_plot + geom_point(position = posn) +
  geom_point(data = iris_summary, shape = 21, size = 5, fill = '#00000080')

# Make lines which cross the mean by each species
iris_plot + geom_point(position = posn) +
  geom_vline(data=iris_summary, linetype = 2,  aes(xintercept = Sepal.Length)) +
  geom_hline(data=iris_summary, linetype = 3,  aes(yintercept = Sepal.Width)) +
  facet_grid(.~Species)

iris_plot + 
  geom_point(position = posn, alpha = 0.5) +
  facet_grid(.~Species) +
  stat_smooth(method = "lm", se = FALSE, col = "grey") +
  scale_y_continuous("Sepal Width (cm)",
                     limits = c(1, 5),
                     expand = c(0, 0)) +
  scale_x_continuous("Sepal length (cm)",
                     limits = c(4, 8),
                     breaks = seq(2, 8, 2),
                     expand = c(0, 0)) +
  coord_equal()
  
iris_theme <- theme(panel.background = element_blank(),
        plot.background = element_blank(),
        legend.background = element_blank(),
        legend.key = element_blank(),
        strip.background = element_blank(),
        axis.text = element_text(color = 'black'),
        axis.ticks = element_line(color = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(color = 'black'),
        strip.text = element_blank(),
        panel.spacing = unit(1, 'lines') 
        )

isis_plot + geom_point(position = posn) +
  labs(title = "Wepal Length by Sepal Width in Iris Dataset") +
  theme_tufte()




