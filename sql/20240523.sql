-- 집합 연산자
-- JOIN과는 별개로 두 개의 테이블을 합치는 방법이 있음

-- UNION
-- 두 개의 테이블에서 '중복을 제거하고 합친 모든 행'을 반환

SELECT FIRST_NAME 
FROM EMPLOYEES e 
UNION
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS;

-- UNION ALL
-- 두 개의 테이블에서 '중복을 제거하지 않고 합친 모든 행'을 반환

SELECT FIRST_NAME 
FROM EMPLOYEES e 
UNION ALL
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS;

-- VIEW
-- 하나 이상의 테이블이나 다른 뷰의 데이터를 볼 수 있게 하는 데이터베이스 객체
-- 실제 데이터는 뷰를 구성하는 테이블에 담겨 있지만 마치 테이블처럼 사용 가능
-- 테이블 뿐만 아니라 다른 뷰를 참조해 새로운 뷰를 만들어 사용 가능

-- VIEW의 사용 목적
-- 개발을 하다보면 여러 개의 테이블에서 필요한 정보를 뽑아 사용할 때가 많음
-- 이때 좀 더 편리하게 사용할 수 있는 방법 중의 하나가 VIEW
-- VIEW를 사용하면 복잡한 쿼리문을 간단하게 사용 가능!
-- 여러 테이블을 JOIN하고 GROUP BY를 한 복잡한 결과를 VIEW로 저장시켜 놓으면 다음부터는 VIEW만 호출하면 된다!

-- VIEW의 특징
-- 독립성 : 테이블 구조가 변경되어도 뷰를 사용하는 응용 프로그램은 변경하지 않아도 된다
-- 편리성 : 복잡한 쿼리문을 뷰로 생성함으로써 관련 쿼리를 단순하게 작성 가능! 또한 해당 형태의 SQL문을 자주 사용할 때 이용하면 편리하게 사용 가능
-- 보안성 : 직원의 급여 정보와 같이 숨기고 싶은 데이터가 존재한다면 뷰를 생성할 때 해당 컬럼을 빼고 생성함으로써 사용자에게 정보를 감출 수 있다.

-- VIEW의 생성
-- OR REPLACE 옵션 : 기존의 정의를 변경하는데 사용(없으면 생성, 있으면 수정)
/*
* CREATE OR REPLACE VIEW 뷰이름 AS (
*		쿼리문
* ); 
*/

-- VIEW의 삭제
-- DROP VIEW 뷰이름 RESTRICT OR CASCADE
-- RESTRICT : 뷰를 다른 곳에서 참조하고 있다면 삭제가 취소
-- CASCADE : 뷰를 참조하는 다른 뷰나 제약조건까지 모두 삭제

CREATE OR REPLACE VIEW MY_EMPL AS(
	SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
	FROM EMPLOYEES e
);

SELECT *
FROM MY_EMPL me; 

-- 사원의 순위, 이름, 급여 순으로 출력하되 순위는 급여를 많이 받는 순으로 매겨라

SELECT *
FROM EMPLOYEES;

CREATE OR REPLACE VIEW DATA_PLUS AS(
	SELECT RANK() OVER(ORDER BY SALARY DESC) "RANK", FIRST_NAME, SALARY
	FROM EMPLOYEES e
);

SELECT *
FROM DATA_PLUS dp;

-- EMPL_DEPT라는 이름의 뷰를 만들고 이름과 부서명을 조회하기
CREATE OR REPLACE VIEW EMPL_DEPT AS(
	SELECT FIRST_NAME, DEPARTMENT_NAME
	FROM EMPLOYEES e JOIN DEPARTMENTS d 
	ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
)

SELECT *
FROM EMPL_DEPT ed;

SELECT *
FROM PLAYER p;


-- 선수의 나이를 구하는 PLAYER_AGE라는 이름의 VIEW 만들기
SELECT ROUND(MONTHS_BETWEEN(SYSDATE, BIRTH_DATE) / 12)
FROM PLAYER p;

CREATE OR REPLACE VIEW PLAYER_AGE AS(
	SELECT PLAYER_NAME, ROUND(MONTHS_BETWEEN(SYSDATE, BIRTH_DATE) / 12) "생일"
	FROM PLAYER p	
);

SELECT *
FROM PLAYER_AGE pa;

-- 30살이 넘는 선수 검색
SELECT *
FROM PLAYER_AGE pa
WHERE "생일" > 30;

SELECT *
FROM EMPLOYEES e;

