-- 2023_08_21(����)

--Q1. ������ MANAGER�� ����� �̸�, �μ����� ����ϴ� SQL����
--    �ۼ� �ϼ���? (JOIN�� ����Ͽ� ó��)
SELECT ename, dname, job from emp, dept where emp.deptno = dept.deptno 
    and job = 'MANAGER';

--Q2. �Ŵ����� KING �� ������� �̸��� ������ ����ϴ� SQL�� �ۼ�?
SELECT ename, job from emp where mgr = 
    (SELECT empno from emp where ename = 'KING');

--Q3. SCOTT�� ������ �ٹ������� �ٹ��ϴ� ����� �̸��� ����ϴ� SQL�� �ۼ�?
SELECT ename, deptno, loc from dept join emp using(deptno) where deptno
     =(SELECT deptno from emp where ename = 'SCOTT');
    
SELECT ename, deptno, loc from dept join emp using(deptno) where loc
=(select loc from dept where deptno
=(SELECT deptno from emp where ename = 'SCOTT'));

----------------------------------------------------------------------
-- ������ �ڵ�
-- ����.

-- Ans 1.
-- Q1. ������ MANAGER�� ����� �̸�, �μ����� ����ϴ� SQL����
--     �ۼ� �ϼ���? (JOIN�� ����Ͽ� ó��)

-- � ����
select ename, dname from emp, dept 
    where emp.deptno=dept.deptno  and  job='MANAGER';

-- Ansi Inner Join
select ename, dname from emp inner join dept 
    on emp.deptno=dept.deptno  where  job='MANAGER'; 

-- USING�� ����� ���
select ename, dname from emp inner join dept 
    using(deptno)  where  job='MANAGER'; 

--  Natural Join�� ����� ���
select ename, dname from emp natural join dept 
    where job='MANAGER'; 

--Ans 2.
-- Q2. �Ŵ����� KING �� ������� �̸��� ������ ����ϴ� SQL�� �ۼ�?

-- ������ ����� ���(��ü ����)
select employee.ename, employee.job 
    from emp employee, emp manager
    where employee.mgr=manager.empno and manager.ename='KING';

-- ���� ������ ����� ���
select ename, job from emp where mgr = 
    (select empno from emp where ename='KING');

--Ans 3.
-- Q3. SCOTT�� ������ �ٹ������� �ٹ��ϴ� ����� �̸��� ����ϴ� SQL�� �ۼ�?
select deptno, ename from emp where deptno 
    = (select deptno from emp where ename = 'SCOTT'); 
