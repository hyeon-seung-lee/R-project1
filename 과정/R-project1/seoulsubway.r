# 서울 지하철 좌표 추출 
rm(list = ls())
library(readxl)
subway<-read_excel("data/sub_station_name.xlsx")

library(dplyr)
library(readxl)
library(stringr)

# 지하철 역 이름 정제
subway$statn_nm <-   subway$statn_nm%>% 
                      str_remove(pattern = '\\(.+\\)') %>% 
                      str_remove('역$') %>% 
                      str_c('역')  
library(ggmap)
register_google(key='AIzaSyBQsv4dm2o6hBfchlPQDMpMyRdkLsk-3k8') # 부여받은 키 등록

geocode(location = '서울',
        output = 'latlon',
        source = 'google')
subway <- mutate_geocode(data = subway, 
                         location = statn_nm,
                          output = 'latlon',
                          source = 'google')
subway = subway[-which(duplicated(subway$statn_nm)),]
subway[1:509,1] = c(1:509)
# NA 값 수정
subway %>% filter(is.na(lat))
subway[6,3:4] = c( 127.010632,37.571697)
subway[498,3:4] = c( 127.141110,37.518278)
subway[505,3:4] = c(127.018113,37.627056)
