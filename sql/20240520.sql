-- SQL 함수
-- 오라클에서 자체적으로 제공하는 함수

-- 내장함수의 종류
-- 단일행 함수 : 1개의 행값이 함수에 적용되어 1개의 행을 반환
-- 집계 함수 : 1개 이상의 행의 값이 함수에 적용되어 1개의 값을 반환

-- ★DUAL 
-- 오라클 자체에서 제공하는 테이블
-- 간단하게 함수를 이용해서 계산 결과 값을 확인할 때 사용하는 테이블

-- ASCII(): 지정된 문자의 ASCII() 코드 값을 반환
SELECT ascii('A')  ascii
FROM dual;

-- CHR() : 지정된 값과 일치하는 아스키코드 반환
SELECT chr(65) chr
FROM dual;

-- RPAD(데이터, 고정길이, 문자) : 왼쪽 정렬 후 오른쪽에 생긴 빈 공간에 특정 문자를 채워 반환
SELECT rpad(DEPARTMENT_NAME, 10, '*') rpad
FROM DEPARTMENTS;

-- LPAD(데이터, 고정길이, 문자) : 오른쪽 정렬 후 왼쪽에생긴 빈 공간에 특정 문자를 채워 반환
SELECT lpad(DEPARTMENT_NAME, 10, '*') lpad
FROM DEPARTMENTS;

-- TRIM() : 문자열 앞뒤에 공백을 제거 
SELECT trim('   HELLO    ') trim
FROM dual;

-- 컬럼이나 대상 문자열에서 특정 문자가 첫 번째나 마지막에 위치해있으면 해당 특정 문자열만 잘라낸 후 남은 문자열만 반환
SELECT trim('Z' from 'ZZZHELLOZZZ') trim
FROM dual;

-- RTRIM() : 오른쪽 공백만 제거
SELECT rtrim('HELLOW    ') rtrim
FROM dual;

-- LTRIM() : 왼쪽 공백만 제거
SELECT ltrim('    HELLOW') ltrim
FROM dual;

-- ★INSTR() : 특정문자의 위치를 반환 
SELECT instr('HELLOW', 'O') instr
FROM dual;

SELECT INSTR('HELLOW', 'L', 1, 2) instr	-- 찾는 문자열이 없으면 0을 반환
FROM dual;

-- 찾는 문자열이 없으면 0을 반환
SELECT instr('HELLOW', 'Z', 1, 2) instr
FROM dual;

-- INITCAP() : 첫 문자를 대문자로 변환하는 함수, 띄어쓰기나 '/'를 구분자로 인식
SELECT initcap('good morning') initcap
FROM dual;

SELECT initcap('good/morning') initcap
FROM dual;

-- LENGTH() : 문자열의 길이를 반환
SELECT length('john') length
FROM dual;

-- REPLACE() : 첫 번째 지정한 문자를 두 번째 지정한 문자로 바꿔 반환
SELECT replace('GOOD MORNUNG', 'GOOD', 'BAD') replace
FROM dual;

-- CONCAT() : 주어지는 두 문자열을 연결
SELECT concat('Republic of', ' Korea') concat
FROM dual;

-- LOWER() : 모두 소문자로 변환
SELECT lower('GOOD MORNING')
FROM dual;

-- UPPER() : 모두 대문자로 변환
SELECT upper('good morning')
FROM dual;

-- ★SUBSTR() : 문자열을 원하는 위치까지 잘라서 반환
SELECT SUBSTR('Hello Oracle', 2) case1, substr('Hello Oracle', 7, 5) case2
FROM dual;

------------------------------------------------------- 문자 함수

-- 사원 테이블에서 이름에 'el'이 들어가면'**'로 치환하여 출력
SELECT replace(first_name, 'el', '**')
FROM EMPLOYEES;

-- 이름이 6글자 이상인 사원의 사원번호와 이름, 급여를 출력
SELECT EMPLOYEE_ID, first_name, salary
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) > 5;

-- 사원 테이블에서 이름, 급여, 급여 1,000당 0의 개수를 채워 조회
-- ex) 급여가 8,500일 경우 반올림 후 00000000로 표현
SELECT first_name, salary, rpad(REPLACE(salary, salary, '■'), round(SALARY / 1000), '■') exam
FROM EMPLOYEES;

