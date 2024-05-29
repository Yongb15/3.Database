-- 사원 테이블에서 급여가 10,000 이상이면서 13,000 이하인 사원들의 정보를 이름, 급여 순으로 조회
SELECT FIRST_NAME, salary
FROM EMPLOYEES
WHERE salary >= 10000 AND salary <= 13000;

-- 사원 테이블에서 입사일이 05년 9월 21일인 사원의 정보를 사원번호, 이름, 입사일 순으로 출력
SELECT employee_id, first_name, hire_date
FROM EMPLOYEES
WHERE HIRE_DATE = '2005-09-21';

-- 사원 테이블에서 입사일이 05년 9월 21일 이후에 입사한 사원의 정보를 사원번호, 이름, 입사일 순으로 출력
SELECT employee_id, first_name, hire_date
FROM EMPLOYEES
WHERE HIRE_DATE > '2005-09-21';

-- 사원 테이블에서 06년도에 입사한 사람들의 정보를 사원번호, 이름, 직종, 입사일 순으로 출력
SELECT employee_id, first_name, job_id, hire_date
FROM EMPLOYEES
WHERE hire_date >= '2006-01-01' AND HIRE_DATE < '2007-01-01';

-- 사원 테이블에서 급여가 4,000 ~ 8,000 사이인 사원의 이름, 직종, 급여 출력
SELECT first_name, job_id, salary
FROM EMPLOYEES
WHERE salary > 3999 AND salary < 8001;

-- 사원 테이블에서 직종이 SA_MAN 이거나 IT_PROG인 사원들의 모든 정보를 출력
SELECT *
FROM EMPLOYEES
WHERE job_id = 'SA_MAN' OR job_id = 'IT_PROG';

-- 사원 테이블에서 급여가 2200, 3200, 5000, 6800을 받는 사원들의 정보를 사원번호, 이름, 직종, 급여 순으로 출력
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE SALARY = 2200 OR SALARY = 3200 OR SALARY = 5000 OR SALARY = 6800;

-- SQL 연산자
-- BETWEEN : AND 연산자 대신 사용할 수 있는 연산자
-- IN : OR 연산자 대신 사용할 수 있는 키워드
-- LIKE : 유사검색

-- 사원 테이블에서 06년도에 입사한 사원들의 정보를 사원번호, 이름, 직종, 입사일 순으로 출력
SELECT employee_id, first_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN '2006-01-01' AND '2006-12-31';

-- IN 연산자
-- 사원 테이블에서 급여가 2200, 3200, 5000, 6800을 받는 사원들의 정보를 사원번호, 이름, 직종, 급여 순으로 출력
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE SALARY in(2200, 3200, 5000, 6800);

-- 사원 테이블에서 직종이 SA_MAN 이거나 IT_PROG가 아닌 사원들의 모든 정보를 출력
SELECT *
FROM EMPLOYEES
WHERE job_id NOT IN('SA_MAN', 'IT_PROG');

-- LIKE 연산자(유사 검색)
-- 쿼리문의 WHERE 절에 주로 사용되며 부분적으로 일치하는 속성을 찾을 때 사용
-- % : 모든 값
-- _ : 하나의 값
-- ex) %
-- 'M%' : M으로 시작하는 모든 데이터
-- '%A' : A로 끝나는 모든 데이터
-- '%A%' : A를 포함하고 있는 모든 데이터
-- '%A%I' : A와 I를 포함하고 있는 모든 데이터
-- ex) _
-- 'M_' : M으로 시작하는 두 글자인 데이터
-- '_M_' : 두 번째 글자에 M이 들어가는 3글자인 데이터
-- 'A__' : 첫번째 글자에 A가 들어가는 3글자인 데이터

-- 사원 테이블에서 사원들의 이름 중 M으로 시작하는 사원의 정보를 사원번호, 이름, 직종순으로 출력
SELECT employee_id, first_name, job_id
FROM employees
WHERE first_name LIKE 'M%';

-- 사원 테이블에서 이름이 d로 끝나는 사원번호, 이름, 직종 출력
SELECT employee_id, first_name, job_id
FROM employees
WHERE FIRST_name LIKE '%d';

