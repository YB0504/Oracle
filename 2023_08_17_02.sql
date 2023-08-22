-- 2023_08_17(목)

select 10 + 20 from dept;   -- 4개 출력
SELECT 10 + 20 from emp;    -- 14개 출력

-- dual 테이블
-- 1. sys계정 소유의 테이블(공개 동의어로 설정된 테이블)
-- 2. 공개가 되어 있기 때문에 누구나 사용 가능하다.
-- 3. 데이터가 1개 밖에 없기 때문에 연산 결과가 한 번만 출력된다.

SELECT 10 + 20 FROM dual;   -- 1개 출력
select 10 + 20 from sys.dual; -- 원래는 해당 계정.테이블명으로 사용해야 한다.

desc dual;  -- DUMMY 컬럼 1개 밖에 없다.
select * from dual; -- X 데이터 1개 밖에 없다.

select * from tab;  -- tab : 공개 동의어(sys계정 소유)
select * from sys.tab;

-- 1. 숫자 처리 함수
-- ABS() : 절대값을 구해주는 함수
select -10, abs(-10), ABS(-10) from dual;

-- FLOOR() : 소수점 이하를 버리는 함수
select 10.2, floor(10.2) from dual;

-- ROUND() : 특정 자리에서 반올림을 하는 함수
-- ROUND( 대상 값, 자리수 )
select 34.5678, round(34.5678) from dual; -- 35 : 소수 첫째자리에서 반올림
select 34.5678, round(34.5678, 2) from dual; -- 34.57 : 소수 셋째자리에서 반올림
select 34.5678, round(34.5678, -1) from dual; -- 30 : 정수 1의 자리에서 반올림
select 34.5678, round(35.5678, -1) from dual; -- 40 : 정수 1의 자리에서 반올림

-- TRUNC() : 특정 자리에서 잘라내는 함수
-- TRUNC( 대상 값, 자리수 )
select trunc(34.5678),  trunc(34.5678, 2), trunc(34.5678, -1) from dual;

-- MOD() : 나누기 연산 후의 나머지 값을 구해주는 함수
-- MOD( 대상 값, 나누는 값 )
SELECT mod(27, 2), mod(27, 5), mod(27, 7) from dual;

-- 사원 번호가 홀수인 사원들을 출력하는 SQL문 작성
select ename, empno from emp where mod(empno, 2) = 1;

----------------------------------------------------------------------------

-- 2. 문자 처리 함수
-- UPPER() : 대문자로 변환하는 함수
select 'Welcome to Oracle', UPPER('Welcome to Oracle') from dual;

-- LOWER() : 소문자로 변환하는 함수
select 'Welcome to Oracle', LOWER('Welcome to Oracle') from dual;

-- INITCAP() : 첫글자만 대문자로 변환하는 함수
select 'welcome to oracle', INITCAP('welcome to oracle') from dual;

-- JOB이 manager인 사원을 검색하는 SQL문 작성
SELECT * from emp where lower(job) = 'manager';
SELECT * from emp where job = upper('manager');

-- LENGTH() : 문자열의 길이를 구하는 함수
select length('Oracle'), length('오라클')from dual;    -- 6, 3

-- LENGTHB() : 문자열의 길이를 byte단위로 구하는 함수
-- 영문 1글자 : 1byte, 한글 1글자 : 3byte (배포판에 따라 한글의 byte가 다를 수 있다.)
select lengthb('Oracle'), lengthb('오라클')from dual;

-- SUBSTR() : 전체 문자에서 일부 문자를 추출하는 함수
-- SUBSTR( 대상 문자열, 시작위치, 추출할 개수 )
select substr('welcome to oracle', 4, 3) from dual; -- com
select substr('welcome to oracle', -4, 3) from dual; -- acl
select substr('welcome to oracle', -6, 3) from dual; -- ora

-- 입사일을 년, 월, 일을 추출하는 SQL문 작성
select substr(hiredate, 1, 2) as "년",
       substr(hiredate, 4, 2) as "월",
       substr(hiredate, 7, 2) as "일" from emp;
       
-- 87년도에 입사한 사원을 검색하는 SQL문 작성
select * from emp where substr(hiredate, 1, 2) = 87;

-- 사원명이 대문자 E로 끝나는 사원을 검색하는 SQL문을 작성
SELECT * from emp where ename like '%E';
select * from emp where substr(ename, -1, 1) = 'E';



















