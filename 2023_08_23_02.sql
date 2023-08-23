-- 2023_08_23(수)

-- 무결성 제약 조건
-- : 테이블에 부적절한 데이터가 입력되는 것을 막기 위해서 테이블을 생성할 때
--   각 컬럼에 대해서 정의하는 여러가지 규칙을 의미한다.
-- ex) not null, unique, primary key(기본키), foreign key(외래키)
--     check, default

-- 1. NOT NULL 제약조건
--    NULL 값을 허용하지 않는다.
--    반드시 값을 입력해야 한다.

-- 실습
drop table emp02 purge;

CREATE table emp02(empno number(4) not null,
                   ename VARCHAR2(12) not null,
                   job VARCHAR2(12),
                   deptno number(2));

SELECT * from tab;
SELECT * from emp02;

-- 제약조건에 위배되지 않는 데이터 입력
insert into emp02 VALUES(1111, '홍길동', 'MANAGER', 30);

-- 제약조건에 위배되는 데이터 입력
insert into emp02 VALUES(null, null, 'SALESMAN', 30); -- 입력이 되지 않는다.
insert into emp02(job, deptno) VALUES('SALESMAN', 30);

-- 2. unique 제약조건
--    유일한 값만 입력할 수 있다.
--    중복된 값을 입력할 수 없다.
--    null 값은 입력될 수 있다.

-- 실습
DROP table emp03 purge;

CREATE table emp03(empno number(4) UNIQUE,
                   ename VARCHAR2(12) not null,
                   job VARCHAR2(12),
                   deptno NUMBER(2));

SELECT * from tab;
SELECT * from emp03;

-- 제약조건에 위배되지 않는 데이터 입력
INSERT into emp03 VALUES(1111, '홍길동', '개발자', 10);

-- 제약조건에 위배되는 데이터 입력
insert into emp03 VALUES(1111, '오라클', '개발자', 20); -- empno값이 중복된 값

-- null값을 입력
-- unique 제약조건은 null값의 입력이 가능하다.
insert into emp03 VALUES(null, '오라클', '개발자', 20);
insert into emp03 VALUES(null, '배고파', '개발자', 30);

-- 3. PRYMARY KEY(기본키) 제약조건
--    not null, unique 제약조건을 결합한 제약조건
--    반드시 중복되지 않은 값을 입력해야 한다.
--    지정된 컬럼은 주로 where 조건절에 사용된다.
-- ex) 부서 테이블(dept) - deptno(pk)
--     사원 테이블(emp)  - empno(pk)

--     게시판(board)    - 번호(no)
--     회원관리(member) - 아이디(id)


-- 부서 테이블 (dept) - deptno(pk)
SELECT * from dept;
insert into dept VALUES(10, '개발부', '서울'); -- unique 제약조건 위배
insert into dept VALUES(null, '개발부', '서울'); -- not null 제약조건 위배

-- 사원 테이블(emp)  - empno(pk)
SELECT * from emp;
insert into emp(empno, ename) VALUES(7369, '홍길동'); -- unique제약조건 위배
insert into emp(empno, ename) VALUES(null, '홍길동'); -- not null 제약조건 위배

drop table emp05 purge;
CREATE table emp05(
    empno NUMBER(4) PRIMARY key,
    ename VARCHAR2(12) not null,
    job VARCHAR2(12),
    deptno number(2));
    
SELECT * from emp05;
    
insert into emp05 VALUES(1111, '홍길동', '개발자', 10);
insert into emp05 VALUES(1111, '홍길동', '개발자', 10); -- unique 제약조건 위배
insert into emp05 VALUES(null, '홍길동', '개발자', 10); -- not null 제약조건 위배

-- 제약조건 이름 설정하여 테이블 생성
drop table emp04 purge;

CREATE table emp04(
    empno NUMBER(4) CONSTRAINT emp04_empno_uk unique,
    ename VARCHAR2(10) CONSTRAINT emp04_ename_nn not null,
    job VARCHAR2(10),
    deptno number(2));
    
SELECT * from emp04;

-- 4. FOREIGN KEY(외래키) 제약조건
--    dept(부모 테이블) - deptno(pk) : 부모키 10, 20, 30, 40
--    emp(자식 테이블)  - drptno(fk) : 외래키 10, 20, 30

-- 1) 사원테이블(emp)의 deptno 컬럼이 foreign key 제약조건이 설정되어 있다.
-- 2) foreign key 제약조건이 가지고 있는 의미는 부모테이블(dept)의 
--    부모키(deptno)값만 참조할 수 있다.
-- 3) 부모키가 되기 위한 조건은 primary key나 
--    unique제약조건으로 설정되어 있어야 한다.

-- 사원 테이블에 새로운 신입사원을 등록
-- 외래키(deptno)는 부모키(dept - deptno)안에 있는 값만 참조할 수 있다.
INSERT into emp(empno, deptno) VALUES(1111, 50); -- foreign key 제약조건 위배
INSERT into emp(empno, deptno) VALUES(1111, 50);

-- 실습
drop table emp06 purge;
CREATE table emp06(
    empno number(4) PRIMARY key,
    ename VARCHAR2(10) not null,
    job VARCHAR2(10),
    deptno NUMBER(2) references dept(deptno));
    
select * from emp06;
insert into emp06 VALUES(1111, '홍길동', '개발부', 10);
insert into emp06 VALUES(1112, '또길동', '개발부', 20);
insert into emp06 VALUES(1113, '고길동', '개발부', 30);
insert into emp06 VALUES(1114, '둘리', '개발부', 40);
-- 50번 부서는 부모키에서 참조할 수 없는 값이기 때문에 foreign key 제약조건에 위배된다.
insert into emp06 VALUES(1115, '도우너', '개발부', 50);

-- 5. CHECK 제약조건
-- :  데이터가 입력될 때 특정 조건을 만족하는 데이터만 입력되도록 
--    만들어주는 제약조건이다.

-- 급여(sal) : 500 ~ 5000
-- 성별(gender) : M or F

CREATE table emp07(
    empno number(4) PRIMARY key,
    ename VARCHAR2(10) not null,
    sal number(7, 2) check(sal between 500 and 5000),
    gender VARCHAR2(1) check(gender in('M','F')));

SELECT * from emp07;

INSERT into emp07 VALUES(1111, '홍길동', 3000, 'M');
INSERT into emp07 VALUES(1112, '홍길동', 8000, 'M'); -- check 제약조건 위배
INSERT into emp07 VALUES(1113, '홍길동', 3000, 'Q'); -- check 제약조건 위배

-- 6. DEFAULT 제약조건
--    : default 제약조건이 설정된 컬럼에 값이 입력되지 않으면
--      default로 설정된 값이 자동으로 입력된다.

drop table dept01 purge;

CREATE table dept01(
    deptno number(2) PRIMARY key,
    dname varchar2(14),
    loc VARCHAR2(13) default 'SEOUL');
    
SELECT * from dept01;

INSERT into dept01 VALUES(10, '영업부', '대전');
INSERT into dept01(deptno, dname) VALUES(20, '개발부');

----------------------------------------------------------------------

-- 제약조건 설정 방식
-- 1. 컬럼레벨 방식으로 제약조건 설정
-- 2. 테이블레벨 방식으로 제약조건 설정

-- 1. 컬럼레벨 방식으로 제약조건 설정
drop table emp01 purge;

CREATE table emp01(
    empno NUMBER(4) primary key,
    ename varchar2(15) not null,
    job varchar2(10) UNIQUE,
    deptno number(4) REFERENCES dept(deptno));

SELECT * from emp01;

-- 2. 테이블레벨 방식으로 제약조건 설정
drop table emp02 purge;

CREATE table emp02(
    empno number(4),
    ename varchar2(15) not null,
    job VARCHAR2(10),
    deptno number(4),
    PRIMARY key(empno),
    unique(job),
    FOREIGN key(deptno) REFERENCES dept(deptno));
    
SELECT * from emp02;

-- 제약 조건을 설정할 때 테이블 레벨 방식만 가능한 경우
-- 1. primary key(기본키) 제약조건을 복합키로 설정하는 경우
-- 2. ALTER TABLE 명렬으로 제약조건을 추가할 경우

-- 1. 2개 이상의 컬럼을 기본키로 설정
DROP TABLE member01 purge;

-- 1) 컬럼레벨 방식으로 2개의 컬럼을 primary key로 설정
CREATE table member01(
    id VARCHAR2(20) PRIMARY key,
    password VARCHAR2(20) PRIMARY key); -- 오류 발생

-- 2) 테이블레벨 방식으로 primary key를 복합키로 설정
CREATE table member01(
    id VARCHAR2(20),
    password VARCHAR2(20),
    PRIMARY key(id, password));
    
SELECT * from member01;

-- 2. alter table 명령으로 제약조건을 추가하는 경우
drop table emp01 purge;

-- 제약조건이 없는 테이블 생성
CREATE table emp01(
    empno NUMBER(4),        -- primary key
    ename varchar2(15),     -- not null
    job varchar2(10),       -- unique
    deptno number(4));      -- foreign key

-- alter table 명령으로 제약조건 추가
alter table emp01 add PRIMARY key(empno);
alter table emp01 modify ename not null;
alter table emp01 add unique(job);
alter table emp01 add CONSTRAINT emp01_deptno_fk 
FOREIGN key(deptno) REFERENCES dept(deptno);

-- alter table 명령으로 제약조건 삭제
-- alter table 테이블 명 drop constraint constraint_name
alter table emp01 drop constraint SYS_C007043;
alter table emp01 drop primary key; -- primary key 제약조건은 이 방식도 가능하다.

alter table emp01 drop constraint SYS_C007045;
alter table emp01 drop unique(job); -- unique 제약조건은 이 방식도 가능하다.

alter table emp01 drop CONSTRAINT SYS_C007044; -- not null

alter table emp01 drop CONSTRAINT EMP01_DEPTNO_FK; -- foreign key







