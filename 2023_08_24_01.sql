-- 2023_08_24(��)

-- ���������� Ȱ��ȭ / �� Ȱ��ȭ

-- dept���̺��� �����͸� ����
DELETE from dept where deptno = 10; -- ���� �߻�

-- 1) �ڽ����̺��� �θ�Ű�� �����ϰ� �ִ� �ܷ�Ű�� �ֱ� ������ ���� �Ұ�
-- 2) �θ� ���̺��� �����͸� �����ϱ� ���� �����ϴ� �ڽ� ���̺��� �ܷ�Ű�� 
--    �� Ȱ��ȭ��Ű�� �θ� ���̺��� �����͸� ���� ����

-- 1. �θ� ���̺� ����
drop table dept01 purge;
CREATE table dept01(
    deptno number(2) PRIMARY key,   -- �θ�Ű
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
insert into dept01 VALUES(10, '������', '����');
SELECT * from dept01;

-- 2. �ڽ� ���̺� ����
drop table emp01 purge;
create table emp01(
    empno NUMBER(4) primary key,
    ename VARCHAR2(10) not null,
    job varchar2(10) UNIQUE,
    deptno number(2) REFERENCES dept01(deptno)); -- �ܷ�Ű
    
insert into emp01 VALUES(1111, 'ȫ�浿', '������', 10);
select * from emp01;

-- 3. �θ����̺�(dept01)�� ������ ����
DELETE from dept01; -- �ڽ����̺��� �����ϴ� �ܷ�Ű�� �ֱ� ������ ������ ���� �Ұ�
SELECT * from dept01;
SELECT * from emp01;

-- 4. �ڽ� ���̺��� �ܷ�Ű ���������� �� Ȱ��ȭ
-- �θ� ���̺��� �����͸� �����ϱ� ���ؼ��� �ڽ� ���̺��� �ܷ�Ű ����������
-- �� Ȱ��ȭ ��Ű�� �θ����̺��� �����͸� ������ �� �ִ�.

-- ���� : alter table ���̺�� disable constraint constraint_name(�������� �̸�)
alter table emp01 disable constraint SYS_C007051; -- �ܷ�Ű �������� �� Ȱ��ȭ

-- �ڽ� ���̺��� ���������� Ȱ��ȭ
-- ���� : alter table ���̺�� enable constraint constraint_name(�������� �̸�)
DELETE from emp01; -- �θ�Ű�� �����ߴ� �����͸� ����
alter table emp01 enable constraint SYS_C007051; -- �ܷ�Ű �������� Ȱ��ȭ

-- 5. �θ� ���̺��� ������ ����
delete from dept01; -- �����ϴ� �ܷ�Ű�� ���� ������ ������ ����������.

-- CASCADE �ɼ�
-- 1. CASCADE �ɼ��� �ٿ��� �θ� ���̺��� ���������� ��Ȱ��ȭ ��Ű��
--    �����ϰ� �ִ� �ڽ� ���̺��� �ܷ�Ű �������ǵ� ���� ��Ȱ��ȭ ��Ų��.
-- alter table �θ� ���̺�� disable CONSTRAINT ���������̸� cascade;
alter table dept01 disable constraint SYS_C007047 cascade;

-- 2. CASCADE �ɼ��� �ٿ��� �θ� ���̺��� primary  key�� �����ϸ�
--    �����ϴ� �ڽ� ���̺��� foreign key �������ǵ� ���� ���ŵȴ�.
--alter table �θ� ���̺�� drop constraint constraint_name cascade;
alter table dept01 drop constraint SYS_C007047 cascade;
alter table dept01 drop primary key cascade;

-- 1. �θ� ���̺� ����
drop table dept01 purge;
CREATE table dept01(
    deptno number(2) PRIMARY key,   -- �θ�Ű
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
insert into dept01 VALUES(10, '������', '����');
SELECT * from dept01;

-- 2. �ڽ� ���̺� ����
drop table emp01 purge;
create table emp01(
    empno NUMBER(4) primary key,
    ename VARCHAR2(10) not null,
    job varchar2(10) UNIQUE,
    deptno number(2) REFERENCES dept01(deptno)on delete cascade); -- �ܷ�Ű
    
-- on delete cascade 
-- : �θ� ���̺��� �����͸� �����ϸ� �����ϴ� �ڽ� ���̺��� �����͵� ���� �������ִ� �ɼ�
    
insert into emp01 VALUES(1111, 'ȫ�浿', '������', 10);
select * from emp01;

-- 3. �θ� ���̺� ������ ����
DELETE from dept01; -- �ڽ� ���̺��� �����͵� ���� �����ȴ�.

----------------------------------------------------------------------------

-- View(��)
-- : �⺻ ���̺��� �̿��ؼ� ������� ���� ���̺�

-- �ǽ��� ���� �⺻ ���̺� ���� : dept_copy, emp_copy

-- 2���� �⺻ ���̺� ����( ���� ������ ���簡 �ȵȴ�. )
CREATE table dept_copy as SELECT * from dept;
CREATE table emp_copy as SELECT * from emp;

select * from tab;
SELECT * from dept_copy;
SELECT * from emp_copy;

-- �� ����
CREATE view emp_view30
as SELECT empno, ename, deptno from emp_copy where deptno = 30;

-- �� ��� Ȯ��
select * from tab;
select * from user_views;

-- �� �˻�
select * from emp_view30;
desc emp_view30;

-- ��(emp_view30)�� insert�� �����͸� �Է��� ��� �⺻���̺�(emp_copy)����
-- ���� �����Ͱ� �ԷµǴ��� Ȯ��
insert into emp_view30 VALUES(1111, 'ȫ�浿', 30);

-- view�� �����Ͱ� �ԷµǸ� �⺻���̺��� �����Ͱ� �Էµȴ�.
select * from emp_view30;
select * from emp_copy;

-- View�� ����
-- �ܼ� View : �ϳ��� �⺻ ���̺�� ������ ��
-- ���� View : ���� ���� �⺻ ���̺�� ������ ��

-- 1. �ܼ� ��
-- �⺻ ���̺��� emp_copy �� �̿��ؼ� 20�� �μ��� �Ҽӵ� �������
-- ����� �̸�, �μ���ȣ, ���� ����� ����� ����ϴ� �� ����(emp_view20)

CREATE view emp_view20
as select empno, ename, deptno, mgr 
from emp_copy where deptno = 20;

select * from user_views;
select * from emp_view20;

-- 2. ���� ��
-- �� �μ���(�μ���) �ִ�޿��� �ּұ޿��� ����ϴ� �並 �ۼ�(sal_view)
CREATE view sal_view
as select dname, max(sal) as "MAX", min(sal) as "MIN"
from dept, emp where dept.deptno = emp.deptno group by dname;

SELECT * from tab;
SELECT * from user_views;
select * from sal_view;

-- �� ����
drop view sal_view;

-- �並 ������ �� ���Ǵ� �ɼ�
-- 1. OR REPLACE �ɼ�
--    ������ �䰡 �������� ������ �並 �����ϰ�, ������ �̸��� ����
--    �䰡 �����ϸ� ���� ������ �����ϵ��� ����� �ִ� �ɼ�

-- 1) or replace �ɼǾ��� ������ ��(emp_view30)�� ���� : ���� �߻�
CREATE view emp_view30
as SELECT empno, ename, deptno, sal, comm
from emp_copy where deptno = 30;

-- 2) or replace �ɼ��� �ٿ��� ������ �並 ���� : ���� ������ �����ȴ�.
CREATE or REPLACE view emp_view30
as SELECT empno, ename, deptno, sal, comm
from emp_copy where deptno = 30;

