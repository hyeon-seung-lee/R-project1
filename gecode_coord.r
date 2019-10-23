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

# Geocode를 500개씩 나누어 처리하기 위해 벡터값 생성
16000/500
num17 = c(1:32)
num17 = c(num17*500,16160)
num17 = num17[-32]
4000/500
num18 = c(1:8)
num18 = c(num18*500,4040)
num18 = num18[-8]
num19 = c(500, 1011)

