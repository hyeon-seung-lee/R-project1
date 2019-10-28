#2018년 20대, 30대 주말 - (화,수) 차이가 가장 큰 곳을 나타내기



#2) 연령별+토,일 
#20대, 토,일


#2018년 20대 주말
load("save/flow18.rdata")
flow18_weekend <-flow18[,c(6,101:112,534:536)]
flow18_weekend_total<-flow18_weekend %>% mutate(total = rowSums(.[1:4040,2:7]))
flow18_weekend_total[,17] <- as.numeric(flow18_weekend_total[,17])
str(flow18_weekend_total)

#content(유동인구),popup(중심점)
# 유동인구에 weekend_total 적용
content <- paste("<a>",flow18_weekend_total$trdar_cd_nm,"</a> : ",
                 flow18_weekend_total$total,'</br> Group ',flow18_weekend_total$group) 

popup <- paste("Group ",flow18_center_denorm$no,"</br> Flow : ",
               flow18_center_denorm$flow_total)

leaflet(flow18_weekend_total) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 12) %>% 
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(total,2)*0.5), popup = content,
             color = ~flow_color(group), fillOpacity = 0.2) 
%>% 
  
  addMarkers( lng = ~lon,lat = ~lat,          
              options = popupOptions(closeButton = FALSE), data = flow18_center_denorm,
              popup = popup
  )


#2018년 20대 화요일 수요일
load("save/flow19.rdata")
flow18_tuewedn <-flow18[,c(6,77:88,534:536)]

flow18_tuewedn_total<-flow18_tuewedn %>% mutate(total = rowSums(.[1:4040,2:13]))
flow18_tuewedn_total[,17] <- as.numeric(flow18_tuewedn_total[,17])



#content(유동인구),popup(중심점)
# 유동인구에 weekend_total 적용
content <- paste("<a>",flow18_tuewedn_total$trdar_cd_nm,"</a> : ",
                 flow18_tuewedn_total$total,'</br> Group ',flow18_tuewedn_total$group) 

popup <- paste("Group ",flow18_center_denorm$no,"</br> Flow : ",
               flow18_center_denorm$flow_total)

leaflet(flow18_tuewedn_total) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 12) %>% 
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(total,2)*0.5), popup = content,
             color = ~flow_color(group), fillOpacity = 0.2) 
%>% 
  
  addMarkers( lng = ~lon,lat = ~lat,          
              options = popupOptions(closeButton = FALSE), data = flow18_center_denorm,
              popup = popup
  )



