#leaflet 탐구구
install.packages("pracma") # nthroot 사용하기 위한 패키지
install.packages("leaflet")
install.packages('viridis')
library(pracma)
library(leaflet)
library(dplyr)

# 변수 선언
cen <- c(126.9894661,	37.53802834)
content <- paste("<a>",flow19_group$trdar_cd_nm,"</a> : ",
              flow19$tot_flpop_co,'</br> group : ',flow19_group$group)
popup <- paste("Group : ",flow19_center_denorm$no)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=cen[1], lat=cen[2], popup="깃발 말주머니에 들어갈 말") # 깃발 생성

m
m %>% addProviderTiles(providers$Stamen.Toner) #흑백
m %>% addProviderTiles(providers$CartoDB.Positron) # 깔끄미

# 1. 명소를 지도에 표시하자
head(att_seoul)
#popup
leaflet(att_seoul) %>% addTiles() %>%
  addPopups(att_seoul$lon,att_seoul$lat, att_seoul$seoul_attractions,
           options = popupOptions(closeButton = FALSE))
#label -> 선택
leaflet(att_seoul) %>% addTiles() %>% 
  addMarkers( lng = ~lon,lat = ~lat,popup= ~seoul_attractions,          #'~'가 'att_seoul$'임
              options = popupOptions(closeButton = FALSE)) 

# 2. 유동인구를 지도에 표시하자 (flow19$tot_flpop_co)

leaflet(flow19) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 11) %>% 
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(tot_flpop_co,3)*2.5), popup = paste(flow19$trdar_cd_nm, flow19$tot_flpop_co),
             fillColor = 'red')

# 3. 유동인구와 명소를 함께 표시하자(flow19$총유동인구수)
 # 유동인구
leaflet(flow19) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 12) %>% 
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(tot_flpop_co,3)*2.5), popup = content,
             fillColor = 'red') %>% 
  #label -> 선택
  addPopups( lng = ~lon,lat = ~lat,popup= ~seoul_attractions,          #'~'가 'att_seoul$'임
              options = popupOptions(closeButton = FALSE), data = att_seoul) 
tot_fl
# 4. 출력을 달리 해보자
tot_fl %>% addProviderTiles(providers$Stamen.Toner) #흑백
tot_fl %>% addProviderTiles(providers$CartoDB.Positron) # 깔끄미

# 5. 말주머니 글씨를 멋지게 해보자
leaflet(flow19) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 12) %>% 
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(tot_flpop_co,3)*2.5), popup = content,
             fillColor = 'red')

paste

# Clusters option을 표시하자.
leaflet(flow19) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 12) %>% 
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(tot_flpop_co,3)*2.3), popup = content,
             fillColor = 'red',color = NA, fillOpacity = 0.3) %>% 
  addMarkers( lng = ~lon,lat = ~lat,popup= ~seoul_attractions,          #서울 명소
             options = popupOptions(closeButton = FALSE), data = att_seoul,
clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F))

# 서울 지하철역과 유동인구를 표시하자
leaflet(flow19) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 12) %>%                      #지도 초기값
  
  addCircles(lng = ~lon, lat = ~lat, weight = 1,                          #유동인구
             radius = (~nthroot(tot_flpop_co,3)*2.3), popup = content,
             fillColor = 'red',color = NA, fillOpacity = 0.3) %>% 
  
  addMarkers( lng = ~lon,lat = ~lat,popup= ~statn_nm,          #서울 지하철
              options = popupOptions(closeButton = FALSE), data = subway
              )

# Cluster Center(20곳)과 유동인구를 표시하자
leaflet(flow19) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 12) %>%                      #지도 초기값
  
  addCircles(lng = ~lon, lat = ~lat, weight = 1,                          #유동인구
             radius = (~nthroot(tot_flpop_co,3)*2.3), popup = content,
             fillColor = 'red',color = NA, fillOpacity = 0.3) %>% 
  
  addMarkers( lng = ~lon,lat = ~lat,          
              options = popupOptions(closeButton = FALSE), data = flow19_center_denorm#,
             # popup = ~trdar_cd_nm
  )


# 유동인구를 그룹별로 나누자

# 색깔 데이터셋 설정 
flow19_color = colorFactor(palette = 'viridis', flow19_group$group)
content <- paste("<a>",flow19_group$trdar_cd_nm,"</a> : ",
                 flow19$tot_flpop_co,'</br> group : ',flow19_group$group)
popup <- paste("Group : ",flow19_center_denorm$no)

leaflet(flow19_group) %>% addTiles() %>%
  setView(lng = cen[1], lat = cen[2], zoom = 12) %>% 
  addCircles(lng = ~lon, lat = ~lat, weight = 1,
             radius = (~nthroot(tot_flpop_co,3)*2.5), popup = content,
             color = ~flow19_color(group), fillOpacity = 0.5) %>% 

  addMarkers( lng = ~lon,lat = ~lat,          
              options = popupOptions(closeButton = FALSE), data = flow19_center_denorm,
              popup = popup
  )

  
  table(flow19_group_data)
table(flow19_group$group)
  