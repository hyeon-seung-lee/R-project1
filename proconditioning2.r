# 전처리2 기존 주소 프레임을 앞 2글자를 따로 떼어냄
rm(list = ls())
setwd ('C:/dev/R-project1')
#데이터프레임 가져오기
add1417 = read.csv('data/flow201417상권명.csv')
add18 = read.csv('data/flow2018상권명.csv')
add19 = read_excel('data/flow2019상권명.xlsx')

View(add1417)
names(add1417)[1] <- c("trdar_cd_nm")


#데이터 프레임 옆에 도로명 '앞2글자' '한글id' 칼럼 생성
add19_test <- head(add19,n=10)
add19_test <- cbind(add19_test,korid=substring(add19_test$trdar_cd_nm,1,2))

add19 <- cbind(add19,korid=substring(add19$trdar_cd_nm,1,2))
head(add19$korid)
add18 <- cbind(add18,korid=substring(add18$trdar_cd_nm,1,2))
head(add18$korid)

add1417 <- cbind(add1417,korid=substring(add1417$trdar_cd_nm,1,2))
head(add1417$korid)

# 좌표 데이터 프레임 가져오기
coordinate <- read_excel('data/주소/add_total_fin2.xlsx')
View(coordinate)
head(coordinate)
# join 하자 -> 각 좌표값 삽입!
left_join(add19_test,coordinate,by = "korid")

add19 = left_join(add19,coordinate,by = "korid")
add18 = left_join(add18,coordinate,by = "korid")
add1417 = left_join(add1417,coordinate,by = "korid")

head(add1417)
head(add18)
head(add19)
add1417 = add1417[,c(1,5,6)]
add18 = add18[,c(1,5,6)]
add19 = add19[,c(1,5,6)]


write.csv(add19,'data/add19_coord.csv')
write.csv(add18,'data/add18_coord.csv')
write.csv(add1417,'data/add1417_coord.csv')

