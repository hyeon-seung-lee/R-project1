# google map 이용
# littlemissdata.com 시작
install.packages("lubridate")
install.packages("ggplot2")
install.packages("data.table") # failed
install.packages("ggrepel")
install.packages("dplyr")
install.packages("data.table")
install.packages("tidyverse")
install_github('https://github.com/Rdatatable/data.table')
library(data.table)
library(lubridate)
library(ggplot2)
library(dplyr)
library(data.table)
library(ggrepel)
library(tidyverse)
library(ggmap)

register_google(key='AIzaSyBQsv4dm2o6hBfchlPQDMpMyRdkLsk-3k8') # 부여받은 키 등록
cen <- c(mean(flow19$long),mean(flow19$lat))
sgm     <-ggmap( get_googlemap(center=cen,
                               maptype='roadmap',
                               zoom=13,
                               size=c(640,640),
                               color = 'color'))
sgm
# 데이터 프레임에서  전체 유동인구만 선택
flow19_tot_flpop <-   flow19 %>% select(tot_flpop_co,long,lat) 
head(flow19_tot_flpop)

# sgm (Seoul Google Map)
sgm + geom_point(aes(x = long, y = lat ), data = flow19_tot_flpop, size = 1.8, alpha=0.25, color = 'red') + 
  theme(legend.position="bottom")

# 구별 center data 또는 동, 서, 남, 북, 중앙 등의 좌표 데이터
# 주요 관광지 주소와 좌표 데이터
# 상권 주소값 전체에 대한 주소 데이터면 좋음
att_Seoul_df<-as.data.frame(att_Seoul_data)
# 관광지 데이터로 인덱스를 만들어 보자
sgm + geom_point(aes(x = long, y = lat ), data = flow19_tot_flpop, 
                 size = 1.8, alpha=0.25, color = 'red') + 
  theme(legend.position="bottom")+
geom_point(aes(x = lon, y = lat, stroke = 2), data = att_Seoul_df, size =1.5) + 
  geom_label_repel(
    aes(x=lon, y=lat, label = seoul_attractions),
    data=att_Seoul_df,
    #family = 'Times', 
    size = 2, 
    box.padding = 0, point.padding = 0,
    segment.color = 'grey50') 
