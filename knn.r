# knn(Nearest Neighbor)
rm(list = ls())
library(readxl)
library(class)
#1. main_trade_area 로부터 각 센터값 가져오기기
main_trade_area <- read_excel('data/main_trade_area.xlsx')

#2. flow19 데이터로부터 도로명과 좌표값 가져온 데이터프레임 생성
str(flow19)
flow18_knn <- flow17 %>%  select(trdar_cd_nm  ,  lon, lat)
main_trade_area[3]
names(main_trade_area)[4] <- c("trdar_cd_nm")
names(main_trade_area)[3] <- c("lon")


#3. 훈련용 데이터 프레임 만들기 : 일단 클러스터 중심 하나로 돌려보기
main_trade_area_train <- main_trade_area[,2:3]
main_trade_area_label <- main_trade_area[,1, drop = T]
flow17_knn_test <- flow17[,534:535]

cluster_knn= knn(train = main_trade_area_train,
             test = flow18_knn_test,
             cl = main_trade_area_label,
             k = 5
)
str(main_trade_area_label)
str(main_trade_area_train)
cluster_knn_df <- as.data.frame(cluster_knn)
flow18_bind <- cbind(flow18,cluster_knn_df)
#flow18<-cbind(flow18,cluster_knn_df)
flow18_bind %>% select(cluster_knn,trdar_cd_nm)
