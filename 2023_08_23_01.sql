-- 2023_08_23(수)

-- 트랜잭션 (Transaction)
-- 1. 논리적인 작업단위
-- 2. 트랜잭션은 DML SQL문으로 시작된다.(insert, update, delete)
-- 3. 데이터 일관성을 유지하면서, 데이터를 안정적으로 복구하기 위해서 사용된다.
-- 4. All - OR - Nothing 방식으로 처리된다.

-- TCL(Transaction Control Language)
-- COMMIT : 트랜잭션을 종료
-- ROLLBACK : 트랜잭션을 취소
-- SAVEPOINT : 복구할 시점(저장점)을 지정하는 역할

-- 실습
drop table dept01 purge;
CREATE table dept01 as select * from dept;
SELECT * from dept01;

-- 1. ROLLBACK : 트랜잭션을 취소
-- 새로운 트랜잭션이 시작되고, 메모리상에서만 delete가 실행된다.
delete from dept01;

-- 트랜잭션을 취소하기 때문에, 메모리상에서 지워진 데이터가 복구된다.
ROLLBACK;
SELECT * from dept01;

-- 2. COMMIT : 트랜잭션을 종료
-- 메모리 상에서 처리된 DML SQL문을 데이터 베이스에 영구히 반영하게 된다.
DELETE from dept01 where deptno = 20; -- 메모리상에서 20번 데이터 삭제
commit; -- 트랜잭션 종료 (메모리상에서 삭제된 데이터를 DB에 반영하고 삭제한다.)
ROLLBACK; -- 트랜잭션이 종료되었기 때문에 삭제된 20번 데이터는 복구할 수 없다.

-- 자동 커밋 : 자동으로 커밋이 수행되는 것
-- 1) 정상적인 종료 : quit, exit, con.close()
-- 2) DDL(create, alter, rename, drop, truncate), DCL(grant, revoke)
--    명령이 수행될 때

-- 예1. DDL 명령어 실행(create)
SELECT * from dept01;
DELETE from dept01 where deptno = 40; -- 새로운 트랜잭션 시작

CREATE table dept03 as SELECT * from dept;  -- 자동 커밋 수행(DDL)
ROLLBACK;   -- 삭제된 40번 데이터를 복구하지 못한다.

-- 예2. DDL 명령어 실행(truncate)
-- delete(DML) : 데이터 복구 가능
-- truncate(DDL) : 데이터 복구 불가능

DELETE from dept01 where deptno = 30;
ROLLBACK;

TRUNCATE table dept01;  -- DDL(truncate) : 자동 커밋 수행
rollback;               -- 삭제된 데이터를 복구할 수 없다.
SELECT * from dept01;

-- 자동 롤백 : 자동으로 롤백이 수행되는 것
-- 데이터 베이스가 비정상적인 종료가 되었을때(강제로 창을 닫거나, 컴퓨터가 다운될 시)

-- 3. SAVEPOINT : 임시 저장점을 지정할 때 사용

-- 실습
drop table dept01 purge;

-- 1. dept01 테이블 생성
CREATE table dept01 as select * from dept;
SELECT * from dept01;

-- 2. 40번 부서 삭제
DELETE from dept01 where deptno = 40;

-- 3. commit 수행 : 트랜잭션 종료
commit;

-- 4. 30번 부서 삭제
DELETE from dept01 where deptno = 30;

-- 5. c1 저장점 생성
SAVEPOINT c1;

-- 6. 20번 부서 삭제
DELETE from dept01 where deptno = 20;

-- 7. c2 저장점 생성
SAVEPOINT c2;

-- 8. 10번 부서 삭제
DELETE from dept01 where deptno = 10;

-- 9. 순차적으로 ROLLBACK 수행
SELECT * from dept01;
ROLLBACK to c2; -- 10번 부서 복구
ROLLBACK to c1; -- 20번 부서까지 복구
ROLLBACK;       -- 이전 트랜잭션 종료 이후를 복구 30번 부서까지 복구









