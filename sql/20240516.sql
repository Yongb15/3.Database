/* 테이블 생성 방법
*	CREATE TABLE 테이블명 (
*		컬럼명 타입(길이),
*		컬럼명 타입(길이),
*		컬럼명 타입(길이)
*	);
*	
*	
* */

-- CAR 테이블 생성
CREATE TABLE CAR(
	ID NUMBER, 
	BRAND VARCHAR2(100),
	COLOR VARCHAR2(100),
	PRICE NUMBER,
	-- 제약조건 주는 방법
	-- CONSTRAINT 제약조건명 제약조건종류(컬럼)
	CONSTRAINT CAR_PK PRIMARY KEY(ID)
);

-- 테이블 삭제
-- DROP TABLE 테이블명;
DROP TABLE CAR;

-- 이미 만들어진 테이블의 제약조건을 삭제하는 법
-- ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE CAR DROP CONSTRAINT CAR_PK; 

-- 이미 만들어진 테이블의 제약조건을 추가하는 법
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건종류
ALTER TABLE CAR ADD CONSTRAINT CAR_PK PRIMARY KEY(ID);  

-- TBL_ANIMAL 테이블 생성
CREATE TABLE TBL_ANIMAL(
	ID NUMBER PRIMARY KEY,
	"TYPE" VARCHAR2(100),			-- TYPE은 명령어이기 때문에 명령어를 컬럼으로 사용하고 싶다면 쌍따옴표 안에 넣어야 한다.
	AGE NUMBER(3),
	FEED varchar2(100)
);

-- 학생 테이블 생성
-- DEFAULT와 CHECK 제약조건에 대해 알아보자
CREATE TABLE TBL_STUDENT(
	ID NUMBER,
	NAME VARCHAR2(100),
	MAJGOR VARCHAR2(100),
	GENDER CHAR(1) DEFAULT 'W' NOT NULL CONSTRAINT BAN_CHAR CHECK(GENDER='W' OR GENDER='M'),
	BIRTH DATE CONSTRAINT BAN_DATE CHECK(BIRTH >= TO_DATE('1980-01-01', 'YYYY-MM-DD')),
	CONSTRAINT STD_PK PRIMARY KEY(ID)
);

-- 1. NOT NULL만 선언한 경우
-- 해당 컬럼에 아무런 값도 넣지 않고 추가했을 때 : NOT NULL 동작
-- 해당 컬럼에 NULL 값을 넣어 추가했을 때 : NOT NULL 동작

-- 2. DEFAULT만 선언한 경우
-- 해당 컬럼에 아무런 값도 넣지 않고 추가했을 때 : DEFAULT 동작
-- 해당 컬럼에 NULL 값을 넣어 추가했을 때 : DEFAULT가 동작하지 않음
-- NULL 이라는 값이 들어간 것으로 취급하여 DEFAULT 값이 들어가지 않는다.

-- 3. NOT NULL과 DEFAULT 둘 다 선언한 경우
-- 해당 컬럼에 아무런 값도 넣지 않고 추가했을 때 : DEFAULT가 동작하여 기본값 들어감
-- 해당 컬럼에 NULL 값을 넣어 추가했을 때 : NOT NULL 동작

-- 무결성
-- 데이터베이스에 저장된 데이터 값과 그것이 표현하는 현실 세계의 실제 값이 일치하는지 정확성을 의미한다
-- 무결성 제약조건은 DB에 들어있는 정확성을 보장하기 위해 부정확한 자료가 DB내에 저장되는 것을 방지하기 위한 제약조건을 말한다.
-- 데이터의 정확성, 일관성, 유효성이 유지되는 것

-- 정확성 : 중복이나 누락이 없는 형태
-- 일관성 : 원인과 결과의 의미가 연속적으로 보장되어 변하지 않는 상태
-- 유효성 : 사용자로부터 값을 입력받을 때 정확한 값만 입력되도록 할 때 유효한 기능

-- 1. 개체 무결성
-- PK로 선택된 컬럼은 고유한 값을 가져야 하며 빈 값 즉 NULL 값은 허용 X

-- 2. 참조 무결성
-- 외래키 값은 NULL이거나 참조 테이블의 기본키 값과 동일해야 함
-- 테이블은 참조할 수 없는 외래키 값을 가질 수 없다.

-- 3. 도메인 무결성
-- 주어진 속성의 값들이 도메인에 속한 값이어야 한다는 규정

-- 4. 사용자 정의 무결성
-- 속성 값들이 사용자가 정의한 제약 조건에 만족해야 한다는 규정

---------------------------------------------------------------------------------------------------

-- 모델링
-- 정보 시스템의 구축의 대상이 되는 업무 내용을 분석하여 이해하고 약속된 표기법에 의해 표현한 것
-- 분석된 모델을 가지고 실제 데이터베이스를 생성하여 개발 및 데이터 관리에 사용
-- 특히 데이터를 추상화한 데이터 모델은 데이터베이스의 골격을 이해하고 그 이해를 바탕으로 SQL문장을 기능과 성능적인 측면에서 효율적으로 작성할 수 있기 때문에 모델링은 데이터베이스 설계의 핵심 과정

