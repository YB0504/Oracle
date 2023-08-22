-- 2023.08.16(수)

-- 테이블 목록
select * from tab;
-- DEPT : 부서 테이블
-- EMP : 사원 테이블
-- BOUNS : 상여금
-- SALGRADE : 급여등급

-- DEPT 테이블 구조
DESCRIBE dept;
desc dept;

-- DEPT 데이터 검색 : SQL문은 대,소문자를 구분하지 않는다.
select * from dept;
SELECT * FROM dept;

-- EMP 테이블 구조
desc emp;

-- EMP 데이터 검색
SELECT * FROM emp;

-- 오라클의 데이터 타입
-- 1. 숫자 데이터
--    number(n)
-- ex) number(2) 정수 2자리까지 저장
--    number(n1, n2) : n1 - 전체 자리수
--                     n2 - 소숫점에 할당된 자리수
-- ex) number(7, 2) : 전체 자리수 7자리
--                    소숫점 2자리
-- 2. 문자 데이터
-- char() : 고정 길이 문자형
--          최대 2000byte까지 저장
-- vachar2() : 가변 길이 문자형
--             최대 4000byte까지 저장
-- long() : 2GB까지 저장
--          long형으로 설정된 컬럼은 검색 기능을 지원하지 않는다.
-- 3. 날짜 데이터
-- date : 년, 월, 일
-- timestamp : 년, 월, 일, 시, 분, 초

-- SELECT SQL문
select * from dept;

select loc, dname, deptno from dept;

SELECT * from emp;

select empno from emp;

-- 산술 연산자 : +, -, *, /
-- 문자형 컬럼은 산술 연산이 불가능하다.
SELECT sal + comm from emp;
SELECT sal + 100 from emp;
SELECT sal - 100 from emp;
SELECT sal * 100 from emp;
SELECT sal / 100 from emp;

-- 각 사원의 연봉 구하기
-- 연봉 = 급여 * 12 + 커미션

-- NULL
-- 1. 정해지지 않은 값을 의미
-- 2. 산술 연산이 불가능하다.
-- ex) EMP 테이블 : MGR 컬럼 - KING 사원은 MGR컬럼이 NULL
--                 COMM 컬럼 - job이 SALESMAN인 사원만 값을 가지고 있다.

-- NVL(컬럼, 치환될 값) : NULL값을 다른 값으로 치환해주는 함수이다.
select ename, job, sal, comm, sal * 12, sal * 12 + nvl(comm, 0) from emp;

-- 별칭 부여 : 별칭 부여할 컬럼 as "별칭명"
select ename, sal * 12, sal * 12 + nvl(comm, 0) as "Annsal" from emp;
select ename, sal * 12, sal * 12 + nvl(comm, 0) "Annsal" from emp; -- as 생략 가능
select ename, sal * 12, sal * 12 + nvl(comm, 0) Annsal from emp; -- 쌍따옴표 생략 가능

-- 한글 별칭명 부여
select ename, sal * 12, sal * 12 + nvl(comm, 0) as "연봉" from emp;
select ename, sal * 12, sal * 12 + nvl(comm, 0) "연봉" from emp;
select ename, sal * 12, sal * 12 + nvl(comm, 0) 연봉 from emp;

-- Concatennation 연산자 : ||
-- 컬럼과 문자열을 연결할 때 사용한다.
SELECT ename, ' is a ', job FROM emp;
SELECT ename || ' is a ' || job FROM emp;



-- Distinct 키워드 : 중복행을 제거하고 1번만 출력하는 역할
-- select distinct 컬럼명 from 테이블명;
select deptno from emp;
select distinct deptno from emp;

--Quiz1. EMP 테이블에서 각 사원들의 job을 1번만 출력하는 SQL문 작성
SELECT DISTINCT job from emp;

--Quiz2. EMP 테이블에서 중복행을 제거한 job의 개수를 출력하는 SQL문 작성

-- count(컬럼명) : 데이터 갯수를 구하는 함수
SELECT count(DISTINCT job) from emp;

-- WHERE 조건절 : 비교 연산자( =, >, >=, <, <=, !=, ^=, <> )

-- 1. 숫자 데이터 검색
-- 사원 테이블에서 급여를 3000 이상 받는 사원을 검색하는 SQL문 작성
SELECT * from emp where sal >= 3000;

-- 급여가 3000인 사원을 겁색하는 SQL문 작성
SELECT * from emp where sal = 3000;

-- 급여가 3000이 아닌 사원을 겁색하는 SQL문 작성
SELECT * from emp where sal != 3000;
SELECT * from emp where sal ^= 3000;
SELECT * from emp where sal <> 3000;

-- 급여가 1500이하인 사원의 사원번호 사원명, 급여를 겁색하는 SQL문 작성
SELECT empno, ENAME, SAL from emp where sal <= 1500;

-- 2. 문자 데이터 검색
--  1) 문자 데이터는 대,소문자를 구별한다.
--  2) ''안에 문자열 작성

-- 사원 테이블에서 사원명이 FORD인 사원을 검색하는 SQL문 작성
-- SELECT * from emp WHERE ename = 'ford'; -- 검색결과가 없다.
-- SELECT * from emp WHERE ename = FORD; -- 오류 발생 
-- SELECT * from emp WHERE ename = "FORD"; -- 별칭에만 ""를 쓸 수 있다.
SELECT * from emp WHERE ename = 'FORD';

-- SCOTT사원의 사원번호,  사원명, 급여를 출력하는 SQL문을 작성
SELECT empno, ENAME, SAL from emp where ename = 'SCOTT';

-- 3. 날짜 데이터 검색
--  1) ''안에 문자열처럼 날짜 작성
--  2) 비교연산자로 비교

-- 1982년 1월 1일 이후에 입사한 사원을 검색하는 SQL문 작성
SELECT * from emp WHERE hiredate >= '82/01/01';
SELECT * from emp WHERE hiredate >= '1982/01/01';

-- 1982년 1월 1일 이후에 입사한 사원을 검색하고, 입사일을 기준으로 
-- 오름차순으로 정렬한 SQL문 작성
SELECT * from emp WHERE hiredate >= '82/01/01'
    order by hiredate asc;








