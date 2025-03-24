SELECT * FROM ALL_INDEXES
WHERE TABLE_NAME = 'EMPLOYEES';


SELECT LAST_NAME, FIRST_NAME
FROM EMPLOYEES e ;

-- 잘 사용되고 있는지 확인을 할 일표가 있다,
-- EXPAIN PLAN FOR
-- 실행계획(EXPLAIN)
-- 실제로 쿼리를 실행하지는 않고, 쿼리의 실행 경로를 분석
-- 실행 계획을 통해 쿼리 성능 개선, 인덱스 활용 여부
-- 병목 현상 등을 진단할 수 있다.
-- PALN_RABLE
-- 실행계획 정보는 기본적으로 PLAN_TABLE 이라는 테이블에 저장된다
-- 이후 DBMS_XPLAN.DISPALY 함수를 이용하여 보기 쉽게 출력할 수 있다.

EXPLAIN PLAN FOR
SELECT * FROM EMPLOYEES WHERE LAST_NAME='Smith';

SELECT * FROM TABLE(DBMS_XPLAN.DISPALY)


-- 사번이 150번인 사원의 급여와 같은 급여를 받는 사원들의
-- 정보를 사번, 이름, 급여 순으로 출력하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY
	  		    FROM EMPLOYEES
	    	    WHERE EMPLOYEE_ID = 150);



-- 급여가 회사의 평균급여 이상인 사람들의 이름과 급여를 조회
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY)
					FROM EMPLOYEES);


-- 사번이 111번인 사원과 직종이 같고, 사번이 159번인 사원의 급여보다 많이 받는 사원의
-- 사번, 이름, 직종, 급여를 검색하시오
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
				FROM EMPLOYEES
				WHERE EMPLOYEE_ID = 111) AND
	  SALARY > (SELECT SALARY
				FROM EMPLOYEES
				WHERE EMPLOYEE_ID = 159);

SELECT JOB_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 111;

SELECT SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 159;


-- 직종별 평균 급여가 Bruce의 급여보다 큰 직종만 직종, 평균급여를 조회하세요
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY) > ( SELECT SALARY
					   FROM EMPLOYEES
					   WHERE FIRST_NAME = 'Bruce');

SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'Bruce'; -- 6000




SELECT * FROM (SELECT *
				FROM PLAYER
				WHERE TEAM_ID = 'K01')
WHERE "POSITION" = 'GK';
-- 내부 서브쿼리에서 TEAM_ID가 'K01' 인 행을 먼저 선택
-- 그 결과를 기반으로 외부쿼리에서 "POSITION"이 "GK"인 행을 추가로 필터링을 한다


SELECT * FROM PLAYER
WHERE TEAM_ID = 'K01' AND "POSITION" = 'GK';
-- 전체 테이블에 대해 두 가지 조건으로 필터링한다.

-- FROM(IN LINE VIEW) : 쿼리문으로 출력되는 결과를 테이블처럼 사용하겠다.
-- SELECTWKF(SCALAR) : 하나의 컬럼처럼 사용되는 서브쿼리
-- WHERE(SUB QUERY) : 하나의 변수처럼 사용한다.
	-- 단일행 서브쿼리 : 쿼리 결과가 단일행만 반환하는 서브쿼리
	-- 다중행 서브쿼리 : 쿼리 결과가 다중행을 리턴하는 서브쿼리
	-- 다중 컬럼 서브쿼리 : 쿼리 결과가 다중컬럼을 반환하는 서브쿼리


-- PLAYER 테이블에서 전체 평균키와 포지션별 평균키 구하기
SELECT "POSITION", ROUND(AVG(HEIGHT),1)  "포지션 별 평균키", (SELECT ROUND(AVG(HEIGHT),1)
								 						 FROM PLAYER) "전체 평균 키"
FROM PLAYER
WHERE "POSITION" IS NOT NULL
GROUP BY "POSITION";


-- PLAYER 테이블에서 NICKNAME이 NULL인 선수들은 정태민 선수의 닉네임으로 바꾸기
SELECT NICKNAME, (SELECT NICKNAME
				  FROM PLAYER
				  WHERE NICKNAME IS NULL) "킹카"
FROM PLAYER


SELECT NICKNAME
FROM PLAYER
WHERE PLAYER_NAME = '정태민'


