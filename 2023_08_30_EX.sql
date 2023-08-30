-- 2023_08_30

-- 1. 조회수가 가장 높은 중고거래 게시물에 대한 첨부파일 경로를 조회하는 SQL 작성
--    file_id 기준 내림차순
select '/home/grep/src/' || board_id || '/' || file_id || file_name
    || file_ext as  FILE_PATH
from used_goods_file
where board_id
    = (select board_id from used_goods_board
    where views = (select max(views) from used_goods_board))
    order by file_id desc;
    
-- 2. 자동차 종류가 세단인 자동차 중 10월에 대여를 시작한 기록이 있는 
--    자동차 ID리스트를 출력하는 SQL문 작성
--    중복 X distinct 자동차 ID 기준 내림차순
select distinct c.car_id    -- 중복되지 않은 자동차 ID 검색
-- 등가 조인
from car_rental_company_car c, CAR_RENTAL_COMPANY_RENTAL_HISTORY h
where c.car_type = '세단' and to_char(h.start_date, 'yyyy-mm') = '2022-10'
and c.car_id = h.car_id
order by car_id desc;





