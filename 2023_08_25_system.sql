-- 2023_08_25(��)

-- �����ͺ��̽� ������ ���� ����

-- �ý��� ����
-- :  ������ ���̽� ������(DBA)�� ������ �ִ� ����
-- ex) create user, drop user...

-- �ý��� �����ڰ� �Ϲ� ����ڿ��� �ο��ؾ� �ϴ� ����
-- ex) create session : ������ ���̽� ���ӱ���
--     create table : ���̺��� ������ �� �ִ� ����
--     create view : �並 ������ �� �ִ� ����
--     create sequence : �������� ������ �� �ִ� ����
--     create procedure : ���ν����� ������ �� �ִ� ����

-- ���ο� ���� ���� : user01 / tiger
CREATE user user01 
IDENTIFIED by tiger;

-- ���� ��� Ȯ��
SELECT * from dba_users;

-- user01 �������� ������ ���̽� ���� ���� �ο�
grant create session to user01;

-- user01 �������� ���̺� ���� ���� �ο�
grant create session, create table to user01;

-- WITH ADMIN OPTION
-- : grant ������� ������ �ο� ���� �� with admin option�� �ٿ���
--   ������ �ο��Ǹ�, ������ �ο����� ������ �ڱⰡ �ο����� ������ �� 3�� ��������
--   �� �ο��� �� �ִ� ������ ������ �ȴ�.

-- 1) ���ο� ���� ���� : user02 / tigere
create user user02 
IDENTIFIED by tiger;

-- 2) �����ͺ��̽� ���� ���� �ο�
grant create session to user02 with admin option;

-- 3) �� 3�� ���� ����
create user user03 
IDENTIFIED by tiger;

-- 4) user01 �������� ���� �� user03�������� create session ���� �ο�
-- conn user01/tiger
-- grant create session to user03; -- ���� �߻�

-- 5) user02 �������� ���� �� user03�������� create session ���� �ο�
-- conn user02/tiger
-- grant create session to user03; -- ���� �ο� ����

-- 6) user03������ user02�������κ��� create session������ �ο��޾ұ� ������,
--    �����ͺ��̽� ������ �����ϴ�.