-- 데이터 모델링의 특징
-- 추상화 : 현실 세계를 일정한 형식에 맞춰 간략하게 표현해야 함
-- 단순화 : 누구나 쉽게 이해할 수 있도록 제한된 표기법이나 언어를 사용해야 함
-- 명확화 : 명확하게 의미가 해석되어야 하고 한 가지 의미만을 가져야 함

-- 모델링의 순서
-- 1) 요구사항 분석
-- 업무를 시작하기 전에 업무에 대해서 파악하는 단계
-- 고객과의 의사소통을 통해 고객의 업무 프로세스를 완벽하게 이해하고 그들의 요구사항을 구체적으로 뽑아내는 과정

-- 2) 개념 모델링
-- 내가 하고자 하는 일의 데이터 간의 관계를 구성하는 단계
-- 각 개체들과 그들간의 관계를 발견하고 표현하기 위해 E-R 다이어그램을 생성

-- 3) 논리 모델링
-- 개념 모델링이 완성되면 구체화된 업무 중심의 데이터 모델을 만들어내야 한다.
-- 업무에 대한 key, 속성, 관계 등을 표시하며 정규화 활동을 수행
-- 정규화는 데이터 모델의 일관성을 확보하고 중복을 제거하며 신뢰성있는 데이터 구조를 얻는데 목적이 있다.

-- 4) 물리 모델링
-- 최종적으로 데이터를 관리할 데이터베이스를 선택하고 선택한 데이터베이스에 실제로 테이블을 만드는 작업
-- 시각적 구조를 만들었으며 그것을 실제로 SQL 코딩을 통해 완성하는 단계

-- 5) 구현

/*
USER_ID(PK) : VARCHAR2(100)
---------
PW : VARCHAR2(100)		
USER_NAME : VARCAHR2(200)	
USER_ADDRESS : VARCAHR2(300)	
USER_EMAIL : VARCAHR2(300)
USER_BIRTH : DATE
*/
CREATE TABLE "USER"(
	USER_ID varchar2(100) PRIMARY KEY,
	PW varchar2(100),
	USER_NAME varchar2(200),
	USER_ADDTESS varchar2(300),
	USER_ENAME varchar2(300),
	USER_BIRTH date
);

/*
ORDER
ORDER_NUM(PK) : NUMBER
---------------------
ORDER_DATE : DATE
ID(FK) : VARCHAR2(100)
PRODUCT_NUM(FK) : NUMBER
*/
CREATE TABLE "ORDER"(
	ORDER_NUM NUMBER PRIMARY KEY,
	ORDER_DATE DATE,
	USER_ID varchar2(100),
	PRODUCT_NUM NUMBER,
	CONSTRAINT USER_FK FOREIGN key(USER_ID) REFERENCES "USER"(USER_ID),
	CONSTRAINT PRODUCT_FK FOREIGN key(PRODUCT_NUM) REFERENCES PRODUCT(PRODUCT_NUM)
	--					제약조건명			칼럼명				   참조테이블	컬럼명	
);

/*
PRODUCT
PRODUCT_NUM(PK) : NUMBER
------------------------------------------
PRODUCK_NAME : VARCHAR2(300)
PRODUCK_PRICE : NUMBER
PRODUCK_COUNT : NUMBER
*/
CREATE TABLE PRODUCT(
	PRODUCT_NUM NUMBER PRIMARY KEY,
	PRODUCT_NAME varchar2(300),
	PRODUCT_PRICE NUMBER,
	PRODUCT_COUNT NUMBER
);

---------------------------------------------------

CREATE TABLE FLOWER(
	FLOWER_NAME varchar2(100) PRIMARY KEY,
	FLOWER_COLOR varchar2(100),
	FLOWER_PRICE NUMBER
);

CREATE TABLE POT(
	POT_NUM varchar2(100) PRIMARY KEY,
	POT_COLOR varchar2(100),
	POT_SHAPE varchar2(100),
	FLOWER_NAME varchar2(100),
	CONSTRAINT POT_FK FOREIGN KEY(FLOWER_NAME) REFERENCES FLOWER(FLOWER_NAME)
);

-- 사원 테이블(EMPLOYEES)의 모든 정보를 조회하기!
SELECT *
FROM EMPLOYEES;

-- 사원 테이블에서 이름, 직종, 급여를 조회하세요
SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES;

-- 사원 테이블에서 사원번호, 이름, 직종, 급여, 보너스율, 실제 보너스 금액
-- SELECT 절에서 간단한 연산이 가능하다
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, COMMISSION_PCT, SALARY * COMMISSION_PCT
FROM EMPLOYEES;

-- 사원 테이블에서 급여가 10,000 이상인 사원들에 대해서 사원번호, 이름, 급여 순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME, salary
FROM EMPLOYEES
WHERE salary >= 10000;

-- 사원 테이블에서 이름이 'Michael'인 사원의 사원번호, 이름, 급여 조회
SELECT employee_id, first_name, salary
FROM EMPLOYEES
WHERE FIRST_name = 'Michael';