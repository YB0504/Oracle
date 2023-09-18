-- 2023_09_17 JOIN
-- 7월 아이스크림 총 주문량과 상반기 아이스크림의 총 주문량을 더한 값이 큰 순서대로
-- 상위 3개 맛을 조회
SELECT A.FLAVOR as FLAVOR
FROM FIRST_HALF A, JULY B
WHERE A.FLAVOR = B.FLAVOR
GROUP BY A.FLAVOR
ORDER BY SUM(A.TOTAL_ORDER + B.TOTAL_ORDER) DESC
FETCH FIRST 3 ROW ONLY;

-- 생산일자가 2022-05인 식품들의 식품ID, 식품이름, 총매출을 조회하는 SQL문
-- 총매출 기준 내림차순 같다면 식품ID 기준 오름차순
select a.product_id, a.product_name, sum(a.price*b.amount)as 총매출
from food_product a, food_order b
where a.product_id = b.product_id
and to_char(b.produce_date, 'yyyy-mm') = '2022-05'
group by a.product_id, a.product_name
order by 총매출 desc, a.product_id asc;
-- 틀린 이유 : 그룹함수를 제외한 모든 컬럼을 group by절에 추가해야한다.

-- 리뷰를 가장 많이 작성한 회원의 리뷰들을 조회하는 SQL문 작성
-- 회원이름, 리뷰텍스트, 리뷰 작성일이 출력되도록 작성
-- 리뷰 작성일 기준 오름차순 같다면 텍스트 기준 오름차순
select a.member_name, b.review_text, 
to_char(b.review_date, 'yyyy-mm-dd')as review_date
from member_profile a join rest_review b
on a.member_id = b.member_id
where a.member_id = (select max(member_id) from rest_review)
group by a.member_name
order by b.review_date asc, b.review_text asc;

-- 정답
SELECT A.MEMBER_NAME, B.REVIEW_TEXT, TO_CHAR(B.REVIEW_DATE,'YYYY-MM-DD') AS REVIEW_DATE
FROM MEMBER_PROFILE A, REST_REVIEW B
WHERE A.MEMBER_ID = B.MEMBER_ID -- 리뷰를 작성한 회원이 누구인지 알 수 있다.
AND A.MEMBER_ID IN
(SELECT MEMBER_ID FROM (
    -- 1. 유저 ID 및 유저별 리뷰 수를 구하는 쿼리
    SELECT MEMBER_ID, COUNT(*) AS CNT FROM REST_REVIEW
    GROUP BY MEMBER_ID)WHERE CNT = (
    -- 2. 최대 리뷰 수 구하는 쿼리
    SELECT MAX(COUNT(*)) AS MAXCNT FROM REST_REVIEW
    GROUP BY MEMBER_ID))
ORDER BY B.REVIEW_DATE, B.REVIEW_TEXT;

-- 2021년에 가입한 전체 회원들 중 상품을 구매한 회원수와 
-- 상품을 구매한 회원의 비율
-- (=2021년에 가입한 회원 중 상품을 구매한 회원수 / 2021년에 가입한 전체 회원 수)
-- 년, 월 별로 출력하는 SQL문을 작성
-- 회원의 비율은 소수점 두번째자리에서 반올림하고, 
-- 년을 기준 오름차순 정렬 같다면 월을 기준 오름차순 정렬
SELECT to_char(a.joined,'yyyy')as "YEAR", to_number(to_char(a.joined,'mm'))as "MONTH",
count(distinct a.user_id)as "구매한회원수", round(count(distinct a.user_id) / count(b.user_id), 1)as "회원비율"
from user_info a
right join online_sale b
on a.user_id = b.user_id
where b.user_id = (select count(distinct user_id) from (
    select count(user_id) from user_info where to_char(joined, 'yyyy') = '2021'))
group by to_char(a.joined,'yyyy'), to_number(to_char(a.joined,'mm'))
order by year asc, month asc;
-- 구매한 회원수를 조회하랬더니 가입한 회원수? 컬럼 select를 잘못했다...

-- 참조한 정답
SELECT TO_CHAR(SALES_DATE, 'YYYY') as YEAR,
       TO_NUMBER(TO_CHAR(SALES_DATE, 'MM')) as MONTH,
       COUNT(DISTINCT(I.USER_ID)) as PUCHASED_USERS,
       ROUND(COUNT(DISTINCT(I.USER_ID)) / 
             (SELECT COUNT(DISTINCT(USER_ID)) 
              FROM USER_INFO
              WHERE TO_CHAR(JOINED, 'YYYY') = '2021')
             ,1) as PUCHASED_RATIO       
FROM USER_INFO I RIGHT JOIN ONLINE_SALE S ON I.USER_ID = S.USER_ID
WHERE TO_CHAR(JOINED, 'YYYY') = '2021'
GROUP BY TO_CHAR(SALES_DATE, 'YYYY'), TO_CHAR(SALES_DATE, 'MM')
ORDER BY year asc, month asc;











