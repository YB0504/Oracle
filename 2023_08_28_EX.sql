-- 2023_08_28(String,Date)

-- 1. ���ǿ� �����ϴ� �߰�ŷ� ���� ��ȸ�ϱ�
select board_id, writer_id, title, price,
CASE when status = 'SALE' then '�Ǹ���'
     when status = 'RESERVED' then '������'
     when status = 'DONE' then '�ŷ��Ϸ�' end as status
     from used_goods_board 
     where to_char(created_date, 'yyyy-mm-dd') = '2022-10-05' 
     order by board_id desc;
     
-- 2. �ڵ��� �뿩��Ͽ��� ���/�ܱ� �뿩 �����ϱ�
--    30���̻��̸� ��� �뿩, �ƴϸ� �ܱ� �뿩(�÷��� rent_type)
--    ��¥ �������� ������ ���õ� ���̺�� ����
select history_id, car_id,
to_char(start_date, 'yyyy-mm-dd') start_date, 
to_char(end_date, 'yyyy-mm-dd') end_date,
case when end_date - start_date + 1 >= 30 then '��� �뿩'
ELSE '�ܱ� �뿩' end as rent_type
from car_rental_company_rental_history
where to_char(start_date, 'yyyy-mm') = '2022-09'
order by history_id desc;

-- 3. Ư�� �ɼ��� ���Ե� ����Ʈ ���ϱ�
--    �׺���̼� �ɼ��� ����
select car_id, car_type, daily_fee, options
from car_rental_company_car
where options like '%�׺���̼�%'
order by car_id desc;

-- 4. ��ÿ� ���� ã��
--    in �����ڴ� or�� ��ü ����
select animal_id, name, sex_upon_intake
from animal_ins
where name IN ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty')
order by animal_id asc;

-- 5. �̸��� el�� ���� ����(��) ã��
--    ��ҹ��� ������ ���� �ʴ´�.
--    lower, upper, initcap ���
select animal_id, name from animal_ins
where upper(name) like upper('%el%') and animal_type = 'Dog'
order by name asc;

-- 6. �߼�ȭ ���� �ľ��ϱ�
--    �߼�ȭ�� �Ǿ��ٸ� 'O' �ƴ϶�� 'X'
--    ���ϵ� ī�� ������ like�� ���
select animal_id, name,
case when sex_upon_intake like 'Neutered%' then 'O'
     when sex_upon_intake like 'Spayed%' then 'O'
     else 'X' end as "�߼�ȭ ����"
     from animal_ins order by animal_id asc;

-- 7. datetime ���� date�� �� ��ȯ
--    ������ ���̵�, �̸�, ���� ��¥�� ��ȸ
select animal_id, name, to_char(datetime, 'yyyy-mm-dd')as "���� ��¥"
from animal_ins order by animal_id asc;

-- 8. ī�װ� �� ��ǰ ���� ���ϱ�
--    ī�װ� �ڵ�� ��ǰ�ڵ��� �� 2�ڸ�
--    �ζ��κ� ���
--    substr()�� ���� 2�ڸ��� ���� ��Ī�� ���� �� ���
SELECT category , count(category)
FROM (SELECT substr(product_code,1,2) AS category
      FROM product)
GROUP BY category
ORDER BY category asc;








