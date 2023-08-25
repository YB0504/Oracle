-- 2023_08_24(목)

-- 제약조건의 활성화 / 비 활성화

-- dept테이블의 데이터를 삭제
DELETE from dept where deptno = 10; -- 오류 발생

-- 1) 자식테이블에서 부모키를 참조하고 있는 외래키가 있기 때문에 삭제 불가
-- 2) 부모 테이블의 데이터를 삭제하기 위해 참조하는 자식 테이블의 외래키를 
--    비 활성화시키면 부모 테이블의 데이터를 삭제 가능

-- 1. 부모 테이블 생성
drop table dept01 purge;
CREATE table dept01(
    deptno number(2) PRIMARY key,   -- 부모키
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
insert into dept01 VALUES(10, '영업부', '서울');
SELECT * from dept01;

-- 2. 자식 테이블 생성
drop table emp01 purge;
create table emp01(
    empno NUMBER(4) primary key,
    ename VARCHAR2(10) not null,
    job varchar2(10) UNIQUE,
    deptno number(2) REFERENCES dept01(deptno)); -- 외래키
    
insert into emp01 VALUES(1111, '홍길동', '영업직', 10);
select * from emp01;

-- 3. 부모테이블(dept01)의 데이터 삭제
DELETE from dept01; -- 자식테이블에서 참조하는 외래키가 있기 때문에 데이터 삭제 불가
SELECT * from dept01;
SELECT * from emp01;

-- 4. 자식 테이블의 외래키 제약조건을 비 활성화
-- 부모 테이블의 데이터를 삭제하기 위해서는 자식 테이블의 외래키 제약조건을
-- 비 활성화 시키면 부모테이블의 데이터를 삭제할 수 있다.

-- 형식 : alter table 테이블명 disable constraint constraint_name(제약조건 이름)
alter table emp01 disable constraint SYS_C007051; -- 외래키 제약조건 비 활성화

-- 자식 테이블의 제약조건을 활성화
-- 형식 : alter table 테이블명 enable constraint constraint_name(제약조건 이름)
DELETE from emp01; -- 부모키를 참조했던 데이터를 삭제
alter table emp01 enable constraint SYS_C007051; -- 외래키 제약조건 활성화

-- 5. 부모 테이블의 데이터 삭제
delete from dept01; -- 참조하는 외래키가 없기 때문에 삭제가 가능해진다.

-- CASCADE 옵션
-- 1. CASCADE 옵션을 붙여서 부모 테이블의 제약조건을 비활성화 시키면
--    참조하고 있는 자식 테이블의 외래키 제약조건도 같이 비활성화 시킨다.
-- alter table 부모 테이블명 disable CONSTRAINT 제약조건이름 cascade;
alter table dept01 disable constraint SYS_C007047 cascade;

-- 2. CASCADE 옵션을 붙여서 부모 테이블의 primary  key를 제거하면
--    참조하는 자식 테이블의 foreign key 제약조건도 같이 제거된다.
--alter table 부모 테이블명 drop constraint constraint_name cascade;
alter table dept01 drop constraint SYS_C007047 cascade;
alter table dept01 drop primary key cascade;

-- 1. 부모 테이블 생성
drop table dept01 purge;
CREATE table dept01(
    deptno number(2) PRIMARY key,   -- 부모키
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
insert into dept01 VALUES(10, '영업부', '서울');
SELECT * from dept01;

-- 2. 자식 테이블 생성
drop table emp01 purge;
create table emp01(
    empno NUMBER(4) primary key,
    ename VARCHAR2(10) not null,
    job varchar2(10) UNIQUE,
    deptno number(2) REFERENCES dept01(deptno)on delete cascade); -- 외래키
    
-- on delete cascade 
-- : 부모 테이블의 데이터를 삭제하면 참조하는 자식 테이블의 데이터도 같이 삭제해주는 옵션
    
insert into emp01 VALUES(1111, '홍길동', '영업직', 10);
select * from emp01;

-- 3. 부모 테이블 데이터 삭제
DELETE from dept01; -- 자식 테이블의 데이터도 같이 삭제된다.

----------------------------------------------------------------------------

-- View(뷰)
-- : 기본 테이블을 이용해서 만들어진 가상 테이블

-- 실습을 위한 기본 테이블 생성 : dept_copy, emp_copy

-- 2개의 기본 테이블 생성( 제약 조건은 복사가 안된다. )
CREATE table dept_copy as SELECT * from dept;
CREATE table emp_copy as SELECT * from emp;

select * from tab;
SELECT * from dept_copy;
SELECT * from emp_copy;

-- 뷰 생성
CREATE view emp_view30
as SELECT empno, ename, deptno from emp_copy where deptno = 30;

-- 뷰 목록 확인
select * from tab;
select * from user_views;

-- 뷰 검색
select * from emp_view30;
desc emp_view30;

-- 뷰(emp_view30)에 insert로 데이터를 입력한 경우 기본테이블(emp_copy)에도
-- 같은 데이터가 입력되는지 확인
insert into emp_view30 VALUES(1111, '홍길동', 30);

-- view에 데이터가 입력되면 기본테이블에도 데이터가 입력된다.
select * from emp_view30;
select * from emp_copy;

-- View의 종류
-- 단순 View : 하나의 기본 테이블로 생성된 뷰
-- 복합 View : 여러 개의 기본 테이블로 생성된 뷰

-- 1. 단순 뷰
-- 기본 테이블인 emp_copy 를 이용해서 20번 부서에 소속된 사원들의
-- 사번과 이름, 부서번호, 직속 상사의 사번을 출력하는 뷰 생성(emp_view20)

CREATE view emp_view20
as select empno, ename, deptno, mgr 
from emp_copy where deptno = 20;

select * from user_views;
select * from emp_view20;

-- 2. 복합 뷰
-- 각 부서별(부서명) 최대급여와 최소급여를 출력하는 뷰를 작성(sal_view)
CREATE view sal_view
as select dname, max(sal) as "MAX", min(sal) as "MIN"
from dept, emp where dept.deptno = emp.deptno group by dname;

SELECT * from tab;
SELECT * from user_views;
select * from sal_view;

-- 뷰 삭제
drop view sal_view;

-- 뷰를 생성할 때 사용되는 옵션
-- 1. OR REPLACE 옵션
--    기존에 뷰가 존재하지 않으면 뷰를 생성하고, 동일한 이름을 가진
--    뷰가 존재하면 뷰의 내용을 수정하도록 만들어 주는 옵션

-- 1) or replace 옵션없이 동일한 뷰(emp_view30)를 생성 : 오류 발생
CREATE view emp_view30
as SELECT empno, ename, deptno, sal, comm
from emp_copy where deptno = 30;

-- 2) or replace 옵션을 붙여서 동일한 뷰를 생성 : 뷰의 내용이 수정된다.
CREATE or REPLACE view emp_view30
as SELECT empno, ename, deptno, sal, comm
from emp_copy where deptno = 30;

