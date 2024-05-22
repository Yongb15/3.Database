-- player 테이블에서 team_id가 K01인 선수 중 position이 'GK'인 선수
SELECT *
FROM (SELECT * FROM PLAYER WHERE TEAM_ID = 'K01')
WHERE "POSITION" = 'GK';

-- player 테이블에서 평균 키(HEIGHT)보다 작은 선수 검색

-- 평균 키
SELECT AVG(HEIGHT)
FROM PLAYER;

SELECT *
FROM PLAYER
WHERE HEIGHT < (SELECT AVG(HEIGHT)
FROM PLAYER);

-- player 테이블에서 포지션 별 평균 키와 전체 평균 키 구하기

SELECT "POSITION", AVG(HEIGHT) "position", (SELECT avg(HEIGHT) FROM PLAYER) "전체 평균 키"
FROM PLAYER
GROUP BY "POSITION";

-- player 테이블에서 NICKNAME이 NULL인 선수들은 정태민 선수의 닉네임으로 바꾸기
UPDATE PLAYER
SET NICKNAME = (SELECT NICKNAME
FROM PLAYER
WHERE PLAYER_NAME = '정태민')
WHERE NICKNAME IS NULL;

SELECT *
FROM PLAYER
WHERE NICKNAME = '킹카';

-- 사원 테이블에서 평균 급여보다 적게 받는 사원들의 급여를 10% 인상하기'
UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE SALARY < (SELECT avg(SALARY)
FROM EMPLOYEES); 

SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES;

-- 연결 : '||'
-- EMPLOYESS 테이블에서 사원들의 이름 연결
SELECT first_name || ' ' || last_name 풀네임
FROM EMPLOYEES;

-- xx의 급여는 xx이다.
SELECT FIRST_NAME || '의 급여는 ' || SALARY || '만원이다!' 급여
FROM EMPLOYEES;

-- 별칭(ALIAS)
-- 컬럼의 이름이 너무 길다면 별칭을 줘서 대신 사용 가능
-- SELECT 절에서 주로 사용
-- AS 별칭
-- "별칭"
-- 별칭
-- FROM절
-- 테이블명 별칭

-- 별칭의 장점
-- 테이블에 별칭을 줘서 컬럼을 단순, 명확히 할 수 있음.
-- 현재의 SELECT 문장에서만 유효함
-- 테이블 별칭은 길이가 30자까지 가능하나 짧을수록 좋음.
-- 테이블 별칭에는 의미가 있어야 함.
-- FROM 절에 테이블 별칭 설정시 해당 테이블은 SELECT절에서 테이블 이름 대신에 사용 가능.

SELECT COUNT(SALARY) 개수, MAX(SALARY) 최대값, MIN(SALARY) 최소값, SUM(SALARY) 합계, AVG(SALARY) 평균
FROM EMPLOYEES;

-- 두 개 이상의 테이블에서 각각의 컬럼을 조회하려고 어떤 테이블에서 온 컬럼인지 확실하게 적어줘야 함
SELECT e.DEPARTMENT_ID, d.DEPARTMENT_NAME  
FROM EMPLOYEES e, DEPARTMENTS d

------------------------------------------------------------------------------------------

-- JOIN
-- 데이터베이스에서 '두 개 이상의 테이블'을 연결하여 '하나의 결과의 테이블'로 만드는 것
-- 이를 통해 데이터를 효율적으로 검색하고 처리하는데 도움을 줌
-- JOIN을 사용하는 이유는 데이터베이스에서 테이블을 분리하여 '데이터 중복을 최소화'하고 '데이터의 일관성'을 유지하기 위함임
-- 여러가지 JOIN방식이 있으며 JOIN방식에 따라 결과가 달라짐

-- JOIN의 종류

-- INNER JOIN
-- 각 테이블에서 조인 조건에 일치되는 데이터만 가져옴
-- INNER은 생략 가능!
/*
 * 테이블A INNER JOIN 테이블B ON 조건식
 * 테이블A JOIN 테이블B ON 조건식
*/

-- 사원 테이블과 부서 테이블에서 이름, 부서번호, 부서명 조회
SELECT first_name, e.department_id, department_name
FROM EMPLOYEES e JOIN DEPARTMENTS d
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID;

-- 부서(departments), 지역(locations)로부터 부서명과 city를 조회
SELECT *
FROM DEPARTMENTS;

SELECT *
FROM LOCATIONS;

SELECT DEPARTMENT_NAME, city
FROM DEPARTMENTS d join LOCATIONS l
ON d.LOCATION_ID = l.LOCATION_ID;

-- 이름, 성, 직종, job_title을 조회(employees와 jobs)
SELECT *
FROM EMPLOYEES;

SELECT *
FROM jobs;

SELECT FIRST_NAME, LAST_NAME, e.JOB_ID, job_title 
FROM EMPLOYEES e JOIN JOBS j 
ON e.JOB_ID  = j.JOB_ID;

-- 사원, 부서, 지역 테이블로부터 이름, 이메일, 부서번호, 부서이름, 지역번호, 도시이름을 출력하되 도시이름이 'Seattle'인 경우만 조회
SELECT *
FROM EMPLOYEES;

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM LOCATIONS;

