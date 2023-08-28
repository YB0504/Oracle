-- 2023_08_28(��)

-- ����� ���� �� ���� : �ѿ� ��ü ������ �ο�
-- 1. ���ο� �� ����
conn system / oracle
create role mrole02;

-- 2. ������ �ѿ� ��ü ������ �ο�
conn scott / tiger
grant select on emp to mrole02;

-- 3. user05 �������� mrloe02 �ο�
conn system / oracle
grant mrole02 to user05;

-- 4. user05 �������� ���� �� �˻�
conn user05 / tiger
select * from scott.emp;

---------------------------------------------------------------------

-- �� ȸ�� : Ư�� �������� �ο��� ���� ����ϴ� ��
-- revoke �� �̸� from ������

-- user05 �������� �ο��� mrole�� mrole02 ���� ȸ��
conn system / oracle
revoke mrole, mrole02 from user05; 

-- �� ����
-- drop role �� �̸�
conn system / oracle
drop role mrole;
drop role mrole02;

-------------------------------------------------------------------------

-- ����� ���� �ѿ� �ý��� ���Ѱ� ��ü������ ��� �ο�
-- ����Ʈ ���� �����Ͽ� ���� ����ڿ��� �� �ο�
-- ����Ʈ �� = �ý��� ���� + ��ü ����

-- 1. ����Ʈ �� ����
conn system / oracle
create role def_role;

-- 2. �ѿ� �ý��� ���� �ο�
conn system / oracle
grant create session, create table to def_role;

-- 3. �ѿ� ��ü ���� �ο�
conn scott / tiger
grant select on emp to def_role;
grant UPDATE on emp to def_role;
grant delete on emp to def_role;

-- 4. ���� �ο��� ���� ����
conn system / oracle
create user usera1
identified by tiger;

create user usera2
identified by tiger;

create user usera3
identified by tiger;

-- 5. ������ ������ �� �ο�
conn system / oracle
grant def_role to usera1;
grant def_role to usera2;
grant def_role to usera3;

-- 6. ������ �� ������ ���� �� �˻�
conn usera1 / tiger
conn usera2 / tiger
conn usera3 / tiger
select * from scott.emp;

----------------------------------------------------------------

-- ���Ǿ�(synonym) : ���� �ǹ̸� ���� �ܾ�
-- 1. �� ���� ���Ǿ�
--    : ��ü�� ���� ���� ������ �ο����� ����ڰ� ������ ���Ǿ�ν� 
--      ���Ǿ ���� ����ڸ� ����� �� �ִ�.

-- 2. ���� ���Ǿ�(���� ���Ǿ�)
--    : DBA������ ���� ����ڸ� ������ �� ������ ������ ��� �����ϴ�.

-- ���� ���Ǿ��� ��
-- sys.tab -> tab ( select * from tab; )
-- sys.seq -> seq ( select * from seq; )
-- sys.dual -> dual ( select 10 + 20 from dual; )

---------------------------------------------------------------------

-- �� ���� ���Ǿ��� ��
-- CREATE SYNONYM ���Ǿ� �̸� FOR ������ . ��ü��
-- 1. system �������� ���� �� ���̺� ����
conn system / oracle
create table systbl(ename varchar2(20));

-- 2. ������ ���̺� ������ �Է�
insert into systbl values('ȫ�浿');
insert into systbl values('����Ŭ');

select * from systbl;

-- 3. scott�������� systbl ���̺� ���� select��ü ���� �ο�
conn system / oracle
grant select on systbl to scott;

-- 4. scott �������� ���� �� �˻�
conn scott / tiger
select * from systbl; -- ���� �߻�
select * from system.systbl; -- �������� �˻� ����

create synonym systbl for system.systbl; -- ���Ǿ ���� �� �ִ� ���� X ���� �߻�

-- 5. scott �������� ���Ǿ� ���� ���� �ο�
conn system / oracle
grant create synonym to scott; 

-- 6. �� ���� ���Ǿ� ����
conn scott / tiger
create synonym systbl for system.systbl;

-- 7. ���Ǿ� ��� Ȯ��
conn scott / tiger
select * from user_synonyms;

-- 8. ���Ǿ �̿��Ͽ� �˻�
conn scott / tiger
select * from systbl;

-- 9. �� ���� ���Ǿ� ����
-- drop synonym ���Ǿ� �̸�
conn scott / tiger
drop SYNONYM systbl;

-- ���� ���Ǿ� ����
-- 1. DBA �������� �����Ͽ� ���� ���Ǿ� ����
-- 2. CREATE [PUBLIC] SYNONYM ���Ǿ� �̸� FOR ������ . ��ü��

