-- 2023_08_24(과제)

-- 사원테이블(EMP)에서 급여를 3~5번째로 많이 받는 사원을
-- 출력하는 SQL문을 작성 하세요?
select rownum, ename, sal from(SELECT  ename, sal 
from (select ename, sal from emp
order by sal desc) where rownum <= 5 order by sal asc)
where rownum <= 3 order by sal desc;



















