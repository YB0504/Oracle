-- 2023_08_18(금)

select 10 + 20 from dept;   -- 4개 출력
SELECT 10 + 20 from emp;    -- 14개 출력

-- dual 테이블
-- 1. sys계정 소유의 테이블(공개 동의어로 설정된 테이블)
-- 2. 공개가 되어 있기 때문에 누구나 사용 가능하다.
-- 3. 데이터가 1개 밖에 없기 때문에 연산 결과가 한 번만 출력된다.

SELECT 10 + 20 FROM dual;   -- 1개 출력
select 10 + 20 from sys.dual; -- 원래는 해당 계정.테이블명으로 사용해야 한다.

desc dual;  -- DUMMY 컬럼 1개 밖에 없다.
select * from dual; -- X 데이터 1개 밖에 없다.

select * from tab;  -- tab : 공개 동의어(sys계정 소유)
select * from sys.tab;

-- 1. 숫자 처리 함수
-- ABS() : 절대값을 구해주는 함수
select -10, abs(-10), ABS(-10) from dual;

-- FLOOR() : 소수점 이하를 버리는 함수
select 10.2, floor(10.2) from dual;

-- ROUND() : 특정 자리에서 반올림을 하는 함수
-- ROUND( 대상 값, 자리수 )
select 34.5678, round(34.5678) from dual; -- 35 : 소수 첫째자리에서 반올림
select 34.5678, round(34.5678, 2) from dual; -- 34.57 : 소수 셋째자리에서 반올림
select 34.5678, round(34.5678, -1) from dual; -- 30 : 정수 1의 자리에서 반올림
select 34.5678, round(35.5678, -1) from dual; -- 40 : 정수 1의 자리에서 반올림

-- TRUNC() : 특정 자리에서 잘라내는 함수
-- TRUNC( 대상 값, 자리수 )
select trunc(34.5678),  trunc(34.5678, 2), trunc(34.5678, -1) from dual;

-- MOD() : 나누기 연산 후의 나머지 값을 구해주는 함수
-- MOD( 대상 값, 나누는 값 )
SELECT mod(27, 2), mod(27, 5), mod(27, 7) from dual;

-- 사원 번호가 홀수인 사원들을 출력하는 SQL문 작성
select ename, empno from emp where mod(empno, 2) = 1;

----------------------------------------------------------------------------

-- 2. 문자 처리 함수
-- UPPER() : 대문자로 변환하는 함수
select 'Welcome to Oracle', UPPER('Welcome to Oracle') from dual;

-- LOWER() : 소문자로 변환하는 함수
select 'Welcome to Oracle', LOWER('Welcome to Oracle') from dual;

-- INITCAP() : 첫글자만 대문자로 변환하는 함수
select 'welcome to oracle', INITCAP('welcome to oracle') from dual;

-- JOB이 manager인 사원을 검색하는 SQL문 작성
SELECT * from emp where lower(job) = 'manager';
SELECT * from emp where job = upper('manager');

-- LENGTH() : 문자열의 길이를 구하는 함수
select length('Oracle'), length('오라클')from dual;    -- 6, 3

-- LENGTHB() : 문자열의 길이를 byte단위로 구하는 함수
-- 영문 1글자 : 1byte, 한글 1글자 : 3byte (배포판에 따라 한글의 byte가 다를 수 있다.)
select lengthb('Oracle'), lengthb('오라클')from dual;

-- SUBSTR() : 전체 문자에서 일부 문자를 추출하는 함수
-- SUBSTR( 대상 문자열, 시작위치, 추출할 개수 )
select substr('welcome to oracle', 4, 3) from dual; -- com
select substr('welcome to oracle', -4, 3) from dual; -- acl
select substr('welcome to oracle', -6, 3) from dual; -- ora

-- 입사일을 년, 월, 일을 추출하는 SQL문 작성
select substr(hiredate, 1, 2) as "년",
       substr(hiredate, 4, 2) as "월",
       substr(hiredate, 7, 2) as "일" from emp;
       
-- 87년도에 입사한 사원을 검색하는 SQL문 작성
select * from emp where substr(hiredate, 1, 2) = 87;

-- 사원명이 대문자 E로 끝나는 사원을 검색하는 SQL문을 작성
SELECT * from emp where ename like '%E';
select * from emp where substr(ename, -1, 1) = 'E';

-- INSTR() : 특정 문자의 위치를 구해주는 함수
-- instr( 대상 문자열, 찾을문자 ) : 가장 먼저 나오는 문자의 위치를 찾는다.
-- instr( 대상 문자열, 찾을문자, 시작위치, 몇번째 발견 )

-- 가장 먼저 나오는 'O'의 위치를 찾는 SQL문 작성
SELECT instr('welcom to oracle', 'o') from dual; -- 5

SELECT instr('welcom to oracle', 'o', 6, 2)from dual;

-- 사원명의 3번째 자리가 R로 되어있는 사원을 검색하는 SQL문 작성
-- 1. LIKE 연산자
SELECT * from emp where ename like '__R%';

-- 2. substr()
SELECT * from emp where substr(ename,3,1) = 'R';

-- 3. instr()
select * from emp where instr(ename, 'R') = 3; -- 가장 먼저 나오는 R의 위치가 3과 같다.
select * from emp where instr(ename, 'R',3 ,1) = 3;

-- LPAD() / RPAD() : 각 방향에 해당 문자를 채워주는 함수
select lpad('oracle', 20, '#')from dual;
select Rpad('oracle', 20, '#')from dual;

-- LTRIM() / RTRIM() : 각 방향의 공백을 삭제 해주는 함수
SELECT '   oracle   ', ltrim('   oracle   ')from dual;
SELECT '   oracle   ', rtrim('   oracle   ')from dual;

-- TRIM() : 문자열 좌, 우측의 공백을 삭제 해주는 함수
--          특정 문자를 잘라내는 함수
SELECT '   oracle   ', trim('   oracle   ')from dual;
SELECT trim('a' from 'aaaaaoracle')from dual;

----------------------------------------------------------------------------

-- 3. 날짜 처리 함수
-- SYSDATE : 시스템의 날짜를 구해오는 함수
--           괄호가 없다
select sysdate from dual;

SELECT sysdate -1 어제, sysdate 오늘, sysdate +1 내일 from dual;

-- 각 사원들의 현재까지 근무한 근무일수를 구하는 SQL문 작성
select ename, sysdate - hiredate from emp;
select ename, round(sysdate - hiredate) from emp; -- 소수 첫째자리 반올림
select ename, trunc(sysdate - hiredate) from emp; -- 소수점 이하를 버림

-- MONTHS_BETWEEN() : 두 날짜 사이의 경과된 개월 수를 구해주는 함수
-- MONTHS_BETWEEN( date1, date2 )

-- 각 사원들이 근무한 개월 수를 구하는 SQL문 작성
SELECT months_between(sysdate, hiredate) from emp; -- 양수 개월수 출력
SELECT months_between(hiredate, sysdate) from emp; -- 음수 개월수 출력

SELECT round(months_between(sysdate, hiredate)) "근무 개월 수" from emp;
SELECT trunc(months_between(sysdate, hiredate)) "근무 개월 수" from emp;

-- ADD_MONTHS() : 특정 날짜에 경과된 개월 수를 더하는 함수
-- ADD_MONTHS( date, 개월 수 )

-- 각 사원들의 입사한 날짜에 6개월이 경과된 날짜를 구하는 SQL문 작성
SELECT ename, hiredate,  add_months(hiredate, 6)from emp;

-- 과정 입과 후 6개월이 경과된 일자를 구하는 SQL문 작성
select add_months('2023.07.11', 6)from dual;

-- NEXT_DAY() : 해당 요일의 특정 요일이 가장 가까운 날짜를 구해주는 함수
-- NEXT_DAY( date, 요일 )
-- 오늘을 기준으로 가장 가까운 토요일이 언제인지 구하는 SQL문 작성
SELECT sysdate, next_day(sysdate, '토요일')from dual;
SELECT hiredate, next_day(hiredate, '화요일')from emp;

-- LAST_DAY() : 해당 달의 마지막 날짜를 구해주는 함수
-- 사원들이 입사한 달의 마지막 날짜를 구하는 SQL문 작성
SELECT hiredate, last_day(hiredate)from emp;

-- 이번달의 마지막 날짜를 구하는 SQL문 작성
SELECT sysdate, last_day(sysdate)from dual;

-- 2023년 2월의 마지막 날짜를 구하는 SQL문 작성
SELECT last_day('2023/02/01')from dual;
SELECT last_day('2020/02/01')from dual;

---------------------------------------------------------------------------

-- 4. 형 변환 함수
-- TO_CHAR(), TO_DATE(), TO_NUMBER()

-- TO_CHAR() : 날짜, 숫자형 데이터를 문자형으로 변환해주는 함수

