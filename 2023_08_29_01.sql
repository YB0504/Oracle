-- 2023_08_29(화)

-- 선택문(조건문)
-- 1. IF - THEN - END IF
-- 사원 테이블(EMP)에서 SCOTT사원의 부서 번호를 검색해서, 
-- 부서명을 출력하는 PL/SQL문 작성

SET SERVEROUTPUT ON
DECLARE
    VEMPNO NUMBER(4);               -- 사원번호
    VENAME VARCHAR2(20);            -- 사원명
    VDEPTNO DEPT.DEPTNO%TYPE;       -- 부서번호
    VDNAME VARCHAR(20) := NULL;     -- 부서명
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

    dbms_output.put_line('사번  /  이름  / 부서명');
    dbms_output.put_line(VEMPNO || ' / ' || VENAME || ' / ' || VDNAME);
END;

-- 사원테이블에서 SCOTT사원의 연봉을 구하는 PL/SQL문을 작성
set SERVEROUTPUT on
DECLARE
    -- %rowtype : emp테이블의 8개 칼럼의 자료형을 모두 참조한다는 의미
    vemp emp%rowtype;           -- 레퍼런스 변수
    annsal number(7,2);         -- 스칼라 변수
begin
    select * into vemp from emp
    where ename = 'SCOTT';
    
    if vemp.comm is null
    then vemp.comm := 0;
    end if;
    
    annsal := vemp.sal * 12 + vemp.comm;
    dbms_output.put_line('사번  /  이름  /  연봉');
    dbms_output.put_line(vemp.empno || ' / ' || vemp.ename || ' / ' || annsal);
end;

-- 2. IF - THEN - ELSE -END IF
-- 사원 테이블에서 SCOTT사원의 연봉을 구하는 PL/SQL문 작성
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
    
    dbms_output.put_line('사번  /  이름  /  연봉');
    dbms_output.put_line(vemp.empno || ' / ' || vemp.ename || ' / ' || annsal);
END;

-- 3. IF - THEN - ELSIF - ELSE - END IF
-- SCOTT사원의 부서번호를 이용해서 부서명을 구하는 PL/SQL문 작성
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
    
    dbms_output.put_line('사번  /  이름  /  부서명');
    dbms_output.put_line(vemp.empno || ' / ' || vemp.ename || ' / ' || 
    vdname);
end;

------------------------------------------------------------------------------

-- 반복문
-- 1. BASIC LOOP
-- LOOP 반복 실행될 문장 조건식 EXIT END LOOP

-- basic loop 문으로 1 ~ 5까지 출력
set SERVEROUTPUT on
declare
    n number := 1;          -- n변수의 초기값을 1로 설정
begin
    loop
        dbms_output.put_line(n);
        n := n + 1;
        if n > 5 then
            exit;           -- loop문을 빠져나온다.
        end if;
    end loop;
end;

-- 1 ~ 10까지 합을 구하는 PL/SQL문 작성
set serveroutput on
declare
    n number := 1;          -- 루프를 돌릴 변수
    s number := 0;        -- 합이 누적될 변수
begin
    loop
        s := s + n;
        n := n + 1;
        if n > 10 then
            exit;
        end if;
    end loop;
    dbms_output.put_line('1 ~ 10까지의 합 : ' || s);
end;

-- 2. FOR LOOP
--    FOR 변수 IN [REVERSE] 작은값..큰값 LOOP
--    반복 실행될 문장
--    END LOOP;

-- FOR LOOP문으로 1부터 5까지 출력
set serveroutput on
begin
--  for n in 1..5 loop          -- 자동으로 1씩 증가
    for n in reverse 1..5 loop  -- 자동으로 1씩 감소
        dbms_output.put_line(n);
    end loop;
end;
    
-- for loop문을 이용해서 부서테이블의 모든 정보를 출력
set serveroutput on
DECLARE
    vdept dept%rowtype;
begin
    dbms_output.put_line('부서번호  /  부서명  /  지역명');
    for cnt in 1..4 loop
        select * into vdept from dept where deptno = 10 * cnt;
        dbms_output.put_line(vdept.deptno || ' / ' ||
        vdept.dname || ' / ' || vdept.loc);
    end loop;
end;

-- 3. WHILE LOOP
-- WHILE 조건식 LOOP 반복 실행될 문장 END LOOP
-- 조건식이 참이면 문장이 실행되고 거짓이면 실행되지 않는다.

-- while loop 문으로 1 ~ 5까지 출력
set SERVEROUTPUT on
DECLARE
    n number := 1;
begin
    while n <= 5 loop
        dbms_output.put_line(n);
        n := n + 1;
    end loop;
end;

-- whlie loop문으로 별(*)을 삼각형 모양으로 출력
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






