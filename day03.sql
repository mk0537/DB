-- 사원 테이블에서 급여를 많이 받는 순으로
-- 사번, 이름, 급여, 입사일을 조회하기

-- ORDER BY 컬럼명 (ASC/EDCS) : 컬럼명 기준으로 정렬하기

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, HIRE_DATE
FROM EMPLOYEES
ORDER BY SALARY DESC, HIRE_DATE ASC; -- 급여가 같을 경우, 입사일이 빠른 기준으로 정렬


-- 사원 테이블에서 부서 번호가 빠른 순, 부서 번호가 같다면 직종이 빠른 순
-- 직종까지 같다면 급여를 많이 받는 순으로 사원의 사번, 이름, 부서번호,
-- 직종, 급여 순으로 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME,DEPARTMENT_ID,JOB_ID,SALARY
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID,JOB_ID,SALARY DESC;



-- 급여가 15000 이상인 사원들의 사번, 이름, 급여, 입사일을
-- 입사일이 빠른 순으로 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME,SALARY,HIRE_DATE
FROM EMPLOYEES
WHERE SALARY >= 15000
ORDER BY HIRE_DATE; 

-- ASCII('값')
-- 지정된 문자의 아스키코드 값을 반환
SELECT ASCII('A') FROM DUAL;

-- CHR(숫자)
-- 지정된 숫자와 일치하는 ASCII코드를 반환한다.
SELECT CHR(65) FROM DUAL;

-- RPAD(데이터,고정길이,문자)
-- 고정길이 안에 데이터를 왼쪽으로 몰아서 출력하고 
-- 나머지 공간은 문자로 채운다.
SELECT RPAD(d.DEPARTMENT_NAME,10,'*')
FROM DEPARTMENTS d;

-- LPAD(데이터,길이, 문자);


-- LPAD(데이터, 길이, 문자) : 왼쪽부터 데이터를 길이만큼 문자로 채워줌
SELECT LPAD('Data', 10, '-')
FROM DUAL;

-- RPAD(데이터, 길이, 문자) : 오른쪽부터 데이터를 길이만큼 문자로 채워줌
SELECT RPAD('Base', 10, '*')
FROM DUAL;

-- TRIM() : 앞 뒤 공백을 제거
SELECT TRIM('            HELLO              ') FROM DUAL;

-- 컬럼이나 대상 문자열에서 특정 문자가 
-- 첫 번째나 마지막 위치에 있으면, 해당 특정 문자를 잘라낸 후 남은 문자열만 반환한다.
SELECT TRIM ('z' FROM 'zzzzzHELLOzzz') FROM DUAL;

-- RTRIM() : 문자열 오른쪽 공백 문자 제거
SELECT RTRIM('HELLO  ') FROM DUAL;

-- LTRIM() : 문자열 왼쪽 공백 문자 제거
SELECT RTRIM('    HELLO') FROM DUAL;

-- INSRT('문자열','문자') : 특정 문자의 위치를 반환
SELECT INSTR('HELLOW','L') FROM DUAL;
SELECT INSTR('HELLOW','L',1,2) -- 1번째 L 위치부터 2번째에 있는 L을 찾기

-- 찾는 문자열이 없으면 0을 반환한다.
SELECT INSTR('HELLOW','Z') FROM DUAL;

-- INITCAP(데이터) : 첫 문자를 대문자로 변환하는 함수
-- 공백, / 를 구분자로 인식
SELECT INITCAP('good morning') FROM DUAL;
SELECT INITCAP('good/morning') FROM DUAL;

-- LENGTH() : 문자열의 길이를 반환
SELECT LENGTH('JOHN') FROM DUAL;

-- CONCAT() : 주어진 두 문자열을 연결
SELECT CONCAT('Republic of', ' Korea') FROM DUAL;

-- SUBSTR() : 문자열의 시작 위치부터 길이 만큼 자른 후 반환
SELECT SUBSTR('Hello Oracle', 2) CASE1,
		SUBSTR('Hello Oracle', 7, 5) CASE2
FROM DUAL;


-- LOWER() : 문자열을 모두 소문자로 변환
-- UPPER() : 문자열을 모두 대문자로 변환
SELECT LOWER('HELLO OLACLE') FROM DUAL;
SELECT UPPER('hello olacle') FROM DUAL;

-- REPLACE() : 문자열 중에서 특정 문자를 다른 문자로 변환
SELECT REPLACE('Hello World','World', 'SQL') FROM DUAL;


-- 부서번호가 50번인 사원들의 이름을 출력하되
-- 이름 중 'el' 을 모두 '**'로 대체하여 조회하시오
SELECT REPLACE(FIRST_NAME,'el','**') 
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;


