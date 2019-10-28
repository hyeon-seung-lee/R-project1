
#del
rm(list = ls())
setwd ('C:/dev/R-project1')
# load 로드
load("save/flow17.rdata")
load("save/flow18.rdata")
load("save/flow19.rdata")
load("save/add_total.rdata")        # 주소
load("save/att_seoul.rdata")        # 서울 명소
load("save/subway.rdata")
load("save/main_trade_area.rdata")
load('save/flow19_center.rdata')
load('save/flow_color.rdata')

# save 세이브
save(att_seoul,file = 'save/att_seoul.rdata')
save(flow17,file = 'save/flow17.rdata')
save(flow18,file = 'save/flow18.rdata')
save(flow19,file = 'save/flow19.rdata')
save(add_total, file = 'save/add_total.rdata')
save(subway, file = 'save/subway.rdata')
save(main_trade_area, file = 'save/main_trade_area.rdata')
save(flow19_center, file = 'save/flow19_center.rdata')
save(flow_color, file = 'save/flow_color.rdata')


# 자주 사용하는 벡터/변수
cen <- c(126.9894661,	37.53802834)



content <- paste("<a>",flow18$trdar_cd_nm,"</a> : ",
                 flow18$tot_flpop_co,'</br> Group ',flow18$group)
popup <- paste("Group : <a>",flow_center$name,"</a></br>",flow_center$no)
