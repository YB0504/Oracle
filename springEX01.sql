create table myboard(
no NUMBER PRIMARY key,
writer varchar2(20),
passwd varchar2(20),
subject varchar2(50),
content varchar2(100),
readcount number,
register date);

create SEQUENCE myboard_seq
start with 1
INCREMENT by 1
NOCACHE;