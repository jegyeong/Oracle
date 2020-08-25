2020-01-22  01)자료 삭제(delete)
    (사용형식)
    delete 테이블명
    [where 조건]
    - '조건'에 서브쿼리를 사용하는 경우 in(exists) 연산자를 사용하여 다수행의 삭제 실행
    
    select * from remain2
    where remain_j_00 <= 10;
    
    delete remain2;
    
    delete remain2;
   
   rollback;
   
예)2005년 3월 입고된 상품코드에 해당하는 상품정보를 remain2 테이블에서 삭제하시오
     delete remain2
     where remain_prod in (서브쿼리)
     
     (서브쿼리) 2005년 3월 입고된 상품의 상품코드
     select distinct buy_prod
     from buy_prod
     where between '20050301' and '20050331';
     
     (결합)
     delete remain2
     where remain_prod in ( select distinct buy_prod
                            from buyprod
                            where buy_date between '20050301' and '20050331');
                            
    rollback;
    
    
    (exists 연산자 사용)
    delete remain2
     where exists in ( select 1
                            from buyprod
                            where buy_date between '20050301' and '20050331')
                            and remain_prod = buy_prod;
                            
    select count(*) from remain2;
    
    예)장바구니 테이블에서 2005냔 7월 19일 판매된 상품의 해당 거래처 정보를 삭제하시오
     delete buyer
     where buyer_id in (서브쿼리)
     
     (서브쿼리) 2005년 7월 19일에 판매된상품의 해당 거래ㅔ처 정보
     select prod_buyer
     from prod, cart 
     where pro_id = cart_prod 
     and cart_no like '20050719%'
     
     (결합)
       delete buyprod
     where prod_buyer in (select prod_buyer
                        from prod, cart 
                        where pro_id = cart_prod 
                        and cart_no like '20050719%');