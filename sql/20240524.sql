-- TCL(Transaction Control Language)
-- 트랜잭션 제어어
-- 트랜잭션 : 데이터베이스의 작업을 처리하는 논리적 연산 단위

-- 트랜잭션의 특성
-- 원자성(Atomicity) : 원자와 같이 데이터베이스 연산들이 나눌 수도 줄일 수도 없는 하나의 유닛으로 취급
-- 트랜잭션에 정의된 연산들은 모두 성공적으로 실행되던지 아니면 전혀 실행되지 않은 상태로 남아야 함
/* 원자성의 EX) 통장 이체 
* UPDATE
* SET 잔액 = 0
* WHERE 계좌번호 = A 
* 
* UPDATE
* SET 잔액 = 10000
* WHERE 계좌번호 = B
**/
-- 일관성(Consistency) : 데이터베이스의 트랜잭션이 제약조건, cascades, trigger를 포함한 정의된 모든 조건에 맞게 데이터 값이 변경
-- 고립성(Isolation) : 특정 DBMS에서 다수의 유저들이 같은 시간에 같은 데이터에 접근할 때 수행중인 트랜잭션이 완료될 때까지 다른 트랜잭션의 요청을 막음으로서 데이터가 꼬이는걸 방지
-- 지속성(Durability) : 트랜잭션의 실행이 성공적일 때 그 트랜잭션이 갱신한 데이터베이스 내용은 영구적으로 저장

-- TCL의 종류
-- COMMIT : DML로 변경된 데이터를 데이터베이스에 적용할 때 사용
-- INSERT, UPDATE, DELETE문 등을 사용한 후 변경 작업을 데이터베이스에 반영하기 위해 사용
-- COMMIT문 사용시 이전 데이터는 영원히 지워짐
-- COMMIT문 사용시 모든 사용자가 변경된 데이터 확인 가능
-- 기본적으로 AUTO COMMIT 모드이므로 자동으로 COMMIT을 수행
-- COMMIT 실행시 트랜잭션 과정을 종료
-- COMMIT이 실행되기 전에는 다른 사용자가 완료되지 않은 데이터를 보거나 변경할 수 없음

-- ROLLBACK
-- DML로 변경된 데이터를 변경 이전 상태로 되돌릴 때 사용
-- 데이터에 대한 변경사항 취소
-- ROLLBACK 사용시 이전 데이터 다시 재저장 -> COMMIT 되지 않은 트랜잭션을 모두 ROLLBACK
-- ROLLBACK 사용시 관련 행의 잠금(LOCKING)이 풀려 다른 사용자들이 데이터 변경 가능

-- SAVEPOINT
-- 오류 복구 처리에 효과적인 방법 -> 전체 트랜잭션을 ROLLBACK 하지 않고도 오류 복귀가 가능
-- 효과적으로 오류 복구 처리를 위해 저장점을 사용
-- 복잡한 대규모 트랜잭션에서 에러가 발생했을 때 주로 사용
-- 복수의 저장점 정의 가능

-- 사용법
-- SAVEPOINT 세이브포인트명
-- ROLLBACK TO 세이브포인트명 

-- 사원테이블에서 JOB_ID가 'IT_PROG'인 사람들의 이름을 자신의 이름으로 바꾸기
UPDATE EMPLOYEES
SET FIRST_NAME = '김'
WHERE JOB_ID = 'IT_PROG';

SELECT *
FROM EMPLOYEES e
WHERE e.JOB_ID = 'IT_PROG';

SAVEPOINT NOUPDATE;
ROLLBACK TO NOUPDATE;

-- 사원테이블에서 직종이 IT_PROG인 사람들 삭제하기
DELETE FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

-- 시퀀스
-- 테이블에 값을 추가할 때 순차적인 정수값이 들어가도록 설정해주는 객체
-- EX) 회원가입을 할 때 회원들에게 순차적인 번호 부여 가능
-- 게시판에 작성된 게시글 순서대로 순차적인 게시글 번호를 부여할 수 있다. / 게시판 만들 때 활용

-- 시퀀스 생성
-- CREATE SEQUENCE 시퀀스명;

-- 시퀀스의 다양한 옵션 / 옵션을 추가할 때는 띄어쓰기 사용
-- INCREMENT BY 1 	-> 		1씩 증가 / 음수일 경우 빼기 연산
-- START WITH 1   	->	 	1부터 카운팅
-- MINVALUE 		->		최소값
-- MAXVALUE			->  	최대값
-- CACHE 20			-> 		20개의 공간을 미리 만들어 20명이 동시에 접속해서 글을 쓰더라도 버벅이지 않게 해줌
-- 	ㄴ EX) 은행에서 번호표를 뽑는 거와 같음 / 메모리가 휘발성메모리이므로 앞에 뽑은 20개는 사라지고 21번부터 받음
-- NOCACHE; 		-> 		1개의 공간만 확보
-- 	ㄴ EX) 1개씩만 생성
	
-- 시퀀스를 이미 만들었다면 SQL문을 통해 옵션을 설정 O
-- ALTER SEQUENCE 시퀀스명 INCREMENT BY 3(3씩 증가) MINVALUE 100 NOCACHE;

CREATE TABLE PERSON(
	 IDX NUMBER,
	 NAME VARCHAR2(200),
	 AGE NUMBER
);

CREATE SEQUENCE PERSON_SEQ;

-- ★시퀀스명.NEXTVAL : 해당 시퀀스에서 다음 순번 값을 자동으로 가져옴
INSERT INTO PERSON 
VALUES (PERSON_SEQ.NEXTVAL, '홍길동', 30);  
INSERT INTO PERSON 
VALUES (PERSON_SEQ.NEXTVAL, '김자바', 27); 
INSERT INTO PERSON 
VALUES (PERSON_SEQ.NEXTVAL, '박디비', 54); 

SELECT *
FROM PERSON;

-- 현재 시퀀스에 들어있는 값 보기
-- 시퀀스명.CURRVAL
SELECT PERSON_SEQ.CURRVAL
FROM DUAL;

-- 시퀀스값 초기화 하는 방법
-- 제일 좋은 방법은 삭제했다가 재생성
-- 대부분의 경우 권한이 없기 때문에 삭제 불가

-- 1. 현재 시퀀스 값 확인
SELECT PERSON_SEQ.CURRVAL
FROM DUAL;

-- 2. 현재 시퀀스 값만큼 INCREMENT를 뺀다
ALTER SEQUENCE PERSON_SEQ INCREMENT BY -2;		-- 

-- 3. NEXTVAL을 통해 3을 뺀다
SELECT PERSON_SEQ.NEXTVAL
FROM DUAL;					-- MINVALUE가 0이 되면 오류 발생

-- 4. 증가량을 다시 1로 바꾸기
ALTER SEQUENCE PERSON_SEQ INCREMENT BY 1;

-- 5. 시퀀스 삭제
DROP SEQUENCE PERSON_SEQ;



