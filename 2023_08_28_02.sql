-- 2023_08_28(��)

-- PL / SQL (Oracle's Procedural Language extention to SQL)

-- PL/SQL�� Hello World ���
set SERVEROUTPUT on -- serveroutputȯ�溯�� Ȱ��ȭ
begin               -- ����� ����
dbms_output.put_line('Hello World!!');
end;                -- ����� ��

-- dbms_output : ��Ű��
-- ��Ű�� = ���� ���ν��� + ���� �Լ�
-- put_line : ���� ���ν���

-- 1. ���� ����ϱ� : ��Į�� ���� ���
set SERVEROUTPUT on
DECLARE                             -- ����� ����
    vempno number(4);               -- ���� ���� : ��Į�� ����
    vename varchar2(15);
begin                               -- ����� ����
    vempno := 7788;                 -- ������ ���� �Ҵ�
    vename := 'SCOTT';
    dbms_output.put_line('��� / �̸�');
    dbms_output.put_line('--------------');
    dbms_output.put_line(vempno || ' / ' || vename); -- Concatenation ������
end;                                -- ����� ��

-- 1-1. ���� ����ϱ� : ���۷��� ���� ���
-- select���� �̿��Ͽ� �˻��� ������ ������ �Ҵ�
-- ����� �̸��� �˻��ϱ�
set serveroutput on
DECLARE
    vempno emp.empno%type;          -- ���� ���� : ���۷��� ����
    vename emp.ename%type;
begin                               -- select������ �˻��� ������ ������ �Ҵ�
    select empno, ename into vempno, vename from emp
    where ename = 'SCOTT';
    
    dbms_output.put_line('��� / �̸�');
    dbms_output.put_line(vempno || '/' || vename);
end;

----------------------------------------------------------------------------
    
-- ���ù�(���ǹ�)
-- 1. IF - THEN -END IF
-- ��� ���̺�(EMP)���� SCOTT����� �μ� ��ȣ�� �˻��ؼ�, 
-- �μ����� ����ϴ� PL/SQL�� �ۼ�

SET SERVEROUTPUT ON
DECLARE
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(20);
    VDEPTNO DEPT.DEPTNO%TYPE;
    VDNAME VARCHAR(20) := NULL;
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
















