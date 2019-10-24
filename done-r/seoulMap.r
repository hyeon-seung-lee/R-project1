#서울 지도 시각화
install.packages('ggmap')
install.packages('ggplot2')
install.packages('raster')
install.packages('rgeos')
install.packages('maptools')
install.packages('rgdal')
rm(list = ls())
library(ggmap)
library(ggplot2)
library(raster)
library(rgeos)
library(maptools)
library(rgdal)
setwd ('C:/dev/R-project1')
# 시각화할 자료 여기에 :
# P<- read.csv('data/sample.csv,header = TRUE') 현 자료에 SEOUL_ID 과 일치하는 id칼럼을 미리 삽입해야 함.

map <- shapefile('maps/TL_SCCO_SIG.shp')# 지리 정보 자료/201703


# https://givitallugot.tistory.com/2

map@polygons[[1]]@Polygons[[1]]@coords %>%  head(n=10L) # 10행까지 좌표 확인
map <- spTransform(map, CRSobj = CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'))
new_map <- fortify(map,region = 'SIG_CD') # fortify 함수로 map을 data-frame으로 변환. SIG_CD 칼럼이 id로 변환됨 
View(new_map)

# id <=11740 인 지역이 서울시 정보. 
new_map$id <- as.numeric(new_map$id) # 문자로 입력된 id를 숫자로 변환한 후, 11740 이하만 추출한다.
seoul_map <- new_map[new_map$id <= 11740,]
View(seoul_map)
# P와 seoul_map의 통합. 시각화 자료를 위한 것 :
# P_merge <- merge(seoul_map, P, by='id')
ggplot() + geom_polygon(data = seoul_map, 
                        aes(x = long, 
                            y = lat, group=group), 
                        fill = 'white', color = 'black' ) # 데이터 통합 후 data = P_merge로 변환
