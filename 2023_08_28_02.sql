-- 2023_08_28(월)

-- PL / SQL (Oracle's Procedural Language extention to SQL)

-- PL/SQL로 Hello World 출력
set SERVEROUTPUT on -- serveroutput환경변수 활성화
begin               -- 실행부 시작
dbms_output.put_line('Hello World!!');
end;                -- 실행부 끝

-- dbms_output : 패키지
-- 패키지 = 저장 프로시저 + 저장 함수
-- put_line : 저장 프로시저

-- 1. 변수 사용하기 : 스칼라 변수 사용
set SERVEROUTPUT on
DECLARE                             -- 선언부 시작
    vempno number(4);               -- 변수 선언 : 스칼라 변수
    vename varchar2(15);
begin                               -- 실행부 시작
    vempno := 7788;                 -- 변수에 값을 할당
    vename := 'SCOTT';
    dbms_output.put_line('사번 / 이름');
    dbms_output.put_line('--------------');
    dbms_output.put_line(vempno || ' / ' || vename); -- Concatenation 연산자
end;                                -- 실행부 끝

-- 1-1. 변수 사용하기 : 레퍼런스 변수 사용
-- select문을 이용하여 검색한 내용을 변수에 할당
-- 사번과 이름을 검색하기
set serveroutput on
DECLARE
    vempno emp.empno%type;          -- 변수 선언 : 레퍼런스 변수
    vename emp.ename%type;
begin                               -- select문으로 검색한 내용을 변수에 할당
    select empno, ename into vempno, vename from emp
    where ename = 'SCOTT';
    
    dbms_output.put_line('사번 / 이름');
    dbms_output.put_line(vempno || '/' || vename);
end;

----------------------------------------------------------------------------
    
-- 선택문(조건문)
-- 1. IF - THEN -END IF
-- 사원 테이블(EMP)에서 SCOTT사원의 부서 번호를 검색해서, 
-- 부서명을 출력하는 PL/SQL문 작성

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

    dbms_output.put_line('사번  /  이름  / 부서명');
    dbms_output.put_line(VEMPNO || ' / ' || VENAME || ' / ' || VDNAME);
END;
















