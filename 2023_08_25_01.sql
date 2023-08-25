-- 2023_08_25(금)

-- Sequence
-- : 테이블에 숫자를 자동으로 증가 시켜주는 역할

-- 시퀀스 생성
create SEQUENCE dept_deptno_seq
start with 10       -- 시퀀스가 시작할 번호값
INCREMENT by 10;    -- 증가치

-- 시퀀스 목록 확인
SELECT * from seq;
SELECT * from user_sequences;

-- CURRVAL : 시퀀스의 현재 값을 반환
-- NEXTVAL : 시퀀스의 다음 값을 반환
SELECT dept_deptno_seq.nextval from dual;
SELECT dept_deptno_seq.currval from dual;

-- 예제 1 : 시퀀스를 테이블의 기본키에 적용
drop table emp01 purge;
CREATE table emp01(
    empno number(4) primary key,
    ename VARCHAR2(10),
    hiredate date);

-- 1부터 1씩 증가하는 시퀀스 생성
CREATE SEQUENCE emp01_empno_seq;
-- start with 10       -- 시퀀스가 시작할 번호값
-- INCREMENT by 10;    -- 증가치
-- 설정하지 않으면 기본으로 1부터 1씩 증가한다.

select * from emp01;
select * from seq;

-- 데이터 입력
insert into emp01 values(emp01_empno_seq.nextval, '홍길동', sysdate);

-- 예제 2.
-- 테이블 생성
create table dept_example(
    deptno number(2) primary key,
    dname varchar2(15),
    loc varchar2(15));

-- 시퀀스 생성 10부터 10씩 증가되는 시퀀스
CREATE sequence dept_example_seq
start with 10
increment by 10;

select * from seq;

insert into dept_example values(dept_example_seq.nextval, '총무과', '세종');

select * from dept_example;

-- 시퀀스 삭제
-- drop sequence 시퀀스 이름
drop sequence dept_example_seq;

-- 시퀀스의 최대값을 수정
drop SEQUENCE dept_deptno_seq;
CREATE SEQUENCE dept_deptno_seq
start with 10
INCREMENT by 10
MAXVALUE 30;    -- 시퀀스 최대치 설정

select * from seq;

-- 시퀀스 다음값을 반환
SELECT dept_deptno_seq.nextval from dual; -- 시퀀스의 값을 30까지만 구할 수 있다.

-- 시퀀스의 mxvalue 값을 100000으로 수정
alter SEQUENCE dept_deptno_seq MAXVALUE 100000;

-- 시퀀스의 증가값을 수정
alter sequence dept_deptno_seq INCREMENT by 1000;

-----------------------------------------------------------------------------

-- Index : 빠르게 검색을 하기 위해서 사용되는 객체

-- 인덱스 목록 확인
select * from user_indexes;
-- primary key 제약조건으로 설정된 컬럼은 자동으로 고유 인덱스로 설정된다.

-- 실습
-- 인덱스의 사용 여부에 따른 검색 속도의 차이 비교

-- 1. 테이블 생성
drop table emp01 purge;

-- 복사본 테이블 생성
CREATE table emp01 as SELECT * from emp;
SELECT * from emp01;

-- 2. emp01 테이블에 데이터 입력
insert into emp01 SELECT * from emp01;

-- 3. 검색용 데이터 입력
insert into emp01(empno, ename) VALUES(1111, '홍');

-- 4. 시간측정 타이머 ON으로 설정
set timing off

-- 5. 검색용 데이터로 검색 시간을 측정 : index 설정 X
select * from emp01 where ename = '홍'; -- 4.026초

-- 6. index 생성 : emp01테이블의 ename컬럼에 index적용
CREATE index idx_emp01_ename on emp01(ename);

-- 7. index 목록 확인
SELECT * from user_indexes;

-- 8. 검색용 데이터로 검색 시간을 측정 : index 설정 O
select * from emp01 where ename = '홍'; -- 2.923초

-- 9. index 삭제
drop index idx_emp01_ename;

-- 인덱스 종류
-- 고유 인덱스 : 중복된 데이터가 없는 컬럼에 적용할 수 있는 인덱스
-- 비 고유 인덱스  : 중복된 데이터가 있는 컬럼에 적용할 수 있는 인덱스

-- 1. 테이블생성
drop table dept01 purge;
CREATE table dept01 as select * from dept where 1=0; -- 테이블 구조만 복사
select * from dept01;

-- 2. 데이터 입력 : loc컬럼은 중복된 데이터가 입력
insert into dept01 VALUES(10, '인사과', '서울');
insert into dept01 VALUES(20, '총무과', '대전');
insert into dept01 VALUES(30, '교육팀', '대전');

-- 3. 고유 인덱스 : deptno컬럼에 고유 인덱스 설정
CREATE unique index idx_dept01_deptno on dept01(deptno); 
SELECT * from user_indexes;

-- 고유 인덱스 설정된 deptno컬럼에 중복 데이터 입력
-- deptno 컬럼은 고유 인덱스가 설정되어서 중복된 데이터를 입력할 수 없다.
insert into dept01 VALUES(10, '인사과', '서울'); -- 오류 발생

-- 4. 비 고유 인덱스
--    loc컬럼에 고유, 비 고유 인덱스를 적용

-- loc컬럼에 고유 인덱스 적용 : 이미 중복된 데이터가 있기 때문에 고유 인덱스 생성 불가
CREATE unique index idx_dept01_loc on dept01(loc); -- 오류 발생 

-- loc컬럼에 비 고유 인덱스 적용
CREATE index idx_dept01_loc on dept01(loc);
SELECT * from user_indexes;

-- 5. 결합 인덱스 : 2개 이상의 컬럼으로 만들어진 인덱스
CREATE index idx_dept01_loc_com on dept01(deptno, dname);

-- 6. 함수 기반 인덱스 : 수식이나 함수를 적용하여 만든 인덱스
CREATE index idx_emp01_annsal on emp(sal*12 + nvl(comm, 0));










