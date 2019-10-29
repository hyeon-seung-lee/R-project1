# 20대vs 60대 유동인구 비교 
# 연령별유동인구
rm(list = ls())

#2018년 60대이상 주말
cen <- c(126.9894661,	37.53802834)
load('save/flow_color.rdata')
load("save/flow18.rdata")
load("save/subway.rdata")
load('save/flow18_center_denorm.rdata')

flow18_ages <-flow18[,c(6,10:15,534:536)]

flow18_age_total<-flow18_ages %>% mutate(total = rowSums(.[1:4040,2:7]))
flow18_age_total[,11] <- as.numeric(flow18_age_total[,11])
str(flow18_age_total)


# 20-60 데이터
library(ggplot2)
#20-60
flow18_20_60_dif<-data.frame( flow18_age_total[,3]-flow18_age_total[,7])

flow18_20_60 <- flow18_age_total[,c(1,8:10)]
flow18_20_60 <-cbind(flow18_20_60,flow18_20_60_dif)
names(flow18_20_60)[5]<- c('total')
flow18_20_60<-flow18_20_60 %>% filter(total>0)


#60-20
flow18_60_20_dif<-data.frame( flow18_age_total[,7]-flow18_age_total[,3])
flow18_60_20 <- flow18_age_total[,c(1,8:10)]
flow18_60_20 <-cbind(flow18_60_20,flow18_60_20_dif)
names(flow18_60_20)[5]<- c('total')

flow18_60_20<-flow18_60_20 %>% filter(total>0)



#이걸 전부  합칠 수 있다구요?
load('save/flow18_center_denorm.rdata')
load('save/popup_center.rdata')
load("save/att_seoul.rdata")    

#20-60
content_20_60 <- paste("<a>",flow18_20_60$trdar_cd_nm,"</a> : ",
                      flow18_20_60$total,'</br> Group ',flow18_20_60$group) 
#60-20
content_60_20<- paste("<a>",flow18_60_20$trdar_cd_nm,"</a> : ",
                      flow18_60_20$total,'</br> Group ',flow18_60_20$group) 

load('save/icons1')
load('save/icons2')
load('save/icons3')


leaflet(flow18_20_60) %>% addTiles() %>%
  addTiles() %>% # 지도 레이어어
  setView(lng = cen[1], lat = cen[2], zoom = 12.2) %>% 
  
  addAwesomeMarkers( lng = ~lon,lat = ~lat,          #상권중심
                     options = popupOptions(closeButton = FALSE), data = flow18_center_denorm,
                     popup = popup_center, group = '상권', icon=icons1  ) %>% 
  
  addAwesomeMarkers( lng = ~lon,lat = ~lat,popup= ~seoul_attractions,   #'~'가 'att_seoul$'임
                     options = popupOptions(closeButton = FALSE), data = att_seoul,
                     group = '서울 명소',icon=icons2) %>%
  
  addAwesomeMarkers( lng = ~lon,lat = ~lat,popup= ~statn_nm,          #서울 지하철
                     options = popupOptions(closeButton = FALSE), data = subway,
                     group = '지하철역',icon=icons3   ) %>% 
  
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(total,3)*2), popup = content_20_60,
             color = ~flow_color(group), fillOpacity = 0.2, group = '20-60') %>% 
  
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(total,3)*2), popup = content_60_20,
             color = ~flow_color(group), fillOpacity = 0.2, data =flow18_60_20,
             group = '60-20') %>% 
  
  addLayersControl(       # 옵션 컨틔롤
    
    overlayGroups = c("상권","서울 명소","지하철역", 
                      "20-60", "60-20"),
    options = layersControlOptions(collapsed = FALSE)
  ) 
