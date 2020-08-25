2020-01-21  02)서브쿼리를 이용한  insert/update/delete

재고수불테이블 생성(remain)
---------------------------------------------
컬럼명     데이터타입(크기)   nullable    key
---------------------------------------------
remain_year  char(4)        n,n         pk
remain_prod  varchar(10)    n,n         pk/fk
remain_j_00  number(5) --기초재고
remain_i     number(5) --입고수량(buyprod
remain_o     number(5) --출고수량(cart
remain_j_99  number(5) --현 재고, (기마재고)
remain_date  date      --수정되어진날
---------------------------------------------

 create table remain(
 remain_year  char(4) not null,
 remain_prod  varchar(10) not null,
 remain_j_00  number(5), 
 remain_i     number(5),
 remain_o     number(5), 
 remain_j_99  number(5),
 remain_date  date,
    
 constraint pk_remain primary key(remain_year, remain_prod),
 constraint fk_remain foreign key(remain_prod)
    references prod(prod_id));--참조해라
    
    
 예)remain 테이블에 다음 조건에 맞게 자료를 입력하시오
    (조건)
    - 년도 : 2005년
    - 상품코드 : 상품테이블(prod)의 상품코드
    - 기초재고 : 상품테이블(prod)의 적정재고(prod_properstock)
    - 입고수량 : 0
    - 출고수량 : 0
    - 기말재고 : 상품테이블(prod)의 적정재고(prod_properstock)
    - 처리일자 : 2004년 12월 31일
    
    --한나씩 입력 > values 씀 
    --일괄입력 > 서브쿼리 사용
    insert into remain (remain_year, remain_prod, remain_j_00,remain_i,
                        remain_o, remain_j_99, remain_date)
        select '2005', prod_id, prod_properstock,0,0,prod_properstock, '20041231'
            from prod;
            
    **서브쿼를 이용한 테이블 복사
    create table remain2 as
        select * from remain;
        --remain2는 기본키와 외래키가 없다는 것만이 remain 테이블과 다르다
        --기본키와 외래키은 고유값!
        --서브쿼리 사용할 때는 가로x
        
    2)서브쿼리를 이용한 data update
    
    예)2005년 1월 31일을 기준으로 제품별 입고수량을조회하여 재고 수불테이블을 갱신하시오
    서브쿼리) : 2005년 1월 제품별 입고수량을 조회

    SELECT BUY_PROD,SUM(BUY_QTY)
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
    GROUP BY BUY_PROD;
    
    (메인쿼리) : 서브쿼리 결과로 REMAIN테이블 갱신
    --UPDATE 테이블명 바뀌는 내용 I,J_99,DATE
    UPDATE REMAIN A
      SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE) = (--서브쿼리
        
        
    (결합)
    UPDATE REMAIN A
    SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE) = (
        SELECT REMAIN_I+B.IAMT,
               REMAIN_J_00+REMAIN_I+B.IAMT-REMAIN_O,
               '20050131'
          FROM (SELECT BUY_PROD,SUM(BUY_QTY) AS IAMT
                    FROM BUYPROD
                WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
                GROUP BY BUY_PROD) B
            WHERE A.REMAIN_PROD =B.BUY_PROD)
    where a.remain_prod in (select distinct buy_prod
                            from buyprod
                            where buy_date between '20050101' and '20050131');
    rollback;
    
    
    UPDATE REMAIN A
    SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE) = (
        SELECT REMAIN_I+B.IAMT,
               REMAIN_J_00+REMAIN_I+B.IAMT-REMAIN_O,
               '20050131'
          FROM (SELECT BUY_PROD,SUM(BUY_QTY) AS IAMT
                    FROM BUYPROD
                WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
                GROUP BY BUY_PROD) B
            WHERE A.REMAIN_PROD =B.BUY_PROD)
    where a.remain_prod in (select distinct buy_prod
                            from buyprod
                            where buy_date between '20050201' and '20050331');
    
    
                            
    UPDATE REMAIN A
    SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE) = (
        SELECT REMAIN_I - B.IAMT,
               REMAIN_J_00+  REMAIN_I - B.IAMT-REMAIN_O,
               '200504%'
          FROM (SELECT BUY_PROD,SUM(BUY_QTY) AS IAMT
                    FROM cart
                WHERE BUY_DATE like '200504%'
                GROUP BY BUY_PROD) B
            WHERE A.REMAIN_PROD =B.BUY_PROD)
    where a.remain_prod in (select distinct buy_prod
                            from buyprod
                            where buy_date between '20050201' and '20050331');
    
    