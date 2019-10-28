#19년도 total 데이터 전처리
#1. Group Data 합계 가능?
rm(list = ls())

#1 kmeans.
flow19_km <- flow19 %>%  select(tot_flpop_co,  lon, lat)

#역정규화
denormalization_lon <- function(x) {
  max_str <- max(flow19$lon)
  min_str <- min(flow19$lon)
  return((x*(max_str-min_str))+min_str)
}
denormalization_lat <- function(x) {
  max_str <- max(flow19$lat)
  min_str <- min(flow19$lat)
  return((x*(max_str-min_str))+min_str)
}

#좌표값을 위도가 아니라 상대 데이터로 정규화 -> 역정규화를 해야겠다.
normalization <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}
flow19_km_n<- as.data.frame(lapply(flow19_km[2:3], normalization) )
flow19_km_n %>% mutate(tot_flpop_co = flow19_km$tot_flpop_co)

#kmeans                여기서 시작
set.seed(12)
flow19_cluster <- kmeans(flow19_km_n,23)
flow19_center <-as.data.frame( flow19_cluster[[2]])
flow19_group_data <-as.data.frame( flow19_cluster[[1]])
flow19_group <- flow19
flow19_group[,536] <- flow19_group_data
names(flow19_group)[536] <- c('group')

flow19_cluster[[2]]
table(flow19_group$group)

flow19_center_denorm_lat<- denormalization_lat(flow19_center$lat)
flow19_center_denorm_lon<- denormalization_lon(flow19_center$lon)


flow19_center_denorm<- as.data.frame(cbind(no = c(1:length(flow19_center_denorm_lat)),
                                           lat = flow19_center_denorm_lat,lon = flow19_center_denorm_lon))





#2 leaflet
popup <- paste("Group ",flow19_center_denorm$no,"</br> Flow : ",
               flow19_center_denorm$flow_total)
content <- paste("<a>",flow19$trdar_cd_nm,"</a> : ",
                 flow19$tot_flpop_co,'</br> Group ',flow19$group)
cen <- c(126.9894661,	37.53802834)
load('save/flow_color.rdata')

leaflet(flow19_group) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 12) %>% 
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(tot_flpop_co,3)*2.5), popup = content,
             color = ~flow_color(group), fillOpacity = 0.03) %>% 
  
  addMarkers( lng = ~lon,lat = ~lat,          
              options = popupOptions(closeButton = FALSE), data = flow19_center_denorm,
              popup = popup
  )

flow19<-flow19_group
flow19_total<-flow19 %>% group_by(group)%>%  summarise(tot_flpop = sum(tot_flpop_co))
names(flow19_total)[1] = c('no')
names(flow19_total)[2] = c('flow_total')
flow19_total
flow19_center_denorm<-left_join(flow19_center_denorm, flow19_total, by = 'no') 
flow19_center_denorm
content <- paste("<a>",flow19$trdar_cd_nm,"</a> : ",
                 flow19$tot_flpop_co,'</br> Group ',flow19$group)
popup <- paste("Group ",flow19_center_denorm$no,"</br> Flow : ",
               flow19_center_denorm$flow_total)

