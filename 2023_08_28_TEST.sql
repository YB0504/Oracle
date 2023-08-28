-- 2023_08_28(TEST)

-- [문항1] 사원 테이블(EMP)에서  SCOTT의 급여보다 적게 받는 사원의 이름, 
--        급여를 출력하는 SQL문을 작성하시오? (10점)
select ename, sal from emp
where sal < (select sal from emp where ename = 'SCOTT');

-- [문항2] 사원 테이블(EMP)에서 각 부서별 평균 급여를 구하는 SQL문을 작성하시오? (10점)
select deptno, avg(sal)as sal from emp
group by deptno order by deptno;

-- [문항3] 사원테이블(EMP)에서  사원명에 A가 포함된 사원을 
--        검색하는 SQL문을 작성하시오? (10점)
select ename from emp where ename like '%A%';

-- [문항4] 사원테이블(EMP)에서 급여를 많이 받는 사원  
--        5명을 구하는 SQL문을 인라인뷰로 작성하시오? (10점)
select ename, sal
from (select * from emp order by sal desc)
where ROWNUM <= 5;

-- [문항5] 사원테이블(EMP)에서 82년도에 입사한 
--        모든 사원의 정보를 출력하는 SQL문을 작성하시오? (10점)
select * from emp where to_char(hiredate, 'yy') = '82';

-- [문항6] 사원테이블(EMP)에서 사번, 이름, 급여, 연봉을 조회하는 SQL문장을 작성하시오?
--        단, 연봉은 별칭을 사용하고, comm이 null값인 경우에는 0으로 연산 처리하시오.
SELECT empno, ename, sal, sal*12 + nvl(comm, '0') as 연봉
from emp;

-- [문항7]  아래의 문제에서 요구하는 SQL문을 각각 작성하시오?  (10점)
-- 1) 아래의 정보로 전산실에 입사한 신입사원에게 새로운 계정을 생성하시오.
--    계정명 : myuser ,  비밀번호 : tiger
-- 2) 생성한 계정에게 데이터 접속 및 테이블, 뷰를 생성할 수 있는 권한을 
--    직접 롤(role)을 생성해서 권한을 부여하시오.
create user myuser
identified by tiger;

create role user_role;

grant create session, create table, create view to user_role;

grant user_role to myuser;

-- [문항8]  아래의 명세서에 따라 제약조건을 만족하는 테이블을 각각 작성하시오? (30점)
create table Book(
    bookid number(2) primary key,
    bookname varchar2(40),
    publisher varchar2(40),
    price number(8));

drop table Book purge;
    
create table Customer1(
    custid number(2) primary key,
    name varchar2(40),
    address varchar2(40),
    phone varchar2(20));
    
drop table Customer1 purge;
    
create table Orders(
    orderid number(2) primary key,
    custid number(2) references Customer1(custid),
    bookid number(2) references Book(bookid),
    saleprice number(8),
    orderdate date default sysdate);

drop table Orders purge;










