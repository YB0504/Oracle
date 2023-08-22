-- 2023_08_21(월)

-- JOIN
-- : 2개 이상의 테이블을 결합해서 정보를 구해오는 것

-- 조인의 필요성
-- SCOTT 사원이 소속된 부서명을 출력하는 SQL문 작성
-- 1) SCOTT 사원의 부서 번호를 구하기(사원테이블emp)
SELECT deptno from emp where ename = 'SCOTT';
-- 2) 부서 테이블(dept)에서 20번 부서의 부서명을 구하기
SELECT dname from dept where deptno = 20;

-- 1. Cross Join
-- 테이블 명을 ,를 사용하여 연속하여 작성 하는 것
SELECT * from emp, dept; -- 4 * 14 = 56개의 데이터 검색

-- Cross Join의 종류
-- 1. 등가 조인(Equi Join)
-- 2. 비 등가 조인(Non-Equi Join)
-- 3. 자체 조인(Self Join)
-- 4. 외부 조인(Outer Join)

-- 1. 등가 조인(Equi Join)
--    두 개의 테이블에 동일한 컬럼을 기준으로 조인 하는 것
select * from emp, dept where emp.deptno = dept.deptno; -- 14개의 데이터

-- SCOTT 사원이 소속된 부서명을 출력하는 SQL문 작성
select ename, dname from emp, dept 
    where emp.deptno = dept.deptno and ename = 'SCOTT';

-- 부서번호와 부서명을 출력
-- 공통적인 컬럼은 반드시 컬럼 앞에 쓰고자하는 테이블명을 적어야한다.
-- 테이블.공통컬럼명
-- 공통컬럼이 아닌 컬럼들은 테이블명을 생략할 수 있다.

select ename, dname, deptno from emp, dept 
    where emp.deptno = dept.deptno and ename = 'SCOTT'; -- 오류 발생

select ename, dname, emp.deptno, sal, loc from emp, dept 
    where emp.deptno = dept.deptno and ename = 'SCOTT';

-- 테이블에 별칭 부여하기
-- 1) 테이블에 별칭이 부여되면 테이블명이 아닌 별칭을 사용만 사용할 수 있다.
-- 2) 별칭명은 대,소문자를 구분하지 않는다.
-- 3) 공통컬럼은 별칭명 . 공통컬럼명으로 사용하게 된다.
-- ex) e.deptno, d.deptno
-- 4) 공통컬럼이 아닌 컬럼은 앞에 별칭명을 생략할 수 있다.

select ename, D.dname, e.deptno, sal, loc from emp e, dept d 
    where e.deptno = d.deptno and ename = 'SCOTT';
    
select ename, dept.dname, emp.deptno, sal, loc from emp e, dept d 
    where e.deptno = d.deptno and ename = 'SCOTT'; -- 오류 발생
    
-- 2. 비 등가 조인(Non-Equi Join)
--    두 개의 테이블에 동일한 컬럼없이 다른 조건을 이용하여 조인 하는 것

-- 각 사원들의 급여가 몇 등급인지를 출력하는 SQL문 작성
-- emp(sal) - salgrade(grade)
SELECT ename, sal from emp;
SELECT * from salgrade;
-- 1	700	    1200
-- 2	1201	1400
-- 3	1401	2000
-- 4	2001	3000
-- 5	3001	9999

select ename, sal, grade from emp, salgrade
    where sal >= losal and sal <= hisal;
    
SELECT ename, sal, grade from emp, salgrade
    where sal BETWEEN losal and hisal;

SELECT ename, sal, grade from emp e, salgrade s
    where sal BETWEEN losal and hisal and deptno = 30;

-- 3. 자체 조인(Self Join)
--    한 개의 테이블 내에서 컬럼과 컬럼 사이의 관계를 이용하여 조인 하는 것

-- 자체 조인을 이용해서 각 사원들의 사원명과 매니저를 출력하는 SQL문 작성
-- empno(사원번호) - mgr(매니저의 사원번호)
SELECT employee.ename || '의 상사는 ' || manager.ename as "상사"
from emp employee, emp manager where employee.mgr = manager.empno; -- 13개의 데이터

-- 4. 외부 조인(Outer Join)
--    조인 조건을 만족하지 않는 데이터를 출력해주는 조인
-- 1) 테이블을 조인할 때 어느 한 쪽의 테이블에는 데이터가 존재하지만, 다른 테이블에는
-- 데이터가 존재하지 않는 경우에 그 데이터가 출력되지 않는 문제를 해결하기 위해 사용하는 조인
-- 2) 정보가 부족한 곳에 (+)를 추가한다.

-- 자체조인의 결과, KING사원은 상사가 없기 때문에 출력되지 않았는데,
-- KING사원도 외부조인을 이용하여 출력
SELECT employee.ename || '의 상사는 ' || manager.ename as "상사"
from emp employee, emp manager where employee.mgr = manager.empno(+);

-- dept테이블과 emp테이블을 등가 조인을 하면 40번 부서가 나타나지 않기 때문에
-- 외부 조인을 이용해서 40번 부서도 출력

-- 1) 등가 조인
SELECT d.deptno, ename, dname from emp e, dept d
    where d.deptno = e.deptno order by deptno asc;
    
-- 2) 외부 조인
SELECT d.deptno, ename, dname from emp e, dept d
    where d.deptno = e.deptno(+) order by deptno asc;
    
---------------------------------------------------------------------------

-- ANSI JOIN
-- ANSI(미국 표준 협회) 표준안에 따라서 만들어진 join방법

-- ANSI Cross Join
SELECT * from emp CROSS join dept; -- 4 * 14 = 56개의 데이터
SELECT * from dept CROSS join emp; -- 14 * 4 = 56개의 데이터

-- ANSI Inner Join(등가 조인)
-- SELECT * from 테이블명1 inner join 테이블명2 on 테이블명.컬럼명1 = 테이블명2.컬럼명2

-- SCOTT 사원이 소속된 부서명을 출력하는 SQL ansdmf ANSI Inner Join으로 작성
-- 조건이 추가로 필요할 때는 WHERE 조건절을 추가해서 사용한다.
SELECT ename, dname from dept inner join emp
    on dept.deptno = emp.deptno where ename = 'SCOTT';
    
-- USING을 사용하여 조인
SELECT ename, dname, loc from dept join emp
    USING(deptno) where ename = 'SCOTT';
    
-- NATURAL JOIN을 사용한 조인
SELECT ename, dname from dept NATURAL join emp where ename = 'SCOTT';

-- ANSI Outer Join
-- select * from table1 [ left | right | full ] outer join table2;

-- 1. dept01 테이블 생성
CREATE table dept01(
deptno NUMBER(2),
dname varchar2(14));

insert into dept01 VALUES(10, 'ACCOUNTING');
insert into dept01 VALUES(20, 'RESEARCH');

SELECT * from dept01;

DROP table dept01;

-- 2. dept02 테이블 생성
CREATE table dept02(
deptno NUMBER(2),
dname varchar2(14));

insert into dept02 VALUES(10, 'ACCOUNTING');
insert into dept02 VALUES(30, 'SALES');

select * from dept02;

-- left outer join : dept01의 정보만 출력
SELECT * from dept01 left OUTER join dept02 USING(deptno);

-- right outer join : dept02의 정보만 출력
SELECT * from dept01 right OUTER join dept02 USING(deptno);

-- full outer join : 모든 테이블의 정보를 출력
SELECT * from dept01 full OUTER join dept02 USING(deptno);
