-- 2023_08_30(수)

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

-- 사원 테이블에서 사원명을 저장함수의 매개변수로 전달하여 해당 사원의 직급을 출력
create or replace FUNCTION job_emp(
    vename in emp.ename%type)
    return varchar2             -- 돌려줄 값의 자료형
is
    vjob emp.job%type;          -- 로컬변수 생성(사원명으로 검색한 사원의 job저장)
begin
    select job into vjob from emp
    where ename = vename;
    return vjob;
end;

-- 저장함수 목록 확인
select * from user_source;

-- 바인드 변수 생성
variable var_job varchar2(10);

-- 저장 함수 실행
execute :var_job := job_emp('SCOTT');

-- 저장 함수 출력
print var_job;

-- 저장함수를 SQL문에 포함해서 실행
select ename, job_emp('SCOTT') from emp where ename = 'SCOTT';

---------------------------------------------------------------------

-- 커서(CURSOR)
-- : 2개 이상의 데이터를 처리할 때 커서를 사용한다.

-- 부서테이블의 모든 데이터를 출력하기 위한 PL/SQL문 작성
-- 1. 저장 프로시저 생성
set serveroutput on
create or replace procedure cursor_sample01
is
    vdept dept%rowtype;     -- 로컬변수 생성
    
    cursor c1               -- 커서 선언
    is
    select * from dept;
begin
    dbms_output.put_line('사원번호  /  부서명  /  지역명');
    dbms_output.put_line('-----------------------------------');
    
    open c1;                -- 커서 열기(첫번째 데이터를 가져온다.)
        loop   
            fetch c1 into vdept.deptno, vdept.dname, vdept.loc; -- 인출
                exit when c1%notfound;  -- 커서가 가져올 값이 없을때 true
                dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'
                ||vdept.loc);
        end loop;
    close c1;
end;

-- 2. 프로시저 목록 확인
select * from user_source;

-- 3. 프로시저 실행
execute cursor_sample01;

---------------------------------------------------------------------------

-- 부서테이블의 모든 데이터를 출력하기 위한 PL/SQL문 작성
-- FOR LOOP문 으로 처리
-- 1. OPEN - FETCH - CLOSE 없이 처리 가능
-- 2. FOR LOOP문을 사용하게 되면 각 반복문마다, CURSOR를 열고,
--    각 행을 인출하고 , 닫는 과정을 자동으로 처리한다.

-- 1. 저장 프로시저 생성
create or replace PROCEDURE cursor_sample02
is
    vdept dept%rowtype;         -- 로컬 변수
    
    CURSOR c1
    is
    select * from dept;
begin
    dbms_output.put_line('부서번호  /  부서명  /  지역명');
    dbms_output.put_line('----------------------------');
    
    for vdept in c1 loop
        dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'
        ||vdept.loc);
        exit when c1%notfound;  -- 커서가 더이상 가져올 값이 없을 때 true
    end loop;
end;

-- 2. 프로시저 목록 확인
select * from user_source;

-- 3. 프로시저 실행
execute cursor_sample02;

-- 사원테이블에서 부서번호를 전달하여 해당 부서의 소속된 사원의 정보를 출력
-- 1. 저장 프로시저 생성
create or replace PROCEDURE info_emp(vdeptno in emp.deptno%type)
is
    vemp emp%rowtype;      -- 로컬 변수
    cursor c1
    is
    select * from emp where deptno = vdeptno;
begin
    dbms_output.put_line('부서번호 / 사원번호 / 사원명 / 직급 / 급여');
    dbms_output.put_line('----------------------------------------');
    
    for vemp in c1 loop
    dbms_output.put_line(vemp.deptno||'/'||vemp.empno||'/'||vemp.ename
                         ||'/'||vemp.job||'/'||vemp.sal);
    exit when c1%notfound;
    end loop;

end;
    
-- 2. 프로시저 목록 확인
select * from user_source;

-- 3. 프로시저 실행
execute info_emp(40);

