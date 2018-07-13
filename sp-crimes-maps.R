setwd('~/Documents/dsa/EstudosProprios/CrimesSP/data')
getwd();

install.packages("ggmap")
install.packages("ggplot2")
library(ggmap)
library(ggplot2)

unzip("clean_2016.zip")

df <- read.csv("clean_2016.csv")

options(warn=-1)

map <- qmap("sao paulo", zoom = 11, source = "stamen", 
             maptype = "toner", darken = c(.3,"#BBBBBB"))
map

map + geom_point(data = df, aes(x = longitude, y = latitude))


map + geom_point(data = df, aes(x = longitude, y = latitude), 
                  color = "dark green", alpha = .03, size = 1.1)

map +
  stat_density2d(data = df, aes(x = longitude, y = latitude, 
                                color = ..density.., 
                                size = ifelse(..density..<= 1,0,..density..), 
                                alpha = ..density..), geom = "tile",contour = F) +
  scale_color_continuous(low = "orange", high = "red", guide = "none") +
  scale_size_continuous(range = c(0, 3), guide = "none") +
  scale_alpha(range = c(0,.5), guide = "none") +
  ggtitle("Crimes em Sao Paulo") +
  theme(plot.title = element_text(family = "Trebuchet MS", size = 36, face = "bold", hjust = 0, color = "#777777")) 
