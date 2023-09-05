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

-- 2022�� 5���� ������ ȯ�� ���� ����� �ڵ庰�� ��ȸ�ϴ� SQL��
-- �÷����� '����� �ڵ�', '5������Ǽ�'
-- ȯ�ڼ��� ���� ��������, ���ٸ� ����� �ڵ带 �������� ��������
-- ������ҿ��ο� ������� ������ ��! ȯ�ڼ��� ����.
select mcdp_cd as "������ڵ�", count(*)as "5������Ǽ�"
from appointment
where to_char(apnt_ymd,'yyyy-mm') = '2022-05'
group by mcdp_cd
order by count(*) asc, mcdp_cd asc;

-- ������ȣ�ҿ� ���� ���� �� ����̿� ���� ���� �� �������� ��ȸ�ϴ� SQL��
-- ����̸� ������ ���� ��ȸ
select animal_type, count(animal_type) ������
from animal_ins
where animal_type in('Cat', 'Dog')
group by animal_type
order by animal_type asc;

-- ���� ��ȣ�ҿ� ���� ���� �̸� �� �� �� �̻� ���� �̸��� 
-- �ش� �̸��� ���� Ƚ���� ��ȸ�ϴ� SQL��
-- �̸��� ���� ������ ����, �̸� ������ ��ȸ
-- HAVING ������ COUNT, SUM, AVG, MAX, MIN �� �����Լ��� ����Ͽ� ������ �ο�
-- �׷�ȭ�� ����� ���� �ȿ����� ����Ѵ�.
select name, count(name) countname from animal_ins
group by name
having count(name) >= 2
order by name asc;


