SELECT NICKNAME
FROM PLAYER
WHERE NICKNAME IS NULL
PLAYER."POSITION" 


-- EMPLOYEES 테이블에서 평균 급여보다 급여가 낮은 사원들의 급여를 10% 인상하기
				
UPDATE EMPLOYEES 
SET SALARY = SALARY * 1.1
WHERE SALARY < (SELECT AVG(SALARY)
				FROM EMPLOYEES);

SELECT * FROM EMPLOYEES;


-- PLAYER 테이블에서 평균키보다 큰 선수들을 삭제
DELETE FROM PLAYER
WHERE HEIGHT > (SELECT AVG(HEIGHT)
				FROM PLAYER);




-- CONCATENATION(연결) : ||

-- 사원테이블에서 사원들의 이름 연결하기
SELECT FIRST_NAME || ' ' || LAST_NAME AS "이름"
FROM EMPLOYEES;
				

-- OO 의 급여는 OO이다
SELECT FIRST_NAME || '의 급여는 ' || SALARY || ' 입니다.' AS "급여 정보"
FROM EMPLOYEES;


-- 별칭(alias)

-- SELECT 절
	-- AS 별칭
	-- 컬럼명 뒤에 한칸 띄우고 작성

-- FROM 절
	-- 테이블명 뒤에 한칸 띄우고 작성

-- < 별칭의 특징 >
-- 테이블에 별칭을 줘서 컬럼을 단순, 명확히 할 수 있다.
-- 현재의 SELECT 문장에서만 유효하다.
-- 테이블 별칭은 길이가 30자 까지 가능하나 짧을수록 좋다.
-- FROM 절에 테이블 별칭 설정 시 해당 테이블 별칭은
-- SELECT 문장에서 테이블 이름 대신 사용할 수 있다.
 
SELECT 
	COUNT(SALARY) AS 개수,
	MAX(SALARY) AS 최대값,
	MIN(SALARY) AS 최소값,
	SUM(SALARY) AS 합계,
	AVG(SALARY) AS 평균
FROM EMPLOYEES;


-- 두 개 이상의 테이블에서 각각의 컬럼을 조회하려고 할 때
-- 어떤 테이블에서 온 컬럼인지 확실하게 해야할 때가 있다.

SELECT E.DEPARTMENT_ID, D.DEPARTMENT_ID
FROM EMPLOYEES E, DEPARTMENTS D;



-- 사원 테이블에 부서명이 없음
-- 부서 테이블과 DEPARTMENT_ID 로 연결되어 있음
SELECT E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


-- 부서테이블과 지역(Locations)로 부터 부서명과 city 조회하기
SELECT department_name, city
FROM departments d JOIN locations l
ON d.location_id = l.location_id;

SELECT * FROM LOCATIONS;
SELECT * FROM COUNTRIES;

-- 지역(LOCATIONS), 나라(COUNTRIES)를 조회하여
-- 도시명과 국가명을 조회
SELECT CITY, COUNTRY_NAME
FROM LOCATIONS L JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID;


-- 사원 테이블과 JOBS 테이블을 이용하여 이름, 성, 직종번호, 직종 이름을 조회하세요.
SELECT E.LAST_NAME, E.FIRST_NAME, J.JOB_ID, J.JOB_TITLE
FROM EMPLOYEES e JOIN JOBS j
ON E.JOB_ID  = J.JOB_ID;



-- 사원, 부서, 지역테이블로 부터 이름, 이메일, 부서번호, 부서명, 지역번호, 도시명
-- 을 조회하되 도시가 'seattle'인 경우만 조회하기
SELECT e.FIRST_name,
	   e.email,
	   e.department_id,
	   d.department_name,
	   l.location_id,
	   l.city
FROM EMPLOYEES e  JOIN departments d
ON e.department_id = d.DEPARTMENT_ID 
JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID
AND l.city = 'Seattle';


-- 1-1 self inner join
-- 하나의 테이블 내에서 다른 컬럼을 참조하기 위해 사용하는 '자기 자신과의 조인' 방법
-- 이를 통해 데이터베이스에서 한 테이블 내의 값을 다른 값과 연결할 수 있다.


--SELECT A.컬럼1, B.컬럼1
--FROM 테이블A a JOIN 테이블A b
--ON a.열 = b.열

