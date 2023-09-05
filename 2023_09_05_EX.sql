--2023_09_05 GROUP BY
-- ��ݱ� ���̽�ũ�� ���� Ÿ�԰� �ش� ���̽�ũ���� ���ֹ����� ��ȸ�ϴ� SQL
-- ���ֹ����� ���� ������ ���� �÷��� TOTAL_ORDER
select ingredient_type, sum(total_order) TOTAL_ORDER
from first_half a, icecream_info b
where a.flavor = b.flavor
group by ingredient_type
order by TOTAL_ORDER asc;

-- '��ǳ��Ʈ', '������Ʈ', '���׽�Ʈ' �� �ϳ� �̻��� �ɼ��� ���Ե� �ڵ�����
-- �������� �� ������ ����ϴ� SQL�� ���
-- �ڵ��� ���� ���� �÷��� CARS, ���� �������� �������� ����
select car_type, COUNT(car_id) CARS
from car_rental_company_car
where options in like('%���׽�Ʈ%', '%������Ʈ%', '%��ǳ��Ʈ%')
group by car_type
order by CARS asc;
-- in�����ڴ� like�� ����� �� ����.

-- ���� �ڵ�
select car_type, COUNT(car_type) CARS
from car_rental_company_car
where options like '%��Ʈ%'
-- �ش� ������ �յڷ� � ������ ���ڰ� �͵� �����ϵ��� �յڷ� %�ۼ�
-- ��Ʈ��� ���ڷ� ���ڿ��� ������ �ʴ� ��쵵 �ִ�.
group by car_type
order by car_type asc;




