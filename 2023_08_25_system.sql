-- 2023_08_25(금)

-- 데이터베이스 보안을 위한 권한

-- 시스템 권한
-- :  데이터 베이스 관리자(DBA)가 가지고 있는 권한
-- ex) create user, drop user...

-- 시스템 관리자가 일반 사용자에게 부여해야 하는 권한
-- ex) create session : 데이터 베이스 접속권한
--     create table : 테이블을 생성할 수 있는 권한
--     create view : 뷰를 생성할 수 있는 권한
--     create sequence : 시퀀스를 생성할 수 있는 권한
--     create procedure : 프로시저를 생성할 수 있는 권한

-- 새로운 계정 생성 : user01 / tiger
CREATE user user01 
IDENTIFIED by tiger;

-- 계정 목록 확인
SELECT * from dba_users;

-- user01 계정에게 데이터 베이스 접속 권한 부여
grant create session to user01;

-- user01 계정에게 테이블 생성 권한 부여
grant create session, create table to user01;

-- WITH ADMIN OPTION
-- : grant 명령으로 권한을 부여 받을 때 with admin option을 붙여서
--   권한이 부여되면, 권한을 부여받은 계정은 자기가 부여받은 권한을 제 3의 계정에게
--   재 부여할 수 있는 권한을 가지게 된다.

-- 1) 새로운 계정 생성 : user02 / tigere
create user user02 
IDENTIFIED by tiger;

-- 2) 데이터베이스 접속 권한 부여
grant create session to user02 with admin option;

-- 3) 제 3의 계정 생성
create user user03 
IDENTIFIED by tiger;

-- 4) user01 계정으로 접속 후 user03계정에게 create session 권한 부여
-- conn user01/tiger
-- grant create session to user03; -- 오류 발생

-- 5) user02 계정으로 접속 후 user03계정에게 create session 권한 부여
-- conn user02/tiger
-- grant create session to user03; -- 권한 부여 성공

-- 6) user03계정은 user02계정으로부터 create session권한을 부여받았기 때문에,
--    데이터베이스 접속이 가능하다.

