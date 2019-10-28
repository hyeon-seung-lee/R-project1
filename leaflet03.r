#17년도 total 데이터 전처리
#1. Group Data 합계 가능?
rm(list = ls())

#1 kmeans.
flow17_km <- flow17 %>%  select(tot_flpop_co,  lon, lat)

#역정규화
denormalization_lon <- function(x) {
  max_str <- max(flow17$lon)
  min_str <- min(flow17$lon)
  return((x*(max_str-min_str))+min_str)
}
denormalization_lat <- function(x) {
  max_str <- max(flow17$lat)
  min_str <- min(flow17$lat)
  return((x*(max_str-min_str))+min_str)
}

#좌표값을 위도가 아니라 상대 데이터로 정규화 -> 역정규화를 해야겠다.
normalization <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}
flow17_km_n<- as.data.frame(lapply(flow17_km[2:3], normalization) )
flow17_km_n %>% mutate(tot_flpop_co = flow17_km$tot_flpop_co)

#kmeans                여기서 시작
set.seed(12)
flow17_cluster <- kmeans(flow17_km_n,23)
flow17_center <-as.data.frame( flow17_cluster[[2]])
flow17_group_data <-as.data.frame( flow17_cluster[[1]])
flow17_group <- flow17
flow17_group[,536] <- flow17_group_data
names(flow17_group)[536] <- c('group')

flow17_cluster[[2]]
table(flow17_group$group)

flow17_center_denorm_lat<- denormalization_lat(flow17_center$lat)
flow17_center_denorm_lon<- denormalization_lon(flow17_center$lon)


flow17_center_denorm<- as.data.frame(cbind(no = c(1:length(flow17_center_denorm_lat)),
                                           lat = flow17_center_denorm_lat,lon = flow17_center_denorm_lon))





#2 leaflet
popup <- paste("Group ",flow17_center_denorm$no,"</br> Flow : ",
               flow17_center_denorm$flow_total)
content <- paste("<a>",flow17$trdar_cd_nm,"</a> : ",
                 flow17$tot_flpop_co,'</br> Group ',flow17$group)
cen <- c(126.9894661,	37.53802834)
load('save/flow_color.rdata')

leaflet(flow17_group) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 12) %>% 
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(tot_flpop_co,3)*2.5), popup = content,
             color = ~flow_color(group), fillOpacity = 0.03) %>% 
  
  addMarkers( lng = ~lon,lat = ~lat,          
              options = popupOptions(closeButton = FALSE), data = flow17_center_denorm,
              popup = popup
  )

flow17<-flow17_group
flow17_total<-flow17 %>% group_by(group)%>%  summarise(tot_flpop = sum(tot_flpop_co))
names(flow17_total)[1] = c('no')
names(flow17_total)[2] = c('flow_total')
flow17_total
flow17_center_denorm<-left_join(flow17_center_denorm, flow17_total, by = 'no') 
flow17_center_denorm
content <- paste("<a>",flow17$trdar_cd_nm,"</a> : ",
                 flow17$tot_flpop_co,'</br> Group ',flow17$group)
popup <- paste("Group ",flow17_center_denorm$no,"</br> Flow : ",
               flow17_center_denorm$flow_total)