-- 사원 테이블에서 이름에 어디라도 a가 포함되어 있는 사원의 정보를 사원번호, 이름, 직종순으로 출력
SELECT employee_id, first_name, job_id
FROM EMPLOYEES 
where first_name LIKE '%a%';

-- 사원 테이블에서 이름의 첫 글자가 M이면서 총 7글자의 이름을 가진 사원의 정보를 사원번호, 이름순으로 출력
SELECT job_id, first_name
FROM EMPLOYEES
WHERE first_name LIKE 'M______';

-- 사원 테이블에서 이름의 세 번째 글자의 a가 들어가는 사원들의 정보를 사원번호, 이름순으로 출력
SELECT job_id, first_name
FROM EMPLOYEES 
WHERE first_name LIKE '__a%'; 

-- 사원 테이블에서 이름이 H로 시작하면서 6글자 이상인 사원들의 정보를 사원번호, 이름 순으로 조회
SELECT employee_id, first_name
FROM employees
WHERE first_name LIKE 'H_____%';

-- 사원 테이블에서 이름에 s가 포함되어있지 않은 사원들만 사원번호, 이름 순으로 조회
SELECT employee_id, first_name
FROM EMPLOYEES
WHERE FIRST_NAME NOT LIKE '%s%';

-- 사원 테이블에서 이름에 'el'이나 'en'이 포함하고 있는 사원들의 사원번호와 이름 순으로 조회
SELECT employee_id, first_name
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%el%' OR FIRST_NAME LIKE '%en%';

-- INSERT
-- 테이블에 데이터를 추가할 때 사용하는 키워드
-- INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3, ... ) values(값1, 값2, 값3, ... );  default 값이 활용하려면 사용
-- INSERT INTO 테이블명 values(값1, 값2, 값3, ... );  default 값이 활용하지 않으려면 사용

SELECT *
FROM flower;

SELECT *
FROM pot;

INSERT INTO FLOWER(flower_name, flower_color, flower_price)
values('장미꽃', '빨간색', 8000);

INSERT INTO FLOWER
values('해바라기', '노란색', 6000);

INSERT INTO FLOWER
values('오로라장미꽃', '연보라색', 9000);

INSERT INTO FLOWER
values('해바라기', '노란색', 6000);

INSERT INTO pot(pot_num, pot_color, pot_shape, flower_name)
values('20240517001', 'RED', '네모', '장미꽃');

INSERT INTO pot
values('20240517002', 'WHITE', '타원', '해바라기');

SELECT *
FROM tbl_student;

INSERT INTO tbl_student(id, name, majgor, gender, birth)
VALUES(0, '홍길동', '컴퓨터공학과', 'M', to_date('1980-01-02', 'yyyy-mm-dd'));

INSERT INTO tbl_student(id, name, majgor, gender, birth)
VALUES(1, '김길동', '컴퓨터공학과', 'M', to_date('1999-01-02', 'yyyy-mm-dd'));

INSERT INTO tbl_student(id, name, majgor, gender, birth)
VALUES(2, '이길동', '컴퓨터공학과', 'M', to_date('2000-12-31', 'yyyy-mm-dd'));

INSERT INTO tbl_student(id, name, majgor, birth)
VALUES(3, '삼길동', '컴퓨터공학과', to_date('2000-12-31', 'yyyy-mm-dd'));

-- INSERT INTO tbl_student
-- VALUES(3, '이길동', '컴퓨터공학과', to_date('2003-05-17', 'yyyy-mm-dd'));

ALTER TABLE tbl_student DROP CONSTRAINT std_pk;

-- 컬럼의 개수가 동일해야 함
INSERT INTO tbl_student
SELECT id, name, majgor, GENDER, birth
FROM tbl_student
WHERE id = 0;

SELECT *
FROM tbl_student;

-- UPDATE
-- 테이블의 내용을 수정할 때 사용하는 키워드
-- UPDATE 테이블명
-- SET 컬럼명 = 수정하려는 데이터(여러 개일 경우 ,로 구분)
-- WHERE 조건식(조건식이 없을 경우 모든 행의 데이터가 바뀜)

