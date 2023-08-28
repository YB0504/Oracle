-- 2023_08_28(월)

-- 사용자 정의 롤 생성 : 롤에 객체 권한을 부여
-- 1. 새로운 롤 생성
conn system / oracle
create role mrole02;

-- 2. 생성된 롤에 객체 권한을 부여
conn scott / tiger
grant select on emp to mrole02;

-- 3. user05 계정에게 mrloe02 부여
conn system / oracle
grant mrole02 to user05;

-- 4. user05 계정으로 접속 후 검색
conn user05 / tiger
select * from scott.emp;

---------------------------------------------------------------------

-- 롤 회수 : 특정 계정에게 부여된 롤을 취소하는 것
-- revoke 롤 이름 from 계정명

-- user05 계정에게 부여된 mrole과 mrole02 롤을 회수
conn system / oracle
revoke mrole, mrole02 from user05; 

-- 롤 삭제
-- drop role 롤 이름
conn system / oracle
drop role mrole;
drop role mrole02;

-------------------------------------------------------------------------

-- 사용자 정의 롤에 시스템 권한과 객체권한을 모두 부여
-- 디폴트 롤을 생성하여 여로 사용자에게 롤 부여
-- 디폴트 롤 = 시스템 권한 + 객체 권한

-- 1. 디폴트 롤 생성
conn system / oracle
create role def_role;

-- 2. 롤에 시스템 권한 부여
conn system / oracle
grant create session, create table to def_role;

-- 3. 롤에 객체 권한 부여
conn scott / tiger
grant select on emp to def_role;
grant UPDATE on emp to def_role;
grant delete on emp to def_role;

-- 4. 롤을 부여할 계정 생성
conn system / oracle
create user usera1
identified by tiger;

create user usera2
identified by tiger;

create user usera3
identified by tiger;

-- 5. 생성된 계정에 롤 부여
conn system / oracle
grant def_role to usera1;
grant def_role to usera2;
grant def_role to usera3;

-- 6. 생성된 각 계정에 접속 후 검색
conn usera1 / tiger
conn usera2 / tiger
conn usera3 / tiger
select * from scott.emp;

----------------------------------------------------------------

-- 동의어(synonym) : 같은 의미를 가진 단어
-- 1. 비 공개 동의어
--    : 객체에 대한 접근 권한을 부여받은 사용자가 정의한 동의어로써 
--      동의어를 만든 사용자만 사용할 수 있다.

-- 2. 공개 동의어(공용 동의어)
--    : DBA권한을 가진 사용자만 생성할 수 있으며 누구나 사용 가능하다.

-- 공개 동의어의 예
-- sys.tab -> tab ( select * from tab; )
-- sys.seq -> seq ( select * from seq; )
-- sys.dual -> dual ( select 10 + 20 from dual; )

---------------------------------------------------------------------

-- 비 공개 동의어의 예
-- CREATE SYNONYM 동의어 이름 FOR 계정명 . 객체명
-- 1. system 계정으로 접속 후 테이블 생성
conn system / oracle
create table systbl(ename varchar2(20));

-- 2. 생성된 테이블에 데이터 입력
insert into systbl values('홍길동');
insert into systbl values('오라클');

select * from systbl;

-- 3. scott계정에게 systbl 테이블에 대한 select객체 권한 부여
conn system / oracle
grant select on systbl to scott;

-- 4. scott 계정으로 접속 후 검색
conn scott / tiger
select * from systbl; -- 오류 발생
select * from system.systbl; -- 정상적인 검색 가능

create synonym systbl for system.systbl; -- 동의어를 만들 수 있는 권한 X 오류 발생

-- 5. scott 계정에게 동의어 생성 권한 부여
conn system / oracle
grant create synonym to scott; 

-- 6. 비 공개 동의어 생성
conn scott / tiger
create synonym systbl for system.systbl;

-- 7. 동의어 목록 확인
conn scott / tiger
select * from user_synonyms;

-- 8. 동의어를 이용하여 검색
conn scott / tiger
select * from systbl;

-- 9. 비 공개 동의어 삭제
-- drop synonym 동의어 이름
conn scott / tiger
drop SYNONYM systbl;

-- 공개 동의어 생성
-- 1. DBA 계정으로 접속하여 공개 동의어 생성
-- 2. CREATE [PUBLIC] SYNONYM 동의어 이름 FOR 계정명 . 객체명

