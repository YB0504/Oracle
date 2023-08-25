-- 2023_08_25(��)

-- Sequence
-- : ���̺� ���ڸ� �ڵ����� ���� �����ִ� ����

-- ������ ����
create SEQUENCE dept_deptno_seq
start with 10       -- �������� ������ ��ȣ��
INCREMENT by 10;    -- ����ġ

-- ������ ��� Ȯ��
SELECT * from seq;
SELECT * from user_sequences;

-- CURRVAL : �������� ���� ���� ��ȯ
-- NEXTVAL : �������� ���� ���� ��ȯ
SELECT dept_deptno_seq.nextval from dual;
SELECT dept_deptno_seq.currval from dual;

-- ���� 1 : �������� ���̺��� �⺻Ű�� ����
drop table emp01 purge;
CREATE table emp01(
    empno number(4) primary key,
    ename VARCHAR2(10),
    hiredate date);

-- 1���� 1�� �����ϴ� ������ ����
CREATE SEQUENCE emp01_empno_seq;
-- start with 10       -- �������� ������ ��ȣ��
-- INCREMENT by 10;    -- ����ġ
-- �������� ������ �⺻���� 1���� 1�� �����Ѵ�.

select * from emp01;
select * from seq;

-- ������ �Է�
insert into emp01 values(emp01_empno_seq.nextval, 'ȫ�浿', sysdate);

-- ���� 2.
-- ���̺� ����
create table dept_example(
    deptno number(2) primary key,
    dname varchar2(15),
    loc varchar2(15));

-- ������ ���� 10���� 10�� �����Ǵ� ������
CREATE sequence dept_example_seq
start with 10
increment by 10;

select * from seq;

insert into dept_example values(dept_example_seq.nextval, '�ѹ���', '����');

select * from dept_example;

-- ������ ����
-- drop sequence ������ �̸�
drop sequence dept_example_seq;

-- �������� �ִ밪�� ����
drop SEQUENCE dept_deptno_seq;
CREATE SEQUENCE dept_deptno_seq
start with 10
INCREMENT by 10
MAXVALUE 30;    -- ������ �ִ�ġ ����

select * from seq;

-- ������ �������� ��ȯ
SELECT dept_deptno_seq.nextval from dual; -- �������� ���� 30������ ���� �� �ִ�.

-- �������� mxvalue ���� 100000���� ����
alter SEQUENCE dept_deptno_seq MAXVALUE 100000;

-- �������� �������� ����
alter sequence dept_deptno_seq INCREMENT by 1000;

-----------------------------------------------------------------------------

-- Index : ������ �˻��� �ϱ� ���ؼ� ���Ǵ� ��ü

-- �ε��� ��� Ȯ��
select * from user_indexes;
-- primary key ������������ ������ �÷��� �ڵ����� ���� �ε����� �����ȴ�.

-- �ǽ�
-- �ε����� ��� ���ο� ���� �˻� �ӵ��� ���� ��

-- 1. ���̺� ����
drop table emp01 purge;

-- ���纻 ���̺� ����
CREATE table emp01 as SELECT * from emp;
SELECT * from emp01;

-- 2. emp01 ���̺� ������ �Է�
insert into emp01 SELECT * from emp01;

-- 3. �˻��� ������ �Է�
insert into emp01(empno, ename) VALUES(1111, 'ȫ');

-- 4. �ð����� Ÿ�̸� ON���� ����
set timing off

-- 5. �˻��� �����ͷ� �˻� �ð��� ���� : index ���� X
select * from emp01 where ename = 'ȫ'; -- 4.026��

-- 6. index ���� : emp01���̺��� ename�÷��� index����
CREATE index idx_emp01_ename on emp01(ename);

-- 7. index ��� Ȯ��
SELECT * from user_indexes;

-- 8. �˻��� �����ͷ� �˻� �ð��� ���� : index ���� O
select * from emp01 where ename = 'ȫ'; -- 2.923��

-- 9. index ����
drop index idx_emp01_ename;

-- �ε��� ����
-- ���� �ε��� : �ߺ��� �����Ͱ� ���� �÷��� ������ �� �ִ� �ε���
-- �� ���� �ε���  : �ߺ��� �����Ͱ� �ִ� �÷��� ������ �� �ִ� �ε���

-- 1. ���̺����
drop table dept01 purge;
CREATE table dept01 as select * from dept where 1=0; -- ���̺� ������ ����
select * from dept01;

-- 2. ������ �Է� : loc�÷��� �ߺ��� �����Ͱ� �Է�
insert into dept01 VALUES(10, '�λ��', '����');
insert into dept01 VALUES(20, '�ѹ���', '����');
insert into dept01 VALUES(30, '������', '����');

-- 3. ���� �ε��� : deptno�÷��� ���� �ε��� ����
CREATE unique index idx_dept01_deptno on dept01(deptno); 
SELECT * from user_indexes;

-- ���� �ε��� ������ deptno�÷��� �ߺ� ������ �Է�
-- deptno �÷��� ���� �ε����� �����Ǿ �ߺ��� �����͸� �Է��� �� ����.
insert into dept01 VALUES(10, '�λ��', '����'); -- ���� �߻�

-- 4. �� ���� �ε���
--    loc�÷��� ����, �� ���� �ε����� ����

-- loc�÷��� ���� �ε��� ���� : �̹� �ߺ��� �����Ͱ� �ֱ� ������ ���� �ε��� ���� �Ұ�
CREATE unique index idx_dept01_loc on dept01(loc); -- ���� �߻� 

-- loc�÷��� �� ���� �ε��� ����
CREATE index idx_dept01_loc on dept01(loc);
SELECT * from user_indexes;

-- 5. ���� �ε��� : 2�� �̻��� �÷����� ������� �ε���
CREATE index idx_dept01_loc_com on dept01(deptno, dname);

-- 6. �Լ� ��� �ε��� : �����̳� �Լ��� �����Ͽ� ���� �ε���
CREATE index idx_emp01_annsal on emp(sal*12 + nvl(comm, 0));










