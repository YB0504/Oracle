-- 2023_08_30

-- 1. ��ȸ���� ���� ���� �߰�ŷ� �Խù��� ���� ÷������ ��θ� ��ȸ�ϴ� SQL �ۼ�
--    file_id ���� ��������
select '/home/grep/src/' || board_id || '/' || file_id || file_name
    || file_ext as  FILE_PATH
from used_goods_file
where board_id
    = (select board_id from used_goods_board
    where views = (select max(views) from used_goods_board))
    order by file_id desc;
    
-- 2. �ڵ��� ������ ������ �ڵ��� �� 10���� �뿩�� ������ ����� �ִ� 
--    �ڵ��� ID����Ʈ�� ����ϴ� SQL�� �ۼ�
--    �ߺ� X distinct �ڵ��� ID ���� ��������
select distinct c.car_id    -- �ߺ����� ���� �ڵ��� ID �˻�
-- � ����
from car_rental_company_car c, CAR_RENTAL_COMPANY_RENTAL_HISTORY h
where c.car_type = '����' and to_char(h.start_date, 'yyyy-mm') = '2022-10'
and c.car_id = h.car_id
order by car_id desc;