select * from user_views;
select * from emp_view30;

-- 2. WITH CHECK OPTION
--  : where 조건절에 사용된 값을 수정하지 못하도록 만들어 주는 옵션
-- 1) with check option 사용하지 않은 경우
--    뷰에 insert, update, delete가 실행되면,
--    기본 테이블에도 동일한 내용이 적용된다.
CREATE or REPLACE view emp_view30
as SELECT empno, ename, deptno, sal, comm
from emp_copy where deptno = 30;

-- emp_view30에서 급여가 1200 이상인 사원들의 부서번호를 30번에서 20번으로 수정
update emp_view30 set deptno = 20 where sal >=1200;
select * from emp_view30;
SELECT * from emp_copy where deptno = 20;

-- 2) with check option 사용한 경우
drop table emp_copy purge;
CREATE table emp_copy as SELECT * from emp;

CREATE or REPLACE view emp_view30
as SELECT empno, ename, deptno, sal, comm
from emp_copy where deptno = 30 with check option;

select * from emp_view30;

update emp_view30 set deptno = 20 where sal >= 1200; -- 오류 발생

-- 3. WITH READ ONLY
--  : 읽기 전용의 뷰를 만들어 주는 옵션
--  : 뷰를 통해서 기본 테이블의 내용을 수정하지 못하도록 만들어 주는 역할

CREATE or REPLACE view view_read30
as select empno, ename, sal, comm deptno
from emp_copy where deptno = 30 with read only;

select * from view_read30;
update view_read30 set deptno = 20 where sal >= 1200; -- 오류 발생

----------------------------------------------------------------------

-- ROWNUM 컬럼
-- 1. 데이터의 검색 순서를 가지고 있는 논리적인 컬럼
-- 2. rownum 값은 1번부터 시작한다.
-- 3. rownum 값은 order by절로 정렬해도 바뀌지 않는다.
-- 4. rownum 값을 변경하기 위해서는 테이블을 변경해야 한다.

SELECT rownum, rowid, deptno, dname, loc from dept;
select rownum, ename, sal from emp;
select rownum, ename, sal from emp where ename = 'WARD';
select rownum, ename, sal from emp order by ename;
--11	ADAMS	1100
--2	    ALLEN	1600
--6	    BLAKE	2850
--7	    CLARK	2450
--13	FORD	3000
--12	JAMES	950
--4	    JONES	2975
--9	    KING	5000
--5	    MARTIN	1250
--14	MILLER	1300
--8	    SCOTT	3000
--1	    SMITH	800
--10	TURNER	1500
--3	    WARD	1250

-- 사원 테이블에서 입사일이 빠른 사원 5명을 구하시오
-- 1) 입사일이 빠른 사원 순으로 정렬
SELECT empno, ename, hiredate from emp
order by hiredate asc;

-- 2) 뷰 생성
create or replace view hire_view
as SELECT empno, ename, hiredate 
from emp order by hiredate asc;

select rownum, ename, hiredate from hire_view;

select ename, hiredate from hire_view
where rownum <= 5;

-- 3) 인라인 뷰
-- 입사일이 빠른 사원 5명 검색
SELECT rownum, ename, hiredate 
from(select empno, ename, hiredate from emp 
order by hiredate asc)
where rownum <= 5;

-- 사원 테이블에서 사원번호가 빠른 사원5명 검색
-- 서브 쿼리 형태의 인라인 뷰 형식으로 출력
select empno, ename
from(select empno, ename from emp 
order by empno asc)
where rownum <= 5;

-- * 로 사용해도 같은 내용으로 출력이 된다.
select empno, ename
from(select * from emp 
order by empno asc)
where rownum <= 5;

-- 사원 테이블에서 급여를 많이 받는 사원 5명을 검색
select empno, ename, sal
from(select * from emp
order by sal desc)  -- 인라인 뷰
where rownum <= 5;

-- 입사일이 3~5번째 빠른사원을 검색
select rownum, rnum, ename, hiredate from(
    select rownum rnum, ename, hiredate from(
    select * from emp order by hiredate asc))
    where rnum between 3 and 5;

-- 사원번호가 3~5번째 빠른 사원을 검색
SELECT rownum, rm, ename, empno from(
select rownum rm, ename, empno from(
select * from emp order by empno asc))
where rm between 3 and 5;