SELECT E1.FIRST_NAME, E2.EMPLOYEE_ID
FROM EMPLOYEES E1 JOIN EMPLOYEES E2
ON E1.EMPLOYEE_ID = E2.MANAGER_ID;



-- CROSS INNER JOIN
-- 두 개 이상의 테이블에서 '모든 가능한 조합' 을 만들어 결과를 반환하는 조인 방법
-- 이를 통해 두 개 이상의 테이블을 조합하여 새로운 테이블을 만들 수 있다.
-- 두 테이블이 서로 관련이 없어도 조인 가능
-- 단, 각 행의 모든 가능한 조합을 만들기 때문에 결과가 매우 큰 테이블이 될 수 있으므로 
-- 주의가 필요함

CREATE TABLE 테이블A(
   A_id NUMBER,
   A_name varchar2(10)
);

CREATE TABLE 테이블B(
   B_id NUMBER,
   B_name varchar2(20)
);


INSERT INTO 테이블A values(1, 'John');
INSERT INTO 테이블A values(2, 'Jane');
INSERT INTO 테이블A values(3, 'Bob');

INSERT INTO 테이블B values(101, 'Apple');
INSERT INTO 테이블B values(102, 'Banana');


SELECT * 
FROM 테이블A CROSS JOIN 테이블B; -- 모든 가능한 조합 (행의 개수의 곱)



-- OUTER JOIN
-- 두 테이블에서 '공통된 값을 가지지 않는 행들'도 반환한다.


-- LEFT OUTER JOIN
-- '왼쪽 테이블의 모든 행'과 '두 테이블이 공통적으로 가지는 값'을 반환
-- 교집합과 차집합의 연산 결과를 합친 것과 같다.
-- 만약 오른쪽 테이블에서 공통된 값을 가지고 있는 행이 없다면 NULL을 반환
-- B에 없는 내용은 NULL


-- 사원 테이블과 부서 테이블의 LEFT OUTER JOIN을 이용하여
-- 사원이 어느 부서에 있는지 조회하기
SELECT E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES e 
LEFT OUTER JOIN DEPARTMENTS d 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


SELECT *
FROM EMPLOYEES E
WHERE FIRST_NAME = 'Kimberely';


SELECT * FROM STADIUM s;
SELECT * FROM TEAM t ;


SELECT *
FROM STADIUM s 
JOIN TEAM t
ON s.HOMETEAM_ID = t.TEAM_ID;




-- RIGHT OUTER JOIN
-- LEFT OUTER JOIN의 반대
-- 공통 데이터와 오른쪽 테이블에 있는 데이터를 조회


-- FULL OUTER JOIN
-- 두 테이블에서 '모든 값'을 반환한다.
-- 서로 공통되지 않은 부분은 NULL 로 채운다
-- 합집합의 연산과 같다 (속성은 더하고 행은 곱하고)

SELECT E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES e 
FULL OUTER JOIN DEPARTMENTS d 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


SELECT * FROM EMP;
SELECT * FROM DEPT;




-- jobs 테이블과 employees 테이블에서
-- 직종번호, 직종이름, 이메일, 이름과 성(연결) 별칭을 이름으로 하고
-- 조회하기
SELECT j.JOB_ID , j.JOB_TITLE ,e.EMAIL , E.FIRST_NAME||' '||E.LAST_NAME AS "이름"
FROM JOBS j JOIN EMPLOYEES e 
ON J.JOB_ID = E.JOB_ID;



-- 비등가조인
-- 두 테이블을 결합할 때 부등호(>, <, <=, >=), BETWEEN, LIKE 등
-- 다양한 비교 연산자를 통해 조인 조건을 지정하는 방식
-- 특정 값이 일정 범위 내에 속하거나, 두 값 사이의 관계를
-- 비교하여 행을 결합할 때 유용하다.

SELECT E.EMPNO, E.ENAME, S.GRADE, E.SAL
FROM SALGRADE s JOIN EMP e 
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- USING() : 중복되는 컬럼이 생길 시 맨 앞으로 출력하며
-- 중복 컬럼을 한 개만 출력한다.
SELECT * FROM EMP e  JOIN DEPT d 
USING(DEPTNO); -- DEPTNO 가 한 번만 나옴



-- DEPT 테이블의 LOC별 평균 SAL를 반올림한 값과, SAL의 총합을 조회하시오
SELECT D.LOC, ROUND(AVG(E.SAL)) AS "평균 급여", SUM(E.SAL) AS "급여 총합"
FROM EMP e JOIN DEPT d
ON E.DEPTNO  = D.DEPTNO
GROUP BY D.LOC; 



-- NATURAL JOIN
-- 두 테이블 간의 동일한 이름을 갖는 모든 컬럼들에 대해
-- 등가 조인을 수행한다.
-- 컬럼 이름 뿐만 아니라 타입도 같아야 한다.

SELECT * FROM EMP E INNER JOIN DEPT d
ON E.DEPTNO = D.DEPTNO;

SELECT * FROM EMP E INNER JOIN DEPT d
USING (DEPTNO);


SELECT * FROM EMP NATURAL JOIN DEPT;
-- 자동 매칭 (NATURAL JOIN)
-- 두 테이블에서 이름이 동일한 컬럼을 찾아서, 해당 컬럼들의 값이 일치하는
-- 행끼리 자동으로 결합한다.
-- 중복 컬럼 제거
-- 조인 결과에서 공통 컬럼은 한 번만 표시된다.
-- 명시적 조건 생략
-- ON 절이나 USING 절 없이 간단하게 조인할 수 있다.

-- 그러나 의도하지 않은 결과가 나올 수 있음
-- 자동으로 공통 컬럼을 기준으로 조인하기 때문에, 개발자가 어떤 컬럼을 기준으로 조인하는지
-- 명확히 알기 어려울 수 있다.



-- 집합 연산자
-- JOIN 과는 별개로 두 개의 테이블을 합치는 방법

-- 1. UNION
-- 두 개의 테이블에서 '중복으 제거하고 합친 모든 행'을 반환

SELECT FIRST_NAME FROM EMPLOYEES 
UNION
SELECT DEPARTMENT_NAME FROM DEPARTMENTS;


-- 2. UNION ALL
-- 중복을 제거하지 않고 모두 합친 행을 반환
SELECT FIRST_NAME FROM EMPLOYEES 
UNION ALL
SELECT DEPARTMENT_NAME FROM DEPARTMENTS;





-- VIEW 의 생성
-- OR REPALCE : 있으면 대체해라
/** 
 * CREATE OR REPALCE VIEW 이름 AS(
			쿼리문
)  */


-- VIEW의 삭제
-- DROP VIEW 뷰이름 [RESTRICT 또는 CASCADE]
-- RESTRICT : 뷰를 다른 곳에서 참조하고 있다면 삭제가 취소
-- CASCADE : 뷰를 참조하는 다른 뷰나 제약 조건까지 모두 삭제


SELECT * FROM PLAYER; 
-- 선수의 이름과 나이를 조회하기
-- EX) 홍길동 35
	SELECT PLAYER_NAME, ROUND((SYSDATE-BIRTH_DATE)/365) AS "나이"
	FROM PLAYER;

-- PALYER_AGE 라는 뷰를 만들어서 저장
CREATE OR REPLACE VIEW PALYER_AGE AS(
	SELECT 
		ROUND((SYSDATE-BIRTH_DATE)/365) AS "나이",
		P.*
	FROM PLAYER P
);

SELECT * FROM PALYER_AGE PA;



-- 30살이 넘은 선수를 조회
SELECT *
FROM PALYER_AGE
WHERE "나이" >= 30;



-- 사원 이름과 상사 이름을 조회하기
SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID = 101;


CREATE OR REPLACE VIEW MANGER_NAME AS (
	SELECT 
		E1.LAST_NAME||' '|| E1.FIRST_NAME AS ENAME,
		E2.LAST_NAME||' '|| E2.FIRST_NAME AS MNAME
	FROM EMPLOYEES E1
	JOIN EMPLOYEES E2
	ON E1.EMPLOYEE_ID = E2.MANAGER_ID
);

SELECT * FROM MANGER_NAME;



-- King Steven의 부하직원이 몇 명인지 조회하기
SELECT COUNT(*)
FROM MANGER_NAME
WHERE MNAME = 'King Steven';


SELECT * FROM TEAM;
SELECT * FROM PLAYER;