select * from user_views;
select * from emp_view30;

-- 2. WITH CHECK OPTION
--  : where �������� ���� ���� �������� ���ϵ��� ����� �ִ� �ɼ�
-- 1) with check option ������� ���� ���
--    �信 insert, update, delete�� ����Ǹ�,
--    �⺻ ���̺��� ������ ������ ����ȴ�.
CREATE or REPLACE view emp_view30
as SELECT empno, ename, deptno, sal, comm
from emp_copy where deptno = 30;

-- emp_view30���� �޿��� 1200 �̻��� ������� �μ���ȣ�� 30������ 20������ ����
update emp_view30 set deptno = 20 where sal >=1200;
select * from emp_view30;
SELECT * from emp_copy where deptno = 20;

-- 2) with check option ����� ���
drop table emp_copy purge;
CREATE table emp_copy as SELECT * from emp;

CREATE or REPLACE view emp_view30
as SELECT empno, ename, deptno, sal, comm
from emp_copy where deptno = 30 with check option;

select * from emp_view30;

update emp_view30 set deptno = 20 where sal >= 1200; -- ���� �߻�

-- 3. WITH READ ONLY
--  : �б� ������ �並 ����� �ִ� �ɼ�
--  : �並 ���ؼ� �⺻ ���̺��� ������ �������� ���ϵ��� ����� �ִ� ����

