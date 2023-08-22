-- 2023_08_18(금)

-- 그룹 함수
-- 하나 이상의 데이터를 그룹으로 묶어서 연산을 처리하고,
-- 하나의 결과로 처리해주는 함수

-- 1. SUM() : 합을 구해주는 함수
-- 숫자 데이터값만 연산 가능하다.
SELECT sum(sal) from emp;
SELECT sum(comm) from emp; -- null 값은 제외 된다.

-- 그룹 함수들끼리는 같이 사용할 수 있다.
SELECT sum(sal), sum (comm) FROM emp;

-- 그룹 함수와 일반 컬럼은 같이 사용할 수 없다.
SELECT sal, sum(sal), sum(comm) from emp; -- 오류 발생

SELECT sum(sal) from emp where deptno = 10;
SELECT sum(sal) from emp where deptno = 20;
SELECT sum(sal) from emp where deptno = 30;

-- 2. AVG() : 평균값을 구해주는 함수
SELECT round(avg(sal)) from emp;
SELECT round(avg(sal)), avg(comm) from emp;
SELECT round(avg(sal)), avg(comm) from emp where deptno = 10;
SELECT round(avg(sal)), avg(comm) from emp where deptno = 20;
SELECT round(avg(sal)), avg(comm) from emp where deptno = 30;

-- 3. MAX() : 최대값을 구해주는 함수

-- 최대 급여 금액을 구하는 SQL문 작성
SELECT max(sal) from emp;

SELECT max(sal) from emp where deptno = 10;
SELECT max(sal) from emp where deptno = 20;
SELECT max(sal) from emp where deptno = 30;

-- 최대 급여와 최대  급여를 받는 사원명을 출력하는 SQL문 작성
SELECT ename, max(sal) FROM emp; -- 오류 발생

-- 가장 늦게 입사한 입사일을 출력하는 SQL문 작성
SELECT max(hiredate) from emp;

-- 사원명이 알파벳으로 가장 나중에 나오는 사원을 구하는 SQL문 작성
SELECT max(ename) from emp;
SELECT * from emp order by ename desc;

--4. MIN() : 최소값을 구해주는 함수

-- 최소 급여 금액을 구하는 SQL문 작성
SELECT MIN(sal) from emp;

SELECT MIN(sal) from emp where deptno = 10;
SELECT min(sal) from emp where deptno = 20;
SELECT MIN(sal) from emp where deptno = 30;

-- 최소 급여와 최소 급여를 받는 사원명을 출력하는 SQL문 작성
SELECT ename, min(sal) FROM emp; -- 오류 발생

-- 가장 빨리 입사한 입사일을 출력하는 SQL문 작성
SELECT min(hiredate) from emp;
SELECT * from emp order by hiredate asc;

-- 사원명이 알파벳으로 가장 먼저 나오는 사원을 구하는 SQL문 작성
SELECT min(ename) from emp;
SELECT * from emp order by ename asc;

-- 그룹 함수들은 같이 사용할 수 있다.
SELECT SUM(sal), trunc(avg(sal)), max(sal), min(sal) from emp;
SELECT SUM(sal), trunc(avg(sal)), max(sal), min(sal) from emp where deptno = 10;
SELECT SUM(sal), trunc(avg(sal)), max(sal), min(sal) from emp where deptno = 20;
SELECT SUM(sal), trunc(avg(sal)), max(sal), min(sal) from emp where deptno = 30;

-- COUNT() : 총 데이터 개수를 구해주는 함수
-- COUNT(컬럼명)
SELECT count(sal) from emp;
SELECT count(mgr) from emp; -- NULL값은 카운팅 하지 않는다.
SELECT count(comm) from emp;
SELECT count(empno) from emp; -- empno는 primary key 제약 조건이 설정되어 있다.
SELECT count(deptno) from dept;
SELECT count(*)from emp; -- (*)는 모든 데이터를 구하라는 의미

-- 중복행을 제거한 job의 개수를 구하는 SQL문 작성
-- 1) job의 개수 구하기
SELECT count(job) from emp;
SELECT job from emp;

-- 2) 중복행 제거
SELECT DISTINCT job from emp;

-- 3) 중복행을 제거한 job의 개수
SELECT count (DISTINCT job) from emp;

-- 30번 부서 소속 사원 중에서 커미션을 받는 사원수를 구하는 SQL문 작성
SELECT count(comm)from emp where deptno = 30;

---------------------------------------------------------------

-- GROUP BY 절 : 특정 컬럼을 기준으로 테이블에 존재하는 데이트를 그룹으로 구분하여
--               처리해주는 역할을 한다.
-- GROUP BY 절에 들어가는 컬럼은 예외적으로 그룹 함수와 같이 사용할 수 있다.
SELECT sum(sal) from emp GROUP by deptno;

SELECT deptno, SUM(sal), trunc(avg(sal)), max(sal), min(sal)
from emp GROUP by deptno order by deptno asc;

-- job 컬럼을 기준으로 급여의 합, 평균급여, 최대급여, 최소급여를 구하는 SQL문 작성
SELECT job, SUM(sal), trunc(avg(sal)), max(sal), min(sal)
from emp GROUP by job order by sum(sal) asc;

-- 각 부서별 사원수와 커미션을 받는 사원수를 구하는 SQL문 작성
SELECT deptno, count(*) 사원수, count(comm) 커미션 from emp
GROUP by deptno order by deptno asc;

-----------------------------------------------------------------------

-- HAVING 조건절
-- : GROUP BY절이 사용되는 경우에 데이터 제한을 하기 위해서 WHERE 조건절
--   대신에 HAVING 조건절을 사용해야한다.

-- 각 부서별 평균급여 금액이 2000이상인 부서만 출력하는 SQL문 작성
SELECT deptno, round(avg(sal)) from emp GROUP by deptno; -- 모든 부서의 평균 출력
SELECT deptno, round(avg(sal)) from emp GROUP by deptno
    where avg(sal) >= 2000; -- 오류 발생
-- group by 절이 사용되는 경우에는 having 조건절을 사용해야 한다.
SELECT deptno, round(avg(sal)) from emp GROUP by deptno 
    HAVING AVG(sal) >= 2000;
    
-- 각 부서별 최대 급여 금액이 2900이상인 부서만 출력하는 SQL문 작성
SELECT deptno, max(sal) from emp GROUP by deptno;
SELECT deptno, max(sal) from emp group by deptno 
    having max(sal) >= 2900 order by deptno asc;





















