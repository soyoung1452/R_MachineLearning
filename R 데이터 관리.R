# 데이터 저장  : save()
# 확장자 : RData
save(x, y, z, file = 'mydata.RData')

# 데이터 로드 : load()
load("mydata.RData")

# 전체 세션 저장 : save.image()
# 확장자 : RData
save.image("myR.RData")

# 현재 메모리 모든 데이터 : ls()
ls()

# 데이터 객체 제거 : rm()
rm(m, subject1)

# 전체 객체 제거 : rm(list = ls())
rm(list = ls())

# csv 파일 불로오기 : read.csv()
# read.table의 특별한 경우 (read.table()은 탭구분값 등 다양한 구분자 형식 포함)
pt_data <- read.csv("pt_data.csv", stringsAsFactors = F, header = F)

# 데이터 프레임 csv 파일 저장 : write.csv()
write.csv(pt_data, file = "pt_data.csv", row.names = F)

# 경로 설정 : setwd()
setwd("C:/Users/sypar/Desktop/git/데이터_실습/Machine Learning with R (2nd Ed.)")

# 경로 확인 : getwd()
getwd()

# 데이터 구조 탐색 : str()
usedcars <- read.csv("Chapter 02/usedcars.csv", stringsAsFactors = F)
str(usedcars)

# 수치 변수 탐색 : summary()
# 여섯개 요약 통계 제공
summary(usedcars$year)
