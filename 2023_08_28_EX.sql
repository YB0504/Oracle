-- 2023_08_28(String,Date)

-- 1. 조건에 부합하는 중고거래 상태 조회하기
select board_id, writer_id, title, price,
CASE when status = 'SALE' then '판매중'
     when status = 'RESERVED' then '예약중'
     when status = 'DONE' then '거래완료' end as status
     from used_goods_board 
     where to_char(created_date, 'yyyy-mm-dd') = '2022-10-05' 
     order by board_id desc;
     
-- 2. 자동차 대여기록에서 장기/단기 대여 구분하기
--    30일이상이면 장기 대여, 아니면 단기 대여(컬럼은 rent_type)
--    날짜 데이터의 형식은 제시된 테이블과 동일
select history_id, car_id,
to_char(start_date, 'yyyy-mm-dd') start_date, 
to_char(end_date, 'yyyy-mm-dd') end_date,
case when end_date - start_date + 1 >= 30 then '장기 대여'
ELSE '단기 대여' end as rent_type
from car_rental_company_rental_history
where to_char(start_date, 'yyyy-mm') = '2022-09'
order by history_id desc;

-- 3. 특정 옵션이 포함된 리스트 구하기
--    네비게이션 옵션이 포함
select car_id, car_type, daily_fee, options
from car_rental_company_car
where options like '%네비게이션%'
order by car_id desc;

-- 4. 루시와 엘라 찾기
--    in 연산자는 or로 대체 가능
select animal_id, name, sex_upon_intake
from animal_ins
where name IN ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty')
order by animal_id asc;

-- 5. 이름에 el이 들어가는 동물(개) 찾기
--    대소문자 구별을 하지 않는다.
--    lower, upper, initcap 사용
select animal_id, name from animal_ins
where upper(name) like upper('%el%') and animal_type = 'Dog'
order by name asc;

-- 6. 중성화 여부 파악하기
--    중성화가 되었다면 'O' 아니라면 'X'
--    와일드 카드 패턴은 like와 사용
select animal_id, name,
case when sex_upon_intake like 'Neutered%' then 'O'
     when sex_upon_intake like 'Spayed%' then 'O'
     else 'X' end as "중성화 여부"
     from animal_ins order by animal_id asc;

-- 7. datetime 에서 date로 형 변환
--    동물의 아이디, 이름, 들어온 날짜를 조회
select animal_id, name, to_char(datetime, 'yyyy-mm-dd')as "들어온 날짜"
from animal_ins order by animal_id asc;

-- 8. 카테고리 별 상품 개수 구하기
--    카테고리 코드는 상품코드의 앞 2자리
--    인라인뷰 사용
--    substr()로 앞의 2자리를 추출 별칭명 지정 후 사용
SELECT category , count(category)
FROM (SELECT substr(product_code,1,2) AS category
      FROM product)
GROUP BY category
ORDER BY category asc;








