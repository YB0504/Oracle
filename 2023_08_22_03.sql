-- 2023_08_22(����)

-- Q1. SMITH�� ������ ������ ���� ����� �̸��� ������ ����ϴ�
--     SQL���� �ۼ� �ϼ���?
SELECT ename, job from emp where job 
    = (SELECT job from emp where ename = 'SMITH');

--  Q2. ������ 'SALESMAN'�� ����� �޴� �޿����� �ִ� �޿�����
-- 	���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ��
--	20���� ����� �����Ѵ�.(ALL������ �̿�)
SELECT ename, sal, deptno from emp where deptno != 20 and sal >
    all(select sal from emp where job = 'SALESMAN');


--  Q3. ������ 'SALESMAN'�� ����� �޴� �޿����� �ּ� �޿�����
-- 	���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ��
--	20���� ����� �����Ѵ�.(ANY������ �̿�)
SELECT ename, sal, deptno from emp where deptno != 20 and sal >
    any(select sal from emp where job = 'SALESMAN');

------------------------------------------------------------------

-- Q1. SMITH�� ������ ������ ���� ����� �̸��� ������ ����ϴ� 
--     SQL���� �ۼ� �ϼ���?

select ename, job from emp 
    where job = (select job from emp where ename='SMITH')
                 and  ename != 'SMITH';

-- Q2. ������ 'SALESMAN'�� ����� �޴� �޿����� �ִ� �޿�����
-- 	   ���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ��
--	   20���� ����� �����Ѵ�.(ALL������ �̿�)
// ������ ��������
select ename, sal from emp where sal > 
    (select max(sal)  from emp where job='SALESMAN')
	     and deptno != 20;

// ������ ��������
select ename, sal from emp where sal > all
    (select sal from emp where job='SALESMAN')
	     and deptno != 20;

-- Q3. ������ 'SALESMAN'�� ����� �޴� �޿����� �ּ� �޿�����
-- 	   ���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ��
--	   20���� ����� �����Ѵ�.(ANY������ �̿�)
// ������ ��������
select ename, sal from emp where sal > 
    (select min(sal)  from emp where job='SALESMAN')
	     and deptno != 20;

// ������ ��������
select ename, sal from emp where sal > any
    (select sal from emp where job='SALESMAN') 
	     and deptno != 20;
         