CREATE or REPLACE view view_read30
as select empno, ename, sal, comm deptno
from emp_copy where deptno = 30 with read only;

select * from view_read30;
update view_read30 set deptno = 20 where sal >= 1200; -- ���� �߻�

----------------------------------------------------------------------

-- ROWNUM �÷�
-- 1. �������� �˻� ������ ������ �ִ� ������ �÷�
-- 2. rownum ���� 1������ �����Ѵ�.
-- 3. rownum ���� order by���� �����ص� �ٲ��� �ʴ´�.
-- 4. rownum ���� �����ϱ� ���ؼ��� ���̺��� �����ؾ� �Ѵ�.

SELECT rownum, rowid, deptno, dname, loc from dept;
select rownum, ename, sal from emp;
select rownum, ename, sal from emp where ename = 'WARD';
select rownum, ename, sal from emp order by ename;
--11	ADAMS	1100
--2	    ALLEN	1600
--6	    BLAKE	2850
--7	    CLARK	2450
--13	FORD	3000
--12	JAMES	950
--4	    JONES	2975
--9	    KING	5000
--5	    MARTIN	1250
--14	MILLER	1300
--8	    SCOTT	3000
--1	    SMITH	800
--10	TURNER	1500
--3	    WARD	1250

-- ��� ���̺��� �Ի����� ���� ��� 5���� ���Ͻÿ�
-- 1) �Ի����� ���� ��� ������ ����
SELECT empno, ename, hiredate from emp
order by hiredate asc;

-- 2) �� ����
create or replace view hire_view
as SELECT empno, ename, hiredate 
from emp order by hiredate asc;

select rownum, ename, hiredate from hire_view;

select ename, hiredate from hire_view
where rownum <= 5;

-- 3) �ζ��� ��
-- �Ի����� ���� ��� 5�� �˻�
SELECT rownum, ename, hiredate 
from(select empno, ename, hiredate from emp 
order by hiredate asc)
where rownum <= 5;

-- ��� ���̺��� �����ȣ�� ���� ���5�� �˻�
-- ���� ���� ������ �ζ��� �� �������� ���
select empno, ename
from(select empno, ename from emp 
order by empno asc)
where rownum <= 5;

-- * �� ����ص� ���� �������� ����� �ȴ�.
select empno, ename
from(select * from emp 
order by empno asc)
where rownum <= 5;

-- ��� ���̺��� �޿��� ���� �޴� ��� 5���� �˻�
select empno, ename, sal
from(select * from emp
order by sal desc)  -- �ζ��� ��
where rownum <= 5;

-- �Ի����� 3~5��° ��������� �˻�
select rownum, rnum, ename, hiredate from(
    select rownum rnum, ename, hiredate from(
    select * from emp order by hiredate asc))
    where rnum between 3 and 5;

-- �����ȣ�� 3~5��° ���� ����� �˻�
SELECT rownum, rm, ename, empno from(
select rownum rm, ename, empno from(
select * from emp order by empno asc))
where rm between 3 and 5;






