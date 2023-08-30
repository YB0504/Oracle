-- 2023_08_29(����)

-- ��� ���̺��� ������� �˻��Ͽ� ����� ������ ���ؿ��� 
-- ���� ���ν����� ���� �����ϼ���?

create or REPLACE PROCEDURE sel_job(
    vename in emp.ename%type,
    vjob out emp.job%type)
is
begin
    select job into vjob from emp
    where ename = vename;
end;

VARIABLE var_job varchar2(10);

EXECUTE sel_job('SCOTT', :var_job);

print var_job;

-----------------------------------------------------------------

-- ������ �ڵ�

--1. ���� ���ν��� ����
create or replace procedure ename_job(
        vename in emp.ename%type,
        vjob out emp.job%type)
is
begin
    select job into vjob from emp where ename = vename;
end;

--2. ���ν��� ��� Ȯ��
select * from  user_source;

--3. ���ε� ���� ����
variable var_job varchar2(10);

--4. ���ν��� ����
execute ename_job('SCOTT', :var_job); 
execute ename_job('KING', :var_job); 
execute ename_job('SMITH', :var_job); 

--5. ���ε� ������ ���� �� ���
print var_job;





