-- 2023_08_18(��)

select 10 + 20 from dept;   -- 4�� ���
SELECT 10 + 20 from emp;    -- 14�� ���

-- dual ���̺�
-- 1. sys���� ������ ���̺�(���� ���Ǿ�� ������ ���̺�)
-- 2. ������ �Ǿ� �ֱ� ������ ������ ��� �����ϴ�.
-- 3. �����Ͱ� 1�� �ۿ� ���� ������ ���� ����� �� ���� ��µȴ�.

SELECT 10 + 20 FROM dual;   -- 1�� ���
select 10 + 20 from sys.dual; -- ������ �ش� ����.���̺������ ����ؾ� �Ѵ�.

desc dual;  -- DUMMY �÷� 1�� �ۿ� ����.
select * from dual; -- X ������ 1�� �ۿ� ����.

select * from tab;  -- tab : ���� ���Ǿ�(sys���� ����)
select * from sys.tab;

-- 1. ���� ó�� �Լ�
-- ABS() : ���밪�� �����ִ� �Լ�
select -10, abs(-10), ABS(-10) from dual;

-- FLOOR() : �Ҽ��� ���ϸ� ������ �Լ�
select 10.2, floor(10.2) from dual;

-- ROUND() : Ư�� �ڸ����� �ݿø��� �ϴ� �Լ�
-- ROUND( ��� ��, �ڸ��� )
select 34.5678, round(34.5678) from dual; -- 35 : �Ҽ� ù°�ڸ����� �ݿø�
select 34.5678, round(34.5678, 2) from dual; -- 34.57 : �Ҽ� ��°�ڸ����� �ݿø�
select 34.5678, round(34.5678, -1) from dual; -- 30 : ���� 1�� �ڸ����� �ݿø�
select 34.5678, round(35.5678, -1) from dual; -- 40 : ���� 1�� �ڸ����� �ݿø�

-- TRUNC() : Ư�� �ڸ����� �߶󳻴� �Լ�
-- TRUNC( ��� ��, �ڸ��� )
select trunc(34.5678),  trunc(34.5678, 2), trunc(34.5678, -1) from dual;

-- MOD() : ������ ���� ���� ������ ���� �����ִ� �Լ�
-- MOD( ��� ��, ������ �� )
SELECT mod(27, 2), mod(27, 5), mod(27, 7) from dual;

-- ��� ��ȣ�� Ȧ���� ������� ����ϴ� SQL�� �ۼ�
select ename, empno from emp where mod(empno, 2) = 1;

----------------------------------------------------------------------------

-- 2. ���� ó�� �Լ�
-- UPPER() : �빮�ڷ� ��ȯ�ϴ� �Լ�
select 'Welcome to Oracle', UPPER('Welcome to Oracle') from dual;

-- LOWER() : �ҹ��ڷ� ��ȯ�ϴ� �Լ�
select 'Welcome to Oracle', LOWER('Welcome to Oracle') from dual;

-- INITCAP() : ù���ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ�
select 'welcome to oracle', INITCAP('welcome to oracle') from dual;

-- JOB�� manager�� ����� �˻��ϴ� SQL�� �ۼ�
SELECT * from emp where lower(job) = 'manager';
SELECT * from emp where job = upper('manager');

-- LENGTH() : ���ڿ��� ���̸� ���ϴ� �Լ�
select length('Oracle'), length('����Ŭ')from dual;    -- 6, 3

-- LENGTHB() : ���ڿ��� ���̸� byte������ ���ϴ� �Լ�
-- ���� 1���� : 1byte, �ѱ� 1���� : 3byte (�����ǿ� ���� �ѱ��� byte�� �ٸ� �� �ִ�.)
select lengthb('Oracle'), lengthb('����Ŭ')from dual;

-- SUBSTR() : ��ü ���ڿ��� �Ϻ� ���ڸ� �����ϴ� �Լ�
-- SUBSTR( ��� ���ڿ�, ������ġ, ������ ���� )
select substr('welcome to oracle', 4, 3) from dual; -- com
select substr('welcome to oracle', -4, 3) from dual; -- acl
select substr('welcome to oracle', -6, 3) from dual; -- ora

-- �Ի����� ��, ��, ���� �����ϴ� SQL�� �ۼ�
select substr(hiredate, 1, 2) as "��",
       substr(hiredate, 4, 2) as "��",
       substr(hiredate, 7, 2) as "��" from emp;
       
-- 87�⵵�� �Ի��� ����� �˻��ϴ� SQL�� �ۼ�
select * from emp where substr(hiredate, 1, 2) = 87;

-- ������� �빮�� E�� ������ ����� �˻��ϴ� SQL���� �ۼ�
SELECT * from emp where ename like '%E';
select * from emp where substr(ename, -1, 1) = 'E';

