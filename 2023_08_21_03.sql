-- 2023_08_21(과제)

--Q1. 직급이 MANAGER인 사원의 이름, 부서명을 출력하는 SQL문을
--    작성 하세요? (JOIN을 사용하여 처리)
SELECT ename, dname, job from emp, dept where emp.deptno = dept.deptno 
    and job = 'MANAGER';

--Q2. 매니저가 KING 인 사원들의 이름과 직급을 출력하는 SQL문 작성?
SELECT ename, job from emp where mgr = 
    (SELECT empno from emp where ename = 'KING');

--Q3. SCOTT과 동일한 근무지에서 근무하는 사원의 이름을 출력하는 SQL문 작성?
SELECT ename, deptno, loc from dept join emp using(deptno) where deptno
     =(SELECT deptno from emp where ename = 'SCOTT');
    
SELECT ename, deptno, loc from dept join emp using(deptno) where loc
=(select loc from dept where deptno
=(SELECT deptno from emp where ename = 'SCOTT'));

----------------------------------------------------------------------
-- 선생님 코드
-- 과제.

-- Ans 1.
-- Q1. 직급이 MANAGER인 사원의 이름, 부서명을 출력하는 SQL문을
--     작성 하세요? (JOIN을 사용하여 처리)

-- 등가 조인
select ename, dname from emp, dept 
    where emp.deptno=dept.deptno  and  job='MANAGER';

-- Ansi Inner Join
select ename, dname from emp inner join dept 
    on emp.deptno=dept.deptno  where  job='MANAGER'; 

-- USING을 사용한 방식
select ename, dname from emp inner join dept 
    using(deptno)  where  job='MANAGER'; 

--  Natural Join을 사용한 방식
select ename, dname from emp natural join dept 
    where job='MANAGER'; 

--Ans 2.
-- Q2. 매니저가 KING 인 사원들의 이름과 직급을 출력하는 SQL문 작성?

-- 조인을 사용한 방식(자체 조인)
select employee.ename, employee.job 
    from emp employee, emp manager
    where employee.mgr=manager.empno and manager.ename='KING';

-- 서브 쿼리를 사용한 방식
select ename, job from emp where mgr = 
    (select empno from emp where ename='KING');

--Ans 3.
-- Q3. SCOTT과 동일한 근무지에서 근무하는 사원의 이름을 출력하는 SQL문 작성?
select deptno, ename from emp where deptno 
    = (select deptno from emp where ename = 'SCOTT'); 
