# first 20 quakes
rm(list = ls())
df.20 <- quakes[1:10,]
str(df.20)
flow19_group <- flow19$group[drop = T]
getColor <- function(flow19_group) {
  sapply(flow19_group$group, function(group) {
    if(group%%7 = 0) {
      "red"
    } else if(group%%7 = 1) {
      "orange"
    } else if(group%%7 = 2) {
      "yellow"
    }else if(group%%7 = 3) {
      "green"
    }else if(group%%7 = 4) {
      "blue"
    }else if(group%%7 = 5) {
      "violet"
    }else(group%%7 = 6) {
      "navy"
    }   })}

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(flow19)
)

leaflet(df.20) %>% addTiles() %>%
  addAwesomeMarkers(~long, ~lat, icon=icons, label=~as.character(group), data = flow19)


names(flow19)[536] <- c("group")



group_color = colorFactor('Set1', flow19$group)
