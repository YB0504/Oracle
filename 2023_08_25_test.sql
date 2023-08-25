-- TEST

-- 1번 문제
--주어진 조건에 맞게 book 테이블을 생성하시오? (20점)
--조건1 : no 컬럼은 반드시, 중복되지 않은 값이 들어가도록 설정한다.
--조건2 : title 컬럼에는 반드시 값이 들어가도록 설정한다.
--조건3 : pub_day 컬럼에 값을 넣지 않으면 기본 값으로 오늘 날짜가 들어가도록 설정 한다
create table book(
    no number(4) primary key,
    title varchar2(20) not null,
    author varchar2(20),
    publisher varchar2(20),
    pub_day date DEFAULT sysdate);
    
-- 2번 문제
--Oracle 데이터베이스를 통한 현재 날짜를 기본형식(23/01/01)과 
--사용자 형식(2023-01-01)으로 차례로 출력하는 SQL문을 작성하시오?  (20점)
select sysdate, to_char(sysdate, 'yyyy-mm-dd') from dual;

-- 3번 문제
--사원테이블(EMP)에서 최대 급여를 받는 사원명과, 
--최대급여 금액을 출력하는 SQL문을 작성하시오? (20점)
select ename, sal from emp
where sal = (select max(sal) from emp);

-- 4번 문제
--MySQL을 Oracle로 DB Migration을 하고자 한다. 
--마이그레이션 한 결과가 같아지도록 아래 내용을 완성하시오? (20점)
--1. Oracle sequence 생성
--2. insert문 작성하기
create table member(
    id number(6) primary key,
    name varchar2(20));

-- 시퀀스 생성
CREATE SEQUENCE member_seq
start with 1
increment by 1;

-- insert 문 작성
insert into member values(member_seq.nextval, 'hong');

-- 5번 문제
--다음은 테이블을 만들 때 name, phone 컬럼을 기본키로 만들려고 한다. 
--composite key(복합키) 이름(Constraint)은 member_compo_pk이며, 
--아래 테이블을 완성하시오? (20점)
create table member(
    name varchar2(10),
    address varchar2(30),
    phone varchar2(16),
    constraint member_compo_pk primary key(name, phone));












