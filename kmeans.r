# k-means 분석 해보기
# 자주 쓰이는 변수
library(stats)
library(dplyr)
rm(list = ls())


#1. 데이터세트 준비 -> 총 유동인구 데이터와 동이름, 좌표만 포함하는 데이터프레임 생성

str(flow19)
flow19_km <- flow19 %>%  select(tot_flpop_co,  lon, lat)

#역정규화
denormalization_lon <- function(x) {
  max_str <- max(flow19$lon)
  min_str <- min(flow19$lon)
  return((x*(max_str-min_str))+min_str)
}
denormalization_lat <- function(x) {
  max_str <- max(flow19$lat)
  min_str <- min(flow19$lat)
  return((x*(max_str-min_str))+min_str)
}

#좌표값을 위도가 아니라 상대 데이터로 정규화 -> 역정규화를 해야겠다.
normalization <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}
flow19_km_n<- as.data.frame(lapply(flow19_km[2:3], normalization) )
flow19_km_n %>% mutate(tot_flpop_co = flow19_km$tot_flpop_co)

#kmeans                여기서 시작
set.seed(12)
flow19_cluster <- kmeans(flow19_km_n,23)
flow19_center <-as.data.frame( flow19_cluster[[2]])
flow19_group_data <-as.data.frame( flow19_cluster[[1]])
flow19_group <- flow19
flow19_group[,536] <- flow19_group_data
names(flow19_group)[536] <- c('group')

flow19_cluster[[2]]
table(flow19_group$group)

flow19_center_denorm_lat<- denormalization_lat(flow19_center$lat)
flow19_center_denorm_lon<- denormalization_lon(flow19_center$lon)

flow19_center_denorm<- as.data.frame(cbind(no = c(1:length(flow19_center_denorm_lat)),
                                           lat = flow19_center_denorm_lat,lon = flow19_center_denorm_lon))





#---------------------------------------------





#1. 데이터세트 준비 -> 총 유동인구 데이터와 동이름, 좌표만 포함하는 데이터프레임 생성

str(flow19)
flow19_km <- flow19 %>%  select(tot_flpop_co,  lon, lat)
# 데이터 확인
str(flow19_km)

#2. k-means 클러스터 생성 -> 할 필요 없음 !
# NA Check & 정제
flow19 %>% filter(is.na(lon))
flow18 %>% filter(is.na(lon))
flow17 %>% filter(is.na(lon))
add_total %>% filter(is.na(lat))
add_total[981,3:4] <- c( 126.930198,37.576169)
flow19_km %>% filter(is.na(lon))
#kmean 가동!

#데이터 확인!



#head(flow19_center_denorm_lon)
flow19_center_denorm<- as.data.frame(cbind(no = c(1:length(flow19_center_denorm_lat)),lat = flow19_center_denorm_lat,lon = flow19_center_denorm_lon))


length(flow19_center_denorm_lat)
#ㄴ 반드시 실행!



# group 컬럼을 추가한 데이터를 만듬
names(flow19_group_data)[1] <- c('group')

length(flow19_group_data[1])
flow19_test <- flow19
flow19_test$group_data <- flow19_group_data[1]
head(flow19_test)
table(flow19_test$group_data)
flow19_test$group
  flow19$group

flow19_group<-bind_cols(flow19,flow19_group_data)
7