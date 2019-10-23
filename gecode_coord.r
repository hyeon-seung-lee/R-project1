# 구글 지오코드를 이용해 모든  좌표값을 구하자
rm(list = ls())
flow17_comname<-read.csv(file = 'data/flow201417상권명.csv')
flow18_comname<-read.csv(file = 'data/flow2018상권명.csv')
flow19_comname<-read_excel('data/flow2019상권명.xlsx')
register_google(key='AIzaSyBQsv4dm2o6hBfchlPQDMpMyRdkLsk-3k8') # 부여받은 키 등록

# 19년도 상권명에 따른 좌표
coords19 <- geocode(location = flow19_comname$trdar_cd_nm, 
                          output = 'latlona',
                          source = 'google')
# 18년도 상권명에 따른 좌표
coords18 <- geocode(location = flow18_comname$trdar_cd_nm, 
                    output = 'latlona',
                    source = 'google')


# 14~17년도 상권명에 따른 좌표
coords17 <- geocode(location = flow17_comname$trdar_cd_nm, 
                    output = 'latlona',
                    source = 'google')
