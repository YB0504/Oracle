-- 2023_08_18(��)

-- �׷� �Լ�
-- �ϳ� �̻��� �����͸� �׷����� ��� ������ ó���ϰ�,
-- �ϳ��� ����� ó�����ִ� �Լ�

-- 1. SUM() : ���� �����ִ� �Լ�
-- ���� �����Ͱ��� ���� �����ϴ�.
SELECT sum(sal) from emp;
SELECT sum(comm) from emp; -- null ���� ���� �ȴ�.

-- �׷� �Լ��鳢���� ���� ����� �� �ִ�.
SELECT sum(sal), sum (comm) FROM emp;

-- �׷� �Լ��� �Ϲ� �÷��� ���� ����� �� ����.
SELECT sal, sum(sal), sum(comm) from emp; -- ���� �߻�

SELECT sum(sal) from emp where deptno = 10;
SELECT sum(sal) from emp where deptno = 20;
SELECT sum(sal) from emp where deptno = 30;

-- 2. AVG() : ��հ��� �����ִ� �Լ�
SELECT round(avg(sal)) from emp;
SELECT round(avg(sal)), avg(comm) from emp;
SELECT round(avg(sal)), avg(comm) from emp where deptno = 10;
SELECT round(avg(sal)), avg(comm) from emp where deptno = 20;
SELECT round(avg(sal)), avg(comm) from emp where deptno = 30;

-- 3. MAX() : �ִ밪�� �����ִ� �Լ�

-- �ִ� �޿� �ݾ��� ���ϴ� SQL�� �ۼ�
SELECT max(sal) from emp;

SELECT max(sal) from emp where deptno = 10;
SELECT max(sal) from emp where deptno = 20;
SELECT max(sal) from emp where deptno = 30;

-- �ִ� �޿��� �ִ�  �޿��� �޴� ������� ����ϴ� SQL�� �ۼ�
SELECT ename, max(sal) FROM emp; -- ���� �߻�

-- ���� �ʰ� �Ի��� �Ի����� ����ϴ� SQL�� �ۼ�
SELECT max(hiredate) from emp;

-- ������� ���ĺ����� ���� ���߿� ������ ����� ���ϴ� SQL�� �ۼ�
SELECT max(ename) from emp;
SELECT * from emp order by ename desc;

--4. MIN() : �ּҰ��� �����ִ� �Լ�

-- �ּ� �޿� �ݾ��� ���ϴ� SQL�� �ۼ�
SELECT MIN(sal) from emp;

SELECT MIN(sal) from emp where deptno = 10;
SELECT min(sal) from emp where deptno = 20;
SELECT MIN(sal) from emp where deptno = 30;

-- �ּ� �޿��� �ּ� �޿��� �޴� ������� ����ϴ� SQL�� �ۼ�
SELECT ename, min(sal) FROM emp; -- ���� �߻�

-- ���� ���� �Ի��� �Ի����� ����ϴ� SQL�� �ۼ�
SELECT min(hiredate) from emp;
SELECT * from emp order by hiredate asc;

-- ������� ���ĺ����� ���� ���� ������ ����� ���ϴ� SQL�� �ۼ�
SELECT min(ename) from emp;
SELECT * from emp order by ename asc;

-- �׷� �Լ����� ���� ����� �� �ִ�.
SELECT SUM(sal), trunc(avg(sal)), max(sal), min(sal) from emp;
SELECT SUM(sal), trunc(avg(sal)), max(sal), min(sal) from emp where deptno = 10;
SELECT SUM(sal), trunc(avg(sal)), max(sal), min(sal) from emp where deptno = 20;
SELECT SUM(sal), trunc(avg(sal)), max(sal), min(sal) from emp where deptno = 30;

-- COUNT() : �� ������ ������ �����ִ� �Լ�
-- COUNT(�÷���)
SELECT count(sal) from emp;
SELECT count(mgr) from emp; -- NULL���� ī���� ���� �ʴ´�.
SELECT count(comm) from emp;
SELECT count(empno) from emp; -- empno�� primary key ���� ������ �����Ǿ� �ִ�.
SELECT count(deptno) from dept;
SELECT count(*)from emp; -- (*)�� ��� �����͸� ���϶�� �ǹ�

-- �ߺ����� ������ job�� ������ ���ϴ� SQL�� �ۼ�
-- 1) job�� ���� ���ϱ�
SELECT count(job) from emp;
SELECT job from emp;

-- 2) �ߺ��� ����
SELECT DISTINCT job from emp;

-- 3) �ߺ����� ������ job�� ����
SELECT count (DISTINCT job) from emp;

-- 30�� �μ� �Ҽ� ��� �߿��� Ŀ�̼��� �޴� ������� ���ϴ� SQL�� �ۼ�
SELECT count(comm)from emp where deptno = 30;

---------------------------------------------------------------

-- GROUP BY �� : Ư�� �÷��� �������� ���̺� �����ϴ� ����Ʈ�� �׷����� �����Ͽ�
--               ó�����ִ� ������ �Ѵ�.
-- GROUP BY ���� ���� �÷��� ���������� �׷� �Լ��� ���� ����� �� �ִ�.
SELECT sum(sal) from emp GROUP by deptno;

SELECT deptno, SUM(sal), trunc(avg(sal)), max(sal), min(sal)
from emp GROUP by deptno order by deptno asc;

-- job �÷��� �������� �޿��� ��, ��ձ޿�, �ִ�޿�, �ּұ޿��� ���ϴ� SQL�� �ۼ�
SELECT job, SUM(sal), trunc(avg(sal)), max(sal), min(sal)
from emp GROUP by job order by sum(sal) asc;

-- �� �μ��� ������� Ŀ�̼��� �޴� ������� ���ϴ� SQL�� �ۼ�
SELECT deptno, count(*) �����, count(comm) Ŀ�̼� from emp
GROUP by deptno order by deptno asc;

-----------------------------------------------------------------------

-- HAVING ������
-- : GROUP BY���� ���Ǵ� ��쿡 ������ ������ �ϱ� ���ؼ� WHERE ������
--   ��ſ� HAVING �������� ����ؾ��Ѵ�.

-- �� �μ��� ��ձ޿� �ݾ��� 2000�̻��� �μ��� ����ϴ� SQL�� �ۼ�
SELECT deptno, round(avg(sal)) from emp GROUP by deptno; -- ��� �μ��� ��� ���
SELECT deptno, round(avg(sal)) from emp GROUP by deptno
    where avg(sal) >= 2000; -- ���� �߻�
-- group by ���� ���Ǵ� ��쿡�� having �������� ����ؾ� �Ѵ�.
SELECT deptno, round(avg(sal)) from emp GROUP by deptno 
    HAVING AVG(sal) >= 2000;
    
-- �� �μ��� �ִ� �޿� �ݾ��� 2900�̻��� �μ��� ����ϴ� SQL�� �ۼ�
SELECT deptno, max(sal) from emp GROUP by deptno;
SELECT deptno, max(sal) from emp group by deptno 
    having max(sal) >= 2900 order by deptno asc;





















