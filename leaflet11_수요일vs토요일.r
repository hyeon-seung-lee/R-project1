#요일별유동인구
# 수요일 vs 토요일  유동인구 비교 
# 연령별유동인구
rm(list = ls())

#2018년 60대이상 주말
cen <- c(126.9894661,	37.53802834)
load('save/flow_color.rdata')
load("save/flow18.rdata")
load("save/subway.rdata")
load('save/flow18_center_denorm.rdata')

flow18_wednsat <-flow18[,c(6,24,27,534:536)]


# 수-토 데이터
library(ggplot2)
flow18_wednsat_dif<-data.frame( flow18_wednsat[,2]-flow18_wednsat[,3])

flow18_wedn_sat <- flow18_wednsat[,c(1,4:6)]
flow18_wedn_sat <-cbind(flow18_wedn_sat,flow18_wednsat_dif)
names(flow18_wedn_sat)[5]<- c('total')
flow18_wedn_sat<-flow18_wedn_sat %>% filter(total>0)


#토-수 데이터
flow18_satwedn_dif<-data.frame( flow18_wednsat[,3]-flow18_wednsat[,2])

flow18_sat_wedn <- flow18_wednsat[,c(1,4:6)]
flow18_sat_wedn <-cbind(flow18_sat_wedn,flow18_satwedn_dif)
names(flow18_sat_wedn)[5]<- c('total')
flow18_sat_wedn<-flow18_sat_wedn %>% filter(total>0)


#이걸 전부  합칠 수 있다구요?
load('save/flow18_center_denorm.rdata')
load('save/popup_center.rdata')
load("save/att_seoul.rdata")    

#20-60
content_wedn_sat <- paste("<a>",flow18_wedn_sat$trdar_cd_nm,"</a> : ",
                       flow18_wedn_sat$total,'</br> Group ',flow18_wedn_sat$group) 
#60-20
content_sat_wedn<- paste("<a>",flow18_sat_wedn$trdar_cd_nm,"</a> : ",
                      flow18_sat_wedn$total,'</br> Group ',flow18_sat_wedn$group) 

load('save/icons1')
load('save/icons2')
load('save/icons3')


leaflet(flow18_wedn_sat) %>% addTiles() %>%
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
             radius = (~nthroot(total,3)*2), popup = content_wedn_sat,
             color = ~flow_color(group), fillOpacity = 0.2, group = '수요일-토요일') %>% 
  
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(total,3)*2), popup = content_sat_wedn,
             color = ~flow_color(group), fillOpacity = 0.2, data =flow18_sat_wedn,
             group = '토요일-수요일') %>% 
  
  addLayersControl(       # 옵션 컨틔롤
    
    overlayGroups = c("상권","서울 명소","지하철역", 
                      "수요일-토요일", "토요일-수요일"),
    options = layersControlOptions(collapsed = FALSE)
  ) 

