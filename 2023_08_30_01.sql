-- 2023_08_30(��)

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

-- ��� ���̺��� ������� �����Լ��� �Ű������� �����Ͽ� �ش� ����� ������ ���
create or replace FUNCTION job_emp(
    vename in emp.ename%type)
    return varchar2             -- ������ ���� �ڷ���
is
    vjob emp.job%type;          -- ���ú��� ����(��������� �˻��� ����� job����)
begin
    select job into vjob from emp
    where ename = vename;
    return vjob;
end;

-- �����Լ� ��� Ȯ��
select * from user_source;

-- ���ε� ���� ����
variable var_job varchar2(10);

-- ���� �Լ� ����
execute :var_job := job_emp('SCOTT');

-- ���� �Լ� ���
print var_job;

-- �����Լ��� SQL���� �����ؼ� ����
select ename, job_emp('SCOTT') from emp where ename = 'SCOTT';

---------------------------------------------------------------------

-- Ŀ��(CURSOR)
-- : 2�� �̻��� �����͸� ó���� �� Ŀ���� ����Ѵ�.

-- �μ����̺��� ��� �����͸� ����ϱ� ���� PL/SQL�� �ۼ�
-- 1. ���� ���ν��� ����
set serveroutput on
create or replace procedure cursor_sample01
is
    vdept dept%rowtype;     -- ���ú��� ����
    
    cursor c1               -- Ŀ�� ����
    is
    select * from dept;
begin
    dbms_output.put_line('�����ȣ  /  �μ���  /  ������');
    dbms_output.put_line('-----------------------------------');
    
    open c1;                -- Ŀ�� ����(ù��° �����͸� �����´�.)
        loop   
            fetch c1 into vdept.deptno, vdept.dname, vdept.loc; -- ����
                exit when c1%notfound;  -- Ŀ���� ������ ���� ������ true
                dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'
                ||vdept.loc);
        end loop;
    close c1;
end;

-- 2. ���ν��� ��� Ȯ��
select * from user_source;

-- 3. ���ν��� ����
execute cursor_sample01;

---------------------------------------------------------------------------

-- �μ����̺��� ��� �����͸� ����ϱ� ���� PL/SQL�� �ۼ�
-- FOR LOOP�� ���� ó��
-- 1. OPEN - FETCH - CLOSE ���� ó�� ����
-- 2. FOR LOOP���� ����ϰ� �Ǹ� �� �ݺ�������, CURSOR�� ����,
--    �� ���� �����ϰ� , �ݴ� ������ �ڵ����� ó���Ѵ�.

-- 1. ���� ���ν��� ����
create or replace PROCEDURE cursor_sample02
is
    vdept dept%rowtype;         -- ���� ����
    
    CURSOR c1
    is
    select * from dept;
begin
    dbms_output.put_line('�μ���ȣ  /  �μ���  /  ������');
    dbms_output.put_line('----------------------------');
    
    for vdept in c1 loop
        dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'
        ||vdept.loc);
        exit when c1%notfound;  -- Ŀ���� ���̻� ������ ���� ���� �� true
    end loop;
end;

-- 2. ���ν��� ��� Ȯ��
select * from user_source;

-- 3. ���ν��� ����
execute cursor_sample02;

-- ������̺��� �μ���ȣ�� �����Ͽ� �ش� �μ��� �Ҽӵ� ����� ������ ���
-- 1. ���� ���ν��� ����
create or replace PROCEDURE info_emp(vdeptno in emp.deptno%type)
is
    vemp emp%rowtype;      -- ���� ����
    cursor c1
    is
    select * from emp where deptno = vdeptno;
begin
    dbms_output.put_line('�μ���ȣ / �����ȣ / ����� / ���� / �޿�');
    dbms_output.put_line('----------------------------------------');
    
    for vemp in c1 loop
    dbms_output.put_line(vemp.deptno||'/'||vemp.empno||'/'||vemp.ename
                         ||'/'||vemp.job||'/'||vemp.sal);
    exit when c1%notfound;
    end loop;

end;
    
-- 2. ���ν��� ��� Ȯ��
select * from user_source;

-- 3. ���ν��� ����
execute info_emp(40);

