# 유동인구 데이터 201417, 2018, 2019에 id값을 부여하고 위도 데이터와 join
rm(list = ls())
library(dplyr)
add19_coord = read.csv(file = 'data/everyCoords19.csv')
add18_coord = read.csv(file = 'data/everyCoords18.csv')
add17_coord = read.csv(file = 'data/everyCoords17.csv')
head(add19_coord)


#
flow19 <- read_excel('flowdata/flow2019.xlsx')
flow18 <- read_excel('flowdata/flow2018.xlsx')
flow17 <- read_excel('flowdata/flow201417.xlsx')
head(flow_19)

add19 = add19[-1011,] # add19 1011obs라 마지막 행 제거

#Join
flow19<- left_join(flow19, add_total, by = 'trdar_cd_nm')
head(flow19)
#id 열 제거
flow19 = flow19[,-535]

flow18<- left_join(flow18, add_total, by = 'trdar_cd_nm')
head(flow_18)
flow18 = flow18[,-535]

flow17<- left_join(flow17, add_total, by = 'trdar_cd_nm')
head(flow_17)
flow17 = flow17[,-535]

#csv 파일로 저장
write.csv(flow_19,'data/flow2019_coord.csv')
write.csv(flow_18,'data/flow2018_coord.csv')
write.csv(flow_17,'data/flow201417_coord.csv')
