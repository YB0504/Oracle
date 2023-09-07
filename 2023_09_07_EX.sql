-- 2023_09_07 Group By
-- 2022년 1월의 카테고리 별 도서 판매량을 합산하고,
-- 카테고리, 총 판매량 리스트를 출력하는 SQL문 작성
-- 카테고리명 기준 오름차순 정렬
select distinct a.category category, sum(b.sales) total_sales
from book a, book_sales b
where a.book_id = b.book_id
and to_char(b.sales_date, 'yyyy-mm') = '2022-01'
group by category
order by category asc;

-- 2022년 10월 16일에 대여중인 자동차인 경우 '대여중'으로 표시, 
-- 대여 중이지 않으면 '대여 가능'으로 표시하는 컬럼을 추가(컬럼명 : availability)
-- 자동차 ID와 availability 리스트를 출력하는 SQL문을 작성
-- 반납날짜가 2022년 10월 16일인 경우에도 '대여중'으로 표시
-- 자동차 ID기준 내림차순
select car_id, availability
from car_rental_company_rental_history
where car_id = (select car_id from car_rental_company_rental_history
    where case when '2022-10-16' between to_char(end_date, 'yyyy-mm-dd') 
    and to_char(start_date, 'yyyy-mm-dd') 
    then '대여중' else '대여 가능' end availability)
group by car_id
order by car_id desc;

-- 정답 코드
SELECT CAR_ID, 
MAX(CASE WHEN '2022-10-16' BETWEEN TO_CHAR(START_DATE,'YYYY-MM-DD') 
    AND TO_CHAR(END_DATE,'YYYY-MM-DD') THEN '대여중'
    ELSE '대여 가능'
    END) AS AVAILABILITY 
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
ORDER BY CAR_ID DESC;

-- 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상인 
-- 자동차들에 대해서 해당 기간 동안의 월별 자동차 ID 별 
-- 총 대여 횟수(컬럼명: RECORDS)리스트를 출력하는 SQL문을 작성
-- 결과는 월을 기준으로 오름차순 정렬, 같다면 자동차ID를 기준으로 내림차순 정렬
-- 특정 월의 총 대여횟수가 0인 경우는 결과에서 제외
select to_number(to_char(start_date, 'mm')) month, car_id,
count(*) as records from CAR_RENTAL_COMPANY_RENTAL_HISTORY
where car_id in(select car_id from CAR_RENTAL_COMPANY_RENTAL_HISTORY
where to_char(start_date,'yyyy-mm') in ('2022-08','2022-09','2022-10')
group by car_id having count(*) >= 5)
and to_number(to_char(start_date, 'mm')) between 8 and 11
group by to_number(to_char(start_date, 'mm')), car_id
order by month asc, car_id desc;












