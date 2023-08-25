-- 2023_08_25(��)

-- ��ü ����
-- ����Ŭ�� ��ü : ���̺�, ��, ������, �ε���, ���Ǿ�, ���ν���, Ʈ����

-- 1. ���� ������ user01 �������� scott���� ������ emp���̺� ��ü�� ����
--    select ��ü ������ �ο�
conn scott/tiger
grant select on emp to user01;

-- 2. user01 �������� ���� �� emp���̺� ��ü�� ���ؼ� select�� ����
conn user01/tiger
select * from emp;          -- ���� �߻�
select * from scott.emp;    -- �˻� ����
-- ��� ������Ʈ â�� �Է��Ͽ� �����Ͽ��� �Ѵ�.

-- 3. ��ü ���� ���
REVOKE SELECT ON emp FROM user01;
select * from scott.emp; -- ��ü ������ ��� �Ǿ��� ������ ���� �߻�

-- WITH GRANT OPTION
-- : user02 �������� scott ���� ������ emp���̺� ��ü�� ���ؼ� select��ü
--   ������ �ο��� �� with grant option�� �ٿ��� ������ �ο��Ǹ�, user02������
--   �ڱⰡ �ο����� ������ �� 3�� ����(user01)���� �� �ο��� �� �ִ�.

-- 1. user02�������� scott ������ emp ���̺� ��ü�� ���� select ��ü ���� �ο�
grant select on emp to user02 with grant option;

-- 2. user02 �������� ���� ��, �ο� ���� ��ü ������ user01���� �� �ο�
select * from scott.emp;
grant select on scott.emp to user01;

-- 3. user01�������� ���� �� scott.emp �˻�
-- SQL> conn user01/tiger
-- Connected.
-- SQL> select * from scott.emp;
