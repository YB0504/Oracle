-- 2023_08_24(����)

-- ������̺�(EMP)���� �޿��� 3~5��°�� ���� �޴� �����
-- ����ϴ� SQL���� �ۼ� �ϼ���?
select rownum, ename, sal from(SELECT  ename, sal 
from (select ename, sal from emp
order by sal desc) where rownum <= 5 order by sal asc)
where rownum <= 3 order by sal desc;



















