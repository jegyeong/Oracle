2020-01-17  02) 단일행/다중행 서브쿼리
    - 서브쿼리의 결과가 하나의 행으로 반환되는 서브쿼리
    - 관계연산자(=, >, <, >=, <=, !=)가 사용
    
예)사원테이블에서 50번 부서에 속한 사원의 최대 급여보다 더 많은 급여를 받는 사원을 구하시오
    Alias 사원번호, 사원명, 부서명, 직책명, 급여
    
    (1)메인쿼리
    select a.employee_id as 사원번호,
           b.department_name as 사원명,
           a.emp_name as 부서명, 
           c.job_title as 직책명, 
           a.salary sa급여
      from employees a, departments b, jobs c
     where a.department_id = b.department_id --조인조건//부서명
       and a.job_id = c.job_id --조인조건//직책명
       and a.salary >= (50번 부서의 최대급여)
        
    (2)서브쿼리 - 50번부서에 속한 사원 중 최대 급여
    select max(salary)
      from employees
     where department_id = 50;
    
    (3)결합
    select a.employee_id as 사원번호,
           b.department_name as 부서명,
           a.emp_name as 사원명, 
           c.job_title as 직책명, 
           a.salary sa급여
      from employees a, departments b, jobs c
     where a.department_id = b.department_id --조인조건//부서명
       and a.job_id = c.job_id --조인조건//직책명
       and a.salary >= (select max(salary)
                          from employees
                         where department_id = 50);
                        
예)2005년 5월 장바구니 테이블에서 최대구매수량의 회원정보를 조횧사이오
    subquery적용 회원번호, 회웜녕, 상품명 --(1)
    subquery적용 회원번호, 회웜녕, 상품명, 최대구매수량 --(2)
    --3개 다 안됨
    (1)subquery적용 회원번호, 회웜녕, 상품명 --(1)
    select (select mem_id 
              from member
             where mem_id = cart_prod) as 회원번호, 
           (select mem_name
              from member 
             where mem_id = cart_prod)as 회원명, 
           (select prod_name
              from prod
           cart_prod = prod_id)as 상품명
      from members a, prod b, cart c
     where cart_no like '200505%'
       and cart_qty =(select max cart_qty
                        from cart); -- 언니 이거 틀린 코드예염
           
           
            
        select c.cart_member  as 회원번호, 
               a.mem_name as 회원명, 
               b.prod_name as 상품명
          from member a, prod b, cart c
         where a.mem_id = c.cart_member
           and b.prod_id = c.cart_prod
           and c.cart_no like '200505%'
           and c.cart_qty =(select max(cart_qty)
                              from cart);
            
            
    select c.cart_member  as 회원번호, 
           a.mem_name as 회원명, 
           b.prod_name as 상품명,
           d.mqty as 최대구매수량
      from member a, prod b, cart c, (select max(cart_qty) as mqty
                                        from cart
                                       where cart_no like '200505%') d
     where a.mem_id = c.cart_member
       and b.prod_id = c.cart_prod
       and c.cart_no like '200505%'
       and c.cart_qty = d.mqty;
            
            
예)2005년 5월 모든 회원별 구매수량 합, 구매금액 합을 구하시오
    단, ansi outer join 을 사용하지 말것
        구매액 기준 사우이 5명만 조회할것
    Alias 는 회원번호,구매수량
    
    select cart_member as 회원번호, 
           sum(cart_qty) as 구매수량 
      from cart
     where cart_no like '200505%'
       and rownum <= 5
     group by cart_memeber
     order by 2 desc;
        
    select cart_qty as 구매수량 
      from cart
     where cart_no like '200505%'
       and rownum <= 5
     group by cart_memeber
     order by 2 desc;
            
__________________________________________________________________________________완성     
 select a.cart_member as 회원번호,
        b.sqty as 구매수량
   from (select distinct cart_member
           from cart
          where cart_no like '200505%') a, 
        (select cart_member, sum(cart_qty) as sqty
           from cart
          where cart_no like '200505%'
          group by cart_member
          order by 2 desc) b
  where a.cart_member = b.cart_member
    and rownum <= 5;
    
    
        
    
    
        
    
    
        