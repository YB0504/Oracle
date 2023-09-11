-- 2023_09_11 GROUP BY
-- 0 ~ 23�ñ���, �� �ð��� ���� �Ծ��� �� �� �߻� �ߴ��� ��ȸ
-- ����� �ð��� �� ����
-- connect by level ���(���� ����)
select b.HOUR,count(a.HOUR) cnt
from (select to_char(datetime,'HH24') HOUR from animal_outs) a 
   , (select level-1 HOUR from dual connect by level <= 24) b
where b.HOUR=a.HOUR(+)
group by b.HOUR
order by b.HOUR;

-- ����
-- 1. a ���� �������� datetime �÷��� 24�ð� ���·� ��ȯ
-- 2. b ���� �������� dual���̺��� ����Ͽ� 1 ~ 24������ ���ڸ�
--    connect by level�� ����Ͽ� �����ϰ� 1�� �� ���� HOUR�� ��ȯ
-- 3. where������ b.HOUR�� 0 ~ 23������ �ð���, a.HOUR�� ���̺��� 
--    ������ ������ �Ծ�ð��븦 ��Ÿ����, (+)�� �ܺ������Ͽ�
--    count�Լ��� �� ���� ������ �����ϴ� �ð����� �Ծ� Ƚ���� �����´�.
-- 4. group by ������ b.HOUR�� �׷�ȭ�ؼ� ���ǿ� �´� �ð��븦 ��� �����Ѵ�.

-- connect by level
-- �������� �����͸� ǥ���ϱ� ���� SQL��
-- �ַ� Ʈ�� ������ �����͸� �ٷ� �� ����ϸ�, �θ� �ڽ� ������ �����͸�
-- ���������� �˻��ϰ� ǥ���ϴµ� ���δ�.
-- �ַ� start with ���� �Բ� �Ͽ��Ѵ�.
SELECT ...          -- �÷� ����
FROM table_name
START WITH condition    
-- ���� ������ �������� �����ϴ� ������ �����Ͽ� �ֻ��� �θ� ��带 �ĺ��Ѵ�.
CONNECT BY PRIOR column_name = parent_column_name;

-- ����
SELECT empno, ename, job, mgr, LEVEL
FROM emp
START WITH mgr IS NULL -- �ֻ��� ������ (PRESIDENT)���� ����
CONNECT BY PRIOR empno = mgr
ORDER BY empno;










