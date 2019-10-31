# 구글 지오코드를 이용해 모든  좌표값을 구하자
rm(list = ls())
flow17_comname<-read.csv(file = 'data/flow201417상권명.csv',stringsAsFactors = F)
flow18_comname<-read.csv(file = 'data/flow2018상권명.csv',stringsAsFactors = F)
flow19_comname<-read_excel('data/flow2019상권명.xlsx')
register_google(key='AIzaSyBQsv4dm2o6hBfchlPQDMpMyRdkLsk-3k8') # 부여받은 키 등록
library(readxl)
library(dplyr)
str(flow19_comname)
# 19년도 상권명에 따른 좌표
coords19 <- geocode(location = flow19_comname$trdar_cd_nm, 
                          output = 'latlona',
                          source = 'google')
# 18년도 상권명에 따른 좌표
coords18 <- geocode(location = flow18_comname$trdar_cd_nm, 
                    output = 'latlona',
                    source = 'google')
head(flow18_comname$trdar_cd_nm)

# 14~17년도 상권명에 따른 좌표
coords17 <- geocode(location = flow17_comname$trdar_cd_nm, 
                    output = 'latlona',
                    source = 'google')

# Geocode를 500개씩 나누어 처리하기 위해 벡터값 생성
16000/500
num17 = c(1:32)
num17 = c(1,num17*500,16160)
num17 = num17[-33]
num17
4000/500
num18 = c(1:8)
num18 = c(1,num18*500,4040)
num18 = num18[-9]
num18
num19 = c(1,500, 1011)
length(num19)

str(co19)
co19[[1]]
# 데이터 프레임 500개씩 쪼개기 <- Geocode 하기 위하여
for (i in 1:(length(num19)-1)){
  co19[[i]]= list(as.vector.factor(flow19_comname[num19[i]:num19[i+1],1]))
}
co19
co18 = list()
for (i in 1:(length(num18)-1)){
  co18[[i]]= list(as.vector.factor(flow18_comname[num18[i]:num18[i+1],1]))
  }

co17 = list()
for (i in 1:(length(num17)-1)){
  co17[[i]]= list(as.vector.factor(flow17_comname[num17[i]:num17[i+1],1]))
}

#Geocode 다시하자
coord19 = list()
for (i in 1:(length(num19)-1)){
  coords19[[i]] <- geocode(location = co19[[i]][1], 
                      output = 'latlona',
                      source = 'google')
}

coords19[[i]] <- geocode(location = co19[[1]][1], 
                         output = 'latlona',
                         source = 'google')
str(co19)
co19

write.csv(coords17,file='data/everyCoords17.csv')
write.csv(coords18,file='data/everyCoords18.csv')
every19<- read.csv(file = 'data/휴지통/everyCoords19.csv', encoding = 'UTF-8',stringsAsFactors = F)
every19
