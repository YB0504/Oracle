-- 2023_08_27(���α׷��ӽ� SQL�����kit is null)

-- 1. ��⵵�� ��ġ�� â���� ID, �̸�, �ּ�, �õ��ü� ���θ� ��ȸ�ϴ� SQL���� �ۼ����ּ���.
--    �̶� �õ��ü� ���ΰ� NULL�� ���, 'N'���� ��½��� �ֽð� 
--    ����� â�� ID�� �������� �������� �������ּ���.
SELECT WAREHOUSE_ID, WAREHOUSE_NAME, ADDRESS, 
NVL(FREEZER_YN, 'N') AS FREEZER_YN
FROM FOOD_WAREHOUSE 
WHERE ADDRESS LIKE '��⵵%'
ORDER BY WAREHOUSE_ID ASC;

-- 2. ���� ��ȣ�ҿ� ���� ���� ��, �̸��� ���� ä�� ���� ������ ID�� 
--    ��ȸ�ϴ� SQL ���� �ۼ����ּ���. ��, ID�� �������� ���ĵǾ�� �մϴ�.
SELECT animal_id from animal_ins
where name is null order by animal_id asc;

-- 3. ���� ��ȣ�ҿ� ���� ���� ��, �̸��� �ִ� ������ ID�� 
--    ��ȸ�ϴ� SQL ���� �ۼ����ּ���. ��, ID�� �������� ���ĵǾ�� �մϴ�.
select animal_id from animal_ins
where name is not null order by animal_id asc;

-- 4. ���� ������ ���� ȸ���� �� ������ ����ϴ� SQL���� �ۼ����ּ���. 
--    �̶� �÷����� USERS�� �������ּ���.
select COUNT(user_id)as USERS from user_info
where age is null;

-- 5. ������ ���� ��, �̸�, ���� �� �߼�ȭ ���θ� 
--    ���̵� ������ ��ȸ�ϴ� SQL���� �ۼ����ּ���. 
--    �̶� ���α׷����� �𸣴� ������� NULL�̶�� ��ȣ�� �𸣱� ������, 
--    �̸��� ���� ������ �̸��� "No name"���� ǥ���� �ּ���.
select animal_type, nvl(name, 'No name') as NAME, 
sex_upon_intake from animal_ins order by animal_id asc;

---------------------------------------------------------------------------

-- SUM, MAX, MIN

-- 1. �Ǹ� ���� ��ǰ �� ���� ���� �ǸŰ��� ����ϴ� SQL���� �ۼ����ּ���. 
--    �̶� �÷����� MAX_PRICE�� �������ּ���.
select max(price) as MAX_PRICE from product;


-- 2. ���� ��ȣ�ҿ� ���� ���� ���� ������ 
--    ���� ���Դ��� ��ȸ�ϴ� SQL ���� �ۼ����ּ���.
select min(datetime) as �ð� from animal_ins;
select max(datetime) as �ð� from animal_ins; -- ���� �ʰ� ���� ����

-- 3. ���� ��ȣ�ҿ� ������ �� ���� ���Դ��� ��ȸ�ϴ� SQL ���� �ۼ����ּ���.
select count(*) as "�� ������" from animal_ins;

-- 4. ���� ��ȣ�ҿ� ���� ������ �̸��� �� ������ ��ȸ�ϴ� SQL ���� �ۼ����ּ���. 
--    �̶� �̸��� NULL�� ���� �������� ������ �ߺ��Ǵ� �̸��� �ϳ��� Ĩ�ϴ�.
select count(name) as "�̸� ����" 
from(select DISTINCT name from animal_ins); -- distinct �ߺ� ����

-- 5. ������ ���� ��� ��ǰ�� ��ǰ ID, ��ǰ �̸�, ��ǰ �ڵ�, 
--    ��ǰ�з�, ��ǰ ������ ��ȸ�ϴ� SQL���� �ۼ����ּ���.
select product_id, product_name, product_cd, category, price
from food_product where price 
= (select max(price) from food_product);    -- ���� ���� �̿�




