-- 문자열 '   oracle SQL Programming   '에서
-- 양쪽 공백을 제거한 후, 모든 문자를 대문자로 변환하고
-- 최종 문자열의 길이를 반환하시오(가상테이블에서)
SELECT LENGTH(UPPER(TRIM('   oracle SQL Programming   ')))
FROM DUAL;


-- ' Hellom, Oracle SQL! ' 문자열에서 양쪽 공백 제거 후
-- 앞의 5글자와 마지막 5글자를 추출하여 각각 대문자로
-- 변환하고 두 결과를 콜론(:)으로 연결하여 반환하는 SQL 작성하기
SELECT UPPER(SUBSTR(TRIM(' Hello, Oracle SQL! '),1,5))			
FROM DUAL;

SELECT CONCAT(':',UPPER(SUBSTR(TRIM(' Hello, Oracle SQL! '),14,5)))			
FROM DUAL; 

-- 두개 합침
SELECT CONCAT(UPPER(SUBSTR(TRIM(' Hello, Oracle SQL! '),1,5)),
		CONCAT(':',UPPER(SUBSTR(TRIM(' Hello, Oracle SQL! '),14,5))))		
FROM DUAL;



-- 'Data' 왼쪽에 '-' 문자를 채워 총 10자리 문자열로 만들고
-- 'Base'를 오른쪽에 '*'문자를 채워 총 10자리의 문자열로
-- 만든 후, 이 두 결과를 연결하여 반환하는 sql문 작성하기
-- 결과 : '------DataBase******'
SELECT CONCAT(LPAD('Data', 10, '-'),RPAD('base', 10, '*'))
FROM DUAL;




-- < 숫자 관련 함수 >

-- ABS() : 절대값 반환
SELECT -10, ABS(-10)
FROM DUAL;


-- ROUND(숫자, 자릿수)
-- 특정 자릿수에서 반올림하여 반환
SELECT
	ROUND(1234.567,1), -- 소수점 둘째자리에서 반올림
	ROUND(1234.567,-1), -- 일의 자리에서 반올림
	ROUND(1234.567) -- 소수점 첫째자리에서 반올림
FROM DUAL;


-- FLOOR() : 주어진 숫자보다 작거나 같은 수 중 최대값을 반환
SELECT FLOOR(2), FLOOR(2.1)
FROM DUAL;


-- TRUNC() : 특정 자릿수를 버림
SELECT
	TRUNC(1234.567,1), -- 소수점 둘째자리에서 버림
	TRUNC(1234.567,-1), -- 일의 자리에서 버림
	TRUNC(1234.567) -- 소수점 첫째자리에서 버림
FROM DUAL;


-- SIGN() : 주어진 값의 양수, 음수, 0인지 여부를 판단
-- 음수는 -1, 양수는 1, 0은 0, NULL은 NULL을 반환
SELECT 
	SIGN(-10), -- 음수이므로 -1 반환
	SIGN(0),
	SIGN(10), -- 양수이므로 1 반환
	SIGN(NULL)
FROM DUAL;


-- CEIL() : 주어진 숫자보다 크거나 같은 정수 중 최소값을 반환
SELECT 
	CEIL(2),
	CEIL(2.1) -- 3
FROM DUAL;


-- MOD() : 나누기 후 나머지를 반환
SELECT 
	MOD(1,3),
	MOD(2,3),
	MOD(3,3),
	MOD(4,3),
	MOD(0,3)
FROM DUAL;


-- POWER() : 주어진 숫자에 지정된 수만큼 제곱
SELECT 
	POWER(2,1),
	POWER(2,2),
	POWER(2,3),
	POWER(2,0)
FROM DUAL;



-- 이름이 6글자 이상인 사원의 사번과 이름, 급여 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) >= 6;


-- 사원테이블에서 사원번호와 사원번호가 홀수면 1, 짝수면 0을 출력하시오
SELECT EMPLOYEE_ID, MOD(EMPLOYEE_ID, 2) AS "ODD"
FROM EMPLOYEES;


-- 사원번호가 짝수인 사람들의 사원번호, 이름을 출력하기
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID,2) = 0
ORDER BY EMPLOYEE_ID;


-- 사원테이블에서 이름, 급여, 급여의 1000당 ■ 개수로 채워서 조회하기
SELECT FIRST_NAME, SALARY, RPAD('■', ROUND(SALARY/1000), '■')
FROM EMPLOYEES;





--<날짜 함수>

-- ADD_MONTHS() : 개월 수를 더해준다
SELECT SYSDATE, ADD_MONTHS(SYSDATE,2)
FROM DUAL;


-- MONTHS_BETWEEN() : 두 날짜 사이의 개월수
-- 모든 사원들이 입사일로 부터 몇 개월이 경과했는지
-- SYSDATE, HIRE_DATE, 개월 수로 조회
SELECT SYSDATE, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEES;


-- NEXT_DAY() : 주어진 일자가 다음에 나타나는 지정 요일의 날짜를 반환
-- 1 : 일요일~  7 : 토요일

--현재 시각으로부터 이번주 일요일이 몇 일인지 알려줌
SELECT SYSDATE, NEXT_DAY(SYSDATE,'일요일') AS "이번주 일요일"
FROM DUAL;
--현재 시각으로부터 저번주 일요일이 몇 일인지 알려줌
SELECT SYSDATE, NEXT_DAY(SYSDATE-7,'일요일') AS "저번주 일요일"
FROM DUAL;


-- TO_CHAR(날짜, 포맷)
SELECT
	TO_CHAR(SYSDATE,'yyyy-mm-dd'),
	TO_CHAR(SYSDATE,'yyyy-mm-dd day'),
	TO_CHAR(SYSDATE,'yyyy-mm-dd HH:MI:SS')
FROM DUAL;
-- 날짜 formatting 형식
-- SCC, CC :세기
-- YYYY, YY : 연도
-- MM : 월
-- DD : 일
-- DAY : 요일
-- MON : 월명(JAN,FAV,MAR ...)
-- MONTH : 월명(JANUARY)
-- HH, HH24 : 시간
-- MI : 분


-- TO_NUMBER -> 잘 안씀
-- 숫자 모양으로 되어 있는 문자열은 오라클이 묵시적으로 숫자취급 해버림..

/* 
 * 0 : 숫자, 공백 시 0으로 채움
 * 9 : 숫자
 * , : 쉼표 표시
 * L : 지역 화폐 단위 표시
 */

SELECT 
	TO_CHAR(1234567, '9,999,999'),
	TO_CHAR(1234567, 'L9,999,999') -- 통화 표시
FROM DUAL;


-- TO_DATE : 문자열을 날짜 형식으로 표현
SELECT
	TO_DATE('2025.03.14'),
	TO_DATE('03.14.2025', 'MM.DD.YYYY'),
	TO_DATE('2025.03', 'YYYY.MM'), -- 일자를 입력하지 않아 1일로 출력됨
	TO_DATE('11', 'DD') -- 년, 월을 입력하지 않으면 해당 연도, 해당 월로 출력
FROM DUAL;




-- < NULL 처리 함수 >
-- NULL값을 다른 값으로 변경

-- NVL(컬럼, 치환할 값)
SELECT FIRST_NAME, NVL(COMMISSION_PCT,0)
FROM EMPLOYEES;

-- NVL2(컬럼, NULL일 때 치환할 값, 아닐 때 치환값)
SELECT FIRST_NAME, NVL2(COMMISSION_PCT,0,1)
FROM EMPLOYEES;





-- < 순위 함수 >
-- RANK() OVER(ORDER BY 컬럼) : 그룹 내 순위를 계산하여 NUMBER 타입으로 순위를 반환
-- DENSE_RANK() : 중복등수 계산 X
SELECT RANK() OVER(ORDER BY SALARY DESC) "RANK", -- 중복등수 계산 O
FIRST_NAME,
SALARY
FROM EMPLOYEES;


-- < 집계함수 > -> FIRST_NAME 과 같은 일반적인 컬럼과 함께 쓸 수 없음 
-- 여러 행들에 대한 연산의 결과를 하나의 행으로 변환
-- NULL 값은 계산 X
-- COUNT() : 행의 개수
SELECT COUNT(EMPLOYEES.COMMISSION_PCT)
FROM EMPLOYEES;


-- 부서의 개수를 출력하기
-- DISTINCT : 중복 값 제거
SELECT COUNT(DISTINCT DEPARTMENT_ID) 
FROM EMPLOYEES;


-- MIN() :최소값
SELECT MIN(SALARY) -- 급여 중 최소값
FROM EMPLOYEES; 

-- MAX() :최대값
SELECT MAX(SALARY) -- 급여 중 최대값
FROM EMPLOYEES; 


-- SUM() : 총합
SELECT SUM(SALARY) -- 급여의 총합
FROM EMPLOYEES; 


-- AVG() : 평균
SELECT AVG(SALARY) -- 급여의 평균
FROM EMPLOYEES; 


--집계 함수는 일반 컬럼과 같이 사용하는 것은 불가하다
--SELECT FIRST_NAME, MAX(SALARY)
--FROM EMPLOYEES;