-- 1) 날짜형 데이터를 문자형 변환
-- TO_CHAR( 날짜 데이터, '출력형식' )
-- 현재 시스템의 날짜를 년, 월, 일, 시, 분, 초, 요일로 출력하는 SQL문 작성
SELECT sysdate, to_char(sysdate, 'yyyy"년"mm"월"dd"일" am hh24:mi:ss DAY')
from dual;

-- 각 사원들의 입사일을 년, 월, 일, 시, 분, 초, 요일로 출력하는 SQL문 작성
SELECT ename, hiredate, to_char(hiredate, 'yyyy"년"mm"월"dd"일" am hh24:mi:ss DAY')
입사일 from emp;

-- 2) 숫자형 데이터를 문자형 변환
-- TO_CHAR( 숫자 데이터, '구분기호 및 출력형식' )

-- 숫자 1230000을 3자리씩 ,로 구분해서 출력
-- 0으로 자릿수를 지정하면, 데이터 길이가 맞지 않을 때 0으로 채운다.
SELECT to_char(1230000, '000,000,000')as 테스트 from dual;

-- 9로 자릿수를 지정하면, 맞지 않는 데이터 길이는 채우지 않는다.
SELECT to_char(1230000, '999,999,999')as 테스트 from dual;

-- 각 사원들의 급여를 3자리씩 ,로 구분해서 출력하는 SQL문 작성
-- L을 붙이면 운영체제 별로 통화기호가 나타난다.
SELECT ename, sal, to_char(sal, 'L999,999') "월 급여" from emp;
select ename, sal, to_char(sal, '999,999L') "월 급여" from emp;

-- TO_DATE() : 문자를 날짜형으로 변환해주는 함수
-- TO_DATE( '문자', '날짜 format' )

-- 2023년 1월 1일부터 현재까지 경과된 일수를 구하는 SQL문 작성
SELECT sysdate, trunc(sysdate - TO_DATE('2023/01/01', 'yyyy/mm/dd'))
"경과된 일수"from dual;

-- 2023년 12월 25일까지 남은 일수를 구하는 SQL문 작성
SELECT sysdate, trunc(to_date('2023/12/25', 'yyyy/mm/dd')
-sysdate)"남은 일수"from dual;

-- 과정 교육기간(2023/07/11 ~ 2024/01/19)의 일수를 구하는 SQL문 작성
select trunc(TO_DATE('2024/01/19', 'yyyy/mm/dd')
- TO_DATE('2023/07/11', 'yyyy/mm/dd'))"과정 일수"from dual;

-- TO_NUMBER() : 문자를 숫자로 변환해주는 함수
-- TO_NUMBER( '문자 데이터', '구분기호 및 출력형식' )
SELECT '20,000' - '10,000' from dual; -- 오류 발생
SELECT TO_NUMBER('20,000', '999,999') 
- TO_NUMBER('10,000', '999,999')from dual;

---------------------------------------------------------------------------

-- NVL() : NULL값을 다른 값으로 치환해주는 함수
-- 1. NULL 값은 정해지지 않은 값을 의미한다.
-- 2. NULL값은 산술 연산이 되지 않는다.
-- NVL( 컬럼, 치환될 값 )

-- 각 사원들의 연봉을 계산하는 SQL문 작성
SELECT ename, job ,sal * 12 + nvl(comm, 0)
as "연봉" from emp order BY sal asc;

-- DECODE() : switch ~ case 구문과 유사
-- DECODE( 컬럼명, 값1, 결과1,
--                값2, 결과2,
--                값3, 결과3,
--                값N, 결과N)

-- 부서번호를 부서명으로 바꿔서 출력하는 SQL문 작성
SELECT ename"사원 명", deptno"부서 번호", decode(deptno, 10, '영업1팀', 20, 
'영업2팀', 30, '영업3팀')as "부서명" from emp order by deptno asc;

-- CASE : if ~ else if 구문과 유사
-- CASE WHEN 컬럼명 = 조건1 THEN 결과1
--      WHEN 컬럼명 = 조건2 THEN 결과2...
--      ELSE 결과N END

-- 부서번호를 부서명으로 바꿔서 출력하는 SQL문을 작성
SELECT ename"사원 명", deptno"부서 번호", CASE when deptno = 10 then '개발1팀'
                                             when deptno = 20 then '개발2팀'
                                             when deptno = 30 then '개발3팀'
                                             END "부서명" from emp order by deptno;
                                             
-----------------------------------------------------------------------------------













