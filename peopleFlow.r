# 참고 : 2015년 서울시 축제 효과 분석
# 이용 데이터 : 2014~2019 서울시 유동인구 공공데이터
rm(list = ls())
setwd ('C:/dev/R-project1')
# 디렉토리의 파일명을 읽어옴
flow_nm <- dir("./flowdata/")
flow_nm = flow_nm[-1] # "~$flow2019.xlsx" 제거
flow_nm
#
assign(flow_nm[1], read_excel("flowdata/flow201417.xlsx"))
assign(flow_nm[2], read_excel("flowdata/flow2018.xlsx"))
assign(flow_nm[3], read_excel("flowdata/flow2019.xlsx"))

for (iVar in flow_nm) {
  cat(iVar,"->", dim(get(iVar))[1],"행",dim(get(iVar))[2],"열", "\n")
}  

# 그냥 str 쓰려면 
str(flow2018.xlsx)

for (iVar in flow_nm) {
  cat(iVar,"->", names(get(iVar)), "\n")
}
