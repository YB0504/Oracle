-- 2023_08_29(ȭ)

-- ���ù�(���ǹ�)
-- 1. IF - THEN - END IF
-- ��� ���̺�(EMP)���� SCOTT����� �μ� ��ȣ�� �˻��ؼ�, 
-- �μ����� ����ϴ� PL/SQL�� �ۼ�

SET SERVEROUTPUT ON
DECLARE
    VEMPNO NUMBER(4);               -- �����ȣ
    VENAME VARCHAR2(20);            -- �����
    VDEPTNO DEPT.DEPTNO%TYPE;       -- �μ���ȣ
    VDNAME VARCHAR(20) := NULL;     -- �μ���
BEGIN
    SELECT EMPNO, ENAME, DEPTNO INTO VEMPNO, VENAME, VDEPTNO
    FROM EMP WHERE ENAME = 'SCOTT';
    
    IF VDEPTNO = 10 THEN VDNAME := 'ACCOUNTING';
    END IF;
    
    IF VDEPTNO = 20 THEN VDNAME := 'RESEARCH';
    END IF;
    
    IF VDEPTNO = 30 THEN VDNAME := 'SALES';
    END IF;
    
    IF VDEPTNO = 50 THEN VDNAME := 'OPERATIONS';
    END IF;

    dbms_output.put_line('���  /  �̸�  / �μ���');
    dbms_output.put_line(VEMPNO || ' / ' || VENAME || ' / ' || VDNAME);
END;

-- ������̺��� SCOTT����� ������ ���ϴ� PL/SQL���� �ۼ�
set SERVEROUTPUT on
DECLARE
    -- %rowtype : emp���̺��� 8�� Į���� �ڷ����� ��� �����Ѵٴ� �ǹ�
    vemp emp%rowtype;           -- ���۷��� ����
    annsal number(7,2);         -- ��Į�� ����
begin
    select * into vemp from emp
    where ename = 'SCOTT';
    
    if vemp.comm is null
    then vemp.comm := 0;
    end if;
    
    annsal := vemp.sal * 12 + vemp.comm;
    dbms_output.put_line('���  /  �̸�  /  ����');
    dbms_output.put_line(vemp.empno || ' / ' || vemp.ename || ' / ' || annsal);
end;

-- 2. IF - THEN - ELSE -END IF
-- ��� ���̺��� SCOTT����� ������ ���ϴ� PL/SQL�� �ۼ�
SET SERVEROUTPUT ON
DECLARE
    VEMP EMP%ROWTYPE;
    ANNSAL NUMBER(7,2);
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';
    IF VEMP.COMM IS NULL
    THEN ANNSAL := VEMP.SAL * 12;
    ELSE ANNSAL := VEMP.SAL * 12 + VEMP.COMM;
    END IF;
    
    dbms_output.put_line('���  /  �̸�  /  ����');
    dbms_output.put_line(vemp.empno || ' / ' || vemp.ename || ' / ' || annsal);
END;

-- 3. IF - THEN - ELSIF - ELSE - END IF
-- SCOTT����� �μ���ȣ�� �̿��ؼ� �μ����� ���ϴ� PL/SQL�� �ۼ�
set serveroutput on
declare
    vemp emp%rowtype;
    vdname VARCHAR2(14);
begin
    select * into vemp from emp where ename = 'SCOTT';
    if vemp.deptno = 10 then vdname := 'ACCOUNTING';
    elsif vemp.deptno = 20 then vdname := 'RESEARCH';
    elsif vemp.deptno = 30 then vdname := 'SALES';
    elsif vemp.deptno = 40 then vdname := 'OPERATIONS';
    end if;
    
    dbms_output.put_line('���  /  �̸�  /  �μ���');
    dbms_output.put_line(vemp.empno || ' / ' || vemp.ename || ' / ' || 
    vdname);
end;

------------------------------------------------------------------------------

-- �ݺ���
-- 1. BASIC LOOP
-- LOOP �ݺ� ����� ���� ���ǽ� EXIT END LOOP

-- basic loop ������ 1 ~ 5���� ���
set SERVEROUTPUT on
declare
    n number := 1;          -- n������ �ʱⰪ�� 1�� ����
begin
    loop
        dbms_output.put_line(n);
        n := n + 1;
        if n > 5 then
            exit;           -- loop���� �������´�.
        end if;
    end loop;
end;

-- 1 ~ 10���� ���� ���ϴ� PL/SQL�� �ۼ�
set serveroutput on
declare
    n number := 1;          -- ������ ���� ����
    s number := 0;        -- ���� ������ ����
begin
    loop
        s := s + n;
        n := n + 1;
        if n > 10 then
            exit;
        end if;
    end loop;
    dbms_output.put_line('1 ~ 10������ �� : ' || s);
end;

-- 2. FOR LOOP
--    FOR ���� IN [REVERSE] ������..ū�� LOOP
--    �ݺ� ����� ����
--    END LOOP;

-- FOR LOOP������ 1���� 5���� ���
set serveroutput on
begin
--  for n in 1..5 loop          -- �ڵ����� 1�� ����
    for n in reverse 1..5 loop  -- �ڵ����� 1�� ����
        dbms_output.put_line(n);
    end loop;
end;
    
-- for loop���� �̿��ؼ� �μ����̺��� ��� ������ ���
set serveroutput on
DECLARE
    vdept dept%rowtype;
begin
    dbms_output.put_line('�μ���ȣ  /  �μ���  /  ������');
    for cnt in 1..4 loop
        select * into vdept from dept where deptno = 10 * cnt;
        dbms_output.put_line(vdept.deptno || ' / ' ||
        vdept.dname || ' / ' || vdept.loc);
    end loop;
end;

-- 3. WHILE LOOP
-- WHILE ���ǽ� LOOP �ݺ� ����� ���� END LOOP
-- ���ǽ��� ���̸� ������ ����ǰ� �����̸� ������� �ʴ´�.

-- while loop ������ 1 ~ 5���� ���
set SERVEROUTPUT on
DECLARE
    n number := 1;
begin
    while n <= 5 loop
        dbms_output.put_line(n);
        n := n + 1;
    end loop;
end;

-- whlie loop������ ��(*)�� �ﰢ�� ������� ���
set serveroutput on
DECLARE
    c number := 1;
    s varchar2(100) := '';
begin
    while c <= 10 loop
        s := s || '*';
        dbms_output.put_line(s);
        c := c + 1;
    end loop;
end;






