# 데이터 프레임 전처리 편집
rm(list = ls())

setwd ('C:/dev/R-project1')
#데이터프레임 가져오기
add1417 = read.csv('data/everyCoords17.csv',stringsAsFactors = F)
add18 = read.csv('data/everyCoords18.csv',stringsAsFactors = F)
add19 = read.csv('data/everyCoords19.csv',stringsAsFactors = F, fileEncoding = 'UTF-8-BOM')

# 데이터 전체에 대한 좌표값을 구하여 주소 데이터 재작업 10/24
# 두글자 프레임 삭제

# 데이터 하나로 결합
add_total = rbind.data.frame(add1417,add18)
names(add19)[2] <- c("lat")
names(add19)[3] <- c("lon")
add_total = rbind.data.frame(add_total,add19)

# 가나다순으로 재배열
View(add_total)

add_test = head(add_total,n = 10)
add_test
order(add_test[1])
add_test %>% arrange(trdar_cd_nm)
a = c('x', 'y', 'a','b','c')
add_total <- add_total %>% arrange(trdar_cd_nm)
add_total <- add_total2
# 중복 데이터값 다시 제거
for (i in 2:nrow(add_total)) {
  x = add_total[i,1]
  y = add_total[i-1,1]
  ifelse ((x==y),(add_total[i,1]=NA),add_total[i,1])
  add_total = na.omit(add_total)
}  
# null 값 데이터 제거
add_total = na.omit(add_total)
add_total

# 중복 데이터값 제거 함수 dropduplicate
add_total = DUPLICATE[-which(duplicated(DUPLICATE$NAME)),]
add_total = add_total[-which(duplicated(add_total$trdar_cd_nm)),]
add_total = as.data.frame(add_total)
add_total
# csv 파일로 저장한다
write.csv(add_total,'data/add_total.csv')
rm(add1417)
