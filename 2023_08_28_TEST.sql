-- 2023_08_28(TEST)

-- [����1] ��� ���̺�(EMP)����  SCOTT�� �޿����� ���� �޴� ����� �̸�, 
--        �޿��� ����ϴ� SQL���� �ۼ��Ͻÿ�? (10��)
select ename, sal from emp
where sal < (select sal from emp where ename = 'SCOTT');

-- [����2] ��� ���̺�(EMP)���� �� �μ��� ��� �޿��� ���ϴ� SQL���� �ۼ��Ͻÿ�? (10��)
select deptno, avg(sal)as sal from emp
group by deptno order by deptno;

-- [����3] ������̺�(EMP)����  ����� A�� ���Ե� ����� 
--        �˻��ϴ� SQL���� �ۼ��Ͻÿ�? (10��)
select ename from emp where ename like '%A%';

-- [����4] ������̺�(EMP)���� �޿��� ���� �޴� ���  
--        5���� ���ϴ� SQL���� �ζ��κ�� �ۼ��Ͻÿ�? (10��)
select ename, sal
from (select * from emp order by sal desc)
where ROWNUM <= 5;

-- [����5] ������̺�(EMP)���� 82�⵵�� �Ի��� 
--        ��� ����� ������ ����ϴ� SQL���� �ۼ��Ͻÿ�? (10��)
select * from emp where to_char(hiredate, 'yy') = '82';

-- [����6] ������̺�(EMP)���� ���, �̸�, �޿�, ������ ��ȸ�ϴ� SQL������ �ۼ��Ͻÿ�?
--        ��, ������ ��Ī�� ����ϰ�, comm�� null���� ��쿡�� 0���� ���� ó���Ͻÿ�.
SELECT empno, ename, sal, sal*12 + nvl(comm, '0') as ����
from emp;

-- [����7]  �Ʒ��� �������� �䱸�ϴ� SQL���� ���� �ۼ��Ͻÿ�?  (10��)
-- 1) �Ʒ��� ������ ����ǿ� �Ի��� ���Ի������ ���ο� ������ �����Ͻÿ�.
--    ������ : myuser ,  ��й�ȣ : tiger
-- 2) ������ �������� ������ ���� �� ���̺�, �並 ������ �� �ִ� ������ 
--    ���� ��(role)�� �����ؼ� ������ �ο��Ͻÿ�.
create user myuser
identified by tiger;

create role user_role;

grant create session, create table, create view to user_role;

grant user_role to myuser;

-- [����8]  �Ʒ��� ������ ���� ���������� �����ϴ� ���̺��� ���� �ۼ��Ͻÿ�? (30��)
create table Book(
    bookid number(2) primary key,
    bookname varchar2(40),
    publisher varchar2(40),
    price number(8));

drop table Book purge;
    
create table Customer1(
    custid number(2) primary key,
    name varchar2(40),
    address varchar2(40),
    phone varchar2(20));
    
drop table Customer1 purge;
    
create table Orders(
    orderid number(2) primary key,
    custid number(2) references Customer1(custid),
    bookid number(2) references Book(bookid),
    saleprice number(8),
    orderdate date default sysdate);

drop table Orders purge;










