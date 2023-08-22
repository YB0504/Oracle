-- 2023_08_22(과제)

-- Q1. SMITH와 동일한 직급을 가진 사원의 이름과 직급을 출력하는 
--     SQL문을 작성 하세요?
SELECT ename, job from emp where job 
    = (SELECT job from emp where ename = 'SMITH');

--  Q2. 직급이 'SALESMAN'인 사원이 받는 급여들의 최대 급여보다
-- 	많이 받는 사원들의 이름과 급여를 출력하되 부서번호가 
--	20번인 사원은 제외한다.(ALL연산자 이용)
SELECT ename, sal, deptno from emp where deptno != 20 and sal >
    all(select max(sal) from emp where job = 'SALESMAN');


--  Q3. 직급이 'SALESMAN'인 사원이 받는 급여들의 최소 급여보다 
-- 	많이 받는 사원들의 이름과 급여를 출력하되 부서번호가 
--	20번이 사원은 제외한다.(ANY연산자 이용)
SELECT ename, sal, deptno from emp where deptno != 20 and sal >
    any(select min(sal) from emp where job = 'SALESMAN');

-- 테스트용 테스트용