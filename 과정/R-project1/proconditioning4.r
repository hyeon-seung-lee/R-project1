# 새로운 좌표 데이터로 join

flow170 <- read_excel('data/flow201417.xlsx')
flow180 <- read_excel('data/flow2018.xlsx')
flow190 <- read_excel('data/flow2019.xlsx')
add_total <- read_excel('data/add_total.xlsx')
rm(list=ls())


flow19=flow19[-534]
flow17<- left_join(flow17, add_total, by = 'trdar_cd_nm')
flow18<- left_join(flow18, add_total, by = 'trdar_cd_nm')
flow19<- left_join(flow19, add_total, by = 'trdar_cd_nm')
rm(flow190)


list_flow2 <- list()
list_flow2[[1]]
head(flow_18)
rm(flow19)




save(flow17,file = 'save/flow17.rdata')
save(flow18,file = 'save/flow18.rdata')
save(flow19,file = 'save/flow19.rdata')
save(add_total, file = 'save/add_total.rdata')

load("save/att_seoul.rdata")

att_seoul


att_seoul = read.csv(file = 'data/주소/att_seoul_coord.csv',
            encoding = 'UTF-8',stringsAsFactors = T)
save(att_seoul,file = 'save/att_seoul.rdata')
