# 예제 데이터 생성
# 재현 가능성을 위한 시드 설정
set.seed(1127)

# 10개의 관측치 변수 2개 생성
x1 <- rnorm(10)
x2 <- rnorm(10)

# 변수 간 관계 설정
y <- 5+x1 + 2*x2 + rnorm(10)

# 결측치 만들기
y[c(3, 6, 7)] <- NA

# 결측치 확인
is.na(y)

## 평균 대체 ##
y_mean <- ifelse(is.na(y), mean(y, na.rm = TRUE), y)

## 중앙값 대체 ##
y_median <- ifelse(is.na(y), median(y, na.rm = T), y)

## 다른값 대체(ex: 0) ##
y_value <- ifelse(is.na(y), 0, y)

## 회귀 예측 대체 ##
# 예측 데이터 프레임
df <- data.frame(y, x1, x2)
# 회귀분석 모델 적합
md <- lm(y ~ x1 + x2, data = df)
# 결측치 예측
predict_y <- predict(md, newdata = df[is.na(df$y), -1]) 
y_regression <- ifelse(is.na(df$y), predict(md, newdata = df[is.na(df$y), -1]) , df$y)

## 패키지 활용 대체 ##
# mice 패키지: 다중 대체법 (Multiple Imputation)
install.packages("mice")
library(mice)
# 예측 df
df
# 다중 대체법
# "norm":  연속형 변수에 대해 정규 분포 기반 다중 대체법, 이경우 결측치 대체는 평균 및 분산 구조를 따르게 됨
# "m=5": 5개의 대체 데이터 셋 생성
# "maxit = 50" : 각 대체 데이터셋에 대해 최대 50회 반복해 대체 수행
imputed_dt <- mice(df, method = "norm", m = 5, maxit = 50)
complete_dt <- complete(imputed_dt)
y_mice <- complete_dt$y

# missForest 패키지: Random Forest 기반 예측
install.packages("missForest")
library(missForest)

imputed_dt <- missForest(df)
complete_dt <- imputed_dt$ximp; complete_dt
y_missforest <- complete_dt$y

# Amelia 패키지: Expected-Maximization(EM) 알고리즘 사용 다중 대체법법
install.packages("Amelia")
library(Amelia)

imputed_dt <- amelia(df)
complete_dt <- imputed_dt$imputations$imp1; complete_dt
y_amelia <- complete_dt$y


## 결측치 대체 결과 한눈에 보기 ##
missing_imputation_result <- cbind(y, y_mean, y_median, y_value, y_regression,
                                   y_mice, y_missforest, y_amelia)
missing_imputation_result
