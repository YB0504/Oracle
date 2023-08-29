-- 2023_08_29(화)

-- 저장 프로시저

-- 실습
drop table emp01 purge;
create table emp01 as SELECT * from emp;
SELECT * from emp01;

-- 1. 매개 변수가 없는 저장 프로시저 생성
create or replace procedure del_all
is
begin
    delete from emp01;
end;

-- 2. 프로시저 목록 확인
select * from user_source;

-- 3. 프로시저 실행
exec del_all;
execute del_all;

-- 4. 프로시저 실행 확인
select * from emp01;    -- 프로시저에 의해서 데이터가 모두 삭제됨

-- 5. 삭제된 데이터 롤백
ROLLBACK;
--------------------------------------------------------------------------

-- 1. 매개 변수가 있는 저장 프로시저 생성
--    매개변수의 모드가 in으로 되어있는 프로시저
--    in : 매개 변수로 값을 받는 역할
create or replace procedure del_ename(vename in emp01.ename%type)
is
begin
    delete from emp01 where ename = vename;
end;

-- 2. 프로시저 목록 확인
select * from user_source;

-- 3. 프로시저 실행
exec del_ename('SCOTT');
execute del_ename('KING');
execute del_ename('SMITH');

-- 4. 프로시저 실행 확인
select * from emp01;

-- 5. 삭제된 데이터 롤백
rollback;

-------------------------------------------------------------------------

-- 매개 변수의 모드가 in, out으로 되어있는 프로시저 생성
-- in : 매개 변수로 값을 직접 받는 역할
-- out : 매개 변수로 값을 돌려주는 역할

-- 프로시저의 매개 변수로 사원번호를 전달해서, 그 사원의 사원명과
-- 급여, 직책을 출력하는 프로시저 생성

-- 1. 프로시저 생성
create or replace PROCEDURE sal_empno(
    vempno in emp.empno%type,           -- 사원번호
    vename out emp.ename%type,          -- 사원명
    vsal out emp.sal%type,              -- 급여
    vjob out emp.job%type)              -- 직책
is
begin
    select ename, sal, job into vename, vsal, vjob from emp
    where empno = vempno;
end;

-- 2. 프로시저 목록 확인
select * from user_source;

-- 3. 바인드 변수 생성 : 프로시저를 실행할 때 결과를 돌려받는 변수
VARIABLE var_ename varchar2(12);
VARIABLE var_sal NUMBER;
VARIABLE var_job varchar2(10);

-- 4. 프로시저 실행
EXECUTE sal_empno(7788, :var_ename, :var_sal, :var_job);
EXECUTE sal_empno(7839, :var_ename, :var_sal, :var_job);

-- 5. 바인드 변수로 돌려받은 값 출력
PRINT var_ename;
PRINT var_sal;
PRINT var_job;

-----------------------------------------------------------------------

-- 자바 프로그램으로 프로시저 실행

-- 예제 1. 매개 변수가 없는 프로시저
-- 1. 프로시저 생성
create or replace procedure del_all
is
begin
    delete from emp01;
end;

-- 2. emp01테이블 생성
drop table emp01 purge;
create table emp01 as select * from emp;
select * from emp01;

-- 자바 프로그램에서 프로시저 실행
-- CallableStatementTest 클래스

-- 자바에서 con.close()함수로 정상 종료를 하였기 때문에 롤백이 불가능 하다.
rollback;

-- 예제 2. 매개 변수가 있는 프로시저
-- 서브 쿼리로 emp01테이블에 데이터를 재 입력
insert into emp01 SELECT * from emp;
select * from emp01;

-- 1. 프로시저 설정
create or replace PROCEDURE del_ename(
    vename in emp01.ename%type)
is
begin
    delete from emp01 where ename = vename;
end;

-- 자바 프로그램으로 프로시저 실행
-- CallableStatementTest02 클래스

-- 2. 프로시저 실행 확인
select * from emp01;

-- 예제 3. 매개 변수의 모드가 in, out 모두 존재하는 프로시저
-- 1. 저장 프로시저 생성
create or replace PROCEDURE sel_customer(
    vname in customer.name%type,
    vemail out customer.email%type,
    vtel out customer.tel%type)
is
begin
    select email, tel into vemail, vtel from customer
    where name = vname;
end;

-- 2. 프로시저 목록 확인
select * from user_source;

select * from customer;

-- 3. 바인드 변수 생성
VARIABLE var_email varchar2(20);
VARIABLE var_tel varchar2(20);

-- 4. 프로시저 실행
EXECUTE sel_customer('홍길동', :var_email, :var_tel);
EXECUTE sel_customer('오라클', :var_email, :var_tel);
EXECUTE sel_customer('SQL', :var_email, :var_tel);

-- 5. 바인드 변수로 받은 결과 출력
print var_email;
print var_tel;

-- 자바 프로그램에서 프로시저 실행
-- CallableStatementTest03 클래스

---------------------------------------------------------------------

-- 저장 함수
-- : 저장 프로시저와 기능을 수행하지만, 실행 결과를 돌려주는 역할을 한다.

-- 사원 테이블에서 특정 사원의 급여를 200% 인상한 결과를 돌려주는 저장 함수 생성
-- 1. 저장 함수
create or replace FUNCTION cal_bouns(
    vempno in emp.empno%type)
    return number           -- 돌려줄 값의 자료형
is
    vsal number(7,2);
begin
    select sal into vsal from emp
    where empno = vempno;
    RETURN vsal * 2;        -- 급여를 200% 인산한 결과를 돌려준다.
end;

-- 2. 저장 함수 목록 확인
select * from user_source;

-- 3. 바인드 변수 생성
VARIABLE var_res number;

-- 4. 저장 함수 실행
EXECUTE :var_res := cal_bouns(7788);
EXECUTE :var_res := cal_bouns(7900);

-- 5. 바인드 변수로 돌려받은 값 출력
print var_res;

-- 저장 함수를 SQL문에 포함시켜서 실행
SELECT ename, sal, cal_bouns(7788) from emp
where empno = 7788;

SELECT ename, sal, cal_bouns(7900) from emp
where empno = 7900;




