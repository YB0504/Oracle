-- 2023_08_30(수)

-- 패키지(package) = 저장프로시저와 저장함수를 묶어 놓은 것

-- 패키지 = 패키지 헤드 + 패키지 바디

-- 패키지 생성
-- 1. 패키지 헤드 생성
create or replace PACKAGE exam_pack
is
    function cal_bouns(vempno in emp.empno%type) -- 저장함수
        return number;
    procedure cursor_sample02;                  -- 저장 프로시저
end;

-- 2. 패키지 바디 생성
create or replace package body exam_pack
is
    -- 저장 함수 : cal_bouns
    FUNCTION cal_bouns(vempno in emp.empno%type)
        return number           -- 돌려줄 값의 자료형
    is
        vsal number(7,2);       -- 로컬 변수
    begin
        select sal into vsal from emp
        where empno = vempno;
        RETURN vsal * 2;        -- 급여를 200% 인산한 결과를 돌려준다.
    end;
    
    -- 저장 프로시저 : cursor_sample02
    PROCEDURE cursor_sample02
    is
        vdept dept%rowtype;         -- 로컬 변수
    
        CURSOR c1                   -- 커서 선언
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
end;

-- 3. 프로시저 실행
execute exam_pack.cursor_sample02;

-- 4. 저장 함수 실행 : cal_bouns()
-- 바인드 변수 생성
variable var_res number;

-- 저장 함수 실행
execute :var_res := exam_pack.cal_bouns(7788);

-- 바인드 변수로 받은 결과 출력
print var_res;

-- SQL문으로 저장함수 실행
select ename, exam_pack.cal_bouns(7788) from emp
where empno = 7788;

--------------------------------------------------------------------------

-- 트리거(TRIGGER)
-- 1. 트리거의 사전적 의미는 방아쇠라는 의미를 가지고 있다.
-- 2. 트리거는 이벤트를 발생시켜서, 연쇄적으로 다른 작업을 
--    자동으로 수행할 때 사용한다.
-- 3. 이벤트는 DML SQL문을 이용하여 이벤트를 발생시키고,
--    이 때 연쇄적으로 실행부(begin~end)안의 내용을 자동으로 실행한다.

-- 사원테이블에 사원이 등록되면, "신입 사원이 입사했습니다." 라는
-- 메시지를 출력하는 트리거를 생성

-- 1. 사원 테이블 생성
drop table emp01 purge;
create table emp01(
    empno number(4) primary key,
    ename varchar2(20),
    job varchar2(20));
    
select * from tab;

-- 2. 트리거 생성
create or replace trigger trg_01
    after insert on emp01           -- 이벤트 발생
begin
    dbms_output.put_line('신입 사원이 입사했습니다.');
    
end;

-- 3. 트리거 목록확인
select * from user_triggers;

-- 4. 이벤트 발생 : emp01테이블에 회원가입(데이터 입력);
set serveroutput on
insert into emp01 values(1111, '홍길동', '개발자');
insert into emp01 values(1112, '홍길동', '개발자');
insert into emp01 values(1113, '홍길동', '개발자');
insert into emp01 values(1114, '홍길동', '개발자');

select * from emp01;

commit;

-- 사원테이블(emp01)에 신입 사원이 등록되면, 급여 테이블(sal01)에 급여 정보를
-- 자동으로 추가 해주는 트리거 생성

-- 1. 사원 테이블 : emp01
-- 2. 급여 테이블 생성 : sal01
create table sal01(
    salno number(4) primary key,
    sal number(7,2),
    empno number(4) references emp01(empno)); -- 외래키

select * from sal01;

-- 3. 시퀀스 생성
create sequence sal01_salno_seq; -- 1부터 자동으로 1씩 증가되는 시퀀스 생성

select * from seq;

-- 4. 트리거 생성
-- :new.컬럼명 : insert, update문을 이용해서 이벤트가 발생한 경우
-- :old.컬럼명 : delete문을 이용해서 이벤트가 발생한 경우
create or replace trigger trg_02
    after insert on emp01           -- 이벤트 발생
    for each row                    -- 행 레벨 트리거
begin
    insert into sal01 VALUES(sal01_salno_seq.nextval, 300, :new.empno);
end;

-- 5. 트리거 목록 확인
select * from user_triggers;

-- 6. 이벤트 발생 : emp01테이블에 사원 등록
insert into emp01 VALUES(1111, '홍길동', '개발자');
insert into emp01 VALUES(1112, '홍길동', '개발자');
insert into emp01 VALUES(1113, '홍길동', '개발자');

-- 7. 데이터 확인
select * from emp01;
select * from sal01;    -- 트리거에 의해서 자동으로 등록

---------------------------------------------------------------------------

-- 사원 테이블에서 사원이 삭제되면 급여 정보를 자동으로 삭제하는 트리거 생성

-- 참조하는 외래키가 있기 때문에 부모 테이블의 데이터를 삭제할 수 없다.
delete from emp01 where empno = 1111; -- 삭제 안됨

-- 1. 트리거 생성
-- :new.컬럼명 : insert, update문을 이용해서 이벤트가 발생한 경우
-- :old.컬럼명 : delete문을 이용해서 이벤트가 발생한 경우
create or replace trigger trg_03
    after delete on emp01           -- 이벤트 발생
    for each row                    -- 행 레벨 트리거
begin
    delete from sal01 where empno = :old.empno;
end;

-- 2. 트리거 목록 확인
select * from user_triggers;

-- 3. 이벤트 발생
-- : 사원 테이블의 사원번호 1111번 사원을 삭제하면, 연쇄적으로
--   급여 테이블의 급여 정보가 같이 삭제된다.
delete from emp01 where empno = 1111;
delete from emp01 where empno = 1112;
delete from emp01 where empno = 1113;

-- 4. 결과 확인
select * from emp01;
select * from sal01;