SELECT *
FROM pot;

UPDATE POT 
SET pot_color = 'BLUE'
WHERE pot_num = '20240517002';

-- DELETE
-- 테이블의 데이터를 삭제할 때 사용하는 명령어
-- DELETE FROM 테이블명 WHERE 조건식;

DELETE FROM FLOWER				-- 그 후 삭제(2)
WHERE flower_name = '장미꽃';	    -- 외래키로 참조되고 있는 데이터는 먼저 삭제할 수 없다!!
								-- 참조되는 데이터를 먼저 삭제해야 삭제할 수 있다!

DELETE FROM POT
WHERE flower_name = '장미꽃'; 	-- 외래키부터 삭제(1)

SELECT *
FROM TBL_STUDENT;

DELETE FROM TBL_STUDENT;

-- C(Insert), R(Select), U(Update), D(Delete)

-- ORDER BY(정렬)
-- 질의 결과에 반환되는 행들을 특정 기준으로 정렬하고자 할 때 사용
-- ORDER BY절은 쿼리문의 가장 마지막에 기술
-- ASC : 오름차순(Default)
-- DESC : 내림차순

-- 사원 테이블에서 급여를 많이 받는 사원순으로 사원번호, 급여, 입사일을 출력
SELECT employee_id, salary, hire_date
FROM employees
ORDER BY salary DESC, hire_date;

-- 사원 테이블에서 급여가 15,000 이상인 사원들의 사원번호, 이름, 급여, 입사일을 입사일이 빠른 순으로 조회
SELECT employee_id, first_name, salary, hire_date
FROM EMPLOYEES
WHERE SALARY >= 15000
ORDER BY hire_date;

-- 함수적 종속성
-- 하나의 테이블에서 한 컬럼의 값(X)이 다른 컬럼의 값(Y)을 결정하는 관계를 함수적 종속이라고 함
-- 정규화가 잘된 테이블일수록 결정자(X)는 PK 한 개이고 종속자(Y)가 여러 개인 구조를 가짐

-- 완전함수 종속
-- 종속자가 기본키에만 종속되며 기본키가 여러 속성으로 구성되어 있을 경우 기본키를 구성하는 모든 속성이 포함된 기본키의 부분 집하에 종속된 경우를 완전함수 종속이라고 함

-- 부분함수 종속
-- 테이블에서 기본키가 복합키일 경우 기본키를 구성하는 속성 중 일부에게 종속된 경우를 부분함수 종속이라고 함

-- 이행함수 종속
-- 테이블에서 X, Y, Z라는 세 개의 컬럼이 존재할 때 X -> Y, Y -> Z 라는 종속관계가 있을 경우 X -> Z가 성립되는 것을 이행적 함수 종속이라고 함

-- 정규화
-- 테이블을 만들 때 모델링을 하면서 정확하게 만들었지만 불필요한 컬럼이라던가 불필요한 요소를 걸러내는 작업
-- 논리 모델링시 정규화를 진행하게 됨
-- 1차 ~ 5차 정규화가 존재하나 대게 3차 정규화까지만 진행

-- 정규화의 이점
-- 불필요한 데이터 반복을 제거함으로써 저장공간을 최소화할 수 있으며 데이터의 변경시 데이터의 불일치성을 최소화하고 연산 작업을 최소화할 수 있음.

-- 정규화가 필요한 이유
-- 데이터베이스를 잘못 설계하면 불필요한 데이터 중복으로 인해 공간이 낭비됨
-- 이러한 현상을 이상현상이라고 함

-- 이상현상의 종류
-- 삽입이상 : 새 데이터를 삽입하기 위해 불필요한 데이터도 삽입해야 하는 문제
-- 갱신이상 : 중복 행 중 일부만 변경하여 데이터가 불일치하게 되는 모순의 문제
-- 삭제이상 : 행을 삭제하면 꼭 필요한 데이터까지 같이 삭제가 되는 문제