-- < GROUP BY > : 그룹화, 특정 테이블에서 소그룹을 만들어 결과를 분산시켜 얻고자 할 때 사용
-- ORDER BY 보다 먼저 기재해야 함
-- 각 부서별 급여의 평균과 총합을 출력
SELECT DEPARTMENT_ID, AVG(SALARY), SUM(SALARY)
FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID;

-- 부서별, 직종별로 그룹을 나눠서 인원수를 출력하되
-- 부서 번호가 낮은 순으로 정렬하기
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID -- 그룹화
ORDER BY DEPARTMENT_ID; -- 정렬



-- 사원 테이블에서 80번 부서에 속하는 사원들의
-- 급여의 평균을 소수점 두 자리까지(세 자리에서) 반올림하여 출력하기
SELECT ROUND(AVG(SALARY),2)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;


-- 각 직종별 인원수
SELECT JOB_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID; 

-- 각 직종별 급여의 합
SELECT JOB_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID; 

-- 부서별로 가장 높은 급여 조회
SELECT DEPARTMENT_ID, MAX(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; 



-- < HAVING 절 > : GROUP BY 절의 조건
-- WHERE 과 HAVING 의 차이 : HAVING 은 GROUP BY와 사용해야 하며
-- 집계함수를 사용하여 조건절을 작성하거나
-- GROUP BY 컬럼만 조건절에 사용할 수 있다.

-- 각 부서의 급여의 최대값, 최소값, 인원수를 조회하되
-- 급여의 최대값이 8000 이상인 결과만 조회할 덧
SELECT DEPARTMENT_ID, MAX(SALARY), MIN(SALARY)
FROM EMPLOYEES
GROUP BY EMPLOYEES.DEPARTMENT_ID
HAVING MAX(SALARY) >= 8000;


-- 각 부서별 인원수가 20명 이상인 부서의 정보를
-- 부서번호, 급여의 합, 급여의 평균, 인원수 순으로 출력하되
-- 급여의 평균은 소수점 둘째자리 까지 반올림하여 조회하기
SELECT DEPARTMENT_ID, SUM(SALARY), ROUND(AVG(SALARY),2), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(DEPARTMENT_ID) >= 20;


-- 부서별, 직종별로 그룹화여 부서번호, 직종, 인원수 순으로 조회하되
-- 직종이 'MAN' 으로 끝나는 경우만 조회
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*)
FROM EMPLOYEES
WHERE JOB_ID LIKE '%MAN'
GROUP BY DEPARTMENT_ID, JOB_ID;



-- 각 부서별 평균 급여를 소수점 한 자리 까지 버리고
-- 평균 급여가 10000 미만인 그룹만 조회해야 하며
-- 부서번호가 50 이하인 부서만 조회하기
SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY),1)
FROM EMPLOYEES
WHERE DEPARTMENT_ID <= 50 
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) < 10000;



-- 테이블 생성
CREATE TABLE 월별매출 (
    상품ID VARCHAR2(5),
    월 VARCHAR2(10),
    회사 VARCHAR2(10),
    매출액 INTEGER
);
    
INSERT INTO  월별매출 VALUES ('P001', '2019.10', '삼성', 15000);
INSERT INTO  월별매출 VALUES ('P001', '2019.11', '삼성', 25000);
INSERT INTO  월별매출 VALUES ('P002', '2019.10', 'LG', 10000);
INSERT INTO  월별매출 VALUES ('P002', '2019.11', 'LG', 20000);
INSERT INTO  월별매출 VALUES ('P003', '2019.10', '애플', 15000);
INSERT INTO  월별매출 VALUES ('P003', '2019.11', '애플', 10000);


SELECT * FROM 월별매출;

DELETE FROM 월별매출
WHERE 상품ID = 'P003';



-- < 그룹함수 >
-- ROLLUP : 계층적 그룹핑을 통해 점진적으로 소계와 총계를 계산
SELECT 상품ID, 월, SUM(매출액) "매출액"
FROM 월별매출
GROUP BY ROLLUP(상품ID, 월);


-- CUBE() : 모든 가능한 조합의 그룹핑 집합을 생성하여 모든 소계와 총계를 포함
-- (A,B그룹핑 / A그룹핑 / B그룹핑) -> A소계, B소계, 합계
SELECT 상품ID, 월, SUM(매출액) "매출액"
FROM 월별매출
GROUP BY CUBE(상품ID, 월);


-- GROUPING SETS() : 사용자 정의 그룹핑 집합을 통해 원하는 조합만 선택적으로 집계할 수 있음
SELECT 상품ID, 월, SUM(매출액) "매출액"
FROM 월별매출
GROUP BY GROUPING SETS(상품ID, 월);
   





