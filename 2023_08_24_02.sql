-- 2023_08_24(����)

-- ������̺�(EMP)���� �޿��� 3~5��°�� ���� �޴� �����
-- ����ϴ� SQL���� �ۼ� �ϼ���?
select rn, ename, sal from(SELECT rownum rn, ename, sal 
from (select * from emp
order by sal desc))
where rn between 3 and 5;





