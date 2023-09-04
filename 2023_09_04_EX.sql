-- 2023_09_04
-- 자동차 종류가 '트럭'인 대여 기록의 대여 기록 별로 
-- 대여 금액(컬럼명: FEE)을 구하여 대여 기록 ID와 대여 금액 리스트를 출력하는 SQL문
-- 대여 금액을 기준으로 내림차순 정렬, 같은 경우 대여 기록 ID를 기준으로 내림차순 정렬
SELECT h.history_id, (c.daily_fee * (h.end_date - h.start_date + 1)) * 
nvl(1 - p.discount_rate/100, 1) as FEE
from car_rental_company_car c, car_rental_company_rental_history h,
car_rental_company_discount_plan p
where c.car_id = h.car_id
and c.car_type = p.car_type
and p.duration_type = (case when to_char(h.end_date - h.start_date + 1) >= '90' then '90일 이상'
                            when to_char(h.end_date - h.start_date + 1) >= '30' then '30일 이상'
                            when to_char(h.end_date - h.start_date + 1) >= '7' then '7일 이상'
                            else null end)
and c.car_type = '트럭'
order by FEE desc, h.history_id desc;
-- 3개의 테이블로 SQL문을 작성할 때의 연결고리는 2개

-- INNER JOIN으로 JOIN할 시 FROM절에 테이블에 약칭을 붙여 나열
-- 연결고리가 될 공통 컬럼을 찾아 관계 정의

-- ANSI JOIN으로 JOIN할 시 
-- 2개의 테이블을 먼저 테이블명1 별칭1 JOIN 테이블명2 별칭2 
-- ON 별칭1.공통컬럼명 = 별칭2.공통컬럼명
-- JOIN 테이블명3 별칭3 ON 별칭2.공통컬럼명 = 별칭3.공통컬럼명

-- 정답 코드
SELECT HISTORY_ID, 
       (DAILY_FEE*(B.END_DATE-B.START_DATE+1))*NVL(1-DISCOUNT_RATE/100, 1) AS FEE 
FROM CAR_RENTAL_COMPANY_CAR A 
JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY B 
ON A.CAR_ID = B.CAR_ID
LEFT OUTER JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN C
-- 왼쪽의 테이블을 LEFT JOIN조인하되 OUTER조인처럼 내용을 합친다.
ON A.CAR_TYPE = C.CAR_TYPE
AND C.DURATION_TYPE = (CASE WHEN (B.END_DATE-B.START_DATE+1)>='90' THEN '90일 이상'
                            WHEN (B.END_DATE-B.START_DATE+1)>='30' THEN '30일 이상'
                            WHEN (B.END_DATE-B.START_DATE+1)>='7' THEN '7일 이상'
                          ELSE NULL END)                        
WHERE A.CAR_TYPE = '트럭'
ORDER BY FEE DESC, B.HISTORY_ID DESC;