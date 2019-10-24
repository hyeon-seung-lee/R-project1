# 서울 관광지명 또는 서울 관광지 주소 데이터수집하기
install.packages('rvest')
library(dplyr)
library(readxl)
library(stringr)

seoul_attractions<- read_excel('data/주소/seoul_attractions.xlsx')
seoul_attractions

#빈칸 제거
seoul_attractions = seoul_attractions %>% filter(!is.na(attraction))

# 평점 항목 제거 -> 정규표현식 이용 & grep 함수

str(seoul_attractions)
n = grep('\\d\\.',seoul_attractions$attraction)
seoul_attractions <-seoul_attractions$attraction[-n]

# 설명 제거
x = c(1:(length(seoul_attractions)/2))
x = c(x*2-1)
seoul_attractions<-seoul_attractions[x]

# 구글 이용한 주소 추출



library(ggmap)
geocodeQueryCheck()
register_google(key='AIzaSyBQsv4dm2o6hBfchlPQDMpMyRdkLsk-3k8') # 부여받은 키 등록

geocode(location = '서울',
        output = 'latlon',
        source = 'google')
attSeoulCoords <- geocode(location = seoul_attractions, 
                          output = 'latlona',
                          source = 'google')

att_Seoul_data <- cbind(seoul_attractions,attSeoulCoords)
att_Seoul_data <- read_excel('data/주소/att_seoul_coord.xlsx')
write.csv(att_Seoul_data,file = 'data/주소/att_seoul_coord.csv') #lon, lat