-- PALYER 테이블에 TEAM_NAME 컬럼을 추가한 VIEW 만들기
-- VIEW 이름은 PALYER_TEAM_NAME

 CREATE OR REPLACE VIEW PALYER_TEAM_NAME AS(
	SELECT T.TEAM_NAME, P.*
	FROM PLAYER P JOIN TEAM T
	ON P.TEAM_ID = T.TEAM_ID
);


SELECT * FROM PALYER_TEAM_NAME;



-- TEAM_NAME이 '울산현대'인 선수들을 조회
SELECT TEAM_NAME, PLAYER_NAME
FROM PALYER_TEAM_NAME
WHERE TEAM_NAME = '울산현대';



-- HOMETEAM_ID, STADIUM_NAME, TEAM_NAME을 조회
-- HOMETEAM이 없는 경기장 이름도 나와야 함
SELECT S.HOMETEAM_ID, S.STADIUM_NAME, T.TEAM_NAME
FROM STADIUM s LEFT OUTER JOIN TEAM T
ON S.STADIUM_ID = T.STADIUM_ID;


-- 홈팀 없는 경기장 검색하기
SELECT S.HOMETEAM_ID, S.STADIUM_NAME, T.TEAM_NAME
FROM STADIUM s LEFT OUTER JOIN TEAM T
ON S.STADIUM_ID = T.STADIUM_ID
WHERE S.HOMETEAM_ID IS NULL;


-- 사원 테이블에서 급여, 급여를 많이 받는 순으로 순위를 조회
-- DATA_PLUS 라는 VIEW에 저장
CREATE OR REPLACE VIEW DATA_PLUS AS (
	SELECT 
		FIRST_NAME, SALARY, 
		RANK() OVER(ORDER BY SALARY DESC) "RANK"
	FROM EMPLOYEES
);


SELECT * FROM DATA_PLUS
WHERE RANK BETWEEN 11 AND 20;




-- TCL(Transaction Controll Language)
-- 트랜잭션 : 데이터베이스의 작업을 처리하는 논리적 연산 단위
-- select, insert, updatem delete문을 하나의 작업 단위라고 한다.

 
-- CASE 문
-- 데이터의 값을 WHEN의 조건과 차례대로 비교한 후 일치하는 값을 찾아
-- THEN 뒤에 있는 결과 값을 반환한다

SELECT 
	ENAME,
	DEPTNO,
	CASE
		WHEN DEPTNO = '10' THEN 'NEW YORK'
		WHEN DEPTNO = '20' THEN 'DALLAS'
		ELSE 'UMKNOWN'
	END AS LOC_NAME
FROM EMP
WHERE JOB = 'MANAGER';


SELECT ROUND(AVG(CASE JOB_ID WHEN 'IT_PROG' THEN SALARY END),2) AS "평균급여"
FROM EMPLOYEES;



-- WHERE 절에서의 사용
SELECT
 	ENAME,
 	SAL,
 	JOB,
 	CASE 
 		WHEN SAL >= 2900 THEN '1등급'
 		WHEN SAL >= 2700 THEN '2등급'
 		WHEN SAL >= 2000 THEN '3등급'
 	END AS SAL_GRADE
 FROM EMP E
 WHERE JOB = 'MANAGER' AND (CASE 
 								WHEN SAL >= 2900 THEN 1
 								WHEN SAL >= 2700 THEN 2
 								WHEN SAL >= 2000 THEN 3
 							END) = 1;


-- EMP 테이블에서 SAL이 3000 이상이면 HIGH, 1000 이상이면 MID,
-- 다 아니면 LOW를 ENAME, SAL, GRADE 순으로 조회하기

SELECT
 	ENAME,
 	SAL,
 	CASE 
 		WHEN SAL >= 3000 THEN 'HIGH'
 		WHEN SAL >= 2000 THEN 'MID'
 		WHEN SAL >= 1000 THEN 'LOW'
 	END AS GRADE
 FROM EMP;




-- CASE 문의 특징과 활용
-- 표현식으로 사용
-- CASE 문은 하나의 값이나 결과를 반환하는 표현식이기 때문에
-- SELECT, ORDER BY, GROUP BY 등의 구문 내에서 사용될 수 있다.

-- 가독성 향상
-- 복잡한 조건에 따른 값을 한 눈에 파악할 수 있게 도와주어, 쿼리의 가독성과 유지보수성이 높아진다.
-- NULL 처리
-- 조건에 해당되지 않는 경우 ELSE 절이 없으면 NULL 이 반환

-- 중첩 사용 가능
-- CASE문 안에 CASE 문을 중첩해서 사용할 수 있다.
-- 표준 SQL 지원
-- 대부분의 주요 데이터베이스 등에서 표준 SQL 문법의 일부로 지원된다.


-- PL(Procedual Language)/SQL문
-- 원래 SQL문은 주로 데이터에 정의, 조작, 제어를 위한 언어
-- PL/SQL은 여기에 조건, 반복문, 변수 선언, 예외 처리와 같은
-- 절차적 기능을 추가하여 복잡한 로직을 구현할 수 있게 해준다.


-- PL/SQL문의 구조
-- 기본적으로 블록 단위로 구성. 하나의 블록은 세 부분으로 이루어져 있다.
-- 1. 선언부(DECLARE) : 변수, 상수, 사용자 정의 타입을 선언
-- 2. 실행부(BEGIN ... END) : 실제 로직이 작성되는 부분
-- 3. 예외처리부(EXCEPTION) : 실행 도중 발생하는 오류를 처리하는 구문 작성

DECLARE
	v_massage VARCHAR2(100); -- 변수 let v_massage;
BEGIN
	v_massage := 'Hello, PL/SQL'; -- 변수에 대입
	DBMS_OUTPUT.PUT_LINE(v_massage); -- console.log()랑 비슷
END;


-- 1. IF 조건 THEN 실행문;
--	  END IF;

-- 2. IF 조건 THEN 실행문;
--	  ELSE 실행문;
--	  END IF;

-- 3. IF 조건 THEN 실행문;
--	  ELSIF 조건 THEN 실행문;
--	  ELSIF 조건 THEN 실행문;
--	  ELSIF 조건 THEN 실행문;
--	  END IF;

DECLARE
	SALARY NUMBER := 5000; --  let salary = 5000;
BEGIN 
	IF SALARY < 3000 THEN DBMS_OUTPUT.PUT_LINE('급여가 낮습니다.');
	ELSIF SALARY BETWEEN 3000 AND 7000 THEN DBMS_OUTPUT.PUT_LINE('급여가 중간입니다.');
	ELSE DBMS_OUTPUT.PUT_LINE('급여가 높습니다.');
	END IF;
END;


--SCORE 변수에 80을 대입하고
-- GRADE VARCHAR2(5)에 어떤 학점인지 대입하여 출력하기
-- 90점 이상은 A, 80점 이상은 B, 70점 이상은 C
-- 60점 이상은 D, 그 이하는 F
-- ex) 당신의 점수 80점, 학점 B


DECLARE
	SCORE NUMBER := 80; --  let score = 80;
BEGIN 
	IF SCORE >= 90 THEN DBMS_OUTPUT.PUT_LINE('당신의 점수 ' || SCORE ||',' || ' 학점 A' );
	ELSIF SCORE >= 80 THEN DBMS_OUTPUT.PUT_LINE('당신의 점수 ' || SCORE ||',' || ' 학점 B' );
	ELSIF SCORE >= 70 THEN DBMS_OUTPUT.PUT_LINE('당신의 점수 ' || SCORE ||',' || ' 학점 C' );
	ELSIF SCORE >= 60 THEN DBMS_OUTPUT.PUT_LINE('당신의 점수 ' || SCORE||',' || ' 학점 D' );
	ELSE DBMS_OUTPUT.PUT_LINE('당신의 점수 ' || SCORE ||',' || ' 학점 F');
	END IF;
END;

DECLARE
	SCORE NUMBER := 80; --  let score = 80;
	GRADE VARCHAR2(5);
BEGIN 
	IF SCORE >= 90 THEN GRADE := 'A';
	ELSIF SCORE >= 80 THEN GRADE := 'B';
	ELSIF SCORE >= 70 THEN GRADE := 'C';
	ELSIF SCORE >= 60 THEN GRADE := 'D';
	ELSE GRADE := 'F';
	END IF;
DBMS_OUTPUT.PUT_LINE('당신의 점수 : ' || SCORE ||'점, ' || '학점 : ' || GRADE);
END;


-- FOR문
-- FOR 변수 IN 시작값 ... END값 LOOP
-- 반복하고자 하는 명령;
-- END LOOP;


