-- 2023_08_22(ȭ)

-- DML(Data Manipulation Language, ������ ���۾�)
-- INSERT, UPDATE, DELETE

-- 1. INSERT : ������ �Է�
-- insert into ���̺��(�÷�1, �÷�N,..) values(������1, ������N,...)
-- Ư�� �÷��� ���ؼ��� �����͸� �Է��� �� ���
-- insert into ���̺�� values(������1, ������N,...)
-- ���̺��� ��� �÷��� ������� ���� �Է��ϴ� ���

-- �ǽ�
drop table dept01 purge;

-- ����ִ� dept01 ���纻 ���̺� ���� - ���̺� ������
CREATE table dept01 as SELECT * from dept where 1 = 0;
desc dept01;
SELECT * from dept01;

INSERT into dept01 (deptno, dname, loc) VALUES(10, 'ACCOUNTING', 'NEWYORK');
INSERT into dept01 VALUES(20, 'RESEARCH', 'DALLAS');
INSERT into dept01 VALUES(30, '������', '����');

-- NULL �� �Է�
INSERT into dept01(deptno, dname) VALUES(40, '���ߺ�'); -- loc�÷� ���� NULL
INSERT into dept01 VALUES(50, '��ȹ��', NULL); -- loc�÷� ���� NULL

-- ���� ������ �̿��� ������ �Է�
drop TABLE dept02 purge;

-- 1) dept02 ���̺� ����
CREATE table dept02 as SELECT * from dept where 1 = 0;
SELECT * from dept02;
desc dept02;

-- 2) ���� ������ �̿��� ������ �Է�
-- �����͸� �Է��� ���� as�� ���� �ۼ��Ѵ�.
INSERT into dept02 SELECT * from dept;
INSERT into dept02 SELECT * from dept02;

SELECT COUNT(*) from dept02;

-- INSERT ALL ��ɹ�����  �� ���̻��� ���̺� �� ���� �����͸� �Է�
-- 2���� ���̺� ����
CREATE table emp_hir as SELECT empno, ename, hiredate from emp where 1 = 0;
SELECT * from emp_hir;

CREATE table emp_mgr as SELECT empno, ename, mgr from emp where 1 = 0;
SELECT * from emp_mgr;

-- insert all ��ɹ����� ���� ���̺� ������ �Է�
insert all into emp_hir VALUES(empno, ename, hiredate)
           into emp_mgr VALUES(empno, ename, mgr)
           SELECT empno, ename, hiredate, mgr from emp where deptno = 20;

-- 2. UPDATE : ������ ����
-- update ���̺�� set �÷�1=�����Ұ�1, �÷�N = �����Ұ�N�� where ������

-- �ǽ�
drop table emp01 purge;

-- ���纻 ���̺� ����
CREATE table emp01 as SELECT * from emp;
SELECT * from emp01;

-- where �������� ������� ���� ���(��� ������ ����)
-- ��� ������� �μ���ȣ�� 30�� ����
UPDATE emp01 set deptno = 30;

-- ��� ������� �޿��� 10%�λ�
UPDATE emp01 set sal = sal * 1.1;

-- ��� ������� �Ի����� ���� ��¥�� ����
UPDATE emp01 set hiredate = sysdate;

-- where �������� ����� ���(Ư�� ������ ����)
drop table emp02 purge;
CREATE table emp02 as SELECT * from emp;
SELECT * from emp02;

-- �޿��� 3000�̻��� ����� �޿��� 10% �λ�
UPDATE emp02 set sal = sal * 1.1 where sal >= 3000;

-- 1987�⵵�� �Ի��� ����� �Ի����� ���ó�¥�� ����
-- ù��° ���
UPDATE emp02 set hiredate = sysdate 
    where hiredate >= '87/01/01' AND hiredate <= '87/12/31';

UPDATE emp02 set hiredate = sysdate 
    where hiredate between '87/01/01' AND '87/12/31';


-- �ι�° ���
update emp02 set hiredate = sysdate
    where substr(hiredate, 1, 2) = 87;
    
-- SCOTT ����� �Ի����� ���ó�¥�� �����ϰ�, 
-- �޿��� 50���� �����ϰ�, Ŀ�̼��� 4000���� ����
update emp02 set hiredate = sysdate, sal = 50, comm = 4000
    where ename = 'SCOTT';
SELECT * from emp02 where ename = 'SCOTT';

-- ���� ������ �̿��� ������ ����
-- 20�� �μ��� �������� 40�� �μ��� ���������� ����
drop table dept01 purge;
CREATE table dept01 as SELECT * from dept;
SELECT * from dept01;

update dept01 set loc = (SELECT loc from dept where deptno = 40)
    where deptno = 20;
SELECT * from dept01;

-- 3. DELETE : ������ ����
-- delete from ���̺�� where ������

-- ��� ������ ���� (where ������ X)
SELECT * from dept01;
DELETE from dept01;
rollback;   -- Ʈ����� ���(������ �ѹ�)

-- Ư�� ������ ���� (where ������ ���)
-- dept01 ���̺��� 30�� �μ��� ����
DELETE from dept01 where deptno = 30;

-- ���� ������ �̿��� ������ ����
-- ������̺�(EMP02) ���̺��� �μ����� SALES �μ��� ����� ����
drop table emp02 purge;
CREATE table emp02 as SELECT * from emp;
select * from emp02;

DELETE from emp02 where deptno 
    = (SELECT deptno from dept where dname = 'SALES');
    
------------------------------------------------------------------------------

-- MERGE
-- * ���̺� ������ ������ �� ���̺��� MERGE ����

--  MERGE : ������ ���� 2���� ���̺��� �ϳ��� ���̺�� ��ġ�� ���.
--  MERGE����� �����Ҷ� ������ �����ϴ� ��(ROW)�� ������ ���ο�     
--  ������ UPDATE�ǰ�, �������� ������ ���ο� ��(ROW)���� �߰��ȴ�.

drop table emp01 purge;
select * from emp01; -- 14
drop table emp02 purge;
select * from emp02; -- 3

-- emp���̺��� ����� ���̺� ����
create table emp01 as select * from emp;

-- emp���̺��� ����� ���̺� ����( job�� MANAGER�� �Ǿ��ִ� �����͸� ���� )
create table emp02 as select * from emp where job='MANAGER';

update emp02 set job='Test';

insert into emp02 values(8000, 'ahn', 'top', 7566, '2023/08/22',1200, 10, 20);

-- (Ȯ��)
select * from emp02; 

merge into emp01
    using emp02 -- 02 -> 01�� ������ ����
	on(emp01.empno = emp02.empno)
	when matched then -- ��ġ ����
	     update set emp01.ename = emp02.ename,
        			emp01.job = emp02.job,
                	emp01.mgr = emp02.mgr,
                    emp01.hiredate = emp02.hiredate,
        			emp01.sal = emp02.sal,
                	emp01.comm = emp02.comm,
                    emp01.deptno = emp02.deptno
	when not matched then
	     insert values(emp02.empno, emp02.ename, emp02.job, 		         	         
                       emp02.mgr,emp02.hiredate, 
                       emp02.sal, emp02.comm,emp02.deptno);

-- (�պ��� ��� Ȯ��)
select * from emp01;

--------------------------------------------------------------------





