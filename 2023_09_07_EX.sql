-- 2023_09_07 Group By
-- 2022�� 1���� ī�װ� �� ���� �Ǹŷ��� �ջ��ϰ�,
-- ī�װ�, �� �Ǹŷ� ����Ʈ�� ����ϴ� SQL�� �ۼ�
-- ī�װ��� ���� �������� ����
select distinct a.category category, sum(b.sales) total_sales
from book a, book_sales b
where a.book_id = b.book_id
and to_char(b.sales_date, 'yyyy-mm') = '2022-01'
group by category
order by category asc;

-- 2022�� 10�� 16�Ͽ� �뿩���� �ڵ����� ��� '�뿩��'���� ǥ��, 
-- �뿩 ������ ������ '�뿩 ����'���� ǥ���ϴ� �÷��� �߰�(�÷��� : availability)
-- �ڵ��� ID�� availability ����Ʈ�� ����ϴ� SQL���� �ۼ�
-- �ݳ���¥�� 2022�� 10�� 16���� ��쿡�� '�뿩��'���� ǥ��
-- �ڵ��� ID���� ��������
select car_id, availability
from car_rental_company_rental_history
where car_id = (select car_id from car_rental_company_rental_history
    where case when '2022-10-16' between to_char(end_date, 'yyyy-mm-dd') 
    and to_char(start_date, 'yyyy-mm-dd') 
    then '�뿩��' else '�뿩 ����' end availability)
group by car_id
order by car_id desc;

-- ���� �ڵ�
SELECT CAR_ID, 
MAX(CASE WHEN '2022-10-16' BETWEEN TO_CHAR(START_DATE,'YYYY-MM-DD') 
    AND TO_CHAR(END_DATE,'YYYY-MM-DD') THEN '�뿩��'
    ELSE '�뿩 ����'
    END) AS AVAILABILITY 
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
ORDER BY CAR_ID DESC;

-- �뿩 �������� �������� 2022�� 8������ 2022�� 10������ �� �뿩 Ƚ���� 5ȸ �̻��� 
-- �ڵ����鿡 ���ؼ� �ش� �Ⱓ ������ ���� �ڵ��� ID �� 
-- �� �뿩 Ƚ��(�÷���: RECORDS)����Ʈ�� ����ϴ� SQL���� �ۼ�
-- ����� ���� �������� �������� ����, ���ٸ� �ڵ���ID�� �������� �������� ����
-- Ư�� ���� �� �뿩Ƚ���� 0�� ���� ������� ����
select to_number(to_char(start_date, 'mm')) month, car_id,
count(*) as records from CAR_RENTAL_COMPANY_RENTAL_HISTORY
where car_id in(select car_id from CAR_RENTAL_COMPANY_RENTAL_HISTORY
where to_char(start_date,'yyyy-mm') in ('2022-08','2022-09','2022-10')
group by car_id having count(*) >= 5)
and to_number(to_char(start_date, 'mm')) between 8 and 11
group by to_number(to_char(start_date, 'mm')), car_id
order by month asc, car_id desc;












