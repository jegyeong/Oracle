2020-01-20  03)집합연산자

2020-01-21- 01)집합(set)
    - union, union all, intersect, minus
    - 각 select 문에 사용된 컬럼의 수와 데이터 타입이 동일해야함
    - 최종출력은 맨앞에 기술된 select 절이 기준이 됨
    - 대용량 데이터타입(blob, clob, bfile 등)은 사용 불가
    - order by 절은 맨 마지막 query 문에서만 사용 가능 
    

    
 1) union, union all
    - 합집합의 결과를 반환
    - union 은 중복배제, union all 은 중복 허용
예) 회원테이블에서 직업이 자영업이고 주거지가 대전인 회원정보를 집합연산자를 사용하여 조회하시오
   Alias는 회원번호, 회원명, 마일리지, 직업
   
   (직업이 자영업)
   select mem_id as 회원번호, 
          mem_name as 회원명, 
          mem_mileage as 마일리지, 
          mem_job as 직업
    from member
   where mem_job = '자영업'
    -----------------------------------------------------   
   (주거지가 대전)
   select mem_id as 회원번호, 
          mem_name as 회원명, 
          mem_mileage as 마일리지, 
          mem_job as 직업,
          substr(mem_add1,1,2) as 거주지
    from member
   where mem_add1 like '대전%'
    -----------------------------------------------------
 (union 사용)
 select mem_id as 회원번호,
       mem_name as 회원명,
       mem_mileage as 마일리지,
       mem_job as 직업,
       substr(mem_add1,1,2) as  거주지
    from member
    where mem_job='자영업'
    
    union
    
    select mem_id as 회원번호,
       mem_name as 회원명,
       mem_mileage as 마일리지,
       mem_job as 직업,
       substr(mem_add1,1,2) as  거주지
    from member
    where mem_add1 like '대전%'
    order by 1;
    -----------------------------------------------------    
    
       (or 연산자)
 select mem_id as 회원번호,
       mem_name as 회원명,
       mem_mileage as 마일리지,
       mem_job as 직업,
       substr(mem_add1,1,2) as  거주지
    from member
    where mem_add1 like '대전%'or mem_job='자영업'
    order by 1;
    
    -----------------------------------------------------
     (union all 사용)
 select mem_id as 회원번호,
       mem_name as 회원명,
       mem_mileage as 마일리지,
       mem_job as 직업,
       substr(mem_add1,1,2) as  거주지
    from member
    where mem_job='자영업'
    
    union all
    
    select mem_id as 회원번호,
       mem_name as 회원명,
       mem_mileage as 마일리지,
       mem_job as 직업,
       substr(mem_add1,1,2) as  거주지
    from member
    where mem_add1 like '대전%'
    order by 1;
    
    
 예) 사원테이블, 부서테이블, 직책테이블에서 테이블이름, 테이블설명, 자료수를 출력하는 쿼리를 작성하시오
   
   select 'EMPLOYEES' as 테이블명,
          '사원테이블' as "테이블 설명",
          count(*) as 자료수
     from employees

    union

    select 'DPARTMENTS' as 테이블명,
          '부서테이블' as "테이블 설명",
          count(*) as 자료수
     from departments
     
     union
     
     select 'JOBS' as 테이블명,
          '직책테이블' as "테이블 설명",
          count(*) as 자료수
     from jobs;

예) 2005년 2월에 구매된 상픔과 2005년 4월에 구매된 상품을 모두 조회하시오
Alias는 상품번호, 상품명, 구매수량합

select buy_prod as 상품번호, 
       prod_name as 상품명, 
       sum(buy_qty) as 구매수량합
  from buyprod, prod
 where buy_prod = prod_id
   and buy_date between '20050201' and '20050228'
 group by buy_prod, prod_name
 
 union all
 
select buy_prod as 상품번호, 
       prod_name as 상품명, 
       sum(buy_qty) as 구매수량합
  from buyprod, prod
 where buy_prod = prod_id
   and buy_date between '20050401' and '20050430'
 group by buy_prod, prod_name
 order by 1;
 
 
 2)intersect
    - 교집합(공통 부분)을 반환

예)2005년 4월에 판매된 상품이면서 2005년 6월에도 판매된 상품을 모두 조회하시오
    Alias 상품번호, 상품명, 판매수량합
    select cart_prod as 상품번호, 
           prod_name as 상품명, 
           sum(cart_qty) as 판매수량합
        from cart, prod
        where cart_no like '200504%'
        and cart_prod = prod_id
        --group by cart_prod, prod_name
        
    intersect  
        
    select cart_prod as 상품번호, 
           prod_name as 상품명, 
           sum(cart_qty) as 판매수량합
        from cart, prod
        where cart_no like '200506%'
        and cart_prod = prod_id
        group by cart_prod,  prod_name
        order by 1;
        
 3)minus
    - 차집합을 반환
    - A minus b : A의 쿼리 결과에서 B쿼리 결과를 제거한 값을 반환
     (순수하게 A에만 포함되어있는 결과를 반환)
     
    select cart_prod as 상품번호, 
       prod_name as 상품명
  from cart, prod
 where substr(cart_no, 1, 6) = '200504'
   and cart_prod = prod_id
 group by cart_prod, prod_name
 
 minus
 
 select cart_prod as 상품번호, 
       prod_name as 상품명
  from cart, prod
 where substr(cart_no, 1, 6) = '200506'
   and cart_prod = prod_id
 group by cart_prod, prod_name
 order by 1;
         
    

  