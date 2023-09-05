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




