-- 2023_08_22(화)

-- DDL(Data Definition Language) : 데이터 정의어
-- CREATE : 테이블 생성
-- ALTER : 테이블 구조 변경
-- RENAME : 테이블 이름 변경
-- DROP : 테이블 삭제
-- TRUNCATE : 데이터 삭제

-- 테이블 목록
SELECT * from tab;
SELECT * from user_tables;

-- 1. CREATE
--    데이터베이스 생성, 테이블 생성
-- CREATE TABLE 테이블명( 컬럼명1, 데이터 타입1,
--                       컬럼명2, 테이터 타입2,...)

-- * 테이블명,컬럼명 명명 규칙
-- 
-- 1. 반드시 문자로 시작 해야함.
-- 2. 1~30자 까지 가능함.
-- 3. A~Z까지의 대소문자와 0~9까지의 숫자, 
--    특수기호는 (_, $, #)만 포함할 수 있음.
-- 4. 오라클에서 사용되는 예약어나 다른 객체명과 중복불가
-- 5. 공백허용 안됨.

-- 오라클의 데이터 타입
-- 1) 숫자 데이터
--    NUMBER(N) : 정수 n자리 까지 저장
--    NUMBER(N1, N2) : N1은 전체 자리수, N2는 소수점 이하의 자리수

-- 2) 문자 데이터
--    CHAR() : 고정길이 문자형
--             최대 2000byte까지 저장 가능
--    VARCHAR2() : 가변길이 문자형
--                 최대 4000byte까지 저장 가능
--    LONG : 2GB까지 저장 가능
--           LONG형으로 설정된 컬럼은 검색 기능을 지원하지 않는다.

-- 3) 날짜 데이터
--    DATE : 년, 월, 일
--    TIMESTAMP : 년, 월, 일, 시, 분, 초

-- 테이블 생성
-- 1) 직접 테이블 생성
CREATE table emp01( empno number(4), 
ename VARCHAR2(20), sal number(7,2));

SELECT * from tab; -- 테이블 목록 확인

-- 2) 서브 쿼리로 테이블 생성
--    복사본 테이블이 생성된다.
--    제약 조건은 복사가 되지 않는다.

-- 복사본 테이블 생성
CREATE table emp02 as SELECT * from emp;

SELECT * from tab;
SELECT * from emp02;

-- 원하는 컬럼으로 구성된 복사본 테이블 생성
CREATE table emp03 as SELECT empno, ename from emp;
SELECT * from emp03;

-- 원하는 행으로 구성된 복사본 테이블 생성
CREATE table emp04 as SELECT * from emp where deptno = 10;
SELECT * from emp04;

-- 테이블 구조만 복사
CREATE table emp05 as SELECT * from emp where 1 = 0;
SELECT * from emp05;

-- 2. ALTER
--    : 테이블 구조 변경 (컬럼추가, 컬럼수정, 컬럼삭제)

-- 컬럼 추가 : emp01 테이블에 job컬럼 추가
alter TABLE emp01 add(job VARCHAR2(10));
desc emp01; -- 테이블 구조 확인
SELECT * from emp01;

-- 컬럼 수정
-- 1) 수정할 컬럼에 데이터가 없는 경우
--    컬럼의 데이터 타입을 변경할 수 있다.
--    컬럼의 크기를 변경할 수 있다.

-- EMP01 테이블의 job컬럼의 크기를 10 -> 30 으로 변경
ALTER table emp01 MODIFY(job VARCHAR2(30));
desc emp01;

-- 2) 수정할 컬럼에 데이터가 있는 경우
--    컬럼의 데이터 타입을 변경할 수 없다.
--    컬럼의 크기를 늘릴수는 있지만, 저장된 데이터 크기보다 
--    작은 크기로는 변경할 수 없다.

-- 컬럼 삭제
alter table emp01 drop COLUMN job;
alter table emp01 drop(job);
desc emp01;

-- 3. RENAME
--    : 테이블 이름 변경
-- RENAME OLD_NAME(기존 테이블명) TO NEW_NAME(변경할 테이블명);

-- emp01 테이블을 test 테이블명으로 변경하는 SQL문 작성
rename emp01 to test;
SELECT * from tab;
desc test;

-- 4. TRUNCATE
--    : 테이블의 모든 데이터 삭제
-- TRUNCATE table 테이블명;
TRUNCATE table emp02;
SELECT * from emp02;

-- 5. DROP
--    : 테이블 삭제
-- DROP table 테이블명; (오라클 10g 버전부터는 임시 테이블로 교체된다.)
-- DROP table 테이블명 purge;

-- test테이블을 삭제하는 SQL문 작성
drop table test;
SELECT * from tab;

-- 임시 테이블을 삭제하는 SQL문
purge RECYCLEBIN;

-----------------------------------------------------------------------------

-- * 오라클의 객체
--   테이블, 뷰, 시퀀스, 인덱스, 동의어, 프로시저, 트리거

-- * 데이터 딕셔너리와 데이터 딕셔너리 뷰
--   데이터 딕셔너리를 통해서 접근가능함

-- 데이터 딕셔너리 뷰 : user_xxxx(객체명의 복수형)
--      (가상 테이블)  all_xxxx
--		             dba_xxxx

-- 데이터 딕셔너리(시스템 테이블) : 

-- SCOTT 계정 소유의 테이블 객체에 대한 정보를 검색
select * from tab;
select * from user_tables; --(테이블)

select * from user_views; -- (뷰)

select * from seq;
select * from user_sequences; -- (시퀀스)

select * from user_indexes; -- (인덱스)

select * from user_synonyms; -- (동의어)

select * from user_source; -- (프로시저)

select * from user_triggers; -- (트리거)

-- 자기 계정 소유나 권한을 위임받은 계정의 객체에 대한 정보 검색
select table_name from all_tables;

-- 데이터 베이스 관리자(DBA)만 접근 가능한 객체에 대한 정보 검색
select table_name from dba_tables; -- (DBA 계정만 사용가능)

-- 오라클 시스템의 모든 계정 정보를 검색
select username from dba_users; -- (DBA 계정만 사용가능)

















