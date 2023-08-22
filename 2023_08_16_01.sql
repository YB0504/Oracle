-- 2023.08.16(��)

-- ���̺� ���
select * from tab;
-- DEPT : �μ� ���̺�
-- EMP : ��� ���̺�
-- BOUNS : �󿩱�
-- SALGRADE : �޿����

-- DEPT ���̺� ����
DESCRIBE dept;
desc dept;

-- DEPT ������ �˻� : SQL���� ��,�ҹ��ڸ� �������� �ʴ´�.
select * from dept;
SELECT * FROM dept;

-- EMP ���̺� ����
desc emp;

-- EMP ������ �˻�
SELECT * FROM emp;

-- ����Ŭ�� ������ Ÿ��
-- 1. ���� ������
--    number(n)
-- ex) number(2) ���� 2�ڸ����� ����
--    number(n1, n2) : n1 - ��ü �ڸ���
--                     n2 - �Ҽ����� �Ҵ�� �ڸ���
-- ex) number(7, 2) : ��ü �ڸ��� 7�ڸ�
--                    �Ҽ��� 2�ڸ�
-- 2. ���� ������
-- char() : ���� ���� ������
--          �ִ� 2000byte���� ����
-- vachar2() : ���� ���� ������
--             �ִ� 4000byte���� ����
-- long() : 2GB���� ����
--          long������ ������ �÷��� �˻� ����� �������� �ʴ´�.
-- 3. ��¥ ������
-- date : ��, ��, ��
-- timestamp : ��, ��, ��, ��, ��, ��

-- SELECT SQL��
select * from dept;

select loc, dname, deptno from dept;

SELECT * from emp;

select empno from emp;

-- ��� ������ : +, -, *, /
-- ������ �÷��� ��� ������ �Ұ����ϴ�.
SELECT sal + comm from emp;
SELECT sal + 100 from emp;
SELECT sal - 100 from emp;
SELECT sal * 100 from emp;
SELECT sal / 100 from emp;

-- �� ����� ���� ���ϱ�
-- ���� = �޿� * 12 + Ŀ�̼�

-- NULL
-- 1. �������� ���� ���� �ǹ�
-- 2. ��� ������ �Ұ����ϴ�.
-- ex) EMP ���̺� : MGR �÷� - KING ����� MGR�÷��� NULL
--                 COMM �÷� - job�� SALESMAN�� ����� ���� ������ �ִ�.

-- NVL(�÷�, ġȯ�� ��) : NULL���� �ٸ� ������ ġȯ���ִ� �Լ��̴�.
select ename, job, sal, comm, sal * 12, sal * 12 + nvl(comm, 0) from emp;

-- ��Ī �ο� : ��Ī �ο��� �÷� as "��Ī��"
select ename, sal * 12, sal * 12 + nvl(comm, 0) as "Annsal" from emp;
select ename, sal * 12, sal * 12 + nvl(comm, 0) "Annsal" from emp; -- as ���� ����
select ename, sal * 12, sal * 12 + nvl(comm, 0) Annsal from emp; -- �ֵ���ǥ ���� ����

-- �ѱ� ��Ī�� �ο�
select ename, sal * 12, sal * 12 + nvl(comm, 0) as "����" from emp;
select ename, sal * 12, sal * 12 + nvl(comm, 0) "����" from emp;
select ename, sal * 12, sal * 12 + nvl(comm, 0) ���� from emp;

-- Concatennation ������ : ||
-- �÷��� ���ڿ��� ������ �� ����Ѵ�.
SELECT ename, ' is a ', job FROM emp;
SELECT ename || ' is a ' || job FROM emp;



-- Distinct Ű���� : �ߺ����� �����ϰ� 1���� ����ϴ� ����
-- select distinct �÷��� from ���̺��;
select deptno from emp;
select distinct deptno from emp;

--Quiz1. EMP ���̺��� �� ������� job�� 1���� ����ϴ� SQL�� �ۼ�
SELECT DISTINCT job from emp;

--Quiz2. EMP ���̺��� �ߺ����� ������ job�� ������ ����ϴ� SQL�� �ۼ�

-- count(�÷���) : ������ ������ ���ϴ� �Լ�
SELECT count(DISTINCT job) from emp;

-- WHERE ������ : �� ������( =, >, >=, <, <=, !=, ^=, <> )

-- 1. ���� ������ �˻�
-- ��� ���̺��� �޿��� 3000 �̻� �޴� ����� �˻��ϴ� SQL�� �ۼ�
SELECT * from emp where sal >= 3000;

-- �޿��� 3000�� ����� �̻��ϴ� SQL�� �ۼ�
SELECT * from emp where sal = 3000;

-- �޿��� 3000�� �ƴ� ����� �̻��ϴ� SQL�� �ۼ�
SELECT * from emp where sal != 3000;
SELECT * from emp where sal ^= 3000;
SELECT * from emp where sal <> 3000;

-- �޿��� 1500������ ����� �����ȣ �����, �޿��� �̻��ϴ� SQL�� �ۼ�
SELECT empno, ENAME, SAL from emp where sal <= 1500;

-- 2. ���� ������ �˻�
--  1) ���� �����ʹ� ��,�ҹ��ڸ� �����Ѵ�.
--  2) ''�ȿ� ���ڿ� �ۼ�

-- ��� ���̺��� ������� FORD�� ����� �˻��ϴ� SQL�� �ۼ�
-- SELECT * from emp WHERE ename = 'ford'; -- �˻������ ����.
-- SELECT * from emp WHERE ename = FORD; -- ���� �߻� 
-- SELECT * from emp WHERE ename = "FORD"; -- ��Ī���� ""�� �� �� �ִ�.
SELECT * from emp WHERE ename = 'FORD';

-- SCOTT����� �����ȣ,  �����, �޿��� ����ϴ� SQL���� �ۼ�
SELECT empno, ENAME, SAL from emp where ename = 'SCOTT';

-- 3. ��¥ ������ �˻�
--  1) ''�ȿ� ���ڿ�ó�� ��¥ �ۼ�
--  2) �񱳿����ڷ� ��

-- 1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �˻��ϴ� SQL�� �ۼ�
SELECT * from emp WHERE hiredate >= '82/01/01';
SELECT * from emp WHERE hiredate >= '1982/01/01';

-- 1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �˻��ϰ�, �Ի����� �������� 
-- ������������ ������ SQL�� �ۼ�
SELECT * from emp WHERE hiredate >= '82/01/01'
    order by hiredate asc;








