-- 2023_08_18(����)

--Q1. ��� ���̺�(EMP)���� ���� �ֱٿ� �Ի��� ������� ��� �ϴ� 
--           SQL���� �ۼ� �ϼ���?

SELECT ename, hiredate from emp where hiredate 
= (SELECT max(hiredate)from emp);

--     Q2. ��� ���̺�(EMP)���� �ִ� �޿��� �޴� ������ �ִ�޿�
--           �ݾ��� ����ϴ� SQL���� �ۼ� �ϼ���?

SELECT ename, sal from emp where sal
= (SELECT max(sal) from emp);

-- ���� �߻�( �Ϲ� �÷��� �׷� �Լ��� ���� �� �� ����.)
SELECT ename,  MAX(sal) from emp;