-- SELF JOIN 가능
CREATE OR REPLACE VIEW EMPL_MANAGER AS(
	SELECT e1.LAST_NAME || ' ' || e1.FIRST_NAME AS NAME, e2.LAST_NAME || ' ' || e2.FIRST_NAME AS MNAME
	FROM EMPLOYEES e1 JOIN EMPLOYEES e2 
	ON e1.MANAGER_ID = e2.EMPLOYEE_ID
);

SELECT *
FROM EMPL_MANAGER;

-- King Steven의 부하직원 목록 조회
SELECT *
FROM EMPL_MANAGER em
WHERE MNAME = 'King Steven';

-- PLAYER 테이블에 TEAM_NAME 컬럼을 추가한 PLAYER_TEAM_NAME VIEW 만들기
SELECT *
FROM PLAYER;

SELECT *
FROM TEAM;

SELECT P.*, T.TEAM_NAME 
FROM PLAYER p JOIN TEAM t 
ON p.TEAM_ID = t.TEAM_ID; 

CREATE OR REPLACE VIEW PLAYER_TEAM_NAME AS(
	SELECT P.*, T.TEAM_NAME 
	FROM PLAYER p JOIN TEAM t 
	ON p.TEAM_ID = t.TEAM_ID
);

-- VIEW를 통해 팀이 '울산현대'인 선수들 검색
SELECT *
FROM PLAYER_TEAM_NAME ptn
WHERE TEAM_NAME = '울산현대';

-- HOMETEAM_ID, STADIUM_NAME, TEAM_NAME을 검색하는 STADIUM_INFO VIEW 만들기
-- HOMETEAM이 없는 경기장 이름도 검색이 되야함

SELECT *
FROM STADIUM s;

SELECT HOMETEAM_ID, S.STADIUM_ID, TEAM_NAME
FROM STADIUM s LEFT OUTER JOIN TEAM t
ON S.HOMETEAM_ID = T.TEAM_ID OR T.TEAM_ID IS NULL;

CREATE OR REPLACE VIEW STADIUM_INFO AS(
	SELECT HOMETEAM_ID, STADIUM_NAME, TEAM_NAME
	FROM STADIUM s LEFT OUTER JOIN TEAM t
	ON S.HOMETEAM_ID = T.TEAM_ID OR T.TEAM_ID IS NULL
);

SELECT *
FROM STADIUM_INFO si;

-- HOMETEAM이 없는 경기장 검색
SELECT STADIUM_NAME
FROM STADIUM_INFO si
WHERE HOMETEAM_ID IS NULL;

-- PL/SQL문
-- Procedural Language extension to SQL
-- SQL을 확장한 절차적 언어

-- 오라클에서 지원하는 프로그래밍 언어의 특성을 수용하여 SQL에서는 사용할 수 없는 절차적 프로그래밍 기능을 가지고있어 SQL의 단점을 보안함

-- PL/SQL문을 사용하는 이유
-- 대용량 데이터를 연산해야 할 때, WAS 등의 서버로 전송해서 처리하려면 네트워크에 부하가 많이 걸림
-- 이때 프로시저나 함수를 사용하여 데이터를 연산하고 가공한 후에 최종 결과만 서버에 전송하면 부담을 많이 줄일 수 있다.
-- 로직을 수정하기 위해 서버를 껐다 켜지 않아도 된다
-- 서버에서는 단순히 DB에 프로시저를 호출하여 사용하지 않아도 됨
-- 쿼리문을 직접 노출하지 않는 만큼 SQL injection의 위험성이 줄어듬

-- PL/SQL문의 구조
/*
 * DECLARE(선언부) PL/SQL문에서 사용하는 모든 변수나 상수를 선언하는 부분
 * 
 * BEGIN(실행부) 절차적으로 SQL문을 실행할 수 있도록 절차적인 언어의 요소인 제어문, 반복문, 함수의 정의 등 로직을 기술할 수 있는 부분
 * 
 * END(실행문 종료) 
 */

-- PL/SQL문의 종류
-- 프로시저 : 리턴 값을 하나 이상 가질 수 있는 프로그램
-- 함수 : 리턴 값을 반드시 반환해야 하는 프로그램
-- 패키지 : 하나 이상의 프로시저, 함수, 변수 등의 묶음
-- 트리거 : 지정된 이벤트가 발생하면 자동으로 실행되는 PL/SQL 블록

-- 오라클에서 콘솔로 보는 방법은 PUT_LINE이라는 프로시저를 사용
-- DBMS_OUTPUT.PUT_LINE('출력할 내용');

-- 변수의 선언
DECLARE
NAME VARCHAR2(20) := '홍길동';
AGE NUMBER(3) := 30;
BEGIN
	DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME || CHR(10) || '나이 : ' || AGE);
END;

