-- 2023_08_30(��)

-- ��Ű��(package) = �������ν����� �����Լ��� ���� ���� ��

-- ��Ű�� = ��Ű�� ��� + ��Ű�� �ٵ�

-- ��Ű�� ����
-- 1. ��Ű�� ��� ����
create or replace PACKAGE exam_pack
is
    function cal_bouns(vempno in emp.empno%type) -- �����Լ�
        return number;
    procedure cursor_sample02;                  -- ���� ���ν���
end;

-- 2. ��Ű�� �ٵ� ����
create or replace package body exam_pack
is
    -- ���� �Լ� : cal_bouns
    FUNCTION cal_bouns(vempno in emp.empno%type)
        return number           -- ������ ���� �ڷ���
    is
        vsal number(7,2);       -- ���� ����
    begin
        select sal into vsal from emp
        where empno = vempno;
        RETURN vsal * 2;        -- �޿��� 200% �λ��� ����� �����ش�.
    end;
    
    -- ���� ���ν��� : cursor_sample02
    PROCEDURE cursor_sample02
    is
        vdept dept%rowtype;         -- ���� ����
    
        CURSOR c1                   -- Ŀ�� ����
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
end;

-- 3. ���ν��� ����
execute exam_pack.cursor_sample02;

-- 4. ���� �Լ� ���� : cal_bouns()
-- ���ε� ���� ����
variable var_res number;

-- ���� �Լ� ����
execute :var_res := exam_pack.cal_bouns(7788);

-- ���ε� ������ ���� ��� ���
print var_res;

-- SQL������ �����Լ� ����
select ename, exam_pack.cal_bouns(7788) from emp
where empno = 7788;

--------------------------------------------------------------------------

-- Ʈ����(TRIGGER)
-- 1. Ʈ������ ������ �ǹ̴� ��Ƽ��� �ǹ̸� ������ �ִ�.
-- 2. Ʈ���Ŵ� �̺�Ʈ�� �߻����Ѽ�, ���������� �ٸ� �۾��� 
--    �ڵ����� ������ �� ����Ѵ�.
-- 3. �̺�Ʈ�� DML SQL���� �̿��Ͽ� �̺�Ʈ�� �߻���Ű��,
--    �� �� ���������� �����(begin~end)���� ������ �ڵ����� �����Ѵ�.

-- ������̺� ����� ��ϵǸ�, "���� ����� �Ի��߽��ϴ�." ���
-- �޽����� ����ϴ� Ʈ���Ÿ� ����

-- 1. ��� ���̺� ����
drop table emp01 purge;
create table emp01(
    empno number(4) primary key,
    ename varchar2(20),
    job varchar2(20));
    
select * from tab;

-- 2. Ʈ���� ����
create or replace trigger trg_01
    after insert on emp01           -- �̺�Ʈ �߻�
begin
    dbms_output.put_line('���� ����� �Ի��߽��ϴ�.');
    
end;

-- 3. Ʈ���� ���Ȯ��
select * from user_triggers;

-- 4. �̺�Ʈ �߻� : emp01���̺� ȸ������(������ �Է�);
set serveroutput on
insert into emp01 values(1111, 'ȫ�浿', '������');
insert into emp01 values(1112, 'ȫ�浿', '������');
insert into emp01 values(1113, 'ȫ�浿', '������');
insert into emp01 values(1114, 'ȫ�浿', '������');

select * from emp01;

commit;

-- ������̺�(emp01)�� ���� ����� ��ϵǸ�, �޿� ���̺�(sal01)�� �޿� ������
-- �ڵ����� �߰� ���ִ� Ʈ���� ����

-- 1. ��� ���̺� : emp01
-- 2. �޿� ���̺� ���� : sal01
create table sal01(
    salno number(4) primary key,
    sal number(7,2),
    empno number(4) references emp01(empno)); -- �ܷ�Ű

select * from sal01;

-- 3. ������ ����
create sequence sal01_salno_seq; -- 1���� �ڵ����� 1�� �����Ǵ� ������ ����

select * from seq;

-- 4. Ʈ���� ����
-- :new.�÷��� : insert, update���� �̿��ؼ� �̺�Ʈ�� �߻��� ���
-- :old.�÷��� : delete���� �̿��ؼ� �̺�Ʈ�� �߻��� ���
create or replace trigger trg_02
    after insert on emp01           -- �̺�Ʈ �߻�
    for each row                    -- �� ���� Ʈ����
begin
    insert into sal01 VALUES(sal01_salno_seq.nextval, 300, :new.empno);
end;

-- 5. Ʈ���� ��� Ȯ��
select * from user_triggers;

-- 6. �̺�Ʈ �߻� : emp01���̺� ��� ���
insert into emp01 VALUES(1111, 'ȫ�浿', '������');
insert into emp01 VALUES(1112, 'ȫ�浿', '������');
insert into emp01 VALUES(1113, 'ȫ�浿', '������');

-- 7. ������ Ȯ��
select * from emp01;
select * from sal01;    -- Ʈ���ſ� ���ؼ� �ڵ����� ���

---------------------------------------------------------------------------

-- ��� ���̺��� ����� �����Ǹ� �޿� ������ �ڵ����� �����ϴ� Ʈ���� ����

-- �����ϴ� �ܷ�Ű�� �ֱ� ������ �θ� ���̺��� �����͸� ������ �� ����.
delete from emp01 where empno = 1111; -- ���� �ȵ�

-- 1. Ʈ���� ����
-- :new.�÷��� : insert, update���� �̿��ؼ� �̺�Ʈ�� �߻��� ���
-- :old.�÷��� : delete���� �̿��ؼ� �̺�Ʈ�� �߻��� ���
create or replace trigger trg_03
    after delete on emp01           -- �̺�Ʈ �߻�
    for each row                    -- �� ���� Ʈ����
begin
    delete from sal01 where empno = :old.empno;
end;

-- 2. Ʈ���� ��� Ȯ��
select * from user_triggers;

-- 3. �̺�Ʈ �߻�
-- : ��� ���̺��� �����ȣ 1111�� ����� �����ϸ�, ����������
--   �޿� ���̺��� �޿� ������ ���� �����ȴ�.
delete from emp01 where empno = 1111;
delete from emp01 where empno = 1112;
delete from emp01 where empno = 1113;

-- 4. ��� Ȯ��
select * from emp01;
select * from sal01;