SELECT e.first_name, e.email, d.DEPARTMENT_ID, d.DEPARTMENT_NAME, l.LOCATION_ID, l.CITY 
FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
				 JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID AND city = 'Seattle';

------------------------------------------------------------------------------------------
				
-- SELF INNER JOIN
-- 하나의 테이블에서 다른 컬럼을 참조하기 위해 사용하는 '자기 자신과의 조인' 방법!
-- 이를 통해 데이터베이스에서 한 테이블 내의 값을 다른 값과 연결 가능!
/*
 * 테이블A a1(별칭) JOIN 테이블A a2(별칭) 
 * ON 조건식
 */

SELECT *
FROM emp;

SELECT *
FROM emp e1 JOIN emp e2
ON e1.mgr = e2.EMPNO;
				
------------------------------------------------------------------------------------------
				
-- CROSS INNER JOIN(행 X 행 의 개수)
-- 두 개 이상의 테이블에서 '모든 가능한 조합'을 만들어 결과를 반환하는 조인방법
-- 이를 통해 두 개 이상의 테이블을 조합하여 새로운 테이블을 생성 가능
-- CROSS JOIN은 일반적으로 테이블 관계가 없을 때 사용
-- 각 행의 모든 가능한 조합을 만들기 때문에 결과가 매우 큰 테이블이 될 수 있으므로 사용에 주의가 필요

CREATE TABLE 테이블A(
	A_id NUMBER,
	A_name varchar2(10)
);

CREATE TABLE 테이블B(
	B_id NUMBER,
	B_name varchar2(20)
);

INSERT INTO 테이블A VALUES(1, 'John');
INSERT INTO 테이블A VALUES(2, 'Jaen');
INSERT INTO 테이블A VALUES(3, 'Bob');

INSERT INTO 테이블B VALUES(101, 'Apple');
INSERT INTO 테이블B VALUES(102, 'Banana');

SELECT *
FROM 테이블A CROSS JOIN 테이블B;

------------------------------------------------------------------------------------------

-- OUTER JOIN
-- OUTER JOIN은 두 테이블에서 '공통된 값을 가지지 않는 행들'도 같이 반환

-- LEFT OUTER JOIN(조금 더 많이 사용)
-- '왼쪽 테이블의 모든 행', '왼쪽과 오른쪽 테이블이 공통적으로 가지는 값'을 가지고 있는 행들을 반환
-- 교집합의 연산 결과와 차집합의 연산 결과를 합친 것과 같음
/*
 * 테이블A LEFT OUTER JOIN 테이블B
 * ON 조건식
 */

-- RIGHT OUTER JOIN
-- LEFT OUTER JOIN의 반대
-- '오른쪽 테이블의 모든 행', '왼쪽과 오른쪽 테이블이 공통적으로 가지는 값'을 가지고 있는 행들을 반환
/*
 * 테이블A RIGHT OUTER JOIN 테이블B
 * ON 조건식
 */

-- FULL OUTER JOIN
-- 두 테이블에서 '모든 값'을 반환
-- 만약 공통된 값을 가지고 있지 않는 행이 있다면 NULL값을 반환
-- 합집합의 연산 결과와 같음
-- 양쪽 테이블 데이터 집합에서 공통적으로 존재하는 데이터, 한쪽에만 존재하는 데이터 모두 추출
/*
 * 테이블A FULL OUTER JOIN 테이블B
 * ON 조건식
 */

SELECT *
FROM EMPLOYEES e
WHERE DEPARTMENT_ID IS NULL;

-- 사원 테이블과 부서 테이블의 LEFT OUTER JOIN을 이용하여 사원이 어느 부서에 있는지 조회하기
SELECT FIRST_NAME, DEPARTMENT_NAME 
FROM EMPLOYEES e LEFT OUTER JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- 사원 테이블과 부서 테이블의 RIGHT OUTER JOIN을 이용하여 사원이 어느 부서에 있는지 조회하기
SELECT FIRST_NAME, DEPARTMENT_NAME 
FROM EMPLOYEES e RIGHT OUTER JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- 사원 테이블과 부서 테이블의 FULL OUTER JOIN을 이용하여 사원이 어느 부서에 있는지 조회하기
SELECT FIRST_NAME, DEPARTMENT_NAME 
FROM EMPLOYEES e FULL OUTER JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

------------------------------------------------------------------------------------------

-- 오라클 조인
-- WHERE절로 JOIN을 하는 옛날 방식

-- ANSI 조인 
-- ON으로 하는 요즘 방식

-- 비등가 조인
-- 부등호를 통한 JOIN(테이블간의 컬럼 값들이 정확히 일치하지는 않을 때 사용)
SELECT *
FROM SALGRADE s;

SELECT *
FROM EMP e;

SELECT e.EMPNO, e.ENAME, s.GRADE, e.SAL 
FROM EMP e JOIN SALGRADE s
ON e.sal BETWEEN  s.LOSAL AND s.HISAL;

-- DEPT 테이블의 LOC별 평균 SAL을 반올림 값과 SAL의 총 합 구하기
-- EMP, DEPT 테이블
SELECT *
FROM DEPT d;

SELECT *
FROM EMP e;

SELECT d.LOC, round(avg(e.SAL)), SUM(e.SAL) 
FROM DEPT d join EMP e
ON d.DEPTNO = e.DEPTNO
GROUP BY d.LOC;