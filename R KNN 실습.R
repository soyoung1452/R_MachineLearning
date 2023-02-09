##### 1단계 : 데이터 수집 #####
library(HDclassif)
# HDclassif 패키지의 내장 데이터 : wine
data("wine")
df <- wine

##### 2단계 : 데이터 탐색과 준비 #####
# 데이터 구조
str(df)   # (178/14)

# target 변수의 빈도 확인
table(df$class)  # (1:59/2:71/3:48)

# target 변수 int -> factor 데이터 타입 변경
# orderd = FALSE : 내림차순
df$class <- factor(df$class, levels = c(1, 2, 3), labels = c("1등급", "2등급", "3등급"), ordered = FALSE)
str(df)

# target 변수의 비율 확인
round(prop.table(table(df$class))*100, digits = 1)

# 변수 요약 통계량
summary(df)

# 변환 : 수치 데이터 정규화
# 정규화 함수
normalize <- function(x){return ((x - min(x))/(max(x) - min(x)))}
df_n <- as.data.frame(lapply(df[2:14], normalize))
# 데이터 세트 나누기
n <- nrow(df); n
idx <- sample(1:n, size = n*0.7, replace=FALSE)

df_train <- df_n[idx, ]; df_train_labels <- df[idx, 1]
df_test <- df_n[-idx, ]; df_test_labels <- df[-idx, 1]

##### 3단계 : 데이터 모델로 훈련 #####
library(class) 
k = round(sqrt(nrow(df_train))); k
df_md_pred <- knn(train = df_train, test = df_test, cl = df_train_labels, k = k)

##### 4단계 : 모델 성능 평가 #####
library(gmodels)
CrossTable(x = df_test_labels, y = df_md_pred, prop.chisq = F)

##### 5단계 : 모델 성능 개선 #####
# 수치 특징 재조정 : z-점수 표준화 (내장함수 scale())
df_z <- as.data.frame(scale(df[-1]))
# 분석 수행
df_train <- df_z[idx, ]; df_test <- df_z[idx, ]
df_train_labels <- df[idx, 1];  df_test_labels <- df[idx, 1]
df_md_pred_2 <- knn(df_train, df_test, df_train_labels, k = k)
CrossTable(df_test_labels, df_md_pred_2, prop.chisq = F)

# k값 조정
df_md_pred_3 <- knn(df_train, df_test, df_train_labels, k = 1)
CrossTable(df_test_labels, df_md_pred_3, prop.chisq = F)

df_md_pred_3 <- knn(df_train, df_test, df_train_labels, k = 5)
CrossTable(df_test_labels, df_md_pred_3, prop.chisq = F)

df_md_pred_3 <- knn(df_train, df_test, df_train_labels, k = 15)
CrossTable(df_test_labels, df_md_pred_3, prop.chisq = F)