-- 이게 더 쉬움!
SELECT first_name, salary, rpad('■', round(SALARY / 1000), '■') exam
FROM EMPLOYEES;

------------------------------------------------------- 문자 함수 예제

-- ABS() : 절대값 반환
SELECT -10, ABS(-10)
FROM dual;

-- ROUND() : 반올림(데이터)
SELECT round(1234.567, 1), round(1234.567, -1), round(1234.567) -- 양수면 소수점을 반올림
FROM dual;

-- FLOOR() : 주어진 숫자보다 작거나 같은 정수 중 최대값을 반환
SELECT floor(2), floor(2.4)
FROM dual;

-- TRUNC() : 특정 자릿수를 버리고 반환
SELECT trunc(1234.567, 1), trunc(1234.567, -1), trunc(1234,567) -- 양수면 소수점을 버림
FROM dual;

-- SIGN() : 음수는 -1, 0은 0, 양수는 1을 반환
SELECT sign(-10), sign(0), sign(10)
FROM dual;

-- CEIL() :  주어진 숫자보다 크거나 같은 정수 중 최소값을 반환
SELECT CEIL(2), CEIL(2.1) as ceil			-- 2.1은 2보다 크므로 3을 반환?
FROM dual;

-- MOD() : 나머지를 반환
SELECT mod(1, 3), mod(2, 3), mod(3, 3), mod(4, 3) mod	-- 1 / 3은 0이므로 1 반환,  2 / 3은 0이므로 2 반환 , 3 / 3은 1이므로 0 반환, 4 / 3은 1.3333333 이므로 1 반환
FROM dual;

-- POWER() : 주어진 숫자의 지정된 수만큼 제곱값을 반환
SELECT power(2, 1), power(2, 2), power(2, 3), power(2, 0) power -- 2 ^ 1 = 2, 2 ^ 2 = 4, 2 ^ 3 = 8, 2 ^ 0 = 1로 각각 반환
FROM dual;

------------------------------------------------------- 숫자 함수

-- 사원 테이블에서 사원번호가 짝수인 사람들의 사원번호와 이름을 출력
SELECT employee_id, first_name
FROM EMPLOYEES
WHERE MOD(employee_id, 2) = 0;

-- 사원 테이블에서 사원번호, 사원번호가 짝수면 0 홀수면 1을 함께 조회하세요
SELECT employee_id, mod(EMPLOYEE_ID, 2) employee_id		-- 조건을 붙이지 않아야만 SELECT절에서 사용 가능!
FROM EMPLOYEES;

------------------------------------------------------- 숫자 함수 예제

-- SYSDATE : 오늘 날짜를 반환
-- ADD_MONTHS() : 특정 날짜의 개월 수를 더함
SELECT sysdate, ADD_MONTHS(sysdate, 2)
FROM dual;

-- MONTHS_BETWEEN() : 두 날짜 사이의 간격을 개월 수로 반환 
SELECT MONTHS_BETWEEN(sysdate, to_date('2005-01-01', 'yyyy-mm-dd'))
FROM dual;

-- NEXT_DAY() : 주어진 일자가 다음에 나타나는 지정 요일(1 : 일요일, 7 : 토요일)의 날짜를 반환
SELECT NEXT_DAY(SYSDATE - 7, '일요일') next_day -- 저번주 일요일의 날짜 / 일요일, 일, 1도 가능 셋 중에 아무거나 가능
FROM dual;

-- LAST_DAY() : 주어진 일자가 포함된 월의 말일을 반환

------------------------------------------------------- 날짜 함수

-- 사원 테이블에서 모든 사원의 입사일로부터 6개월 뒤의 날짜를 이름, 입사일, 6개월 뒤 날짜 순으로 출력
SELECT first_name, hire_date, ADD_MONTHS(HIRE_DATE, 6) add_months
FROM EMPLOYEES;

-- 사원 테이블에서 사원번호가 120번인 사원은 입사 후 3년 6개월 후 지급한다. 이름과 진급 날짜 조회
SELECT first_name, ADD_MONTHS(hire_date, 42) hire_date 
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 120;

