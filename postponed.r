# 일단 보류
remove.packages("ggmap")
remove.packages("tibble")
# ggmap을 쓰기 위해 최신 패키지 다운로드
# 출처 : https://jjeongil.tistory.com/371
install.packages('devtools')
install.packages('ggmap')
library('devtools')
install_github('dkahle/ggmap', ref="tidyup")
library('ggmap')
library(digest)
install.packages('digest')
#두 데이터 합해야하나?
#seoul_flow_1417 <- left_join(flow, flow201417.xlsx, by = c('region'='state'))
#seoul_flow_18 <- left_join(us_state, flow2018.xlsx, by = c('region'='state'))
#seoul_flow_19 <- left_join(us_state, flow2019.xlsx, by = c('region'='state'))