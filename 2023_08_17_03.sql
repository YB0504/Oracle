-- 2023_08_17(과제)

-- 사원테이블(EMP)에서 입사일(HIREDATE)을 4자리 연도로 출력 
-- 되도록 SQL문을 작성하세요? (ex. 1980/01/01)
SELECT hiredate, to_char(hiredate, 'yyyy"년"mm"월"dd"일"')"입사 일"from emp;

-- 사원테이블(EMP)에서 MGR컬럼의  값이  null 인 데이터의 MGR의 
-- 값을  CEO 로  출력하는 SQL문을 작성 하세요?
select * from emp;
select ename, job, nvl(to_char(mgr, '0'),'CEO')
as "상사" from emp where mgr is null;

-- 단계별 설명
-- null 값 검색
SELECT * FROM emp where mgr is NULL;
-- nvl함수를 이용해서 null값을 다른 값으로 치환
SELECT nvl(mgr, 0) from emp where mgr is null;
SELECT nvl(mgr, 'CEO') from emp where mgr is null; -- 오류 발생
-- 문자 데이터 값으로 치환한 NULL값을 CEO로 변환
SELECT nvl(to_char(mgr, '9999'), 'CEO')
as "MANAGER" from emp where mgr is null;


