-- 그룹화
-- GROUP BY : 특정 테이블에서 소그룹을 만들어 결과를 분산시켜 얻고자 할 때 사용

-- 각 부서별 급여의 평균과 총합 출력
SELECT DEPARTMENT_ID, avg(salary), sum(salary)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 부서별, 직종별로 그룹을 나눠서 인원수를 출력하되, 부서번호가 낮은순으로 정렬
SELECT DEPARTMENT_ID, JOB_ID, count(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

-- 각 직종별 인원수를 조회
SELECT job_id, count(*)
FROM EMPLOYEES
GROUP BY JOB_ID;

-- 각 직종별 급여의 합 조회
SELECT job_id, sum(salary)
FROM EMPLOYEES
GROUP BY JOB_ID;

-- 부서별 급여의 합계를 내림차순으로 조회
SELECT DEPARTMENT_ID, sum(salary)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY sum(SALARY) desc;

------------------------------------------------------- 집계 함수 예제

CREATE TABLE 월별매출(
	상품ID VARCHAR2(5),
	월 varchar2(10),
	회사 varchar2(10),
	매출액 number
);

INSERT INTO 월별매출 values('P001', '2024.05', '삼성', 15000);
INSERT INTO 월별매출 values('P001', '2024.06', '삼성', 25000);
INSERT INTO 월별매출 values('P002', '2024.05', 'LG', 10000);
INSERT INTO 월별매출 values('P002', '2024.06', 'LG', 20000);
INSERT INTO 월별매출 values('P003', '2024.05', '애플', 15000);
INSERT INTO 월별매출 values('P003', '2024.06', '애플', 10000);

SELECT *
FROM 월별매출;

-- ROLLUP : 소그룹간의 합계를 계산하는 함수
SELECT 상품ID, 월, 회사, sum(매출액) 매출액
FROM 월별매출
GROUP BY ROLLUP(상품ID, 월, 회사);

-- CUBE : 항목들 간의 다차원적인 소계를 계산합니다. ROLLUP과 달리 GROUP BY절에 명시한 모든 컬럼에 대해 소그룹 합계를 계산
SELECT 상품id, 월, sum(매출액) 매출액
FROM 월별매출
GROUP BY cube(상품id, 월);

-- GROUPING SETS : 특정 항목에 대한 소계를 계산하는 함수
SELECT 상품id, 월, sum(매출액) 매출액
FROM 월별매출
GROUP BY GROUPING sets(상품id, 월); 

-- ★HAVING절★
-- GROUP BY로 집계된 값 중 WHERE절 처럼 특정 조건을 추가
-- HAVING절은 GROUP BY절과 함께 사용해야 하며 집계 함수를 사용하여 조건절을 작성하거나 GROUP BY컬럼만 조건절에 사용할 수 있다.
-- HAVING에서도 LIKE 사용 가능!

-- 각 부서의 급여의 최대값, 최소값, 인원수를 출력하되 급여의 최대값이 8000이상인 결과만 출력
SELECT department_id, max(salary), min(salary), count(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING max(SALARY) >= 8000;

-- 각 부서별 인원수가 20명 이상인 부서의 정보를 부서번호, 급여의 합, 급여의 평균, 인원수 순으로 출력 
-- 단, 급여의 평균은 소수점 첫째자리까지 반올림
SELECT  department_id, sum(salary) "급여의 합", round(avg(salary), 1) "급여의 평균", count(*) 인원수
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING count(*) >= 20;

-- 부서별 직종별로 그룹화 하여 결과를 부서번호, 직종, 인원수 순으로 출력하되 직종이 'MAN'으로 끝나는 경우에만 조회
SELECT department_id, job_id, count(*) 인원수
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID 
HAVING JOB_ID LIKE '%MAN';

-- 각 부서별 평균 급여를 소수점 한자리까지만 버림으로 출력하되 평균 급여가 10,000미만이고 부서번호가 50번 이하인 부서만 조회
SELECT DEPARTMENT_ID, trunc(avg(salary), 1) "평균 급여"
FROM EMPLOYEES
GROUP BY department_id
HAVING avg(salary) < 10000 AND department_id <= 50;

------------------------------------------------------- 그룹 함수 예제

-- DCL
-- 데이터 제어어 : 데이터베이스에 접근하고 객체들을 사용하도록 권한을 주고 회수하는 명령어
-- 종류
-- grant : 권한 부여
-- revoke : 권한 강탈

-- INDEX 
-- SELECT문을 통해 데이터를 조회하려는 테이블이 너무 거대한 경우 정렬되지 않는 모든 데이터를 순차적으로 검색하면 조회 결과를 구하기까지 오랜 시간이 걸림
-- 오라클 데이터베이스에서 테이블 내의 원하는 레코드를 빠르게 찾아갈 수 있도록 만들어진 데이터 구조
-- 원리 : 원하는 책을 찾는 것과 비슷함(도서관)

-- INDEX의 생성
-- INDEX는 테이블 내의 1개의 컬럼 또는 여러 개의 컬럼을 이용하여 생성
-- 데이터가 많다면 인덱스를 만들어 놓는 것이 효과적
-- 데이터가 적으면 정리하고 찾는 것보다 그냥 찾는 것이 더 빠름
-- 규모가 큰 테이블이나 여러번 생성, 수정, 삭제가 발생하지 않는 테이블에 적합함

-- 자동 인덱스
-- PRIMARY KEY 또는 UNIQUE에 의해 자동으로 생성되는 INDEX
-- 제목의 순서에 따라 책을 정리해놓고 해당되는 위치에 찾아가는 방식

-- 수동 인덱스
-- 사용자 직접 생성한 INDEX를 의미
-- CREATE INDEX 인덱스명 ON 테이블명(정리하고 싶은 컬럼1, 컬럼2, 컬럼3, ... );

-- INDEX의 조회
-- INDEX는 USER_INDEXES 시스템에서 조회 가능
SELECT *
FROM ALL_INDEXES
WHERE table_name = 'FLOWER';

-- INDEX의 삭제
-- 조회 성능을 높이기 위해 만든 객체지만 저장공간을 많이 차지하며 DML 작업시(INSERT, UPDATE, DELETE)
-- 부하가 많이 발생해 전체적인 데이터베이스 성능을 저하시킴

-- DBA는 주기적으로 INDEX를 검토하여 사용하지 않는 인덱스는 삭제하는 것이 데이터베이스 전체 성능을 향상시킬 수 있음
-- DROP INDEX 인덱스명;

-- INDEX REBUILD
-- 생성된 인덱스는 기본적으로 ROOT, BRANCH, LEAF로 구성된 트리구조를 가지며 DML 작업이 오랜시간 발생하며 트리의 하위 레벨이 많아져 트리 구조의 한쪽이 무거워지는 현상 발생
-- 이러한 현상은 인덱스의 검색 속도를 저하시키고 전체 데이터베이스의 성능에 영향을 미침
-- 그러므로 주기적인 INDEX를 리빌딩 작업을 해줘야 함
-- ALTER INDEX 인덱스명 REBUILD;

-- 서브쿼리
-- 특정 SQL문장 안에 또 다른 SQL문장이 포함되어 있는 것
-- 여러번 DB접속이 필요한 상황을 한 번으로 줄여서 속도를 증가시킬 수 있음
-- 서브쿼리를 사용할 수 있는 곳
-- WHERE, HAVING 절
-- SELECT 절
-- FROM 절
-- INSERT INTO 절

-- 사원 테이블에서 이름이 'Michael'이고 직종이 'MK_MAN'인 사원의 급여보다 많이 받는 사원들의 정보를 사원번호, 이름, 직종, 급여 순으로 출력

-- 1) 이름이 'Michael'이고 직종이 'MK_MAN'인 사원의 급여
SELECT salary
FROM EMPLOYEES
WHERE FIRST_NAME = 'Michael' AND JOB_ID = 'MK_MAN';

-- 2) 13,000 보다 급여가 높은 사원들의 정보
SELECT employee_id, first_name, job_id, salary
FROM EMPLOYEES
WHERE SALARY >= 13000;

