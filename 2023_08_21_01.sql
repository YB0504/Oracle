-- 2023_08_21(��)

-- JOIN
-- : 2�� �̻��� ���̺��� �����ؼ� ������ ���ؿ��� ��

-- ������ �ʿ伺
-- SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�
-- 1) SCOTT ����� �μ� ��ȣ�� ���ϱ�(������̺�emp)
SELECT deptno from emp where ename = 'SCOTT';
-- 2) �μ� ���̺�(dept)���� 20�� �μ��� �μ����� ���ϱ�
SELECT dname from dept where deptno = 20;

-- 1. Cross Join
-- ���̺� ���� ,�� ����Ͽ� �����Ͽ� �ۼ� �ϴ� ��
SELECT * from emp, dept; -- 4 * 14 = 56���� ������ �˻�

-- Cross Join�� ����
-- 1. � ����(Equi Join)
-- 2. �� � ����(Non-Equi Join)
-- 3. ��ü ����(Self Join)
-- 4. �ܺ� ����(Outer Join)

-- 1. � ����(Equi Join)
--    �� ���� ���̺� ������ �÷��� �������� ���� �ϴ� ��
select * from emp, dept where emp.deptno = dept.deptno; -- 14���� ������

-- SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�
select ename, dname from emp, dept 
    where emp.deptno = dept.deptno and ename = 'SCOTT';

-- �μ���ȣ�� �μ����� ���
-- �������� �÷��� �ݵ�� �÷� �տ� �������ϴ� ���̺���� ������Ѵ�.
-- ���̺�.�����÷���
-- �����÷��� �ƴ� �÷����� ���̺���� ������ �� �ִ�.

select ename, dname, deptno from emp, dept 
    where emp.deptno = dept.deptno and ename = 'SCOTT'; -- ���� �߻�

select ename, dname, emp.deptno, sal, loc from emp, dept 
    where emp.deptno = dept.deptno and ename = 'SCOTT';

-- ���̺� ��Ī �ο��ϱ�
-- 1) ���̺� ��Ī�� �ο��Ǹ� ���̺���� �ƴ� ��Ī�� ��븸 ����� �� �ִ�.
-- 2) ��Ī���� ��,�ҹ��ڸ� �������� �ʴ´�.
-- 3) �����÷��� ��Ī�� . �����÷������� ����ϰ� �ȴ�.
-- ex) e.deptno, d.deptno
-- 4) �����÷��� �ƴ� �÷��� �տ� ��Ī���� ������ �� �ִ�.

select ename, D.dname, e.deptno, sal, loc from emp e, dept d 
    where e.deptno = d.deptno and ename = 'SCOTT';
    
select ename, dept.dname, emp.deptno, sal, loc from emp e, dept d 
    where e.deptno = d.deptno and ename = 'SCOTT'; -- ���� �߻�
    
-- 2. �� � ����(Non-Equi Join)
--    �� ���� ���̺� ������ �÷����� �ٸ� ������ �̿��Ͽ� ���� �ϴ� ��

-- �� ������� �޿��� �� ��������� ����ϴ� SQL�� �ۼ�
-- emp(sal) - salgrade(grade)
SELECT ename, sal from emp;
SELECT * from salgrade;
-- 1	700	    1200
-- 2	1201	1400
-- 3	1401	2000
-- 4	2001	3000
-- 5	3001	9999

select ename, sal, grade from emp, salgrade
    where sal >= losal and sal <= hisal;
    
SELECT ename, sal, grade from emp, salgrade
    where sal BETWEEN losal and hisal;

SELECT ename, sal, grade from emp e, salgrade s
    where sal BETWEEN losal and hisal and deptno = 30;

-- 3. ��ü ����(Self Join)
--    �� ���� ���̺� ������ �÷��� �÷� ������ ���踦 �̿��Ͽ� ���� �ϴ� ��

-- ��ü ������ �̿��ؼ� �� ������� ������ �Ŵ����� ����ϴ� SQL�� �ۼ�
-- empno(�����ȣ) - mgr(�Ŵ����� �����ȣ)
SELECT employee.ename || '�� ���� ' || manager.ename as "���"
from emp employee, emp manager where employee.mgr = manager.empno; -- 13���� ������

-- 4. �ܺ� ����(Outer Join)
--    ���� ������ �������� �ʴ� �����͸� ������ִ� ����
-- 1) ���̺��� ������ �� ��� �� ���� ���̺��� �����Ͱ� ����������, �ٸ� ���̺���
-- �����Ͱ� �������� �ʴ� ��쿡 �� �����Ͱ� ��µ��� �ʴ� ������ �ذ��ϱ� ���� ����ϴ� ����
-- 2) ������ ������ ���� (+)�� �߰��Ѵ�.

-- ��ü������ ���, KING����� ��簡 ���� ������ ��µ��� �ʾҴµ�,
-- KING����� �ܺ������� �̿��Ͽ� ���
SELECT employee.ename || '�� ���� ' || manager.ename as "���"
from emp employee, emp manager where employee.mgr = manager.empno(+);

-- dept���̺�� emp���̺��� � ������ �ϸ� 40�� �μ��� ��Ÿ���� �ʱ� ������
-- �ܺ� ������ �̿��ؼ� 40�� �μ��� ���

-- 1) � ����
SELECT d.deptno, ename, dname from emp e, dept d
    where d.deptno = e.deptno order by deptno asc;
    
-- 2) �ܺ� ����
SELECT d.deptno, ename, dname from emp e, dept d
    where d.deptno = e.deptno(+) order by deptno asc;
    
---------------------------------------------------------------------------

-- ANSI JOIN
-- ANSI(�̱� ǥ�� ��ȸ) ǥ�ؾȿ� ���� ������� join���

-- ANSI Cross Join
SELECT * from emp CROSS join dept; -- 4 * 14 = 56���� ������
SELECT * from dept CROSS join emp; -- 14 * 4 = 56���� ������

-- ANSI Inner Join(� ����)
-- SELECT * from ���̺��1 inner join ���̺��2 on ���̺��.�÷���1 = ���̺��2.�÷���2

-- SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL ansdmf ANSI Inner Join���� �ۼ�
-- ������ �߰��� �ʿ��� ���� WHERE �������� �߰��ؼ� ����Ѵ�.
SELECT ename, dname from dept inner join emp
    on dept.deptno = emp.deptno where ename = 'SCOTT';
    
-- USING�� ����Ͽ� ����
SELECT ename, dname, loc from dept join emp
    USING(deptno) where ename = 'SCOTT';
    
-- NATURAL JOIN�� ����� ����
SELECT ename, dname from dept NATURAL join emp where ename = 'SCOTT';

-- ANSI Outer Join
-- select * from table1 [ left | right | full ] outer join table2;

-- 1. dept01 ���̺� ����
CREATE table dept01(
deptno NUMBER(2),
dname varchar2(14));

insert into dept01 VALUES(10, 'ACCOUNTING');
insert into dept01 VALUES(20, 'RESEARCH');

SELECT * from dept01;

DROP table dept01;

-- 2. dept02 ���̺� ����
CREATE table dept02(
deptno NUMBER(2),
dname varchar2(14));

insert into dept02 VALUES(10, 'ACCOUNTING');
insert into dept02 VALUES(30, 'SALES');

select * from dept02;

-- left outer join : dept01�� ������ ���
SELECT * from dept01 left OUTER join dept02 USING(deptno);

-- right outer join : dept02�� ������ ���
SELECT * from dept01 right OUTER join dept02 USING(deptno);

-- full outer join : ��� ���̺��� ������ ���
SELECT * from dept01 full OUTER join dept02 USING(deptno);
