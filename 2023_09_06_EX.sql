-- 2023_09_06
-- 09~19:59���� �� �ð��� ���� �Ծ��� �� �� �߻��ߴ��� ��ȸ�ϴ� SQL�� �ۼ�
-- �ð��� �� ����
-- to_number �Լ��� �������� ��¥ �����͸� �ٽ� ���ڷ� �ٲ㼭 �˻�
select to_number(to_char(datetime, 'HH24')) HOUR, count(*) COUNT
from animal_outs
where to_number(to_char(datetime, 'HH24')) BETWEEN 9 and 20
group by to_number(to_char(datetime, 'HH24'))
order by HOUR asc; -- order by �������� �÷��� ��Ī�� �ִٸ� ��Ī ���

-- ���� �������� ���ã�� ���� ���� ���� �Ĵ��� ��������,ID,�Ĵ��̸�,���ã�����
-- ��ȸ�ϴ� SQL�� �ۼ�(���� ������ �������� �������� ����)
select b.food_type, b.rest_id, b.rest_name, b.favorites
from(select distinct food_type, max(favorites) favorites
    from rest_info group by food_type) a, rest_info b
    where a.food_type = b.food_type
    and a.favorites = b.favorites
order by food_type desc;

-- �Ϸ�� �߰� �ŷ��� �ѱݾ��� 70���� �̻��� ����� ȸ��ID, �г���, �Ѱŷ� �ݾ���
-- ��ȸ�ϴ� SQL�� �ۼ�, �Ѱŷ��ݾ� �������� ��������
select user_id, nickname, total_sales
from used_goods_user join (select writer_id, sum(price) as total_sales
                            from used_goods_board
                            where status = 'DONE'
                            group by writer_id)
                    on writer_id = user_id
                    where total_sales >= 700000
                    order by total_sales asc;























