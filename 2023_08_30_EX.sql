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

-- 3. �߰� �ŷ� �Խù��� 3�� �̻�(count)����� �������
--    ����� ID, �г���, ��ü �ּ�, ��ȭ��ȣ�� ��ȸ�ϴ� SQL�� �ۼ�
--    ��ü �ּҴ� ��, ���θ� �ּ�, ���ּ� (||) ��ȭ��ȣ�� ������ ����
--    ȸ�� ID���� ��������
select user_id,nickname,city||' '||street_address1||' '||street_address2 as ��ü�ּ�,
substr(tlno,1,3)||'-'||substr(tlno,4,4)||'-'||substr(tlno,8,4) as ��ȭ��ȣ
from used_goods_user, used_goods_board
where nickname = (select writer_id from used_goods_board
                where count(writer_id) >= 3)
order by user_id desc;

-- ����
-- ���� ������ �׷��Լ��� count�� ����ϱ� ������ group by ���� having���� ���
select user_id,nickname,city||' '||street_address1||' '||street_address2 as ��ü�ּ�,
substr(tlno,1,3)||'-'||substr(tlno,4,4)||'-'||substr(tlno,8,4) as ��ȭ��ȣ
from used_goods_user
where user_id IN (select writer_id from used_goods_board
                  group by writer_id
                  having count(writer_id) >= 3)
order by user_id desc;

-- 4. �Ծ��� �� ���� ��, ��ȣ�Ⱓ�� ���� ����� ���� �θ�����
--    ���̵�� �̸��� ��ȸ�ϴ� SQL�� �ۼ�
--    ��ȣ �Ⱓ�� �� ������ ��ȸ
--    �ζ��κ�(inner join)
select animal_id, name from (
    select o.animal_id, o.name from animal_ins i 
    join animal_outs o on i.animal_id = o.animal_id
    order by o.datetime - i.datetime desc)
    -- order by ���� �÷��� ���� �� �� �ִ� ���� �ƴϴ�.
    where rownum <= 2; -- �θ����� ��ȸ�ϴ� ���̱� ������ ���� 2�� �������ش�













