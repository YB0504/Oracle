-- TEST

-- 1�� ����
--�־��� ���ǿ� �°� book ���̺��� �����Ͻÿ�? (20��)
--����1 : no �÷��� �ݵ��, �ߺ����� ���� ���� ������ �����Ѵ�.
--����2 : title �÷����� �ݵ�� ���� ������ �����Ѵ�.
--����3 : pub_day �÷��� ���� ���� ������ �⺻ ������ ���� ��¥�� ������ ���� �Ѵ�
create table book(
    no number(4) primary key,
    title varchar2(20) not null,
    author varchar2(20),
    publisher varchar2(20),
    pub_day date DEFAULT sysdate);
    
-- 2�� ����
--Oracle �����ͺ��̽��� ���� ���� ��¥�� �⺻����(23/01/01)�� 
--����� ����(2023-01-01)���� ���ʷ� ����ϴ� SQL���� �ۼ��Ͻÿ�?  (20��)
select sysdate, to_char(sysdate, 'yyyy-mm-dd') from dual;

-- 3�� ����
--������̺�(EMP)���� �ִ� �޿��� �޴� ������, 
--�ִ�޿� �ݾ��� ����ϴ� SQL���� �ۼ��Ͻÿ�? (20��)
select ename, sal from emp
where sal = (select max(sal) from emp);

-- 4�� ����
--MySQL�� Oracle�� DB Migration�� �ϰ��� �Ѵ�. 
--���̱׷��̼� �� ����� ���������� �Ʒ� ������ �ϼ��Ͻÿ�? (20��)
--1. Oracle sequence ����
--2. insert�� �ۼ��ϱ�
create table member(
    id number(6) primary key,
    name varchar2(20));

-- ������ ����
CREATE SEQUENCE member_seq
start with 1
increment by 1;

-- insert �� �ۼ�
insert into member values(member_seq.nextval, 'hong');

-- 5�� ����
--������ ���̺��� ���� �� name, phone �÷��� �⺻Ű�� ������� �Ѵ�. 
--composite key(����Ű) �̸�(Constraint)�� member_compo_pk�̸�, 
--�Ʒ� ���̺��� �ϼ��Ͻÿ�? (20��)
create table member(
    name varchar2(10),
    address varchar2(30),
    phone varchar2(16),
    constraint member_compo_pk primary key(name, phone));












