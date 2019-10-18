install.packages('ggmap')
install.packages('ggplot2')
install.packages('raster')
install.packages('rgeos')
install.packages('maptools')
install.packages('rgdal')

library(ggmap)
library(ggplot2)
library(raster)
library(rgeos)
library(maptools)
library(rgdal)

geocode('Korea', source = 'google')
map <- shapefile('C:/dev/R-project1/maps/TL_SCCO_SIG.shp')
setwd ('C:/dev/R-project1')

# https://givitallugot.tistory.com/2
