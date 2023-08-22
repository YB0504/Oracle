-- 2023_08_17(��)

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



















