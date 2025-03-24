 /*
  
 1. 하나의 릴레이션에서 튜플의 전체 개수를 릴레이션의 ( ) 이라고 한다. ( ) 의 올바른 것은?
 카디널리티

 2. 성별이라는 칼럼은 M 혹은 F 값만 가질 수 있다. 성별이라는 칼럼의 제약조건은 무엇인가?
 도메인

 3. 아래 칼럼을 가지는 PRODUCT 테이블을 생성하는 DDL 을 작성하시오.
 제약조건의 이름은 자동으로 부여되도록 별도로 지정하지 마시오. (단, 제약조건의 이름을 지정하더라도 감점하지 않는다.) (10점)
 << 칼럼 정보 >>
 1) NO : 제품번호, 숫자, 기본키
 2) NAME : 제품명, 문자열 최대 100바이트, 필수
 3) PRICE : 제품가격, 숫자
 4) P_DATE : 생산일자, 날짜 
 
 */

 CREATE TABLE PRODUCT (
 	"NO" NUMBER PRIMARY KEY,
 	NAME VARCHAR2(100) NOT NULL,
 	PRICE NUMBER,
 	P_DATE DATE
 );
 
 
  CREATE TABLE "USER" (
  	ID VARCHAR2(100) PRIMARY KEY,
  	PW VARCHAR2(100),
  	ADDRESS VARCHAR2(300),
  	EMAIL VARCHAR2(300),
  	BIRTH DATE
  
  )
 
 ALTER TABLE PRODUCT RENAME COLUMN "NO" TO PRODUCT_NUM;
 ALTER TABLE PRODUCT RENAME COLUMN NAME TO PRODUCT_NAME;
 ALTER TABLE PRODUCT RENAME COLUMN PRICE TO PRODUCT_PRICE;
 ALTER TABLE PRODUCT RENAME COLUMN P_DATE TO PRODUCT_DATE;
 
 
 -- 주문테이블
 CREATE TABLE "ORDER" (
 	ORDER_NUM NUMBER PRIMARY KEY,
 	ORDER_DATE DATE,
 	USER_ID VARCHAR2(100),
 	PRODUCT_NUM NUMBER
 	-- 외래키 설정(FOREIGN KEY)
 	CONSTRAINT USER_FK FOREIGN KEY(USER_ID) REFERENCES "USER"(ID),
 	CONSTRAINT PRODUCT_FK FOREIGN KEY(PRODUCT_NUM) REFERENCES PRODUCT(PRODUCT_NUM)
 )
 
 
 DROP TABLE "ORDER"
 
 
 CREATE TABLE "ORDER" (
    ORDER_NUM NUMBER PRIMARY KEY,
    ORDER_DATE DATE,
    USER_ID VARCHAR2(100),
    PRODUCT_NUM NUMBER,
    -- 외래키 설정 (FOREIGN KEY)
    CONSTRAINT USER_FK FOREIGN KEY (USER_ID) REFERENCES "USER"(ID),
    CONSTRAINT PRODUCT_FK FOREIGN KEY (PRODUCT_NUM) REFERENCES PRODUCT(PRODUCT_NUM)
);
 
 

-- 꽃 테이블
CREATE TABLE FLOWER (
	
 VARCHAR2(100) PRIMARY KEY,
	COLOR VARCHAR2(100),
	PRICE NUMBER
);

 

-- 화분 테이블
CREATE TABLE HWABUN (
	HWA_ID NUMBER PRIMARY KEY,
	HWA_COLOR VARCHAR2(100),
	HWA_SHAPE VARCHAR2(200),
	FLO_NAME VARCHAR2(200),
	CONSTRAINT FLOWER_FK FOREIGN KEY (FLO_NAME) REFERENCES FLOWER(FLO_NAME)
); 


SELECT JOB_TITLE FROM JOBS;


-- SELECT : 튜플 조회하기
-- 사원 테이블에서 모든 내용 조회하기
SELECT * FROM EMPLOYEES;


-- 부서 테이블의 모든 정보 조회하기
SELECT * FROM DEPARTMENTS; 


-- 사원 테이블에서 이름, 직종, 급여를 조회하기
SELECT FIRST_NAME, JOB_ID, SALARY FROM EMPLOYEES;


-- 사원 테이블에서 사번, 이름, 입사일, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY FROM EMPLOYEES;


-- 사원 테이블에서 사번, 이름, 직종, 급여, 보너스 비율, 실제 보너스 급여 출력
SELECT EMPLOYEE_ID,
		FIRST_NAME,
		JOB_ID,
		SALARY,
		COMMISSION_PCT,
		-- SELECT 절에서 간단한 연산도 가능
		SALARY * COMMISSION_PCT AS "REAL BONUS"
FROM EMPLOYEES;



-- 조건: 사원 테이블에서 급여가 10000 이상인 사원들의 정보를 사번, 이름 ,급여 순으로 조회하기
SELECT EMPLOYEE_ID,
		FIRST_NAME,
		SALARY
FROM EMPLOYEES
--조건절
WHERE SALARY >= 10000;


-- 사원 테이블에서 이름이 MICHAEL인 사원의 사번, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID,
		FIRST_NAME,
		SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'Michael';


SELECT FIRST_NAME
FROM EMPLOYEES


SELECT JOB_ID
FROM EMPLOYEES


-- 사원 테이블에서 직종이 it_prog 인 사원들의 정보를
-- 사번, 이름, 직종, 급여 순으로 출력하기
SELECT EMPLOYEE_ID,
		FIRST_NAME,
		JOB_ID,
		SALARY
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';



-- 사원 테이블에서 급여가 10000원 이상 13000이하인 사원의 정보를
-- 사원번호, 이름, 급여 순으로 조회하세요
SELECT EMPLOYEE_ID,
		FIRST_NAME,
		SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000 AND SALARY <= 13000



-- 사원 테이블에서 입사일이 05년 9월 21일인 사원의 정보를 사원, 이름, 입사일 순으로 출력하시오
SELECT EMPLOYEE_ID,
		FIRST_NAME,
		HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE = '2005-09-21';



-- 사원 테이블에서 입사일이 05년 9월 21일 이후에 입사한 사원의 정보를 사원, 이름, 입사일 순으로 출력하시오
SELECT EMPLOYEE_ID,
		FIRST_NAME,
		HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2005-09-21';



-- 사원 테이블에서 직종이 SA_MAN 이거나 IT_PROG인 사원들의
-- 모든 정보를 출력하기
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = 'SA_MAN' OR JOB_ID = 'IT_PROG';



-- 사원테이블에서 급여가 2200, 3200, 5000, 6800,을 받는 사원의 정보를
-- 사원번호, 이름, 직종, 급여 순으로 조회하세요
SELECT EMPLOYEE_ID,
		FIRST_NAME,
		JOB_ID,
		SALARY
FROM EMPLOYEES
WHERE SALARY = 2200 OR SALARY = 3200 OR SALARY = 5000 OR SALARY = 6800; 



-- SQL 연산자
-- 1. BETWEEN A AND B : A와 B 사이의 값을 조회할 때 사용
-- 2. IN : OR을 대신해서 사용하는  연산자
-- 3. LIKE : 유사검색


-- 사원 테이블에서 06년도에 입사한 사원들의 정보를 사번, 이름, 직종, 입사일 순으로 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2006/01/01' AND '2006/12/31'



-- 사원 테이블에서 직종이 SA_MAN 이거나 IT_PROG인 사원들의
-- 이름, 직종 출력하기
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID IN('SA_MAN', 'IT_PROG');


SELECT EMPLOYEE_ID,
		FIRST_NAME,
		JOB_ID,
		SALARY
FROM EMPLOYEES
WHERE SALARY IN(2200, 3200, 5000, 6800); 



-- LIKE 연산자 (유사검색)
-- WHERE 절에 주로 사용되며 부분적으로 일치하는 속성을 찾을 때 사용된다.
-- % : 모든 값
-- _ : 하나의 값
-- # : 숫자 하나
-- EX)'A%': A로 시작하는 모든 값, 
--	  '%A': A로 끝나는 모든 값
-- 	  '%A%': A를 포함하고 있는 모든 값,
--	  '%A%B%': A와 B를 포함하고 있는 모든 값
-- 	  'A_': A로 시작하는 두 글자 짜리 데이터,
--	  'A_ _': A로 시작하는 세 글자
--    '_A_' : 두 번째 글자에 A가 들어가는 세 글자 짜리 데이터



-- 사원 테이블에서 사원들의 이름 중 M으로 시작하는 사원들의
-- 정보를 사번, 이름, 직종 순으로 출력하세요
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'M%';



-- 사원 테이블에서 이름이 D로 끝나는 사원의
-- 사번, 이름, 직종을 조회하세요
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%d';



-- 사원 테이블에서 이름에 a가 포함되어 있는 사원의 정보를
-- 이름, 직종 순으로 조회하기
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%a%';



-- 이름에 소문자 o가 들어가면서 a로 끝나는 사원들의 정보를
-- 이름, 급여 순으로 조회하기
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%o%a';



-- 이름 이 H로 시작하면서 6글자 이상인 사원의 정보를
-- 사번, 이름 순으로 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'H______%'



-- 사원 테이블에서 이름이 s가 포함되어 있지 않은 사원들만
-- 사원, 이름 순으로 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME NOT LIKE '%s%'



-- OR 연산자를 통해서 여러개의 LIKE 조건을 연결할 수도 있다.
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%el%' OR FIRST_NAME LIKE '%en%'




-- INSERT : 튜플 삽입
-- INSER INTO 테이블명 (컬럼명1, 컬럼명2 ...)
-- VALUES (값1, 값2 ...)
INSERT INTO TBL_STUDENT (ID, NAME, MAJOR, GENDER, BIRTH)
VALUES (0, '홍길동', '컴공', 'M', TO_DATE('1980-01-02','YYYY-MM-DD'));


SELECT * FROM TBL_STUDENT


-- PK로 설정된 컬럼(ID)에는 값이 겹치거나 비워둘 수 없다.
INSERT INTO TBL_STUDENT (ID, NAME, MAJOR, GENDER, BIRTH)
VALUES (1, '허춘삼', '컴공', 'W', TO_DATE('1980-01-02','YYYY-MM-DD'));


-- CHECK 제약조건으로 1980년생 보다 나이가 많은 사람은 추가할 수 없다.
INSERT INTO TBL_STUDENT (ID, NAME, MAJOR, GENDER, BIRTH)
VALUES (2, '김마리', '컴공', 'W', TO_DATE('1989-01-02','YYYY-MM-DD'));


-- 성별 생략 : 디폴트 값 W로 들어감
INSERT INTO TBL_STUDENT (ID, NAME, MAJOR, BIRTH)
VALUES (3, '김길동', '컴공', TO_DATE('1980-01-06','YYYY-MM-DD'));



SELECT * FROM FLOWER;


INSERT INTO FLOWER (FLO_NAME, COLOR, PRICE) VALUES ('장미꽃', '빨간색', 2000);
INSERT INTO FLOWER (FLO_NAME, COLOR, PRICE) VALUES ('해바라기', '노란색', 3000);
INSERT INTO FLOWER (FLO_NAME, COLOR, PRICE) VALUES ('안개꽃', '흰색', 4000);


-- < 다중 속성 삽입하는 법 >
-- INSERT ALL
-- INTO 테이블명 (컬럼명1, 컬럼명2 ...) VALUES (값1, 값2 ...)
-- INTO 테이블명 (컬럼명1, 컬럼명2 ...) VALUES (값1, 값2 ...)
-- INTO 테이블명 (컬럼명1, 컬럼명2 ...) VALUES (값1, 값2 ...)
-- INTO 테이블명 (컬럼명1, 컬럼명2 ...) VALUES (값1, 값2 ...)
-- SELECT * FROM DUAL;
-- DUAL 테이블을 이용한 SELECT 구문은 단일 행을 반환하여
-- 각 INTO 절이 한 번씩 실행되도록 한다



SELECT * FROM HWABUN;

-- 참조하는 테이블에 없는 데이터는 추가할 수 없다.
INSERT INTO HWABUN (HWA_ID, HWA_COLOR, HWA_SHAPE, FLO_NAME)
VALUES (202503130001,'검은색','타원형','안개꽃'); -- 할미꽃(X)
INSERT INTO HWABUN (HWA_ID, HWA_COLOR, HWA_SHAPE, FLO_NAME)
VALUES ('202503130002','은색','타원형','장미꽃'); -- 개나리꽃(X)
INSERT INTO HWABUN (HWA_ID, HWA_COLOR, HWA_SHAPE, FLO_NAME)
VALUES (202503130003,'흰색','네모','해바라기'); -- 반드시 참조테이블(FLOWER)에 있는 값만 가능


-- 튜플 속성값 수정
UPDATE HWABUN
SET HWA_SHAPE = '동그라미'
WHERE HWA_ID = 202503130002;



-- DELETE : 튜플 삭제
-- DELETE FROM 테이블명 WHERE 조건;
-- 외래키로 참조되고 있을 때 자식 테이블에서 참조되고 있는 행을
-- 먼저 삭제해주어야 부모 테이블의 행을 삭제할 수 있다.

DELETE FROM HWABUN WHERE FLO_NAME = '장미꽃';
DELETE FROM FLOWER 
-- WHERE FLO_NAME = '장미꽃' : 실행불가능 -> 다른 테이블에서 참조하고 있는 값이 있기 때문에
WHERE FLO_NAME = '장미꽃';