-- 3) 서브쿼리는 두 쿼리문을 합침
SELECT employee_id, first_name, job_id, salary
FROM EMPLOYEES
WHERE SALARY >= (SELECT salary
FROM EMPLOYEES
WHERE FIRST_NAME = 'Michael' AND JOB_ID = 'MK_MAN');

-- 사번이 150번인 사원의 급여와 같은 급여를 받는 사원들의 정보를 사원번호, 이름, 급여 순으로 출력

-- 1) 사번이 150번인 사원의 급여
SELECT SALARY 
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 150;		-- 10,000

-- 2) 급여가 10,000인 사원의 사원번호, 이름, 급여
SELECT employee_id 사번, first_name 이름, salary 급여
FROM EMPLOYEES
WHERE SALARY = 10000;

-- 3) 두 쿼리문 합치기
SELECT employee_id 사번, first_name 이름, salary 급여
FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY 
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 150);

-- 급여가 회사의 평균 급여 이상인 사람들의 이름과 급여를 조회

-- 1) 회사의 평균 급여
SELECT avg(salary)
FROM EMPLOYEES;			-- 6,461

-- 2) 급여가 6,461 이상인 사람들의 이름과 급여를 조회
SELECT first_name, salary
FROM EMPLOYEES
WHERE SALARY >= 6461;

-- 3) 두 쿼리문 합치기
SELECT first_name, salary
FROM EMPLOYEES
WHERE SALARY >= (SELECT avg(SALARY)
FROM EMPLOYEES)

-- 사원번호가 111번인 사원의 직종과 같고 사원번호가 159번인 사원의 급여보다 많이 받는 사원들의 정보를 사원번호, 이름, 직종, 급여 순으로 출력
SELECT employee_id, first_name, job_id, salary
FROM EMPLOYEES
WHERE job_id = (SELECT JOB_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 111) AND SALARY >= (SELECT SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 159);

-- 사원 테이블에서 100번 부서의 최소 급여보다 많이 받는 다른 모든 부서의 부서번호, 최소급여를 출력

-- 100번 부서의 최소 급여
SELECT min(SALARY) 
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 100; -- 6,900

-- 6,900원 보다 많이 받는 부서의 부서번호와 최소급여를 출력
SELECT DEPARTMENT_ID, MIN(SALARY)  
FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID
HAVING MIN(SALARY) > (SELECT min(SALARY) 
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 100); 














