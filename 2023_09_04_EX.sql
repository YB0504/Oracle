-- 2023_09_04
-- �ڵ��� ������ 'Ʈ��'�� �뿩 ����� �뿩 ��� ���� 
-- �뿩 �ݾ�(�÷���: FEE)�� ���Ͽ� �뿩 ��� ID�� �뿩 �ݾ� ����Ʈ�� ����ϴ� SQL��
-- �뿩 �ݾ��� �������� �������� ����, ���� ��� �뿩 ��� ID�� �������� �������� ����
SELECT h.history_id, (c.daily_fee * (h.end_date - h.start_date + 1)) * 
nvl(1 - p.discount_rate/100, 1) as FEE
from car_rental_company_car c, car_rental_company_rental_history h,
car_rental_company_discount_plan p
where c.car_id = h.car_id
and c.car_type = p.car_type
and p.duration_type = (case when to_char(h.end_date - h.start_date + 1) >= '90' then '90�� �̻�'
                            when to_char(h.end_date - h.start_date + 1) >= '30' then '30�� �̻�'
                            when to_char(h.end_date - h.start_date + 1) >= '7' then '7�� �̻�'
                            else null end)
and c.car_type = 'Ʈ��'
order by FEE desc, h.history_id desc;
-- 3���� ���̺�� SQL���� �ۼ��� ���� ������� 2��

-- INNER JOIN���� JOIN�� �� FROM���� ���̺� ��Ī�� �ٿ� ����
-- ������� �� ���� �÷��� ã�� ���� ����

-- ANSI JOIN���� JOIN�� �� 
-- 2���� ���̺��� ���� ���̺��1 ��Ī1 JOIN ���̺��2 ��Ī2 
-- ON ��Ī1.�����÷��� = ��Ī2.�����÷���
-- JOIN ���̺��3 ��Ī3 ON ��Ī2.�����÷��� = ��Ī3.�����÷���

-- ���� �ڵ�
SELECT HISTORY_ID, 
       (DAILY_FEE*(B.END_DATE-B.START_DATE+1))*NVL(1-DISCOUNT_RATE/100, 1) AS FEE 
FROM CAR_RENTAL_COMPANY_CAR A 
JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY B 
ON A.CAR_ID = B.CAR_ID
LEFT OUTER JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN C
-- ������ ���̺��� LEFT JOIN�����ϵ� OUTER����ó�� ������ ��ģ��.
ON A.CAR_TYPE = C.CAR_TYPE
AND C.DURATION_TYPE = (CASE WHEN (B.END_DATE-B.START_DATE+1)>='90' THEN '90�� �̻�'
                            WHEN (B.END_DATE-B.START_DATE+1)>='30' THEN '30�� �̻�'
                            WHEN (B.END_DATE-B.START_DATE+1)>='7' THEN '7�� �̻�'
                          ELSE NULL END)                        
WHERE A.CAR_TYPE = 'Ʈ��'
ORDER BY FEE DESC, B.HISTORY_ID DESC;