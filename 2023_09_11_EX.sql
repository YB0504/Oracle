-- 2023_09_11 GROUP BY
-- 0 ~ 23시까지, 각 시간대 별로 입양이 몇 건 발생 했는지 조회
-- 결과는 시간대 순 정렬
-- connect by level 사용(계층 쿼리)
select b.HOUR,count(a.HOUR) cnt
from (select to_char(datetime,'HH24') HOUR from animal_outs) a 
   , (select level-1 HOUR from dual connect by level <= 24) b
where b.HOUR=a.HOUR(+)
group by b.HOUR
order by b.HOUR;

-- 설명
-- 1. a 서브 쿼리에서 datetime 컬럼을 24시간 형태로 변환
-- 2. b 서브 쿼리에서 dual테이블을 사용하여 1 ~ 24까지의 숫자를
--    connect by level을 사용하여 생성하고 1씩 뺀 값을 HOUR로 반환
-- 3. where절에서 b.HOUR는 0 ~ 23까지의 시간대, a.HOUR는 테이블에서 
--    가져온 동물의 입양시간대를 나타내고, (+)로 외부조인하여
--    count함수로 두 개의 조건을 만족하는 시간대의 입양 횟수를 가져온다.
-- 4. group by 절에서 b.HOUR로 그룹화해서 조건에 맞는 시간대를 모두 집계한다.

-- connect by level
-- 계층적인 데이터를 표현하기 위한 SQL문
-- 주로 트리 구조의 데이터를 다룰 때 사용하며, 부모 자식 관계의 데이터를
-- 계층적으로 검색하고 표시하는데 쓰인다.
-- 주로 start with 절과 함께 하용한다.
SELECT ...          -- 컬럼 지정
FROM table_name
START WITH condition    
-- 계층 구조의 시작점을 정의하는 조건을 지정하여 최상위 부모 노드를 식별한다.
CONNECT BY PRIOR column_name = parent_column_name;

-- 예제
SELECT empno, ename, job, mgr, LEVEL
FROM emp
START WITH mgr IS NULL -- 최상위 관리자 (PRESIDENT)부터 시작
CONNECT BY PRIOR empno = mgr
ORDER BY empno;










