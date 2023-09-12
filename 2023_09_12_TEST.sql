-- 2023_09_12 (TEST)

-- 1 ~ 10 ������ ���� �߿��� ¦���� ���� ���ϴ� PL/SQL�� �ۼ�
set serveroutput on
declare
    n number := 2;
    s number := 0;
begin
    loop
        s := s + n;
        n := n + 2;
        if n > 10 then
            exit;
        end if;
    end loop;
    dbms_output.put_line('1~10���� ¦���� �� : ' || s);
end;

-- ������̺� ���� �����ȣ�� �Ű������� �޾Ƽ� ��������� �����ϴ� ���ν����� �����ϰ�
-- ���ν����� ����
create or replace procedure del_empno(vempno in emp.empno%type)
is
begin
    delete from emp where empno = vempno;
end;

EXECUTE del_empno;

-- ��� ���̺��� SCOTT����� ������� ���ν����� �Ű������� �����ؼ�
-- SCOTT����� �޿��� ����ϴ� ���ν����� �����ϰ� ����
CREATE or replace PROCEDURE emp_sal(
    vename in emp.ename%type,
    vsal out emp.sal%type)
is
begin
    select sal into vsal from emp
    where ename = vename;
end;

VARIABLE var_sal NUMBER;

execute emp_sal('SCOTT', :var_sal);

-- ��� ���̺��� �����ȣ�� ���ν����� �Ű������� ���� �޾Ƽ�,
-- �� ����� �����, �޿�, �μ���ȣ�� ���ϴ� ���ν����� ���� ����
create or replace procedure emp_info(
    vempno in emp.vempno%type,
    vename out emp.ename%type,
    vsal out emp.sal%type,
    vdeptno out emp.deptno%type)
is
begin
    select ename, sal, deptno into vename, vsal, vdeptno from emp
    where empno = vempno;
end;

variable var_ename varchar2;
variable var_sal number;
variable var_deptno number;

execute emp_info(7788, :var_ename, :var_sal, :var_deptno);
















