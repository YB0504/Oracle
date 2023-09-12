-- 2023_09_12 (TEST)

-- 1 ~ 10 사이의 정수 중에서 짝수의 합을 구하는 PL/SQL문 작성
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
    dbms_output.put_line('1~10까지 짝수의 합 : ' || s);
end;

-- 사원테이블 에서 사원번호를 매개변수로 받아서 사원정보를 삭제하는 프로시저를 생성하고
-- 프로시저를 실행
create or replace procedure del_empno(vempno in emp.empno%type)
is
begin
    delete from emp where empno = vempno;
end;

EXECUTE del_empno;

-- 사원 테이블에서 SCOTT사원의 사원명을 프로시저의 매개변수로 전달해서
-- SCOTT사원의 급여를 출력하는 프로시저를 생성하고 실행
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

-- 사원 테이블에서 사원번호를 프로시저의 매개변수로 전달 받아서,
-- 그 사원의 사원명, 급여, 부서번호를 구하는 프로시저를 생성 실행
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
















