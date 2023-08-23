-- 2023_08_23(��)

-- ���Ἲ ���� ����
-- : ���̺� �������� �����Ͱ� �ԷµǴ� ���� ���� ���ؼ� ���̺��� ������ ��
--   �� �÷��� ���ؼ� �����ϴ� �������� ��Ģ�� �ǹ��Ѵ�.
-- ex) not null, unique, primary key(�⺻Ű), foreign key(�ܷ�Ű)
--     check, default

-- 1. NOT NULL ��������
--    NULL ���� ������� �ʴ´�.
--    �ݵ�� ���� �Է��ؾ� �Ѵ�.

-- �ǽ�
drop table emp02 purge;

CREATE table emp02(empno number(4) not null,
                   ename VARCHAR2(12) not null,
                   job VARCHAR2(12),
                   deptno number(2));

SELECT * from tab;
SELECT * from emp02;

-- �������ǿ� ������� �ʴ� ������ �Է�
insert into emp02 VALUES(1111, 'ȫ�浿', 'MANAGER', 30);

-- �������ǿ� ����Ǵ� ������ �Է�
insert into emp02 VALUES(null, null, 'SALESMAN', 30); -- �Է��� ���� �ʴ´�.
insert into emp02(job, deptno) VALUES('SALESMAN', 30);

-- 2. unique ��������
--    ������ ���� �Է��� �� �ִ�.
--    �ߺ��� ���� �Է��� �� ����.
--    null ���� �Էµ� �� �ִ�.

-- �ǽ�
DROP table emp03 purge;

CREATE table emp03(empno number(4) UNIQUE,
                   ename VARCHAR2(12) not null,
                   job VARCHAR2(12),
                   deptno NUMBER(2));

SELECT * from tab;
SELECT * from emp03;

-- �������ǿ� ������� �ʴ� ������ �Է�
INSERT into emp03 VALUES(1111, 'ȫ�浿', '������', 10);

-- �������ǿ� ����Ǵ� ������ �Է�
insert into emp03 VALUES(1111, '����Ŭ', '������', 20); -- empno���� �ߺ��� ��

-- null���� �Է�
-- unique ���������� null���� �Է��� �����ϴ�.
insert into emp03 VALUES(null, '����Ŭ', '������', 20);
insert into emp03 VALUES(null, '�����', '������', 30);

-- 3. PRYMARY KEY(�⺻Ű) ��������
--    not null, unique ���������� ������ ��������
--    �ݵ�� �ߺ����� ���� ���� �Է��ؾ� �Ѵ�.
--    ������ �÷��� �ַ� where �������� ���ȴ�.
-- ex) �μ� ���̺�(dept) - deptno(pk)
--     ��� ���̺�(emp)  - empno(pk)

--     �Խ���(board)    - ��ȣ(no)
--     ȸ������(member) - ���̵�(id)


-- �μ� ���̺� (dept) - deptno(pk)
SELECT * from dept;
insert into dept VALUES(10, '���ߺ�', '����'); -- unique �������� ����
insert into dept VALUES(null, '���ߺ�', '����'); -- not null �������� ����

-- ��� ���̺�(emp)  - empno(pk)
SELECT * from emp;
insert into emp(empno, ename) VALUES(7369, 'ȫ�浿'); -- unique�������� ����
insert into emp(empno, ename) VALUES(null, 'ȫ�浿'); -- not null �������� ����

drop table emp05 purge;
CREATE table emp05(
    empno NUMBER(4) PRIMARY key,
    ename VARCHAR2(12) not null,
    job VARCHAR2(12),
    deptno number(2));
    
SELECT * from emp05;
    
insert into emp05 VALUES(1111, 'ȫ�浿', '������', 10);
insert into emp05 VALUES(1111, 'ȫ�浿', '������', 10); -- unique �������� ����
insert into emp05 VALUES(null, 'ȫ�浿', '������', 10); -- not null �������� ����

-- �������� �̸� �����Ͽ� ���̺� ����
drop table emp04 purge;

CREATE table emp04(
    empno NUMBER(4) CONSTRAINT emp04_empno_uk unique,
    ename VARCHAR2(10) CONSTRAINT emp04_ename_nn not null,
    job VARCHAR2(10),
    deptno number(2));
    
SELECT * from emp04;

-- 4. FOREIGN KEY(�ܷ�Ű) ��������
--    dept(�θ� ���̺�) - deptno(pk) : �θ�Ű 10, 20, 30, 40
--    emp(�ڽ� ���̺�)  - drptno(fk) : �ܷ�Ű 10, 20, 30

-- 1) ������̺�(emp)�� deptno �÷��� foreign key ���������� �����Ǿ� �ִ�.
-- 2) foreign key ���������� ������ �ִ� �ǹ̴� �θ����̺�(dept)�� 
--    �θ�Ű(deptno)���� ������ �� �ִ�.
-- 3) �θ�Ű�� �Ǳ� ���� ������ primary key�� 
--    unique������������ �����Ǿ� �־�� �Ѵ�.

-- ��� ���̺� ���ο� ���Ի���� ���
-- �ܷ�Ű(deptno)�� �θ�Ű(dept - deptno)�ȿ� �ִ� ���� ������ �� �ִ�.
INSERT into emp(empno, deptno) VALUES(1111, 50); -- foreign key �������� ����
INSERT into emp(empno, deptno) VALUES(1111, 50);

-- �ǽ�
drop table emp06 purge;
CREATE table emp06(
    empno number(4) PRIMARY key,
    ename VARCHAR2(10) not null,
    job VARCHAR2(10),
    deptno NUMBER(2) references dept(deptno));
    
select * from emp06;
insert into emp06 VALUES(1111, 'ȫ�浿', '���ߺ�', 10);
insert into emp06 VALUES(1112, '�Ǳ浿', '���ߺ�', 20);
insert into emp06 VALUES(1113, '��浿', '���ߺ�', 30);
insert into emp06 VALUES(1114, '�Ѹ�', '���ߺ�', 40);
-- 50�� �μ��� �θ�Ű���� ������ �� ���� ���̱� ������ foreign key �������ǿ� ����ȴ�.
insert into emp06 VALUES(1115, '�����', '���ߺ�', 50);

-- 5. CHECK ��������
-- :  �����Ͱ� �Էµ� �� Ư�� ������ �����ϴ� �����͸� �Էµǵ��� 
--    ������ִ� ���������̴�.

-- �޿�(sal) : 500 ~ 5000
-- ����(gender) : M or F

CREATE table emp07(
    empno number(4) PRIMARY key,
    ename VARCHAR2(10) not null,
    sal number(7, 2) check(sal between 500 and 5000),
    gender VARCHAR2(1) check(gender in('M','F')));

SELECT * from emp07;

INSERT into emp07 VALUES(1111, 'ȫ�浿', 3000, 'M');
INSERT into emp07 VALUES(1112, 'ȫ�浿', 8000, 'M'); -- check �������� ����
INSERT into emp07 VALUES(1113, 'ȫ�浿', 3000, 'Q'); -- check �������� ����

-- 6. DEFAULT ��������
--    : default ���������� ������ �÷��� ���� �Էµ��� ������
--      default�� ������ ���� �ڵ����� �Էµȴ�.

drop table dept01 purge;

CREATE table dept01(
    deptno number(2) PRIMARY key,
    dname varchar2(14),
    loc VARCHAR2(13) default 'SEOUL');
    
SELECT * from dept01;

INSERT into dept01 VALUES(10, '������', '����');
INSERT into dept01(deptno, dname) VALUES(20, '���ߺ�');

----------------------------------------------------------------------

-- �������� ���� ���
-- 1. �÷����� ������� �������� ����
-- 2. ���̺��� ������� �������� ����

-- 1. �÷����� ������� �������� ����
drop table emp01 purge;

CREATE table emp01(
    empno NUMBER(4) primary key,
    ename varchar2(15) not null,
    job varchar2(10) UNIQUE,
    deptno number(4) REFERENCES dept(deptno));

SELECT * from emp01;

-- 2. ���̺��� ������� �������� ����
drop table emp02 purge;

CREATE table emp02(
    empno number(4),
    ename varchar2(15) not null,
    job VARCHAR2(10),
    deptno number(4),
    PRIMARY key(empno),
    unique(job),
    FOREIGN key(deptno) REFERENCES dept(deptno));
    
SELECT * from emp02;

-- ���� ������ ������ �� ���̺� ���� ��ĸ� ������ ���
-- 1. primary key(�⺻Ű) ���������� ����Ű�� �����ϴ� ���
-- 2. ALTER TABLE ������� ���������� �߰��� ���

-- 1. 2�� �̻��� �÷��� �⺻Ű�� ����
DROP TABLE member01 purge;

-- 1) �÷����� ������� 2���� �÷��� primary key�� ����
CREATE table member01(
    id VARCHAR2(20) PRIMARY key,
    password VARCHAR2(20) PRIMARY key); -- ���� �߻�

-- 2) ���̺��� ������� primary key�� ����Ű�� ����
CREATE table member01(
    id VARCHAR2(20),
    password VARCHAR2(20),
    PRIMARY key(id, password));
    
SELECT * from member01;

-- 2. alter table ������� ���������� �߰��ϴ� ���
drop table emp01 purge;

-- ���������� ���� ���̺� ����
CREATE table emp01(
    empno NUMBER(4),        -- primary key
    ename varchar2(15),     -- not null
    job varchar2(10),       -- unique
    deptno number(4));      -- foreign key

-- alter table ������� �������� �߰�
alter table emp01 add PRIMARY key(empno);
alter table emp01 modify ename not null;
alter table emp01 add unique(job);
alter table emp01 add CONSTRAINT emp01_deptno_fk 
FOREIGN key(deptno) REFERENCES dept(deptno);

-- alter table ������� �������� ����
-- alter table ���̺� �� drop constraint constraint_name
alter table emp01 drop constraint SYS_C007043;
alter table emp01 drop primary key; -- primary key ���������� �� ��ĵ� �����ϴ�.

alter table emp01 drop constraint SYS_C007045;
alter table emp01 drop unique(job); -- unique ���������� �� ��ĵ� �����ϴ�.

alter table emp01 drop CONSTRAINT SYS_C007044; -- not null

alter table emp01 drop CONSTRAINT EMP01_DEPTNO_FK; -- foreign key







