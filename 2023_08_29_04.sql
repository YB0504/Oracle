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







