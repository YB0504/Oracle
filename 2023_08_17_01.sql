-- 2023.08.17(��)

-- �� ������ : AND, OR, NOT

-- 1. AND ������ : �� ���ǽ��� ��� �����ϴ� �����͸� �˻�
-- ��� ���̺��� �μ���ȣ�� 10���̰�, job�� MANAGER�� ����� �˻��ϴ� SQL�� �ۼ�
SELECT * from emp where deptno = 10 and job = 'MANAGER';

-- 2. OR ������ : �� ���ǽ� �߿��� �Ѱ����� �����ص� �����͸� �˻�
-- ��� ���̺��� �μ���ȣ�� 10���̰�, job�� MANAGER�� ����� �˻��ϴ� SQL�� �ۼ�
select * from emp where deptno = 10 or job = 'MANAGER';

-- 3. NOT ������ : ������ �ݴ�� �ٲ��ִ� ����
-- �μ���ȣ�� 10���� �ƴ� ����� �˻��ϴ� SQL�� �ۼ�
select * from emp where not deptno = 10; -- �� ������
select * from emp where deptno != 10; -- �� ������
select * from emp where deptno ^= 10; -- �� ������
select * from emp where deptno <> 10; -- �� ������

-- Quiz �޿��� 2000�̻� 3000 ������ �޿��� �޴� ����� �˻��ϴ� SQL�� �ۼ�
select * from emp where sal >= 2000 and sal <= 3000;

-- Quiz Ŀ�̼��� 300�̰ų� 500�̰ų� 1400�� ����� �˻�
SELECT * from emp where comm = 300 or comm = 500 or comm = 1400;

-- Quiz �����ȣ�� 7521 �̰ų� 7654�̰ų� 7844�� ����� �˻��ϴ� SQL�� �ۼ�
SELECT * from emp where empno = 7521 or empno = 7654 or empno = 7844;

-- BETWEEN AND ������ : ������ ���� ������ �ִ� ��쿡 ��� �����ϴ�.
-- WHERE �÷��� BETWEEN ���� �� AND ū ��
select * from emp where sal BETWEEN 2000 and 3000;

-- Quiz �޿��� 2000�̸��̰ų� 3000 �ʰ��� ����� �˻��ϴ� SQL���� �ۼ�
SELECT * from emp where sal < 2000 or sal > 3000;
select * from emp where sal NOT BETWEEN 2000 and 3000;

-- 1987�⵵�� �Ի��� ����� �˻��ϴ� SQL�� �ۼ�
select * from emp where hiredate >= '1987/01/01' and hiredate <= '1987/12/31';
select * from emp where hiredate BETWEEN '1987/01/01' and '1987/12/31';

-- IN ������ : OR �����ڸ� ����ؼ� ǥ���� �� ����Ѵ�.
-- WHERE �÷��� IN (A, B, C�� )

-- Ŀ�̼��� 300�̰ų� 500�̰ų� 1400�� ����� �˻��ϴ� SQL���� �ۼ�
select * from emp where comm in (300, 500, 1400);

-- Ŀ�̼��� 300, 500, 1400�� �ƴ� ����� �˻��ϴ� SQL���� �ۼ�
select * from emp where comm not in(300, 500, 1400);

-- �����ȣ�� 7521�̰ų� 7844�� ����� �˻��ϴ� SQL�� �ۼ�
SELECT * from emp where empno = 7521 or empno = 7844;
select * from emp where empno in (7521, 7844);

-- �����ȣ�� 7521, 7654, 7844�� �ƴ� ����� �˻��ϴ� SQL���� �ۼ�
select * from emp where empno <> 7521 and empno <> 7654 and empno <> 7844;
select * from emp where empno not in(7521, 7654, 7844);

----------------------------------------------------------------------------

-- LIKE �����ڿ� ���ϵ� ī�� : �˻������ ������ �� ����Ѵ�.
-- WHERE �÷��� LIKE PATTERN(���ϵ� ī�带 �̿�)

-- ���ϵ� ī��
-- 1. % : ���ڰ� ���ų�, �ϳ� �̻��� ���ڿ� � ���� �͵� �������.
-- 2. _ : �ϳ��� ���ڿ� � ���� �͵� �������.

-- % ���ϵ� ī�� : % �ڸ��� ���ڰ� �� ���� �͵� �ȴ�.
-- ������� F�� �����ϴ� ������� �˻��ϴ� SQL�� �ۼ�
select * from emp where ename like 'F%';

-- ����� A�� ���� ������� �˻��ϴ� SQL��
select * from emp where ename like '%A%';

-- ������� N���� ������ ������� �˻��ϴ� SQL��
select * from emp where ename like '%N';

-- _ ���ϵ� ī�� : _ �ϳ��� �ϳ��� ���ڸ� �ǹ��Ѵ�.

-- ��� �̸��� �� ��° ���ڰ� A�� ����� �˻��ϴ� SQL���� �ۼ�
select * from emp where ename like '_A%';

-- ��� �̸��� �� ��° ���ڰ� A�� ����� �˻��ϴ� SQL���� �ۼ�
select * from emp where ename like '__A%';

-- ����� A�� ���ԵǾ� ���� ���� ����� �˻��ϴ� SQL���� �ۼ�
select * from emp where ename not like '%A%';

-- NULL ���� �˻�
-- EMP ���̺� : MGR, COMM

-- MGR, comm�÷��� NULL���� �����͸� �˻�
SELECT * from emp where mgr = null; -- �˻��ȵ�
SELECT * from emp where mgr = ''; -- �˻��ȵ�

SELECT * from emp where mgr is null;
SELECT * from emp where comm is null;

-- MGR, comm�÷��� NULL���� �ƴ� �����͸� �˻�
SELECT * from emp where mgr is NOT null;
SELECT * from emp where comm is NOT null;

---------------------------------------------------
-- ����
-- ORDER BY �÷��� ���Ĺ��
-- ��������(ascending), ��������(descending)

-- ���� ������ ����
-- �޿��� �������� �������� ����
SELECT * from emp order by sal asc;

-- ���� ����� �����ϸ� �⺻���� ������������ �����Ѵ�.
SELECT * from emp order by sal;

-- �޿��� �������� �������� ����
SELECT * from emp order by sal DESC;

-- ���� ������ ����
-- ��� ���� �������� �������� ���� : ���������� ����
SELECT * from emp order by ename asc;
SELECT * from emp order by ename; -- ���������� ���� ����

-- ��� ���� �������� �������� ���� : ���� �������� ����
SELECT * from emp order by ename DESC;

-- ��¥ ������ ����
-- �Ի��� ��¥�� �������� ����
SELECT * from emp order by hiredate asc;
SELECT * from emp order by hiredate desc;

-- NULL �� ����
SELECT * from emp order by comm asc;
SELECT * from emp order by comm desc;

-- ������ �����ϱ�
-- 1. �ѹ� �������� �� ������ ���� ��� ���� ���� �������� �ѹ� �� �����Ѵ�.
-- 2. �� ��° ���� ������ ������ ����� ���� �����͸� ���� ������ �����Ѵ�.

-- �� �� �����ϱ�
-- �Ի� ���� �������� �����ϰ�, ������ �Ի����̶�� ������� ������������ ����
-- ����ϴ� SQL�� �ۼ�
select * from emp order by hiredate asc, ename desc;

-- �޿��� �������� �������� �����ϰ�, ������ �޿���� ������� ������������ ����
select * from emp order by sal desc, ename asc;

-- �μ���ȣ�� �������� �������� �����ϰ�, ������ ��ȣ��� �Ի����� ������������ ����
select * from emp order by deptno asc, hiredate desc;













