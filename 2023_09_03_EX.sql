-- 2023_09_03
-- 2022/4/13 ��ҵ��� ���� ��οܰ� ���� ���೻���� ��ȸ
-- ���Ό���ȣ, ȯ���̸�, ȯ�ڹ�ȣ, ������ڵ�, �ǻ��̸�, ���Ό���Ͻð� ���
-- ���Ό���Ͻ� ���� ��������
select a.apnt_no, p.pt_name, a.pt_no, a.mcdp_cd, d.dr_name, a.apnt_ymd
from patient p, doctor d, appointment a
where p.pt_no = a.pt_no
and d.mcdp_cd = a.mcdp_cd
and d.dr_id = a.mddr_id
and a.mcdp_cd = 'CS'
and apny_cncl_yn = 'N'
and to_char(a.apnt_ymd,'yyyy-mm-dd') = '2022-04-13'
order by apnt_ymd asc;





















