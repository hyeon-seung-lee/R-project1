#2018년 30대, 주말 - (화,수) 차이가 가장 큰 곳을 나타내기
rm(list = ls())


#2) 연령별+토,일 
#30대, 토,일
library(dplyr)
library(leaflet)

#2018년 30대 주말
cen <- c(126.9894661,	37.53802834)
load('save/flow_color.rdata')
load("save/flow18.rdata")
load("save/subway.rdata")
load('save/flow18_center_denorm.rdata')
flow18_weekend <-flow18[,c(6,143:154,395:406,534:536)]
flow18_weekend_total<-flow18_weekend %>% mutate(total = rowSums(.[1:4040,2:25]))
flow18_weekend_total[,29] <- as.numeric(flow18_weekend_total[,29])
str(flow18_weekend_total)

#2018년 30대 화요일 수요일
load("save/flow18.rdata")
flow18_tuewedn <-flow18[,c(6,119:130,371:382,534:536)]

flow18_tuewedn_total<-flow18_tuewedn %>% mutate(total = rowSums(.[1:4040,2:25]))
flow18_tuewedn_total[,29] <- as.numeric(flow18_tuewedn_total[,29])



# 30대 주말 - 화수 데이터
flow18_wend_tuwen<-data.frame(c(flow18_weekend_total[1],flow18_weekend_total[,2:25]-flow18_tuewedn_total[,2:25],flow18_weekend_total[26:28]))
flow18_wend_tuwen<-flow18_wend_tuwen %>% mutate(total = rowSums(.[1:4040,2:25]))
flow18_wend_tuwen[,29] <- as.numeric(flow18_wend_tuwen[,29])
flow18_wend_tuwen_positive<-flow18_wend_tuwen %>% filter(flow18_wend_tuwen[29]>0)



# 30대 화수 - 주말 데이터

flow18_tuwen_wend<-data.frame(c(flow18_weekend_total[1],flow18_tuewedn_total[,2:25]-flow18_weekend_total[,2:25],flow18_tuewedn_total[26:28]))
flow18_tuwen_wend<-flow18_tuwen_wend %>% mutate(total = rowSums(.[1:4040,2:25]))
flow18_tuwen_wend[,29] <- as.numeric(flow18_tuwen_wend[,29])
flow18_tuwen_wend_positive<-flow18_tuwen_wend %>% filter(flow18_tuwen_wend[29]>0)
flow18_tuwen_wend
flow18_tuwen_wend_positive


#이걸 전부  합칠 수 있다구요?
load('save/flow18_center_denorm.rdata')
load('save/popup_center.rdata')
load("save/att_seoul.rdata")    

#30대주말
content_wknd <- paste("<a>",flow18_weekend_total$trdar_cd_nm,"</a> : ",
                      flow18_weekend_total$total,'</br> Group ',flow18_weekend_total$group) 
#30대화수
content_tuwd <- paste("<a>",flow18_tuewedn_total$trdar_cd_nm,"</a> : ",
                      flow18_tuewedn_total$total,'</br> Group ',flow18_tuewedn_total$group) 
#30대주말-화수
content_wknd_tuwd <- paste("<a>",flow18_wend_tuwen_positive$trdar_cd_nm,"</a> : ",
                           flow18_wend_tuwen_positive$total,'</br> Group ',flow18_wend_tuwen_positive$group)   

#30대화수-주말
content_tuwd_wknd <- paste("<a>",flow18_tuwen_wend_positive$trdar_cd_nm,"</a> : ",
                           flow18_tuwen_wend_positive$total,'</br> Group ',flow18_tuwen_wend_positive$group)   

load('save/icons1')
load('save/icons2')
load('save/icons3')


leaflet(flow18_weekend_total) %>% addTiles() %>%
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
             radius = (~nthroot(total,2)*0.5), popup = content_wknd,
             color = ~flow_color(group), fillOpacity = 0.2, group = '30대 주말') %>% 
  
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(total,2)*0.5), popup = content_tuwd,
             color = ~flow_color(group), fillOpacity = 0.2, data =flow18_tuewedn_total,
             group = '30대 화수') %>% 
  
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(total,2)*0.5), popup = content_wknd_tuwd,
             color = ~flow_color(group), fillOpacity = 0.2, data = flow18_wend_tuwen_positive,
             group = '30대 주말-화수') %>% 
  
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(total,2)*0.5), popup = content_tuwd_wknd,
             color = ~flow_color(group), fillOpacity = 0.2, data = flow18_tuwen_wend_positive,
             group = '30대 화수-주말') %>% 
  
  addLayersControl(       # 옵션 컨틔롤
    
    overlayGroups = c("상권","서울 명소","지하철역", 
                      "30대 주말", "30대 화수", "30대 주말-화수", "30대 화수-주말"),
    options = layersControlOptions(collapsed = FALSE)
  ) 

