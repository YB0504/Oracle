-- 2023_09_17 JOIN
-- 7�� ���̽�ũ�� �� �ֹ����� ��ݱ� ���̽�ũ���� �� �ֹ����� ���� ���� ū �������
-- ���� 3�� ���� ��ȸ
SELECT A.FLAVOR as FLAVOR
FROM FIRST_HALF A, JULY B
WHERE A.FLAVOR = B.FLAVOR
GROUP BY A.FLAVOR
ORDER BY SUM(A.TOTAL_ORDER + B.TOTAL_ORDER) DESC
FETCH FIRST 3 ROW ONLY;

-- �������ڰ� 2022-05�� ��ǰ���� ��ǰID, ��ǰ�̸�, �Ѹ����� ��ȸ�ϴ� SQL��
-- �Ѹ��� ���� �������� ���ٸ� ��ǰID ���� ��������
select a.product_id, a.product_name, sum(a.price*b.amount)as �Ѹ���
from food_product a, food_order b
where a.product_id = b.product_id
and to_char(b.produce_date, 'yyyy-mm') = '2022-05'
group by a.product_id, a.product_name
order by �Ѹ��� desc, a.product_id asc;
-- Ʋ�� ���� : �׷��Լ��� ������ ��� �÷��� group by���� �߰��ؾ��Ѵ�.

-- ���並 ���� ���� �ۼ��� ȸ���� ������� ��ȸ�ϴ� SQL�� �ۼ�
-- ȸ���̸�, �����ؽ�Ʈ, ���� �ۼ����� ��µǵ��� �ۼ�
-- ���� �ۼ��� ���� �������� ���ٸ� �ؽ�Ʈ ���� ��������
select a.member_name, b.review_text, 
to_char(b.review_date, 'yyyy-mm-dd')as review_date
from member_profile a join rest_review b
on a.member_id = b.member_id
where a.member_id = (select max(member_id) from rest_review)
group by a.member_name
order by b.review_date asc, b.review_text asc;

-- ����
SELECT A.MEMBER_NAME, B.REVIEW_TEXT, TO_CHAR(B.REVIEW_DATE,'YYYY-MM-DD') AS REVIEW_DATE
FROM MEMBER_PROFILE A, REST_REVIEW B
WHERE A.MEMBER_ID = B.MEMBER_ID -- ���並 �ۼ��� ȸ���� �������� �� �� �ִ�.
AND A.MEMBER_ID IN
(SELECT MEMBER_ID FROM (
    -- 1. ���� ID �� ������ ���� ���� ���ϴ� ����
    SELECT MEMBER_ID, COUNT(*) AS CNT FROM REST_REVIEW
    GROUP BY MEMBER_ID)WHERE CNT = (
    -- 2. �ִ� ���� �� ���ϴ� ����
    SELECT MAX(COUNT(*)) AS MAXCNT FROM REST_REVIEW
    GROUP BY MEMBER_ID))
ORDER BY B.REVIEW_DATE, B.REVIEW_TEXT;














