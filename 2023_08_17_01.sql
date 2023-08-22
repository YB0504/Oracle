-- 2023.08.17(목)

-- 논리 연산자 : AND, OR, NOT

-- 1. AND 연산자 : 두 조건식을 모두 만족하는 데이터를 검색
-- 사원 테이블에서 부서번호가 10번이고, job이 MANAGER인 사원을 검색하는 SQL문 작성
SELECT * from emp where deptno = 10 and job = 'MANAGER';

-- 2. OR 연산자 : 두 조건식 중에서 한가지만 만족해도 데이터를 검색
-- 사원 테이블에서 부서번호가 10번이고, job이 MANAGER인 사원을 검색하는 SQL문 작성
select * from emp where deptno = 10 or job = 'MANAGER';

-- 3. NOT 연산자 : 논리값을 반대로 바꿔주는 역할
-- 부서번호가 10번이 아닌 사원을 검색하는 SQL문 작성
select * from emp where not deptno = 10; -- 논리 연산자
select * from emp where deptno != 10; -- 비교 연산자
select * from emp where deptno ^= 10; -- 비교 연산자
select * from emp where deptno <> 10; -- 비교 연산자

-- Quiz 급여를 2000이상 3000 사이의 급여를 받는 사원을 검색하는 SQL문 작성
select * from emp where sal >= 2000 and sal <= 3000;

-- Quiz 커미션이 300이거나 500이거나 1400인 사원을 검색
SELECT * from emp where comm = 300 or comm = 500 or comm = 1400;

-- Quiz 사원번호가 7521 이거나 7654이거나 7844인 사원을 검색하는 SQL문 작성
SELECT * from emp where empno = 7521 or empno = 7654 or empno = 7844;

-- BETWEEN AND 연산자 : 일정한 값의 범위가 있는 경우에 사용 가능하다.
-- WHERE 컬럼명 BETWEEN 작은 값 AND 큰 값
select * from emp where sal BETWEEN 2000 and 3000;

-- Quiz 급여가 2000미만이거나 3000 초과인 사원을 검색하는 SQL문을 작성
SELECT * from emp where sal < 2000 or sal > 3000;
select * from emp where sal NOT BETWEEN 2000 and 3000;

-- 1987년도에 입사한 사원을 검색하는 SQL문 작성
select * from emp where hiredate >= '1987/01/01' and hiredate <= '1987/12/31';
select * from emp where hiredate BETWEEN '1987/01/01' and '1987/12/31';

-- IN 연산자 : OR 연산자를 대신해서 표현할 때 사용한다.
-- WHERE 컬럼명 IN (A, B, C… )

-- 커미션이 300이거나 500이거나 1400인 사원을 검색하는 SQL문을 작성
select * from emp where comm in (300, 500, 1400);

-- 커미션이 300, 500, 1400이 아닌 사원을 검색하는 SQL문을 작성
select * from emp where comm not in(300, 500, 1400);

-- 사원번호가 7521이거나 7844인 사원을 검색하는 SQL문 작성
SELECT * from emp where empno = 7521 or empno = 7844;
select * from emp where empno in (7521, 7844);

-- 사원번호가 7521, 7654, 7844가 아닌 사원을 검색하는 SQL문을 작성
select * from emp where empno <> 7521 and empno <> 7654 and empno <> 7844;
select * from emp where empno not in(7521, 7654, 7844);

----------------------------------------------------------------------------

-- LIKE 연산자와 와일드 카드 : 검색기능을 구현할 때 사용한다.
-- WHERE 컬럼명 LIKE PATTERN(와일드 카드를 이용)

-- 와일드 카드
-- 1. % : 문자가 없거나, 하나 이상의 문자에 어떤 값이 와도 상관없다.
-- 2. _ : 하나의 문자에 어떤 값이 와도 상관없다.

-- % 와일드 카드 : % 자리에 문자가 몇 개가 와도 된다.
-- 사원명이 F로 시작하는 사원명을 검색하는 SQL문 작성
select * from emp where ename like 'F%';

-- 사원명에 A가 들어가는 사원명을 검색하는 SQL문
select * from emp where ename like '%A%';

-- 사원명이 N으로 끝나는 사원명을 검색하는 SQL문
select * from emp where ename like '%N';

-- _ 와일드 카드 : _ 하나가 하나의 문자를 의미한다.

-- 사원 이름의 두 번째 글자가 A인 사원을 검색하는 SQL문을 작성
select * from emp where ename like '_A%';

-- 사원 이름의 세 번째 글자가 A인 사원을 검색하는 SQL문을 작성
select * from emp where ename like '__A%';

-- 사원명에 A가 포함되어 있지 않은 사원을 검색하는 SQL문을 작성
select * from emp where ename not like '%A%';

-- NULL 값을 검색
-- EMP 테이블 : MGR, COMM

-- MGR, comm컬럼에 NULL값인 데이터를 검색
SELECT * from emp where mgr = null; -- 검색안됨
SELECT * from emp where mgr = ''; -- 검색안됨

SELECT * from emp where mgr is null;
SELECT * from emp where comm is null;

-- MGR, comm컬럼에 NULL값이 아닌 데이터를 검색
SELECT * from emp where mgr is NOT null;
SELECT * from emp where comm is NOT null;

---------------------------------------------------
-- 정렬
-- ORDER BY 컬럼명 정렬방식
-- 오름차순(ascending), 내림차순(descending)

-- 숫자 데이터 정렬
-- 급여를 기준으로 오름차순 정렬
SELECT * from emp order by sal asc;

-- 정렬 방식을 생략하면 기본으로 오름차순으로 정렬한다.
SELECT * from emp order by sal;

-- 급여를 기준으로 내림차순 정렬
SELECT * from emp order by sal DESC;

-- 문자 데이터 정렬
-- 사원 명을 기준으로 오름차순 정렬 : 사전순으로 정렬
SELECT * from emp order by ename asc;
SELECT * from emp order by ename; -- 오름차순은 생략 가능

-- 사원 명을 기준으로 내림차순 정렬 : 사전 역순으로 정렬
SELECT * from emp order by ename DESC;

-- 날짜 데이터 정렬
-- 입사한 날짜를 기준으로 정렬
SELECT * from emp order by hiredate asc;
SELECT * from emp order by hiredate desc;

-- NULL 값 정렬
SELECT * from emp order by comm asc;
SELECT * from emp order by comm desc;

-- 여러번 정렬하기
-- 1. 한번 정렬했을 때 동일한 값이 경우 뒤의 정렬 조건으로 한번 더 정렬한다.
-- 2. 두 번째 정렬 조건은 동일한 결과가 나온 데이터만 정렬 조건을 적용한다.

-- 두 번 정렬하기
-- 입사 일을 기준으로 정렬하고, 동일한 입사일이라면 사원명을 내림차순으로 정렬
-- 출력하는 SQL문 작성
select * from emp order by hiredate asc, ename desc;

-- 급여를 기준으로 내림차순 정렬하고, 동일한 급여라면 사원명을 오름차순으로 정렬
select * from emp order by sal desc, ename asc;

-- 부서번호를 기준으로 오름차순 정렬하고, 동일한 번호라면 입사일을 내림차순으로 정렬
select * from emp order by deptno asc, hiredate desc;













