-- 2023_08_17(����)

-- ������̺�(EMP)���� �Ի���(HIREDATE)�� 4�ڸ� ������ ��� 
-- �ǵ��� SQL���� �ۼ��ϼ���? (ex. 1980/01/01)
SELECT hiredate, to_char(hiredate, 'yyyy"��"mm"��"dd"��"')"�Ի� ��"from emp;

-- ������̺�(EMP)���� MGR�÷���  ����  null �� �������� MGR�� 
-- ����  CEO ��  ����ϴ� SQL���� �ۼ� �ϼ���?
select * from emp;
select ename, job, nvl(to_char(mgr, '0'),'CEO')
as "���" from emp where mgr is null;

-- �ܰ躰 ����
-- null �� �˻�
SELECT * FROM emp where mgr is NULL;
-- nvl�Լ��� �̿��ؼ� null���� �ٸ� ������ ġȯ
SELECT nvl(mgr, 0) from emp where mgr is null;
SELECT nvl(mgr, 'CEO') from emp where mgr is null; -- ���� �߻�
-- ���� ������ ������ ġȯ�� NULL���� CEO�� ��ȯ
SELECT nvl(to_char(mgr, '9999'), 'CEO')
as "MANAGER" from emp where mgr is null;