-- DELETE 문에 조건을 쓰지 않으면 의도치 않게 모든 데이터가 날아갈 수 있음
-- DELETE FROM HWABUN -> 화분 테이블의 모든 데이터가 날아감




-- UPDATE : 튜플 수정
-- UPDATE 테이블명
-- SET 컬럼명 = '변경값'
-- WHERE 조건

SELECT * FROM TBL_STUDENT;

-- TBL_STUDENT 테이블에서 홍길동의 전공을 경영학과로 수정하기
UPDATE TBL_STUDENT
SET MAJOR = '경영학과'
WHERE NAME = '홍길동';


-- 테이블 사이에는 관계라는 개념이 존재하고
-- 일대일(1:1), 일대다(1:N), 다대다(N:M) 의 관계가 있다

-- 일대일 (1:1) 관계
-- 두 테이블 A와 B가 있을 때 A의 정보와 B의 정보 하나가 연결된 관계
-- ㄴ 한 사람은 하나의 여권만 소지 가능, 하나의 여권은 한 사람에게만 발급 가능

-- 일대다(1:N) 관계
-- 테이블 A의 행 하나가 B의 여러 행과 연결되는 관계
-- ㄴ 한 사람이 여러 개의 부동산을 가질 수 있음, 집은 주인이 하나임

-- 다대다(N:M) 관계
-- ㄴ 테이블 A의 행 하나가 테이블 B의 행 여러 개와,
-- 	 테이블 B의 행 하나가 테이블 A의 행 여러 개와 연결된 상태
-- 학생과 강의의 관계
-- 한 학생이 여러 강의 수강 가능, 하나의 강의는 여러 학생들이 들을 수 있음

-- 다대다 관계는 두 개의 테이블 사이에서 직접 구현할 수 없으므로
-- 연결 테이블을 사용하여 테이블 A와 B를 사용한다
-- 연결 테이블은 두 테이블의 기본키를 외래키로 포함하며
-- 복합 기본키로 지정하는 경우가 많다.






/* 1. 데이터베이스 설계 순서로 옳은 것은?
2. 요구사항 분석 → 개념적 모델링 → 논리적 모델링 → 물리적 모델링 → 데이터베이스 구현

*/

/* 2.CD 정보를 데이터베이스에 저장하려고 한다.
CD는 타이틀, 가격, 장르, 트랙 리스트 등의 정보를 가지고 있다.
각 CD는 아티스트가 있으며 아티스트는 여러 CD를 출반한다.
트랙은 타이틀, 러닝타임(초)이 있다.
개체와 관계
개체(Entity)
CD : 타이틀, 가격, 장르, 트랙 리스트
아티스트 : 이름, 국적, 데뷔년도
트랙 : 타이틀, 러닝타임
관계(Relationship)
CD와 아티스트는 N:1(한명의 아티스트는 여러 CD를 낼 수 있다.)
CD와 트랙은 1:N(하나의 CD에는 여러 트랙이 포함될 수 있다.) */

CREATE TABLE CD (
	TITLE VARCHAR2(100) PRIMARY KEY,
	PRICE NUMBER,
	GENRE VARCHAR2(200),
	TRACKLIST NUMBER,
	ARTISTNAME VARCHAR2 (200),
	CONSTRAINT ARTIST_FK FOREIGN KEY (ARTISTNAME) REFERENCES ARTIST(NAME)
);

CREATE TABLE ARTIST (
	NAME VARCHAR2(100) PRIMARY KEY,
	COUNTRY VARCHAR2(100),
	DEBUTYEAR DATE
);

CREATE TABLE TRACK (
	TITLE VARCHAR2(100) PRIMARY KEY,
	RUNNINGTIME VARCHAR2(100),
	CDTITLE VARCHAR2 (200),
	CONSTRAINT CD_FK FOREIGN KEY (CDTITLE) REFERENCES CD(TITLE)
);



 -- 3. 10번 및 30번 부서에 속하는 모든 사원 중 급여가 1500을 넘는 사원의사원번호,이름 및 급여를 조회하세요
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10, 30) AND SALARY >= 1500;


-- 4. 관리자가 없는 모든 사원의 이름 및 직종을 출력하세요
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;


-- 5. 직업이 IT_PROG 또는 SA_MAN 이면서 급여가 1000,3000,5000이 아닌 모든 사원들의 이름, 직종 및 급여를 조회하세요
SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID IN('IT_PROG', 'SA_MAN') AND SALARY NOT IN (1000, 3000, 5000);



SELECT * FROM PRODUCT;



SELECT NAME, PRICE
FROM PRODUCT
WHERE NAME IN ('컴퓨터', '냉장고', '에어컨', '오디오');