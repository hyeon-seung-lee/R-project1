# 참고 : 2015년 서울시 축제 효과 분석
# 이용 데이터 : 2014~2019 서울시 유동인구 공공데이터
rm(list = ls())
setwd ('C:/dev/R-project1')
library(readxl)
install.packages('tibble')
library(tibble)
library(ggmap)
# 디렉토리의 파일명을 읽어옴

flow17 <- read.csv(file = 'flowdata/flow201417_coord.csv')
flow18 <- read.csv(file = 'flowdata/flow2018_coord.csv')
flow19 <- read.csv(file = 'flowdata/flow2019_coord.csv')



remove.packages("ggmap")
remove.packages("tibble")
# ggmap을 쓰기 위해 최신 패키지 다운로드
# 출처 : https://jjeongil.tistory.com/371
install.packages('devtools')
library('devtools')
install_github('dkahle/ggmap', ref="tidyup")
library('ggmap')

#두 데이터 합해야하나?
#seoul_flow_1417 <- left_join(flow, flow201417.xlsx, by = c('region'='state'))
#seoul_flow_18 <- left_join(us_state, flow2018.xlsx, by = c('region'='state'))
#seoul_flow_19 <- left_join(us_state, flow2019.xlsx, by = c('region'='state'))
seoul_map_ggplot
ggplot()+geom_polygon(data = flow19, aes(x = long, y = lat, fill = tot_flpop_co, alpha = 0.3))

                      #  seoul_map_ggplot 이라는 변수에 지도를 미리 저장

