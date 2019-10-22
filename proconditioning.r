# 데이터 프레임 전처리 편집
rm(list = ls())
setwd ('C:/dev/R-project1')
#데이터프레임 가져오기
add1417 = read.csv('data/flow201417상권명.csv')
add18 = read.csv('data/flow2018상권명.csv')
add19 = read_excel('data/flow2019상권명.xlsx')
names(add1417)[1] <- c("trdar_cd_nm")

library(readxl)

#상권명 앞 두 글자가 같으면 데이터 프레임 삭제하는 것이 목표
for (i in 2:nrow(add19)) {
  x = substring(add19[i,1],1,2)
  y = substring(add19[i-1,1],1,2)
  ifelse ((x==y),(add19[i,1]=x),add19[i,1])
}  # 윗 행과 앞 두 글자가 같으면, 두 글자만 반환


nrow(add19[1])
add19[1]
nchar(add19[1,1])
nchar(add19[2,1])

# 행의 길이가 2이면 null
for (i in 2:nrow(add19)) {
  x = add19[i,1]
  ifelse ((nchar(x)==2), (add19[i,1]= NA), add19[i,1])
}
# null 값 데이터 제거
add19 = na.omit(add19)
# 19년 ↑

## 18년 ↓
for (i in 2:nrow(add18)) {
  x = substring(add18[i,1],1,2)
  y = substring(add18[i-1,1],1,2)
  ifelse ((x==y),(add18[i,1]=x),add18[i,1])
}  
for (i in 2:nrow(add18)) {
  x = add18[i,1]
  ifelse ((nchar(x)==2), (add18[i,1]= NA), add18[i,1])
}
# null 값 데이터 제거
add18 = na.omit(add18)

## 14~ 17년 ↓
for (i in 2:nrow(add1417)) {
  x = substring(add1417[i,1],1,2)
  y = substring(add1417[i-1,1],1,2)
  ifelse ((x==y),(add1417[i,1]=x),add1417[i,1])
}  
for (i in 2:nrow(add1417)) {
  x = add1417[i,1]
  ifelse ((nchar(x)==2), (add1417[i,1]= NA), add1417[i,1])
}
# null 값 데이터 제거
add1417 = na.omit(add1417)


# 데이터 행결합 
str(add1417)
str(add18)
str(add19)
names(add19)
names(add18)
names(add1417)
names(add1417)[1] <- c("trdar_cd_nm")
add_total = rbind.data.frame(add1417,add18)
add_total = rbind.data.frame(add_total,add19)

# 가나다순으로 재배열
View(add_total)

add_test = head(add_total,n = 10)
add_test
order(add_test[1])
add_test %>% arrange(trdar_cd_nm)
a = c('x', 'y', 'a','b','c')
add_total <- add_total %>% arrange(trdar_cd_nm)

# 중복 데이터값 다시 제거
for (i in 2:nrow(add_total)) {
  x = substring(add_total[i,1],1,2)
  y = substring(add_total[i-1,1],1,2)
  ifelse ((x==y),(add_total[i,1]=x),add_total[i,1])
}  
for (i in 2:nrow(add_total)) {
  x = add_total[i,1]
  ifelse ((nchar(x)==2), (add_total[i,1]= NA), add_total[i,1])
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

