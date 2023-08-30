-- 2023_08_29(과제)
-- Q1. 전산실에 새로 입사한 사원에게 새로운 계정을 생성해 주려고 
--          합니다. 아래의 요구 사항을 만족하는 SQL문을 각각 작성 
--          하세요 ? 
--   [요구1] USER명 : woman, 패스워드 : tiger 
create user woman
IDENTIFIED by tiger;

--   [요구2] CREATE SESSION 이라는 시스템 권한을 부여해 줍니다. 
--	(단, 또 다른 유저에게도 권한을 줄 수 있도록 
--	      WITH ADMIN OPTION을 부여합니다). 
grant create session to woman with admin option;

--   [요구3] woman유저에게 connect, resource, dba 권한을 부여합니다.

grant connect, resource, dba to woman;

--   Q2. user01 계정을 생성 하세요? (비밀번호: tiger)
drop user user01;
create user user01
identified by tiger;

--   Q3. user01 계정에게 오라클 데이터 베이스에 접속해서, 테이블을 
--        생성할 수 있는 권한을 부여하시오.
grant create session, create table to user01;

----------------------------------------------------------------------

-- 선생님 코드

Ans 1. SQL> create user woman identified by tiger;

       SQL> grant create session to woman with admin option;

       SQL> grant connect, resource, dba to woman;


Ans 2. SQL> create user user01 identified by tiger;


Ans 3. SQL> grant create session, create table to user01;









