# 유동인구 데이터 201417, 2018, 2019에 id값을 부여하고 위도 데이터와 join
rm(list = ls())
library(dplyr)
add19_coord = read.csv(file = 'data/add19_coord.csv')
add18_coord = read.csv(file = 'data/add18_coord.csv')
add17_coord = read.csv(file = 'data/add1417_coord.csv')
head(add19_coord)


#
flow_19 <- read_excel('flowdata/flow2019.xlsx')
flow_18 <- read_excel('flowdata/flow2018.xlsx')
flow_17 <- read_excel('flowdata/flow201417.xlsx')
head(flow_19)

add19 = add19[-1011,] # add19 1011obs라 마지막 행 제거

#Join
flow_19<- left_join(flow_19, add19_coord, by = 'trdar_cd_nm')
head(flow_19)
#id 열 제거
flow_19 = flow_19[,-533]

flow_18<- left_join(flow_18, add18_coord, by = 'trdar_cd_nm')
head(flow_18)
flow_18 = flow_18[,-533]

flow_17<- left_join(flow_17, add17_coord, by = 'trdar_cd_nm')
head(flow_17)
flow_17 = flow_17[,-533]

#csv 파일로 저장
write.csv(flow_19,'data/flow2019_coord.csv')
write.csv(flow_18,'data/flow2018_coord.csv')
write.csv(flow_17,'data/flow201417_coord.csv')
