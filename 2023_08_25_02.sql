-- 2023_08_25(금)

-- 객체 권한
-- 오라클의 객체 : 테이블, 뷰, 시퀀스, 인덱스, 동의어, 프로시저, 트리거

-- 1. 새로 생성된 user01 계정에게 scott계정 소유의 emp테이블 객체에 대한
--    select 객체 권한을 부여
conn scott/tiger
grant select on emp to user01;

-- 2. user01 계정으로 접속 후 emp테이블 객체에 대해서 select를 실행
conn user01/tiger
select * from emp;          -- 오류 발생
select * from scott.emp;    -- 검색 가능
-- 명령 프롬프트 창에 입력하여 실행하여야 한다.

-- 3. 객체 권한 취소
REVOKE SELECT ON emp FROM user01;
select * from scott.emp; -- 객체 권한이 취소 되었기 때문에 오류 발생

-- WITH GRANT OPTION
-- : user02 계정에게 scott 계정 소유의 emp테이블 객체에 대해서 select객체
--   권한을 부여할 때 with grant option을 붙여서 권한이 부여되면, user02계정은
--   자기가 부여받은 권한을 제 3의 계정(user01)에게 재 부여할 수 있다.

-- 1. user02계정에게 scott 소유의 emp 테이블 객체에 대한 select 객체 권한 부여
grant select on emp to user02 with grant option;

-- 2. user02 계정으로 접속 후, 부여 받은 객체 권한을 user01에게 재 부여
select * from scott.emp;
grant select on scott.emp to user01;

-- 3. user01계정으로 접속 후 scott.emp 검색
-- SQL> conn user01/tiger
-- Connected.
-- SQL> select * from scott.emp;
