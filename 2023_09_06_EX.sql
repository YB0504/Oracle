-- 2023_09_06
-- 09~19:59까지 각 시간대 별로 입양이 몇 건 발생했는지 조회하는 SQL문 작성
-- 시간대 순 정렬
-- to_number 함수로 문자형인 날짜 데이터를 다시 숫자로 바꿔서 검색
select to_number(to_char(datetime, 'HH24')) HOUR, count(*) COUNT
from animal_outs
where to_number(to_char(datetime, 'HH24')) BETWEEN 9 and 20
group by to_number(to_char(datetime, 'HH24'))
order by HOUR asc; -- order by 절에서는 컬럼명에 별칭이 있다면 별칭 사용

-- 음식 종류별로 즐겨찾기 수가 가장 많은 식당의 음식종류,ID,식당이름,즐겨찾기수를
-- 조회하는 SQL문 작성(음식 종류를 기준으로 내림차순 정렬)
select b.food_type, b.rest_id, b.rest_name, b.favorites
from(select distinct food_type, max(favorites) favorites
    from rest_info group by food_type) a, rest_info b
    where a.food_type = b.food_type
    and a.favorites = b.favorites
order by food_type desc;