-- 사원 테이블에서 사원들의 이름, 입사일, 입사 후 오늘까지의 개월 수를 조회하되 입사기간이 200개월 이상인 사람만 조회하고 입사 개월 수는 소수점 한자리까지 반올림하여 조회
SELECT first_name, hire_date, round(MONTHS_BETWEEN(sysdate, HIRE_DATE), 1) months
FROM employees
WHERE MONTHS_BETWEEN(sysdate, HIRE_DATE) >= 200; 

-- 사원 테이블에서 입사기간이 160개월 이상인 사원들의 이름, 입사일, 입사 후 개월 출력?
SELECT first_name, hire_date, round(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) months 
FROM EMPLOYEES
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 160;

------------------------------------------------------- 날짜 함수 예제

-- TO_CHAR(날짜, 포멧)
SELECT to_char(sysdate, 'yyyy-mm-dd') case1 , to_char(sysdate, 'yyyy-mm-dd day') CASE2 , to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') case3
FROM dual;

-- 날짜 형식 FORMATTING 모델
-- SCC, CC : 세기
-- YYYY, YY : 연도
-- MM : 월
-- DD : 일
-- DAY : 요일
-- MON : 월명() ex) JAN, FEB
-- MONTH : 월명(January)
-- HH, HH24 : 시간
-- MI : 분
-- SS : 초

SELECT to_char(1234567, '9,999,999') 				-- 하나의 자릿수라고 생각		
FROM dual;	

SELECT to_char(1234567, 'L9,999,999') 				-- 원화 표시 추가
FROM dual;

SELECT to_char(12, '0999')
FROM dual;

-- TO_DATE : 문자열을 날짜로 변환
SELECT TO_DATE('2022-04-11')
FROM dual;

SELECT TO_DATE('04-11-2002', 'mm-dd-yyyy')			-- 위에 것과 차이 X
FROM dual;

-- NULL 처리 함수 : NULL 값을 다른 값으로 변경
-- NVL() : NULL 값 대신에 다른 값으로 변경 후 검색
SELECT first_name, nvl(COMMISSION_PCT, 0) COMMISSION_PCT 
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

-- NVL2() : NULL이 아닐 때 다른값으로 변경, NULL일 때 변경할 값
SELECT first_name, nvl2(COMMISSION_PCT, 0, 1) COMMISSION_PCT 
FROM EMPLOYEES;

------------------------------------------------------- 형변환 함수

-- RANK() OVER() / 동일한 순위일 경우 그 다음 순위는 1순위씩 밀림
SELECT rank() over(ORDER BY salary desc) RANK, FIRST_name, salary
FROM EMPLOYEES;

-- DENSE_RANK() OVER() / 동일한 순위여도 그대로 출력
SELECT dense_rank() over(ORDER BY salary desc) RANK, FIRST_name, salary
FROM EMPLOYEES;

------------------------------------------------------- 순위 함수

-- 집계 함수
-- 여러 행들에 대한 연산의 결과를 하나의 행으로 반환
-- 집계 함수는 NULL 값을 체크하지 않음
-- 단 행의 개수를 세는 경우 NULL도 포함한 값을 반환

-- COUNT() : 행들의 개수를 반환
-- MIN() : 행들의 최소값을 반환
-- MAX() : 행들의 최대값을 반환
-- SUM() : 행들의 합계를 반환
-- AVG() : 행들의 평균을 반환
-- STDDEV() : 행들의 표준편차 반환
-- VARIANCE() : 행들의 분산을 반환

SELECT count(*)				-- 다른 컬럼 사용 X
FROM EMPLOYEES;

SELECT sum(salary)
FROM EMPLOYEES;

-- 사원 테이블에서 직종이 SA_REP인 사원들의 평균 급여, 급여 최고액, 급여 최저액, 급여의 총합을 출력
SELECT avg(salary) "평균 급여", max(salary) "급여 최고액", min(salary) "급여 최저액", sum(salary) "급여의 총합"
FROM EMPLOYEES;

------------------------------------------------------- 집계 함수 예제

