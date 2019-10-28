#18년도 total 데이터 전처리
#1. Group Data 합계 가능?
rm(list = ls())



rm(list = ls())

#1 kmeans.
flow18_km <- flow18 %>%  select(tot_flpop_co,  lon, lat)

#역정규화
denormalization_lon <- function(x) {
  max_str <- max(flow18$lon)
  min_str <- min(flow18$lon)
  return((x*(max_str-min_str))+min_str)
}
denormalization_lat <- function(x) {
  max_str <- max(flow18$lat)
  min_str <- min(flow18$lat)
  return((x*(max_str-min_str))+min_str)
}

#좌표값을 위도가 아니라 상대 데이터로 정규화 -> 역정규화를 해야겠다.
normalization <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}
flow18_km_n<- as.data.frame(lapply(flow18_km[2:3], normalization) )
flow18_km_n %>% mutate(tot_flpop_co = flow18_km$tot_flpop_co)

#kmeans                여기서 시작
set.seed(12)
flow18_cluster <- kmeans(flow18_km_n,23)
flow18_center <-as.data.frame( flow18_cluster[[2]])
flow18_group_data <-as.data.frame( flow18_cluster[[1]])
flow18_group <- flow18
flow18_group[,536] <- flow18_group_data
names(flow18_group)[536] <- c('group')

flow18_cluster[[2]]
table(flow18_group$group)

flow18_center_denorm_lat<- denormalization_lat(flow18_center$lat)
flow18_center_denorm_lon<- denormalization_lon(flow18_center$lon)


flow18_center_denorm<- as.data.frame(cbind(no = c(1:length(flow18_center_denorm_lat)),
                                           lat = flow18_center_denorm_lat,lon = flow18_center_denorm_lon))





#2 leaflet
popup <- paste("Group ",flow18_center_denorm$no,"</br> Flow : ",
               flow18_center_denorm$flow_total)
content <- paste("<a>",flow18$trdar_cd_nm,"</a> : ",
                 flow18$tot_flpop_co,'</br> Group ',flow18$group)
cen <- c(126.9894661,	37.53802834)
load('save/flow_color.rdata')

leaflet(flow18_group) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 12) %>% 
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(tot_flpop_co,2)*0.2), popup = content,      #3)*2.5 ->2)*0.5
             color = ~flow_color(group), fillOpacity = 0.03) %>% 
  
  addMarkers( lng = ~lon,lat = ~lat,          
              options = popupOptions(closeButton = FALSE), data = flow18_center_denorm,
              popup = popup
  )

flow18<-flow18_group
flow18_total<-flow18 %>% group_by(group)%>%  summarise(tot_flpop = sum(tot_flpop_co))
names(flow18_total)[1] = c('no')
names(flow18_total)[2] = c('flow_total')
flow18_total
flow18_center_denorm<-left_join(flow18_center_denorm, flow18_total, by = 'no') 
flow18_center_denorm
content <- paste("<a>",flow18$trdar_cd_nm,"</a> : ",
                 flow18$tot_flpop_co,'</br> Group ',flow18$group)
popup <- paste("Group ",flow18_center_denorm$no,"</br> Flow : ",
               flow18_center_denorm$flow_total)

# 오류의 원인이 numeric이 아니라서?
str(flow19_weekend_total)
