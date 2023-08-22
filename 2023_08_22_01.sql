-- 2023_08_22(ȭ)

-- DDL(Data Definition Language) : ������ ���Ǿ�
-- CREATE : ���̺� ����
-- ALTER : ���̺� ���� ����
-- RENAME : ���̺� �̸� ����
-- DROP : ���̺� ����
-- TRUNCATE : ������ ����

-- ���̺� ���
SELECT * from tab;
SELECT * from user_tables;

-- 1. CREATE
--    �����ͺ��̽� ����, ���̺� ����
-- CREATE TABLE ���̺��( �÷���1, ������ Ÿ��1,
--                       �÷���2, ������ Ÿ��2,...)

-- * ���̺��,�÷��� ��� ��Ģ
-- 
-- 1. �ݵ�� ���ڷ� ���� �ؾ���.
-- 2. 1~30�� ���� ������.
-- 3. A~Z������ ��ҹ��ڿ� 0~9������ ����, 
--    Ư����ȣ�� (_, $, #)�� ������ �� ����.
-- 4. ����Ŭ���� ���Ǵ� ���� �ٸ� ��ü��� �ߺ��Ұ�
-- 5. ������� �ȵ�.

-- ����Ŭ�� ������ Ÿ��
-- 1) ���� ������
--    NUMBER(N) : ���� n�ڸ� ���� ����
--    NUMBER(N1, N2) : N1�� ��ü �ڸ���, N2�� �Ҽ��� ������ �ڸ���

-- 2) ���� ������
--    CHAR() : �������� ������
--             �ִ� 2000byte���� ���� ����
--    VARCHAR2() : �������� ������
--                 �ִ� 4000byte���� ���� ����
--    LONG : 2GB���� ���� ����
--           LONG������ ������ �÷��� �˻� ����� �������� �ʴ´�.

-- 3) ��¥ ������
--    DATE : ��, ��, ��
--    TIMESTAMP : ��, ��, ��, ��, ��, ��

-- ���̺� ����
-- 1) ���� ���̺� ����
CREATE table emp01( empno number(4), 
ename VARCHAR2(20), sal number(7,2));

SELECT * from tab; -- ���̺� ��� Ȯ��

-- 2) ���� ������ ���̺� ����
--    ���纻 ���̺��� �����ȴ�.
--    ���� ������ ���簡 ���� �ʴ´�.

-- ���纻 ���̺� ����
CREATE table emp02 as SELECT * from emp;

SELECT * from tab;
SELECT * from emp02;

-- ���ϴ� �÷����� ������ ���纻 ���̺� ����
CREATE table emp03 as SELECT empno, ename from emp;
SELECT * from emp03;

-- ���ϴ� ������ ������ ���纻 ���̺� ����
CREATE table emp04 as SELECT * from emp where deptno = 10;
SELECT * from emp04;

-- ���̺� ������ ����
CREATE table emp05 as SELECT * from emp where 1 = 0;
SELECT * from emp05;

-- 2. ALTER
--    : ���̺� ���� ���� (�÷��߰�, �÷�����, �÷�����)

-- �÷� �߰� : emp01 ���̺� job�÷� �߰�
alter TABLE emp01 add(job VARCHAR2(10));
desc emp01; -- ���̺� ���� Ȯ��
SELECT * from emp01;

-- �÷� ����
-- 1) ������ �÷��� �����Ͱ� ���� ���
--    �÷��� ������ Ÿ���� ������ �� �ִ�.
--    �÷��� ũ�⸦ ������ �� �ִ�.

-- EMP01 ���̺��� job�÷��� ũ�⸦ 10 -> 30 ���� ����
ALTER table emp01 MODIFY(job VARCHAR2(30));
desc emp01;

-- 2) ������ �÷��� �����Ͱ� �ִ� ���
--    �÷��� ������ Ÿ���� ������ �� ����.
--    �÷��� ũ�⸦ �ø����� ������, ����� ������ ũ�⺸�� 
--    ���� ũ��δ� ������ �� ����.

-- �÷� ����
alter table emp01 drop COLUMN job;
alter table emp01 drop(job);
desc emp01;

-- 3. RENAME
--    : ���̺� �̸� ����
-- RENAME OLD_NAME(���� ���̺��) TO NEW_NAME(������ ���̺��);

-- emp01 ���̺��� test ���̺������ �����ϴ� SQL�� �ۼ�
rename emp01 to test;
SELECT * from tab;
desc test;

-- 4. TRUNCATE
--    : ���̺��� ��� ������ ����
-- TRUNCATE table ���̺��;
TRUNCATE table emp02;
SELECT * from emp02;

-- 5. DROP
--    : ���̺� ����
-- DROP table ���̺��; (����Ŭ 10g �������ʹ� �ӽ� ���̺�� ��ü�ȴ�.)
-- DROP table ���̺�� purge;

-- test���̺��� �����ϴ� SQL�� �ۼ�
drop table test;
SELECT * from tab;

-- �ӽ� ���̺��� �����ϴ� SQL��
purge RECYCLEBIN;

-----------------------------------------------------------------------------

-- * ����Ŭ�� ��ü
--   ���̺�, ��, ������, �ε���, ���Ǿ�, ���ν���, Ʈ����

-- * ������ ��ųʸ��� ������ ��ųʸ� ��
--   ������ ��ųʸ��� ���ؼ� ���ٰ�����

-- ������ ��ųʸ� �� : user_xxxx(��ü���� ������)
--      (���� ���̺�)  all_xxxx
--		             dba_xxxx

-- ������ ��ųʸ�(�ý��� ���̺�) : 

-- SCOTT ���� ������ ���̺� ��ü�� ���� ������ �˻�
select * from tab;
select * from user_tables; --(���̺�)

select * from user_views; -- (��)

select * from seq;
select * from user_sequences; -- (������)

select * from user_indexes; -- (�ε���)

select * from user_synonyms; -- (���Ǿ�)

select * from user_source; -- (���ν���)

select * from user_triggers; -- (Ʈ����)

-- �ڱ� ���� ������ ������ ���ӹ��� ������ ��ü�� ���� ���� �˻�
select table_name from all_tables;

-- ������ ���̽� ������(DBA)�� ���� ������ ��ü�� ���� ���� �˻�
select table_name from dba_tables; -- (DBA ������ ��밡��)

-- ����Ŭ �ý����� ��� ���� ������ �˻�
select username from dba_users; -- (DBA ������ ��밡��)

















