-- 2023_08_18(과제)

--Q1. 사원 테이블(EMP)에서 가장 최근에 입사한 사원명을 출력 하는 
--           SQL문을 작성 하세요?

SELECT ename, hiredate from emp where hiredate 
= (SELECT max(hiredate)from emp);

--     Q2. 사원 테이블(EMP)에서 최대 급여를 받는 사원명과 최대급여
--           금액을 출력하는 SQL문을 작성 하세요?

SELECT ename, sal from emp where sal
= (SELECT max(sal) from emp);

-- 오류 발생( 일반 컬럼과 그룹 함수는 같이 쓸 수 없다.)
SELECT ename,  MAX(sal) from emp;