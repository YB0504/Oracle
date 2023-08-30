-- 2023_08_29(����)
-- Q1. ����ǿ� ���� �Ի��� ������� ���ο� ������ ������ �ַ��� 
--          �մϴ�. �Ʒ��� �䱸 ������ �����ϴ� SQL���� ���� �ۼ� 
--          �ϼ��� ? 
--   [�䱸1] USER�� : woman, �н����� : tiger 
create user woman
IDENTIFIED by tiger;

--   [�䱸2] CREATE SESSION �̶�� �ý��� ������ �ο��� �ݴϴ�. 
--	(��, �� �ٸ� �������Ե� ������ �� �� �ֵ��� 
--	      WITH ADMIN OPTION�� �ο��մϴ�). 
grant create session to woman with admin option;

--   [�䱸3] woman�������� connect, resource, dba ������ �ο��մϴ�.

grant connect, resource, dba to woman;

--   Q2. user01 ������ ���� �ϼ���? (��й�ȣ: tiger)
drop user user01;
create user user01
identified by tiger;

--   Q3. user01 �������� ����Ŭ ������ ���̽��� �����ؼ�, ���̺��� 
--        ������ �� �ִ� ������ �ο��Ͻÿ�.
grant create session, create table to user01;

----------------------------------------------------------------------

-- ������ �ڵ�

Ans 1. SQL> create user woman identified by tiger;

       SQL> grant create session to woman with admin option;

       SQL> grant connect, resource, dba to woman;


Ans 2. SQL> create user user01 identified by tiger;


Ans 3. SQL> grant create session, create table to user01;









