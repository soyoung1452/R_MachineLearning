# 학습 알고리즘의 우수성은 입력 데이터의 수준에 따라 결정된다.
# 데이터의 복잡성으로 인해 머신 러닝 프로젝트에 투자하는 노력 중 가장 많은 부분이 데이터의 준비와 탐색에 소요된다.

##### R 데이터 구조 #####
# 데이터 타입별로 특정한 작업에 적합한 장단점을 갖고 있다.
# 머신 러닝에 주로 사용되는 R 데이터 구조는 벡터, 팩터, 배열과 행렬, 데이터 프레임이 있다.

# Vector
# 항목(element)이라고 하는 갑의 순서 집합을 저장 : vector <- c()
# 개수 제한이 없으며, 모두 같은 타입
# 벡터의 타입  : typeof(vector)
# integer(소수 자리가 없는 숫자)/double(소수 자리가 있는 숫자)/character(텍스트)/logical(TRUE or FALSE)
# NULL(absence)/NA(missing value)
# 항목은 1부터 계산

subject_name <- c("John", "Jane", "Steve")
temperature <- c(98.1, 98.6, 101.4)
flu_status <- c(FALSE, FALSE, TRUE)
temperature[2]; temperature[2:3]; temperature[-2] # -k : k번째 항목 제외

# Factor
# 명목 데이터 저장을 위해 문자 벡터를 사용해도 되지만, factor는 R의 특화된 데이터 구조 : factor <- factor(c(), levels = c(), ordered = )
# 범주 변수나 순위 변수만을 나타내기 위해 사용되는 특별한 종류
# 장점 : 범주 레이블이 한번만 저장 -> 동일한 정보를 저장하는 데 필요한 메모리 크기를 줄여준다.

gender <- factor(c("MALE", "FEMALE", "MALE")); gender
blood <- factor(c("O", "AB", "A"), levels = c("A", "B", "AB", "O")); blood
symptoms <- factor(c("SEVERE", "MILD", "MODERATE"),
                   levels = c("MILD", "MODERATE", "SEVERE"),
                   ordered = TRUE)    # 순서 정보 데이터
symptoms > "MODERATE"   # 순위 테스트 -> 논리값

# List
# 항목의 순서 집합을 저장한다는 점에서 vector와 유사하다.
# 그러나 리스트는 수집된 항목이 다른 타입이여도 된다. : list <- list()
# 구성 요소의 이름 지정 가능
# 구성 요소 선택 시, 이중 괄호를 [[]] 사용한다. 또는 $로 구성 요소에 접근한다. [] 일때는 리스트로 출력

subject1 <- list(fullname = subject_name[1],
                 temperature = temperature[1], 
                 flu_status = flu_status[1],
                 gender = gender[1],
                 blood = blood[1],
                 symptoms = symptoms[1])
subject1[[2]]; subject1$temperature


# DateFrame
# 행과 열을 갖고 있어 스프레드시트나 테이터베이스와 유사한 구조이다.
# 동일한 개수의 값을 갖는 벡터나 팩터의 리스트이다. : df <- data.frame()
# stringAsFactors = FALSE : 모든 문자를 팩터형으로 변환하는 것을 방지
# 벡터, 리스트 -> 1차원, 데이터 프레임 -> 2차원

pt_data <- data.frame(subject_name, temperature, flu_status, gender, blood, symptoms, stringsAsFactors = FALSE)
pt_data


# Matrix
# 데이터 프레임 이외에 표 형태로 값을 저장하는 데이터 구조
# 행렬 : 벡터처럼 같은 타입의 2차원 표 : matrix <- matrix()
# 배열 : 행과 열, 임의의 개수의 추가 계층으로 구성 (행렬은 행과 열로 구성)

m <- matrix(c(1,2,3,4), nrow = 2); m

