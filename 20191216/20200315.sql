2020-01-15  01)ANSI Inner join 형식
    (사용형식)
    select 컬럼명...
      from 테이블명
     inner join 테이블명2 on 조인조건
     --조인된 결과와 조인되어진다!
      [and 일반조건... > 테이블1,2에만 속한 조건일때] 
    [inner join 테이블명2 on 조인조건
    ...]
    [where 일반조건...]
    
예) 2005년 3월 제품별 매입정보를 조회하시오
    Alias 는 제품번호, 제품명, 매입수량, 매입금액
    by prod 에 매입정보
    (일반조인)
    select a.buy_prod as 제품번호,
           b.prod_name as 제품명,
--           count(*) as 구매횟수,
           sum (a.buy_qty) as 매입수량,
           sum (a.buy_qty * a.buy_cost) as 매입금액
        from buyprod a, prod b
    where a.buy_prod = b.prod_id                        --조인조건
      and a.buy_date between '20050301' and '20050331'  --일반조건
    group by a.buy_prod, b.prod_name;
    
    (ANSI 형식)
      select a.buy_prod as 제품번호,
           b.prod_name as 제품명,
--           count(*) as 구매횟수,
           sum (a.buy_qty) as 매입수량,
           sum (a.buy_qty * a.buy_cost) as 매입금액
        from buyprod a
        inner join prod b on (a.buy_prod = b.prod_id --조인조건
         and a.buy_date between '20050301' and '20050331')
        group by a.buy_prod, b.prod_name;
    
예)상품테이블에 저장된 상품에 대하여  상품번호, 상품명, 분류명, 거래처명을
    조회하시오
    (일반조인)
    select a.prod_id as 상품번호,
           a.prod_name as 상품명,
           c.prod_nm as 분류처, 
           c.buyer_name as 거래처명
        from prod a, buyer b, lprod c 
        where a.prod_buyer = b.buyer_id
        and a.prod_lgu = c.prod_gu;
    
    (ANSI 형식)    
    select a.prod_id as 상품번호,
           a.prod_name as 상품명,
           c.prod_nm as 분류처,
           c.buyer_name as 거래처명
        from prod a --하나만 기술
        inner join buyer b on (a.prod_buyer = b.buyer_id) --조인조건
        inner join lprod c on (a.prod_lgu = c.lprod_gu);  --조인조건
        
예)2005년도 회원별 매출액을 조회하시오.
    단, 구입건수가 5회이상이고 매출액이 500만원 이상인 회원에 대하여 
    회원번호, 회원명, 구매건수, 구입금액을 조회하시오
    
    select a.mem_id as 회원번호,
           a.mem_name as 회원명,
           count(*) as 구매건수,          
           sum (b.prod_price * c.cart_qty) as 구입금액
        from member a, prod b, cart c
    where a.mem_id = c.cart_member
      and c.cart_prod = b.prod_id
      and substr(cart_no,1,4) = '2005'
       group by a.mem_id, a.mem_name
      having count(*) >= 5 and sum(b.prod_price * c.cart_qty) >= 5000000
      order by 4 desc;
    
    (ANSI)  
         select a.mem_id as 회원번호,
           a.mem_name as 회원명,
           count(*) as 구매건수,          
           sum (b.prod_price * c.cart_qty) as 구입금액
        from member a
        inner join cart c on (a.mem_id = c.cart_member) 
        inner join prod b on (c.cart_prod = b.prod_id)
        and c.cart_prod = b.prod_id
        and substr(cart_no,1,4) = '2005'
        group by a.mem_id, a.mem_name --집계함수와 일반칼럼이 항께라면 항상써야해
        having count(*) >= 5 and sum(b.prod_price * c.cart_qty) >= 5000000
        order by 1;
        --집계함수비교 having 절 ! 
        --select from where groupby having by, oder by 순서로 

-------------------------------------------------------------------------------------------        
예)2008년도 회원별 매출액을 조회하시오. 단, 구매건수가 5회 이상이고, 매출액이 500만원 이상인 회원에 대하여 
    Alias 는 회원번호, 회원명, 구매건수, 구입금액
    
    select c.mem_id as 회원번호,
           c.mem_name as 회원명,
           count(*) as 구매건수, --inner join 일때만 아스트릭스 쓸 수 있음!
           sum(b.prod_price * a.cart_qty) as 구매금액
     from cart a, prod b, member c
     where substr(a.cart_no,1,4) = '2008'
     --where cart_no like '2005%'로 써도됨
     having count(
---------------------------------------------------------------------------------------

예)2005년도 매출자료(cart)를 이용하여 거래처별 매출액을 조회하시오
    거래처번호, 거래처명, 판매건수, 판매금액
     --proud_lgu 상품 분류코드임!
    select b.buyer_id as 거래처번호, 
           b.buyer_name as 거래처명, 
           count(*) as 판매건수, 
           sum(a.cart_qty * c.prod_price)as 판매금액
       from cart a, buyer b, prod c
       where a.cart_prod = c.prod_id
         and b.buyer_id = c.prod_buyer
         and substr(a.cart_no,1,4) = '2005'
       group by b.buyer_id, b.buyer_name
       order by 1 desc;
       
       --관계선 존재한다 > 반드시 조인이 나온다
       
       (ANSDI)
       select b.buyer_id as 거래처번호, 
           b.buyer_name as 거래처명, 
           count(*) as 판매건수, 
           sum(a.cart_qty * c.prod_price)as 판매금액
       from cart a
       inner join  prod c on (a.cart_prod = c.prod_id)
       inner join buyer b on (b.buyer_id = c.prod_buyer)
       where substr(a.cart_no,1,4) = '2005'
       group by b.buyer_id, b.buyer_name
       order by 1 desc;
       
예)장바구니 테이블의 자료를 활용하여 2005년 5월 상품 분류별 판매현황을 조회하시오
    Alias 분류코드, 분류명, 판매액합계
 (일반쿼리)--다시써보긔
    select b.lprod_gu as 분류코드, 
           b.lprod_nm as 분류명, 
           sum (c.prod_price * a.cart_qty) as 판매액합계
      from cart a, lprod b, prod c
      where substr(a.cart_no,1,6) = '200505' 
           --cart_no like '200505%'
       and a.cart_prod = c.prod_id
       and b.lprod_gu = c.prod_lgu
  group by b.lprod_gu, b.lprod_nm;
  
  (ANSI 쿼리)
    select b.lprod_gu as 분류코드, 
           b.lprod_nm as 분류명, 
           sum (c.prod_price * a.cart_qty) as 판매액합계
      from lprod b
     inner join prod c on (b.lprod_gu = c.prod_lgu)
     inner join cart a on (a.cart_prod = c.prod_id)
     where substr(a.cart_no,1,6) = '200505'
  group by c.prod_id, c.prod_lgu;
  
  
  (ANSI)
  select b.lprod_gu as 분류코드, 
           b.lprod_nm as 분류명, 
           sum (c.prod_price * a.cart_qty) as 판매액합계
      from prod c
      inner join cart a on (a.cart_prod = c.prod_id)
      inner join lprod b on (b.lprod_gu = c.prod_lgu) 
      where substr(a.cart_no,1,6) = '200505' 
           --cart_no like '200505%'
   group by b.lprod_gu, b.lprod_nm;
      
       
       
       
       
       
       