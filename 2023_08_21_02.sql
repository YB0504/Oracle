-- 2023_08_21(월)

-- 서브 쿼리

-- SCOTT 사원이 소속된 부서명을 출력하는 SQL문 작성
-- 1) SCOTT 사원의 부서 번호를 구하기(사원테이블emp)
SELECT deptno from emp where ename = 'SCOTT';
-- 2) 부서 테이블(dept)에서 20번 부서의 부서명을 구하기
SELECT dname from dept where deptno = 20;

-- 서브 쿼리로 처리
-- 사원명은 dept테이블에 없기 때문에 같이 작성하면 오류가 발생한다.
SELECT dname from dept where deptno 
= (SELECT deptno from emp where ename = 'SCOTT');

-- join으로 처리
SELECT dname from dept, emp where dept.deptno = emp.deptno and ename = 'SCOTT';

-- Ansi Inner Join으로 처리
SELECT dname from dept inner join emp 
on dept.deptno = emp.deptno where ename = 'SCOTT';

-- USING
SELECT dname from dept inner join emp 
USING(deptno) where ename = 'SCOTT';

-- NATURAL Join
SELECT dname from dept NATURAL join emp where ename = 'SCOTT';

-- 1. 단일 행 서브 쿼리
-- 1) 서브 쿼리의 검색 결과가 하나만 반환되는 쿼리
-- 2) 메인 쿼리의 WHERE조건절에서 비교 연산자만 사용할 수 있다.
-- EX) ( =, >, >=, <, <=, != )

--Q1. 사원 테이블(EMP)에서 가장 최근에 입사한 사원명을 출력 하는 SQL문을 작성
SELECT ename, hiredate from emp where hiredate =
    (SELECT max(hiredate) from emp); -- 87/07/13 단일 행 서브 쿼리
-- SCOTT	87/07/13
-- ADAMS	87/07/13

-- Q2. 사원 테이블(EMP)에서 최대 급여를 받는 사원명과 
--     최대급여 금액을 출력하는 SQL문을 작성
SELECT ename, sal from emp where sal =
    (SELECT max(sal) from emp); -- 5000
-- KING	5000

-- Q3. 직속상사(MGR)가 KING인 사원의 사원명과 급여를 출력하는 SQL문을 작성
SELECT ename, sal, mgr from emp where mgr =
    (SELECT empno from emp where ename = 'KING')order by sal asc;

-- 2. 다중 행 서브 쿼리
-- 1) 서브 쿼리에서 반환되는 검색 결과가 두 개 이상인 쿼리
-- 2) 메인 쿼리의 WHERE 조건절에서 다중 행 연산자를 사용하여야 한다.
-- ex) ( in, all, any...)

-- IN 연산자
-- 서브 쿼리의 검색 결과가 하나라도 일치되면 참이 된다.

-- 급여를 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는
-- 사원들의 정보를 출력하는 SQL문 작성

-- 각 부서별 최대급여 금액 구하기
SELECT deptno, max(sal) from emp group by deptno;

-- where deptno in (10, 20)
SELECT ename, sal, deptno from emp where deptno IN
    (SELECT DISTINCT deptno from emp where sal >= 3000); -- 10, 20
    
-- ALL 연산자
-- 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치되면 참이 된다.

-- 30번 부서의 소속된 사원 중 급여를 가장 많이 받는 사원보다 더 많은 급여를
-- 받는 사원의 이름과 급여를 출력하는 SQL문 작성

-- 1) 단일 행 서브 쿼리로 처리
SELECT ename, sal from emp where sal >
    (select max(sal) from emp where deptno = 30);

-- 2) 다중 행 서브 쿼리로 처리
SELECT ename, sal from emp where sal >
    all(select sal from emp where deptno = 30);

-- ANY 연산자
-- 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나 이상이 일치되면 참이 된다.

-- 부서 번호가 30번인 사원들의 급여 중 가장 낮은 급여보다 높은 급여를
-- 받는 사원명과 급여를 출력하는 SQL문 작성

-- 30번 부서의 최소 급여 구하기
SELECT min(sal) from emp where deptno = 30;

-- 1) 단일 행 서브 쿼리로 처리
SELECT ename, sal from emp where sal >
    (SELECT min(sal) from emp where deptno = 30);

-- 2) 다중 행 서브 쿼리로 처리
SELECT ename, sal from emp where sal >
    any(SELECT sal from emp where deptno = 30);
    
---------------------------------------------------------------------

