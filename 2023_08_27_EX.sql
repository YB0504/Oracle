-- 2023_08_27(프로그래머스 SQL고득점kit is null)

-- 1. 경기도에 위치한 창고의 ID, 이름, 주소, 냉동시설 여부를 조회하는 SQL문을 작성해주세요.
--    이때 냉동시설 여부가 NULL인 경우, 'N'으로 출력시켜 주시고 
--    결과는 창고 ID를 기준으로 오름차순 정렬해주세요.
SELECT WAREHOUSE_ID, WAREHOUSE_NAME, ADDRESS, 
NVL(FREEZER_YN, 'N') AS FREEZER_YN
FROM FOOD_WAREHOUSE 
WHERE ADDRESS LIKE '경기도%'
ORDER BY WAREHOUSE_ID ASC;

-- 2. 동물 보호소에 들어온 동물 중, 이름이 없는 채로 들어온 동물의 ID를 
--    조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
SELECT animal_id from animal_ins
where name is null order by animal_id asc;

-- 3. 동물 보호소에 들어온 동물 중, 이름이 있는 동물의 ID를 
--    조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
select animal_id from animal_ins
where name is not null order by animal_id asc;

-- 4. 나이 정보가 없는 회원이 몇 명인지 출력하는 SQL문을 작성해주세요. 
--    이때 컬럼명은 USERS로 지정해주세요.
select COUNT(user_id)as USERS from user_info
where age is null;

-- 5. 동물의 생물 종, 이름, 성별 및 중성화 여부를 
--    아이디 순으로 조회하는 SQL문을 작성해주세요. 
--    이때 프로그래밍을 모르는 사람들은 NULL이라는 기호를 모르기 때문에, 
--    이름이 없는 동물의 이름은 "No name"으로 표시해 주세요.
select animal_type, nvl(name, 'No name') as NAME, 
sex_upon_intake from animal_ins order by animal_id asc;

---------------------------------------------------------------------------

-- SUM, MAX, MIN

-- 1. 판매 중인 상품 중 가장 높은 판매가를 출력하는 SQL문을 작성해주세요. 
--    이때 컬럼명은 MAX_PRICE로 지정해주세요.
select max(price) as MAX_PRICE from product;


-- 2. 동물 보호소에 가장 먼저 들어온 동물은 
--    언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
select min(datetime) as 시간 from animal_ins;
select max(datetime) as 시간 from animal_ins; -- 가장 늦게 들어온 동물

-- 3. 동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성해주세요.
select count(*) as "총 동물수" from animal_ins;

-- 4. 동물 보호소에 들어온 동물의 이름은 몇 개인지 조회하는 SQL 문을 작성해주세요. 
--    이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.
select count(name) as "이름 개수" 
from(select DISTINCT name from animal_ins); -- distinct 중복 제거

-- 5. 가격이 제일 비싼 식품의 식품 ID, 식품 이름, 식품 코드, 
--    식품분류, 식품 가격을 조회하는 SQL문을 작성해주세요.
select product_id, product_name, product_cd, category, price
from food_product where price 
= (select max(price) from food_product);    -- 서브 쿼리 이용




















