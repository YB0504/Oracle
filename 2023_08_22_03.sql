-- 2023_08_22(����)

-- Q1. SMITH�� ������ ������ ���� ����� �̸��� ������ ����ϴ� 
--     SQL���� �ۼ� �ϼ���?
SELECT ename, job from emp where job 
    = (SELECT job from emp where ename = 'SMITH');

--  Q2. ������ 'SALESMAN'�� ����� �޴� �޿����� �ִ� �޿�����
-- 	���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ�� 
--	20���� ����� �����Ѵ�.(ALL������ �̿�)
SELECT ename, sal, deptno from emp where deptno != 20 and sal >
    all(select max(sal) from emp where job = 'SALESMAN');


--  Q3. ������ 'SALESMAN'�� ����� �޴� �޿����� �ּ� �޿����� 
-- 	���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ�� 
--	20���� ����� �����Ѵ�.(ANY������ �̿�)
SELECT ename, sal, deptno from emp where deptno != 20 and sal >
    any(select min(sal) from emp where job = 'SALESMAN');

-- �׽�Ʈ�� �׽�Ʈ��