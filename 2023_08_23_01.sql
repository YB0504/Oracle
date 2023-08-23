-- 2023_08_23(��)

-- Ʈ����� (Transaction)
-- 1. ������ �۾�����
-- 2. Ʈ������� DML SQL������ ���۵ȴ�.(insert, update, delete)
-- 3. ������ �ϰ����� �����ϸ鼭, �����͸� ���������� �����ϱ� ���ؼ� ���ȴ�.
-- 4. All - OR - Nothing ������� ó���ȴ�.

-- TCL(Transaction Control Language)
-- COMMIT : Ʈ������� ����
-- ROLLBACK : Ʈ������� ���
-- SAVEPOINT : ������ ����(������)�� �����ϴ� ����

-- �ǽ�
drop table dept01 purge;
CREATE table dept01 as select * from dept;
SELECT * from dept01;

-- 1. ROLLBACK : Ʈ������� ���
-- ���ο� Ʈ������� ���۵ǰ�, �޸𸮻󿡼��� delete�� ����ȴ�.
delete from dept01;

-- Ʈ������� ����ϱ� ������, �޸𸮻󿡼� ������ �����Ͱ� �����ȴ�.
ROLLBACK;
SELECT * from dept01;

-- 2. COMMIT : Ʈ������� ����
-- �޸� �󿡼� ó���� DML SQL���� ������ ���̽��� ������ �ݿ��ϰ� �ȴ�.
DELETE from dept01 where deptno = 20; -- �޸𸮻󿡼� 20�� ������ ����
commit; -- Ʈ����� ���� (�޸𸮻󿡼� ������ �����͸� DB�� �ݿ��ϰ� �����Ѵ�.)
ROLLBACK; -- Ʈ������� ����Ǿ��� ������ ������ 20�� �����ʹ� ������ �� ����.

-- �ڵ� Ŀ�� : �ڵ����� Ŀ���� ����Ǵ� ��
-- 1) �������� ���� : quit, exit, con.close()
-- 2) DDL(create, alter, rename, drop, truncate), DCL(grant, revoke)
--    ����� ����� ��

-- ��1. DDL ��ɾ� ����(create)
SELECT * from dept01;
DELETE from dept01 where deptno = 40; -- ���ο� Ʈ����� ����

CREATE table dept03 as SELECT * from dept;  -- �ڵ� Ŀ�� ����(DDL)
ROLLBACK;   -- ������ 40�� �����͸� �������� ���Ѵ�.

-- ��2. DDL ��ɾ� ����(truncate)
-- delete(DML) : ������ ���� ����
-- truncate(DDL) : ������ ���� �Ұ���

DELETE from dept01 where deptno = 30;
ROLLBACK;

TRUNCATE table dept01;  -- DDL(truncate) : �ڵ� Ŀ�� ����
rollback;               -- ������ �����͸� ������ �� ����.
SELECT * from dept01;

-- �ڵ� �ѹ� : �ڵ����� �ѹ��� ����Ǵ� ��
-- ������ ���̽��� ���������� ���ᰡ �Ǿ�����(������ â�� �ݰų�, ��ǻ�Ͱ� �ٿ�� ��)

-- 3. SAVEPOINT : �ӽ� �������� ������ �� ���

-- �ǽ�
drop table dept01 purge;

-- 1. dept01 ���̺� ����
CREATE table dept01 as select * from dept;
SELECT * from dept01;

-- 2. 40�� �μ� ����
DELETE from dept01 where deptno = 40;

-- 3. commit ���� : Ʈ����� ����
commit;

-- 4. 30�� �μ� ����
DELETE from dept01 where deptno = 30;

-- 5. c1 ������ ����
SAVEPOINT c1;

-- 6. 20�� �μ� ����
DELETE from dept01 where deptno = 20;

-- 7. c2 ������ ����
SAVEPOINT c2;

-- 8. 10�� �μ� ����
DELETE from dept01 where deptno = 10;

-- 9. ���������� ROLLBACK ����
SELECT * from dept01;
ROLLBACK to c2; -- 10�� �μ� ����
ROLLBACK to c1; -- 20�� �μ����� ����
ROLLBACK;       -- ���� Ʈ����� ���� ���ĸ� ���� 30�� �μ����� ����









