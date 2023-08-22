-- 2023_08_21(��)

-- ���� ����

-- SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�
-- 1) SCOTT ����� �μ� ��ȣ�� ���ϱ�(������̺�emp)
SELECT deptno from emp where ename = 'SCOTT';
-- 2) �μ� ���̺�(dept)���� 20�� �μ��� �μ����� ���ϱ�
SELECT dname from dept where deptno = 20;

-- ���� ������ ó��
-- ������� dept���̺� ���� ������ ���� �ۼ��ϸ� ������ �߻��Ѵ�.
SELECT dname from dept where deptno 
= (SELECT deptno from emp where ename = 'SCOTT');

-- join���� ó��
SELECT dname from dept, emp where dept.deptno = emp.deptno and ename = 'SCOTT';

-- Ansi Inner Join���� ó��
SELECT dname from dept inner join emp 
on dept.deptno = emp.deptno where ename = 'SCOTT';

-- USING
SELECT dname from dept inner join emp 
USING(deptno) where ename = 'SCOTT';

-- NATURAL Join
SELECT dname from dept NATURAL join emp where ename = 'SCOTT';

-- 1. ���� �� ���� ����
-- 1) ���� ������ �˻� ����� �ϳ��� ��ȯ�Ǵ� ����
-- 2) ���� ������ WHERE���������� �� �����ڸ� ����� �� �ִ�.
-- EX) ( =, >, >=, <, <=, != )

--Q1. ��� ���̺�(EMP)���� ���� �ֱٿ� �Ի��� ������� ��� �ϴ� SQL���� �ۼ�
SELECT ename, hiredate from emp where hiredate =
    (SELECT max(hiredate) from emp); -- 87/07/13 ���� �� ���� ����
-- SCOTT	87/07/13
-- ADAMS	87/07/13

-- Q2. ��� ���̺�(EMP)���� �ִ� �޿��� �޴� ������ 
--     �ִ�޿� �ݾ��� ����ϴ� SQL���� �ۼ�
SELECT ename, sal from emp where sal =
    (SELECT max(sal) from emp); -- 5000
-- KING	5000

-- Q3. ���ӻ��(MGR)�� KING�� ����� ������ �޿��� ����ϴ� SQL���� �ۼ�
SELECT ename, sal, mgr from emp where mgr =
    (SELECT empno from emp where ename = 'KING')order by sal asc;

-- 2. ���� �� ���� ����
-- 1) ���� �������� ��ȯ�Ǵ� �˻� ����� �� �� �̻��� ����
-- 2) ���� ������ WHERE ���������� ���� �� �����ڸ� ����Ͽ��� �Ѵ�.
-- ex) ( in, all, any...)

-- IN ������
-- ���� ������ �˻� ����� �ϳ��� ��ġ�Ǹ� ���� �ȴ�.

-- �޿��� 3000�̻� �޴� ����� �Ҽӵ� �μ��� ������ �μ����� �ٹ��ϴ�
-- ������� ������ ����ϴ� SQL�� �ۼ�

-- �� �μ��� �ִ�޿� �ݾ� ���ϱ�
SELECT deptno, max(sal) from emp group by deptno;

-- where deptno in (10, 20)
SELECT ename, sal, deptno from emp where deptno IN
    (SELECT DISTINCT deptno from emp where sal >= 3000); -- 10, 20
    
-- ALL ������
-- ���� ������ �� ������ ���� ������ �˻� ����� ��� ���� ��ġ�Ǹ� ���� �ȴ�.

-- 30�� �μ��� �Ҽӵ� ��� �� �޿��� ���� ���� �޴� ������� �� ���� �޿���
-- �޴� ����� �̸��� �޿��� ����ϴ� SQL�� �ۼ�

-- 1) ���� �� ���� ������ ó��
SELECT ename, sal from emp where sal >
    (select max(sal) from emp where deptno = 30);

-- 2) ���� �� ���� ������ ó��
SELECT ename, sal from emp where sal >
    all(select sal from emp where deptno = 30);

-- ANY ������
-- ���� ������ �� ������ ���� ������ �˻� ����� �ϳ� �̻��� ��ġ�Ǹ� ���� �ȴ�.

-- �μ� ��ȣ�� 30���� ������� �޿� �� ���� ���� �޿����� ���� �޿���
-- �޴� ������ �޿��� ����ϴ� SQL�� �ۼ�

-- 30�� �μ��� �ּ� �޿� ���ϱ�
SELECT min(sal) from emp where deptno = 30;

-- 1) ���� �� ���� ������ ó��
SELECT ename, sal from emp where sal >
    (SELECT min(sal) from emp where deptno = 30);

-- 2) ���� �� ���� ������ ó��
SELECT ename, sal from emp where sal >
    any(SELECT sal from emp where deptno = 30);
    
---------------------------------------------------------------------

