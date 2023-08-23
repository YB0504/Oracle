-- 2023_08_22(화)

-- DML(Data Manipulation Language, 데이터 조작어)
-- INSERT, UPDATE, DELETE

-- 1. INSERT : 데이터 입력
-- insert into 테이블명(컬럼1, 컬럼N,..) values(데이터1, 데이터N,...)
-- 특정 컬럼에 대해서만 데이터를 입력할 때 사용
-- insert into 테이블명 values(데이터1, 데이터N,...)
-- 테이블의 모든 컬럼을 순서대로 값을 입력하는 방식

-- 실습
drop table dept01 purge;

-- 비어있는 dept01 복사본 테이블 생성 - 테이블 구조만
CREATE table dept01 as SELECT * from dept where 1 = 0;
desc dept01;
SELECT * from dept01;

INSERT into dept01 (deptno, dname, loc) VALUES(10, 'ACCOUNTING', 'NEWYORK');
INSERT into dept01 VALUES(20, 'RESEARCH', 'DALLAS');
INSERT into dept01 VALUES(30, '영업부', '서울');

-- NULL 값 입력
INSERT into dept01(deptno, dname) VALUES(40, '개발부'); -- loc컬럼 값이 NULL
INSERT into dept01 VALUES(50, '기획부', NULL); -- loc컬럼 값이 NULL

-- 서브 쿼리를 이용한 데이터 입력
drop TABLE dept02 purge;

-- 1) dept02 테이블 생성
CREATE table dept02 as SELECT * from dept where 1 = 0;
SELECT * from dept02;
desc dept02;

-- 2) 서브 쿼리를 이용한 데이터 입력
-- 데이터를 입력할 때는 as를 빼고 작성한다.
INSERT into dept02 SELECT * from dept;
INSERT into dept02 SELECT * from dept02;

SELECT COUNT(*) from dept02;

-- INSERT ALL 명령문으로  두 개이상의 테이블에 한 번에 데이터를 입력
-- 2개의 테이블 생성
CREATE table emp_hir as SELECT empno, ename, hiredate from emp where 1 = 0;
SELECT * from emp_hir;

CREATE table emp_mgr as SELECT empno, ename, mgr from emp where 1 = 0;
SELECT * from emp_mgr;

-- insert all 명령문으로 다중 테이블에 데이터 입력
insert all into emp_hir VALUES(empno, ename, hiredate)
           into emp_mgr VALUES(empno, ename, mgr)
           SELECT empno, ename, hiredate, mgr from emp where deptno = 20;

-- 2. UPDATE : 데이터 수정
-- update 테이블명 set 컬럼1=수정할값1, 컬럼N = 수정할값N… where 조건절

-- 실습
drop table emp01 purge;

-- 복사본 테이블 생성
CREATE table emp01 as SELECT * from emp;
SELECT * from emp01;

-- where 조건절을 사용하지 않은 경우(모든 데이터 수정)
-- 모든 사원들의 부서번호를 30번 수정
UPDATE emp01 set deptno = 30;

-- 모든 사원들의 급여를 10%인상
UPDATE emp01 set sal = sal * 1.1;

-- 모든 사원들의 입사일을 오늘 날짜로 수정
UPDATE emp01 set hiredate = sysdate;

-- where 조건절을 사용한 경우(특정 데이터 수정)
drop table emp02 purge;
CREATE table emp02 as SELECT * from emp;
SELECT * from emp02;

-- 급여가 3000이상인 사원만 급여를 10% 인상
UPDATE emp02 set sal = sal * 1.1 where sal >= 3000;

-- 1987년도에 입사한 사원만 입사일을 오늘날짜로 수정
-- 첫번째 방법
UPDATE emp02 set hiredate = sysdate 
    where hiredate >= '87/01/01' AND hiredate <= '87/12/31';

UPDATE emp02 set hiredate = sysdate 
    where hiredate between '87/01/01' AND '87/12/31';


-- 두번째 방법
update emp02 set hiredate = sysdate
    where substr(hiredate, 1, 2) = 87;
    
-- SCOTT 사원의 입사일을 오늘날짜로 수정하고, 
-- 급여를 50으로 수정하고, 커미션을 4000으로 수정
update emp02 set hiredate = sysdate, sal = 50, comm = 4000
    where ename = 'SCOTT';
SELECT * from emp02 where ename = 'SCOTT';

-- 서브 쿼리를 이용한 데이터 수정
-- 20번 부서의 지역명을 40번 부서의 지역명으로 수정
drop table dept01 purge;
CREATE table dept01 as SELECT * from dept;
SELECT * from dept01;

update dept01 set loc = (SELECT loc from dept where deptno = 40)
    where deptno = 20;
SELECT * from dept01;

-- 3. DELETE : 데이터 삭제
-- delete from 테이블명 where 조건절

-- 모든 데이터 삭제 (where 조건절 X)
SELECT * from dept01;
DELETE from dept01;
rollback;   -- 트랜잭션 취소(데이터 롤백)

-- 특정 데이터 삭제 (where 조건절 사용)
-- dept01 테이블의 30번 부서만 삭제
DELETE from dept01 where deptno = 30;

-- 서브 쿼리를 이용한 데이터 삭제
-- 사원테이블(EMP02) 테이블에서 부서명이 SALES 부서의 사원을 삭제
drop table emp02 purge;
CREATE table emp02 as SELECT * from emp;
select * from emp02;

DELETE from emp02 where deptno 
    = (SELECT deptno from dept where dname = 'SALES');
    
------------------------------------------------------------------------------

-- MERGE
-- * 테이블 구조가 동일한 두 테이블의 MERGE 연습

--  MERGE : 구조가 같은 2개의 테이블을 하나의 테이블로 합치는 기능.
--  MERGE명령을 수행할때 기존에 존재하는 행(ROW)이 있으면 새로운     
--  값으로 UPDATE되고, 존재하지 않으면 새로운 행(ROW)으로 추가된다.

drop table emp01 purge;
select * from emp01; -- 14
drop table emp02 purge;
select * from emp02; -- 3

-- emp테이블의 복사된 테이블 생성
create table emp01 as select * from emp;

-- emp테이블의 복사된 테이블 생성( job이 MANAGER로 되어있는 데이터만 복사 )
create table emp02 as select * from emp where job='MANAGER';

update emp02 set job='Test';

insert into emp02 values(8000, 'ahn', 'top', 7566, '2023/08/22',1200, 10, 20);

-- (확인)
select * from emp02; 

merge into emp01
    using emp02 -- 02 -> 01로 머지를 수행
	on(emp01.empno = emp02.empno)
	when matched then -- 매치 여부
	     update set emp01.ename = emp02.ename,
        			emp01.job = emp02.job,
                	emp01.mgr = emp02.mgr,
                    emp01.hiredate = emp02.hiredate,
        			emp01.sal = emp02.sal,
                	emp01.comm = emp02.comm,
                    emp01.deptno = emp02.deptno
	when not matched then
	     insert values(emp02.empno, emp02.ename, emp02.job, 		         	         
                       emp02.mgr,emp02.hiredate, 
                       emp02.sal, emp02.comm,emp02.deptno);

-- (합병된 결과 확인)
select * from emp01;

--------------------------------------------------------------------





