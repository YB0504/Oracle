-- 2023_08_29(과제)

-- 사원 테이블에서 사원명을 검색하여 사원의 직급을 구해오는 
-- 저장 프로시저를 만들어서 실행하세요?

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







