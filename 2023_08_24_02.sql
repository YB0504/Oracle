-- 2023_08_24(����)

-- ������̺�(EMP)���� �޿��� 3~5��°�� ���� �޴� �����
-- ����ϴ� SQL���� �ۼ� �ϼ���?
select rn, ename, sal from(SELECT rownum rn, ename, sal 
from (select * from emp
order by sal desc))
where rn between 3 and 5;

-----------------------------------------------------------------

-- �޿��� 3 ~ 5��° ���� �޴� ��� �˻�?
select rownum, ename, sal from (
    select * from emp order by sal desc)
where rownum >= 3 and rownum <=5;              -- �˻� �ȵ�

select rownum, ename, sal from ( 
    select rownum rnum, ename, sal from (   -- rownum �÷��� ��Ī �ο�  
    select * from emp order by sal desc) )
where rnum >=3 and rnum <=5;

-- �÷����� �����ϰ� ó��
select rnum, ename, sal, hiredate from (
    select rownum rnum, board.* from(
    select * from emp order by sal desc)  board) --���������� ��Ī �ο�
where rnum>=3 and rnum <= 5;
-- �÷����� ���� ��� �������� ��ü�� ��Ī�� �ο��ϰ� 
-- ��Ī��.*�� �ش��ϴ� ��� �÷��� �ڵ����� �����Ѵ�.




