-- 2023_08_29(ȭ)

-- ���� ���ν���

-- �ǽ�
drop table emp01 purge;
create table emp01 as SELECT * from emp;
SELECT * from emp01;

-- 1. �Ű� ������ ���� ���� ���ν��� ����
create or replace procedure del_all
is
begin
    delete from emp01;
end;

-- 2. ���ν��� ��� Ȯ��
select * from user_source;

-- 3. ���ν��� ����
exec del_all;
execute del_all;

-- 4. ���ν��� ���� Ȯ��
select * from emp01;    -- ���ν����� ���ؼ� �����Ͱ� ��� ������

-- 5. ������ ������ �ѹ�
ROLLBACK;
--------------------------------------------------------------------------

-- 1. �Ű� ������ �ִ� ���� ���ν��� ����
--    �Ű������� ��尡 in���� �Ǿ��ִ� ���ν���
--    in : �Ű� ������ ���� �޴� ����
create or replace procedure del_ename(vename in emp01.ename%type)
is
begin
    delete from emp01 where ename = vename;
end;

-- 2. ���ν��� ��� Ȯ��
select * from user_source;

-- 3. ���ν��� ����
exec del_ename('SCOTT');
execute del_ename('KING');
execute del_ename('SMITH');

-- 4. ���ν��� ���� Ȯ��
select * from emp01;

-- 5. ������ ������ �ѹ�
rollback;

-------------------------------------------------------------------------

-- �Ű� ������ ��尡 in, out���� �Ǿ��ִ� ���ν��� ����
-- in : �Ű� ������ ���� ���� �޴� ����
-- out : �Ű� ������ ���� �����ִ� ����

-- ���ν����� �Ű� ������ �����ȣ�� �����ؼ�, �� ����� ������
-- �޿�, ��å�� ����ϴ� ���ν��� ����

-- 1. ���ν��� ����
create or replace PROCEDURE sal_empno(
    vempno in emp.empno%type,           -- �����ȣ
    vename out emp.ename%type,          -- �����
    vsal out emp.sal%type,              -- �޿�
    vjob out emp.job%type)              -- ��å
is
begin
    select ename, sal, job into vename, vsal, vjob from emp
    where empno = vempno;
end;

-- 2. ���ν��� ��� Ȯ��
select * from user_source;

-- 3. ���ε� ���� ���� : ���ν����� ������ �� ����� �����޴� ����
VARIABLE var_ename varchar2(12);
VARIABLE var_sal NUMBER;
VARIABLE var_job varchar2(10);

-- 4. ���ν��� ����
EXECUTE sal_empno(7788, :var_ename, :var_sal, :var_job);
EXECUTE sal_empno(7839, :var_ename, :var_sal, :var_job);

-- 5. ���ε� ������ �������� �� ���
PRINT var_ename;
PRINT var_sal;
PRINT var_job;

-----------------------------------------------------------------------

-- �ڹ� ���α׷����� ���ν��� ����

-- ���� 1. �Ű� ������ ���� ���ν���
-- 1. ���ν��� ����
create or replace procedure del_all
is
begin
    delete from emp01;
end;

-- 2. emp01���̺� ����
drop table emp01 purge;
create table emp01 as select * from emp;
select * from emp01;

-- �ڹ� ���α׷����� ���ν��� ����
-- CallableStatementTest Ŭ����

-- �ڹٿ��� con.close()�Լ��� ���� ���Ḧ �Ͽ��� ������ �ѹ��� �Ұ��� �ϴ�.
rollback;

-- ���� 2. �Ű� ������ �ִ� ���ν���
-- ���� ������ emp01���̺� �����͸� �� �Է�
insert into emp01 SELECT * from emp;
select * from emp01;

-- 1. ���ν��� ����
create or replace PROCEDURE del_ename(
    vename in emp01.ename%type)
is
begin
    delete from emp01 where ename = vename;
end;

-- �ڹ� ���α׷����� ���ν��� ����
-- CallableStatementTest02 Ŭ����

-- 2. ���ν��� ���� Ȯ��
select * from emp01;

-- ���� 3. �Ű� ������ ��尡 in, out ��� �����ϴ� ���ν���
-- 1. ���� ���ν��� ����
create or replace PROCEDURE sel_customer(
    vname in customer.name%type,
    vemail out customer.email%type,
    vtel out customer.tel%type)
is
begin
    select email, tel into vemail, vtel from customer
    where name = vname;
end;

-- 2. ���ν��� ��� Ȯ��
select * from user_source;

select * from customer;

-- 3. ���ε� ���� ����
VARIABLE var_email varchar2(20);
VARIABLE var_tel varchar2(20);

-- 4. ���ν��� ����
EXECUTE sel_customer('ȫ�浿', :var_email, :var_tel);
EXECUTE sel_customer('����Ŭ', :var_email, :var_tel);
EXECUTE sel_customer('SQL', :var_email, :var_tel);

-- 5. ���ε� ������ ���� ��� ���
print var_email;
print var_tel;

-- �ڹ� ���α׷����� ���ν��� ����
-- CallableStatementTest03 Ŭ����

---------------------------------------------------------------------

-- ���� �Լ�
-- : ���� ���ν����� ����� ����������, ���� ����� �����ִ� ������ �Ѵ�.

-- ��� ���̺��� Ư�� ����� �޿��� 200% �λ��� ����� �����ִ� ���� �Լ� ����
-- 1. ���� �Լ�
create or replace FUNCTION cal_bouns(
    vempno in emp.empno%type)
    return number           -- ������ ���� �ڷ���
is
    vsal number(7,2);
begin
    select sal into vsal from emp
    where empno = vempno;
    RETURN vsal * 2;        -- �޿��� 200% �λ��� ����� �����ش�.
end;

-- 2. ���� �Լ� ��� Ȯ��
select * from user_source;

-- 3. ���ε� ���� ����
VARIABLE var_res number;

-- 4. ���� �Լ� ����
EXECUTE :var_res := cal_bouns(7788);
EXECUTE :var_res := cal_bouns(7900);

-- 5. ���ε� ������ �������� �� ���
print var_res;

-- ���� �Լ��� SQL���� ���Խ��Ѽ� ����
SELECT ename, sal, cal_bouns(7788) from emp
where empno = 7788;

SELECT ename, sal, cal_bouns(7900) from emp
where empno = 7900;




