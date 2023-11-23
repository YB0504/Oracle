create table Client(
CNO char(3) Not Null,
CNAME VARCHAR2(10) Not Null,
CID VARCHAR2(14) Not Null
);

insert into Client values('1', 'ȫ�浿1', 'hong1');
insert into Client values('2', 'ȫ�浿2', 'hong2');
insert into Client values('3', 'ȫ�浿3', 'hong3');

select * from client;