-- IF문
-- IF 조건 THEN 실행문; END IF;
-- IF 조건 THEN 실행문; ELSE 실행문; END IF;
-- IF 조건 THEN 실행문; ELSIF 조건 THEN 실행문; ELSE 실행문; END IF;

-- 점수에 맞는 학점 출력
DECLARE
	SCORE NUMBER := 80;
	GRADE VARCHAR2(5);
BEGIN
	IF SCORE >= 90 THEN GRADE := 'A';
	ELSIF SCORE >= 80 THEN GRADE := 'B';
	ELSIF SCORE >= 70 THEN GRADE := 'C';
	ELSIF SCORE >= 60 THEN GRADE := 'D';
	ELSE GRADE := 'F';
	END IF;
DBMS_OUTPUT.PUT_LINE('당신의 점수 : ' || SCORE || '점' || CHR(10) || '학점 : ' || GRADE);
END;

-- FOR LOOP문
/*
 * FOR index in [REVERSE] 시작값 .. END값 LOOP
 * 		실행문1;
 * 		실행문2;
 * 		...
 * END LOOP;
 */

-- index는 자동 선언되는 변수고 1씩 증가
-- reverse 옵션이 사용될 경우 index는 거꾸로 감소

BEGIN
	FOR i IN 1..4 LOOP
		IF mod(i, 2) = 0 THEN 
			dbms_output.put_line(i || '는 짝수!');
		ELSE
			dbms_output.put_line(i || '는 홀수!');
		END IF;
	END LOOP;
END;

-- LOOP문
/*
 * LOOP
 * 		실행문;
 * EXIT [WHEN 조건]
 * END LOOP;
 */

-- EXIT가 사용되었을 경우 무조건 LOOP문을 빠져나감
-- EXIT WHEN 조건이 사용될 경우 WHEN절에서 LOOP를 빠져나가는 조건을 제어할 수 있음

DECLARE
	NUM NUMBER := 6;
	TOTAL NUMBER := 0;
BEGIN
	LOOP
		dbms_output.put_line('현재 숫자 : ' || NUM);
		NUM := NUM + 1;
		TOTAL := TOTAL + 1;
		EXIT WHEN TOTAL > 10;
	END LOOP;
	dbms_output.put_line(TOTAL || '번의 LOOP!');
END;

-- 프로시저(PROCEDURE)
-- PL/SQL의 대표적인 부 프로그램
-- 데이터베이스에 대한 일련의 작업을 정리한 절차를 RDBMS에 저장하는 것으로 영구 저장 모듈이라고도 함
-- 일련의 쿼리를 마치 하나의 함수처럼 실행하기 위한 쿼리의 집합

-- 장점
-- 하나의 요청으로 여러 SQL문을 실행 가능
-- 네트워크 소요 시간을 줄여 성능 개선 가능
-- 기능변경이 편함

-- 단점
-- 문자나 숫자 연산에 사용하면 오히려 C, JAVA보다 느린 성능을 볼 수 있다
-- 유지보수가 쉽지 않음

-- 프로시저의 생성
/*
 * CREATE OR REPLACE PROCEDURE 프로시저명 (
 * 		매개변수 변수타입;
 *	 	매개변수 변수타입;
 *		...;
 * )
 * IS
 * BEGIN
 * 		쿼리문
 * END;
 */

-- 프로시저의 호출
-- CALL 프로시저의 이름(값1, 값2);

-- 간단한 프로시저 만들기
-- 두 수를 더하여 반환하는 프로시저
CREATE OR REPLACE PROCEDURE "ADD"(
	X NUMBER,
	Y NUMBER
)
IS
BEGIN
	dbms_output.put_line(X || ' + ' || Y || ' = ' || (X+Y));
END;

CALL "ADD"(10, 7);

-- 프로시저와 SQL
-- JOBS 테이블에 데이터를 INSERT 해주는 프로시저 만들기
SELECT *
FROM JOBS;

CREATE OR REPLACE PROCEDURE MY_NEW_JOB_PROC(
	P_JOB_ID IN JOBS.JOB_ID %TYPE,			-- JOB_ID의 타입과 크기를 그대로 따라감
	P_JOB_TITLE IN JOBS.JOB_TITLE %TYPE,
	P_MIN_SALARY IN JOBS.MIN_SALARY %TYPE,
	P_MAX_SALARY IN JOBS.MAX_SALARY %TYPE
)
IS
BEGIN 
	INSERT INTO JOBS
	VALUES (P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
	dbms_output.put_line('ALL DONE ABOUT' || ' ' || P_JOB_ID);
END;

CALL MY_NEW_JOB_PROC('IT', 'Developer', 14000, 20000);







