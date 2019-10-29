# 9시 vs 22시


# 시간별유동인구구 

# 연령별유동인구
rm(list = ls())

#2018년 60대이상 주말
cen <- c(126.9894661,	37.53802834)
load('save/flow_color.rdata')
load("save/flow18.rdata")
load("save/subway.rdata")
load('save/flow18_center_denorm.rdata')

flow18_922 <-flow18[,c(6,17,21,534:536)]


# 수-토 데이터
library(ggplot2)
flow18_922_dif<-data.frame( flow18_922[,2]-flow18_922[,3])

flow18_9_22 <- flow18_922[,c(1,4:6)]
flow18_9_22 <-cbind(flow18_9_22,flow18_922_dif)
names(flow18_9_22)[5]<- c('total')
flow18_9_22<-flow18_9_22 %>% filter(total>0)


#토-수 데이터
flow18_satwedn_dif<-data.frame( flow18_922[,3]-flow18_922[,2])

flow18_22_9 <- flow18_922[,c(1,4:6)]
flow18_22_9 <-cbind(flow18_22_9,flow18_satwedn_dif)
names(flow18_22_9)[5]<- c('total')
flow18_22_9<-flow18_22_9 %>% filter(total>0)


#이걸 전부  합칠 수 있다구요?
load('save/flow18_center_denorm.rdata')
load('save/popup_center.rdata')
load("save/att_seoul.rdata")    

#20-60
content_9_22 <- paste("<a>",flow18_9_22$trdar_cd_nm,"</a> : ",
                       flow18_9_22$total,'</br> Group ',flow18_9_22$group) 
#60-20
content_22_9<- paste("<a>",flow18_22_9$trdar_cd_nm,"</a> : ",
                      flow18_22_9$total,'</br> Group ',flow18_22_9$group) 

load('save/icons1')
load('save/icons2')
load('save/icons3')


leaflet(flow18_9_22) %>% addTiles() %>%
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
             radius = (~nthroot(total,3)*2), popup = content_9_22,
             color = ~flow_color(group), fillOpacity = 0.2, group = '9시우세') %>% 
  
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(total,3)*2), popup = content_22_9,
             color = ~flow_color(group), fillOpacity = 0.2, data =flow18_22_9,
             group = '22시우세') %>% 
  
  addLayersControl(       # 옵션 컨틔롤
    
    overlayGroups = c("상권","서울 명소","지하철역", 
                      "9시우세", "22시우세"),
    options = layersControlOptions(collapsed = FALSE)
  ) 

