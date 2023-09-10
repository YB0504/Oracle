-- 2023_09_10 GROUP BY
-- 2022년 1월의 도서판매 데이터를 기준으로 저자 별, 카테고리 별 매출액(TOTAL_SALES)을
-- 구하고, 저자ID, 저자명, 카테고리, 매출액 리스트를 출력하는 SQL문을 작성
-- 저자ID 기준 오름차순, 카테고리 기준 내림차순
SELECT a.author_id as author_id, b.author_name as author_name,
a.category as category, sum(c.sales * a.price) as total_sales
from book a, author b,
(select book_id, to_char(sales_date, 'yyyy-mm'), sales
from book_sales
where to_char(sales_date,'yyyy-mm') = '2022-01') c
where a.author_id = b.author_id
and a.book_id = c.book_id
group by a.author_id, b.author_name, a.category
order by author_id asc, category desc;

-- 식품분류별로 가격이 제일 비싼 식품의 분류, 가격, 이름을 조회하는 SQL문 작성
-- 식품분류가 과자, 국, 김치, 식용유인 경우만 출력
-- 식품가격 기준 내림차순
-- where 조건절에 서브쿼리에서 찾은 결과와 메인 쿼리의 결과가 일치하는 값만
-- 찾기 위해 where 조건절에서 두개의 컬럼을 묶는다.
select category, price as max_price, product_name
from food_product
where (category, price) in (select category, max(price) max_price
    from food_product where category in ('과자','국','김치','식용유')
    group by category)
order by max_price desc;

-- 년, 월, 성별 별로 상품을 구매한 회원수를 집계하는 SQL문을 작성
-- 결과는 년, 월, 성별을 기준으로 오름차순 정렬
-- 성별 정보가 없는 경우 결과에서 제외
-- 예시에 나온 MONTH값은 1,2...로 표시 되기 때문에 
-- to_number함수로 '01'이 아닌 1로 출력되게 작성
-- 구매 수 가 아닌 구매한 회원!의 수이기 때문에 distinct로 중복 구매한 회원을 제외
select to_char(b.sales_date, 'yyyy') YEAR, 
to_number(to_char(b.sales_date, 'mm')) MONTH,
a.gender GENDER, count(distinct b.user_id) users
from user_info a join online_sale b on a.user_id = b.user_id
where gender is not null
group by a.gender, to_char(b.sales_date, 'yyyy'), to_char(b.sales_date, 'mm')
order by YEAR asc, MONTH asc, GENDER asc;

-- 0 ~ 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문 작성
-- 결과는 시간대 순 정렬










