-- 2023_08_24(과제)

-- 사원테이블(EMP)에서 급여를 3~5번째로 많이 받는 사원을
-- 출력하는 SQL문을 작성 하세요?
select rn, ename, sal from(SELECT rownum rn, ename, sal 
from (select * from emp
order by sal desc))
where rn between 3 and 5;

-----------------------------------------------------------------

-- 급여를 3 ~ 5번째 많이 받는 사원 검색?
select rownum, ename, sal from (
    select * from emp order by sal desc)
where rownum >= 3 and rownum <=5;              -- 검색 안됨

select rownum, ename, sal from ( 
    select rownum rnum, ename, sal from (   -- rownum 컬럼에 별칭 부여  
    select * from emp order by sal desc) )
where rnum >=3 and rnum <=5;

-- 컬럼명을 간결하게 처리
select rnum, ename, sal, hiredate from (
    select rownum rnum, board.* from(
    select * from emp order by sal desc)  board) --서브쿼리에 별칭 부여
where rnum>=3 and rnum <= 5;
-- 컬럼명이 많을 경우 서브쿼리 전체에 별칭을 부여하고 
-- 별칭명.*로 해당하는 모든 컬럼을 자동으로 나열한다.