BEGIN
	FOR I IN REVERSE 1..10 LOOP
		DBMS_OUTPUT.PUT_LINE('I의 값 : ' || I);
	END LOOP;
END;



-- 1부터 10까지 
-- X는 짝수입니다.
-- X는 홀수입니다.
-- 출력하기

BEGIN
	FOR I IN 1..10 LOOP
		IF MOD(I, 2) = 0 THEN DBMS_OUTPUT.PUT_LINE( I || '는 짝수입니다.' );
		ELSE DBMS_OUTPUT.PUT_LINE( I || '는 홀수입니다.' );
		END IF;
	END LOOP;
END;



-- 쿼리 결과를 행 단위로 반복처리 할 때 사용
BEGIN
	FOR rec IN (SELECT employee_id, first_name FROM employees) LOOP
		DBMS_OUTPUT.PUT_LINE( 'employee id: ' ||rec.employee_id || ', name: ' ||rec. first_name  );
	END LOOP;
END;



-- while
-- WHILE 조건 LOOP
--		반복한 문장
-- END LOOP;

-- 1 부터 10가지 총합을 구해서 출력하기
-- ex) 총합 : _ _

DECLARE
	NUM NUMBER := 1; -- let num = 1;
	TOTAL NUMBER := 0; -- let total = 0; (초기화)
BEGIN
	WH   ILE NUM < 11 LOOP -- WHILE (num < 11) 
		TOTAL := TOTAL + NUM;
		NUM := NUM + 1;
	END LOOP;
DBMS_OUTPUT.PUT_LINE( '총합 : ' || TOTAL );
END;


-- < PL/SQL의 종류 >
-- 1. 익명 블록
-- 이름 없이 한 번 실행되는 PL/SQL 블록이다.
-- 데이터베이스에 저장되지 않고 즉시 실행된다.
-- 테스트, 일회성 작업, 간단한 스크립트 작성 등에 주로 사용된다.


-- 2. 프로시저(Procedured)
-- 데이터베이스에 저장되어 필요할 때마다 호출할 수 있는 이름이 있는 PL/SQL 블록이다.
-- 하나의 요청으로 여러 SQL문들 실행시킬 수 있다.
-- 네트워크 소요시간을 줄여 성능을 개선할 수 있다.
-- 기능 변경이 편하다.
/* 
  CREATE OR REPLACE PROCEDURE 프로시저명(
  		매개변수 IN 데이터타입%TYPE,
  		매개변수 IN 데이터타입%TYPE,
  		매개변수 IN 데이터타입%TYPE	
  ) IS
  함수 내에서 사용할 변수, 상수 선언
  BEGIN 
  	실행할 문장
  END;
  
 */


-- 3. 트리거(trigger)
-- 특정 테이블 or 뷰에 대한 DML or DDL 작업이 발생할 때
-- 자동으로 실행되는 PL/SQL 코드이다.



-- JOBS 테이블에 INSERT를 해주는 프로시저 만들어보기
SELECT * FROM JOBS;

INSERT INTO JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES (값1, 값2, 값3, 값4);


CREATE OR REPLACE PROCEDURE MY_NEW_JOB_PORC(
   -- 매개변수
   P_JOB_ID IN JOBS.JOB_ID%TYPE,
   P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
   P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE,
   P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE
)
IS
BEGIN
   INSERT INTO JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
   VALUES(P_JOB_ID,P_JOB_TITLE,P_MIN_SALARY,P_MAX_SALARY);
   DBMS_OUTPUT.PUT_LINE('ALL DONE ABOUT '||' '||P_JOB_ID);
END;


-- 프로시저 호출
CALL MY_NEW_JOB_PORC('IT', 'DEVELOPER', 14000, 20000);

SELECT * FROM JOBS;



-- 함수와 프로시저의 차이
-- 함수는 반드시 하나 이상의 값을 반환해야 한다.
-- 함수는 SQL문 내에서 사용할 수 있다.
-- 함수는 주로 계산, 데이터의 가공, 값의 반환 작업에 사용

-- 프로시저는 값을 반드시 반환할 필요는 없다.
-- 프로시저는 SQL문 내에서 사용할 수 있다.
-- 함수는 특정 작업이나 프로세스를 실행하기 위해 사용된다.

