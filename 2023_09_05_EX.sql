--2023_09_05 GROUP BY
-- 상반기 아이스크림 성분 타입과 해당 아이스크림의 총주문량을 조회하는 SQL
-- 총주문량이 작은 순으로 정렬 컬럼명 TOTAL_ORDER
select ingredient_type, sum(total_order) TOTAL_ORDER
from first_half a, icecream_info b
where a.flavor = b.flavor
group by ingredient_type
order by TOTAL_ORDER asc;

-- '통풍시트', '열선시트', '가죽시트' 중 하나 이상의 옵션이 포함된 자동차가
-- 종류별로 몇 대인지 출력하는 SQL문 출력
-- 자동차 수에 대한 컬럼명 CARS, 종류 기준으로 오름차순 정렬
select car_type, COUNT(car_id) CARS
from car_rental_company_car
where options in like('%가죽시트%', '%열선시트%', '%통풍시트%')
group by car_type
order by CARS asc;
-- in연산자는 like를 사용할 수 없다.

-- 정답 코드
select car_type, COUNT(car_type) CARS
from car_rental_company_car
where options like '%시트%'
-- 해당 글자의 앞뒤로 어떤 형태의 문자가 와도 가능하도록 앞뒤로 %작성
-- 시트라는 문자로 문자열이 끝나지 않는 경우도 있다.
group by car_type
order by car_type asc;

-- 2022년 5월에 예약한 환자 수를 진료과 코드별로 조회하는 SQL문
-- 컬럼명은 '진료과 코드', '5월예약건수'
-- 환자수를 기준 오름차순, 같다면 진료과 코드를 기준으로 오름차순
-- 예약취소여부와 상관없이 예약을 한! 환자수를 센다.
select mcdp_cd as "진료과코드", count(*)as "5월예약건수"
from appointment
where to_char(apnt_ymd,'yyyy-mm') = '2022-05'
group by mcdp_cd
order by count(*) asc, mcdp_cd asc;

-- 동물보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문
-- 고양이를 개보다 먼저 조회
select animal_type, count(animal_type) 마리수
from animal_ins
where animal_type in('Cat', 'Dog')
group by animal_type
order by animal_type asc;

-- 동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 
-- 해당 이름이 쓰인 횟수를 조회하는 SQL문
-- 이름이 없는 동물은 제외, 이름 순으로 조회
-- HAVING 절에는 COUNT, SUM, AVG, MAX, MIN 등 집계함수를 사용하여 조건을 부여
-- 그룹화된 대상의 조건 안에서만 출력한다.
select name, count(name) countname from animal_ins
group by name
having count(name) >= 2
order by name asc;


