-- INSTR() : Ư�� ������ ��ġ�� �����ִ� �Լ�
-- instr( ��� ���ڿ�, ã������ ) : ���� ���� ������ ������ ��ġ�� ã�´�.
-- instr( ��� ���ڿ�, ã������, ������ġ, ���° �߰� )

-- ���� ���� ������ 'O'�� ��ġ�� ã�� SQL�� �ۼ�
SELECT instr('welcom to oracle', 'o') from dual; -- 5

SELECT instr('welcom to oracle', 'o', 6, 2)from dual;

-- ������� 3��° �ڸ��� R�� �Ǿ��ִ� ����� �˻��ϴ� SQL�� �ۼ�
-- 1. LIKE ������
SELECT * from emp where ename like '__R%';

-- 2. substr()
SELECT * from emp where substr(ename,3,1) = 'R';

-- 3. instr()
select * from emp where instr(ename, 'R') = 3; -- ���� ���� ������ R�� ��ġ�� 3�� ����.
select * from emp where instr(ename, 'R',3 ,1) = 3;

-- LPAD() / RPAD() : �� ���⿡ �ش� ���ڸ� ä���ִ� �Լ�
select lpad('oracle', 20, '#')from dual;
select Rpad('oracle', 20, '#')from dual;

-- LTRIM() / RTRIM() : �� ������ ������ ���� ���ִ� �Լ�
SELECT '   oracle   ', ltrim('   oracle   ')from dual;
SELECT '   oracle   ', rtrim('   oracle   ')from dual;

-- TRIM() : ���ڿ� ��, ������ ������ ���� ���ִ� �Լ�
--          Ư�� ���ڸ� �߶󳻴� �Լ�
SELECT '   oracle   ', trim('   oracle   ')from dual;
SELECT trim('a' from 'aaaaaoracle')from dual;

----------------------------------------------------------------------------

-- 3. ��¥ ó�� �Լ�
-- SYSDATE : �ý����� ��¥�� ���ؿ��� �Լ�
--           ��ȣ�� ����
select sysdate from dual;

SELECT sysdate -1 ����, sysdate ����, sysdate +1 ���� from dual;

-- �� ������� ������� �ٹ��� �ٹ��ϼ��� ���ϴ� SQL�� �ۼ�
select ename, sysdate - hiredate from emp;
select ename, round(sysdate - hiredate) from emp; -- �Ҽ� ù°�ڸ� �ݿø�
select ename, trunc(sysdate - hiredate) from emp; -- �Ҽ��� ���ϸ� ����

-- MONTHS_BETWEEN() : �� ��¥ ������ ����� ���� ���� �����ִ� �Լ�
-- MONTHS_BETWEEN( date1, date2 )

-- �� ������� �ٹ��� ���� ���� ���ϴ� SQL�� �ۼ�
SELECT months_between(sysdate, hiredate) from emp; -- ��� ������ ���
SELECT months_between(hiredate, sysdate) from emp; -- ���� ������ ���

SELECT round(months_between(sysdate, hiredate)) "�ٹ� ���� ��" from emp;
SELECT trunc(months_between(sysdate, hiredate)) "�ٹ� ���� ��" from emp;

-- ADD_MONTHS() : Ư�� ��¥�� ����� ���� ���� ���ϴ� �Լ�
-- ADD_MONTHS( date, ���� �� )

-- �� ������� �Ի��� ��¥�� 6������ ����� ��¥�� ���ϴ� SQL�� �ۼ�
SELECT ename, hiredate,  add_months(hiredate, 6)from emp;

-- ���� �԰� �� 6������ ����� ���ڸ� ���ϴ� SQL�� �ۼ�
select add_months('2023.07.11', 6)from dual;

-- NEXT_DAY() : �ش� ������ Ư�� ������ ���� ����� ��¥�� �����ִ� �Լ�
-- NEXT_DAY( date, ���� )
-- ������ �������� ���� ����� ������� �������� ���ϴ� SQL�� �ۼ�
SELECT sysdate, next_day(sysdate, '�����')from dual;
SELECT hiredate, next_day(hiredate, 'ȭ����')from emp;

-- LAST_DAY() : �ش� ���� ������ ��¥�� �����ִ� �Լ�
-- ������� �Ի��� ���� ������ ��¥�� ���ϴ� SQL�� �ۼ�
SELECT hiredate, last_day(hiredate)from emp;

-- �̹����� ������ ��¥�� ���ϴ� SQL�� �ۼ�
SELECT sysdate, last_day(sysdate)from dual;

-- 2023�� 2���� ������ ��¥�� ���ϴ� SQL�� �ۼ�
SELECT last_day('2023/02/01')from dual;
SELECT last_day('2020/02/01')from dual;

---------------------------------------------------------------------------

-- 4. �� ��ȯ �Լ�
-- TO_CHAR(), TO_DATE(), TO_NUMBER()

-- TO_CHAR() : ��¥, ������ �����͸� ���������� ��ȯ���ִ� �Լ�

-- 1) ��¥�� �����͸� ������ ��ȯ
-- TO_CHAR( ��¥ ������, '�������' )
-- ���� �ý����� ��¥�� ��, ��, ��, ��, ��, ��, ���Ϸ� ����ϴ� SQL�� �ۼ�
SELECT sysdate, to_char(sysdate, 'yyyy"��"mm"��"dd"��" am hh24:mi:ss DAY')
from dual;

-- �� ������� �Ի����� ��, ��, ��, ��, ��, ��, ���Ϸ� ����ϴ� SQL�� �ۼ�
SELECT ename, hiredate, to_char(hiredate, 'yyyy"��"mm"��"dd"��" am hh24:mi:ss DAY')
�Ի��� from emp;

-- 2) ������ �����͸� ������ ��ȯ
-- TO_CHAR( ���� ������, '���б�ȣ �� �������' )

-- ���� 1230000�� 3�ڸ��� ,�� �����ؼ� ���
-- 0���� �ڸ����� �����ϸ�, ������ ���̰� ���� ���� �� 0���� ä���.
SELECT to_char(1230000, '000,000,000')as �׽�Ʈ from dual;

-- 9�� �ڸ����� �����ϸ�, ���� �ʴ� ������ ���̴� ä���� �ʴ´�.
SELECT to_char(1230000, '999,999,999')as �׽�Ʈ from dual;

-- �� ������� �޿��� 3�ڸ��� ,�� �����ؼ� ����ϴ� SQL�� �ۼ�
-- L�� ���̸� �ü�� ���� ��ȭ��ȣ�� ��Ÿ����.
SELECT ename, sal, to_char(sal, 'L999,999') "�� �޿�" from emp;
select ename, sal, to_char(sal, '999,999L') "�� �޿�" from emp;

-- TO_DATE() : ���ڸ� ��¥������ ��ȯ���ִ� �Լ�
-- TO_DATE( '����', '��¥ format' )

-- 2023�� 1�� 1�Ϻ��� ������� ����� �ϼ��� ���ϴ� SQL�� �ۼ�
SELECT sysdate, trunc(sysdate - TO_DATE('2023/01/01', 'yyyy/mm/dd'))
"����� �ϼ�"from dual;

-- 2023�� 12�� 25�ϱ��� ���� �ϼ��� ���ϴ� SQL�� �ۼ�
SELECT sysdate, trunc(to_date('2023/12/25', 'yyyy/mm/dd')
-sysdate)"���� �ϼ�"from dual;

-- ���� �����Ⱓ(2023/07/11 ~ 2024/01/19)�� �ϼ��� ���ϴ� SQL�� �ۼ�
select trunc(TO_DATE('2024/01/19', 'yyyy/mm/dd')
- TO_DATE('2023/07/11', 'yyyy/mm/dd'))"���� �ϼ�"from dual;

-- TO_NUMBER() : ���ڸ� ���ڷ� ��ȯ���ִ� �Լ�
-- TO_NUMBER( '���� ������', '���б�ȣ �� �������' )
SELECT '20,000' - '10,000' from dual; -- ���� �߻�
SELECT TO_NUMBER('20,000', '999,999') 
- TO_NUMBER('10,000', '999,999')from dual;

---------------------------------------------------------------------------

-- NVL() : NULL���� �ٸ� ������ ġȯ���ִ� �Լ�
-- 1. NULL ���� �������� ���� ���� �ǹ��Ѵ�.
-- 2. NULL���� ��� ������ ���� �ʴ´�.
-- NVL( �÷�, ġȯ�� �� )

-- �� ������� ������ ����ϴ� SQL�� �ۼ�
SELECT ename, job ,sal * 12 + nvl(comm, 0)
as "����" from emp order BY sal asc;

-- DECODE() : switch ~ case ������ ����
-- DECODE( �÷���, ��1, ���1,
--                ��2, ���2,
--                ��3, ���3,
--                ��N, ���N)

-- �μ���ȣ�� �μ������� �ٲ㼭 ����ϴ� SQL�� �ۼ�
SELECT ename"��� ��", deptno"�μ� ��ȣ", decode(deptno, 10, '����1��', 20, 
'����2��', 30, '����3��')as "�μ���" from emp order by deptno asc;

-- CASE : if ~ else if ������ ����
-- CASE WHEN �÷��� = ����1 THEN ���1
--      WHEN �÷��� = ����2 THEN ���2...
--      ELSE ���N END

-- �μ���ȣ�� �μ������� �ٲ㼭 ����ϴ� SQL���� �ۼ�
SELECT ename"��� ��", deptno"�μ� ��ȣ", CASE when deptno = 10 then '����1��'
                                             when deptno = 20 then '����2��'
                                             when deptno = 30 then '����3��'
                                             END "�μ���" from emp order by deptno;
                                             
-----------------------------------------------------------------------------------













