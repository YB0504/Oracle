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

-- 3. 중고 거래 게시물을 3건 이상(count)등록한 사용자의
--    사용자 ID, 닉네임, 전체 주소, 전화번호를 조회하는 SQL문 작성
--    전체 주소는 시, 도로명 주소, 상세주소 (||) 전화번호는 하이픈 삽입
--    회원 ID기준 내림차순
select user_id,nickname,city||' '||street_address1||' '||street_address2 as 전체주소,
substr(tlno,1,3)||'-'||substr(tlno,4,4)||'-'||substr(tlno,8,4) as 전화번호
from used_goods_user, used_goods_board
where nickname = (select writer_id from used_goods_board
                where count(writer_id) >= 3)
order by user_id desc;

-- 수정
-- 서브 쿼리에 그룹함수인 count를 사용하기 때문에 group by 절과 having절을 사용
select user_id,nickname,city||' '||street_address1||' '||street_address2 as 전체주소,
substr(tlno,1,3)||'-'||substr(tlno,4,4)||'-'||substr(tlno,8,4) as 전화번호
from used_goods_user
where user_id IN (select writer_id from used_goods_board
                  group by writer_id
                  having count(writer_id) >= 3)
order by user_id desc;

-- 4. 입양을 간 동물 중, 보호기간이 가장 길었던 동물 두마리의
--    아이디와 이름을 조회하는 SQL문 작성
--    보호 기간이 긴 순으로 조회
--    인라인뷰(inner join)
select animal_id, name from (
    select o.animal_id, o.name from animal_ins i 
    join animal_outs o on i.animal_id = o.animal_id
    order by o.datetime - i.datetime desc)
    -- order by 에는 컬럼명만 기재 할 수 있는 것이 아니다.
    where rownum <= 2; -- 두마리를 조회하는 것이기 때문에 값을 2로 제한해준다













