-- 2023_09_10 GROUP BY
-- 2022�� 1���� �����Ǹ� �����͸� �������� ���� ��, ī�װ� �� �����(TOTAL_SALES)��
-- ���ϰ�, ����ID, ���ڸ�, ī�װ�, ����� ����Ʈ�� ����ϴ� SQL���� �ۼ�
-- ����ID ���� ��������, ī�װ� ���� ��������
SELECT a.author_id as author_id, b.author_name as author_name,
a.category as category, sum(c.sales * a.price) as total_sales
from book a, author b,
(select book_id, to_char(sales_date, 'yyyy-mm'), sales
from book_sales
where to_char(sales_date,'yyyy-mm') = '2022-01') c
where a.author_id = b.author_id
and a.book_id = c.book_id
group by a.author_id, b.author_name, a.category
order by author_id asc, category desc;

-- ��ǰ�з����� ������ ���� ��� ��ǰ�� �з�, ����, �̸��� ��ȸ�ϴ� SQL�� �ۼ�
-- ��ǰ�з��� ����, ��, ��ġ, �Ŀ����� ��츸 ���
-- ��ǰ���� ���� ��������
-- where �������� ������������ ã�� ����� ���� ������ ����� ��ġ�ϴ� ����
-- ã�� ���� where ���������� �ΰ��� �÷��� ���´�.
select category, price as max_price, product_name
from food_product
where (category, price) in (select category, max(price) max_price
    from food_product where category in ('����','��','��ġ','�Ŀ���')
    group by category)
order by max_price desc;

-- ��, ��, ���� ���� ��ǰ�� ������ ȸ������ �����ϴ� SQL���� �ۼ�
-- ����� ��, ��, ������ �������� �������� ����
-- ���� ������ ���� ��� ������� ����
-- ���ÿ� ���� MONTH���� 1,2...�� ǥ�� �Ǳ� ������ 
-- to_number�Լ��� '01'�� �ƴ� 1�� ��µǰ� �ۼ�
-- ���� �� �� �ƴ� ������ ȸ��!�� ���̱� ������ distinct�� �ߺ� ������ ȸ���� ����
select to_char(b.sales_date, 'yyyy') YEAR, 
to_number(to_char(b.sales_date, 'mm')) MONTH,
a.gender GENDER, count(distinct b.user_id) users
from user_info a join online_sale b on a.user_id = b.user_id
where gender is not null
group by a.gender, to_char(b.sales_date, 'yyyy'), to_char(b.sales_date, 'mm')
order by YEAR asc, MONTH asc, GENDER asc;

-- 0 ~ 23�ñ���, �� �ð��뺰�� �Ծ��� �� ���̳� �߻��ߴ��� ��ȸ�ϴ� SQL�� �ۼ�
-- ����� �ð��� �� ����










