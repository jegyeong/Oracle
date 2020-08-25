2020-01-16  01)외부조인(outer join)
    - 내부 조인(inner join, equal-join)에서는 조인조건을 만족하지 않ㄴ느 데이터는 검색에서 제외
    - 외부조인에서는 모자라는 테이블에 null 행을 삽입하여 모든 행이 검색 되도록 조회하는 방법
    - 데이터의 갯수(행의 수)가 아니라 종류가 기준
    --내부조인 부족하면 부족한 자료를 기준으로 해서 남은 행들을 무시? > 적은쪽기준
    --외부조인 부족한 쪽에 null을 다 넣고 남는 >많은쪽 기준
    --전체 자료에 대해서, 모든 자료에 대해서 라고 들어가면 외부조인을 쓴다 
    --물리적 행의 수가 많고 적음이 아니다! > 가짓수가 많다는 것
    
    (사용형식-일반 outer join)
    - 조인 조건식에서 부족한 쪽의 컬럼명 뒤에 '(+)' 연산자를 추가
        select 컬럼명 list
          from 테이블 list
         where 컬럼명 = 컬럼명 (+)....
         
    (사용형식- Ansi outer join)
        select 컬럼명 list
          from 테이블1 list
          left|right|full [outer] join 테이블명2 on(조인조건 [ --left|right|full 왼쪽 오른쪽은 많은것 기준 
          --left는 테이블 1이 테이블2 보다 많을때  양쪽다 부족하면 full
          and 일반조건...] -- 테이블명 1과 2에 국한된 것이면 and 뒤에다가 쓴다
                :
         [where 일반조건] --총괄조건
         
    (주의사항)
    - 3개 이상의 테이블이 사용되는 경우 모두 외부조인할 경우 모든 조인조건에 '(+)' 연산자를 기술해야함
    - 한번에 한 테이블에 대해서만 외부조인을 할 수 있음. 즉, a, b, c 테이블을 대상으로 외부 조인을 수행하는 경우 a를 
      기준으로 b테이블을 외부조인으로 연겨랳ㅆ다면 c를 기준으로 b테이블에 외부조인을 수행할 수 없다
    - '(+)' 연산자가 붙은 조건과 다른 조건을 or 연산자로 결합시킬 수 없다
    - '(+)' 연산자는 IN 연산자와 같이 사용할 수 없다 
    -- 괄호안에 + 는 한번만!
    - 일반 외부조인 조건과 일반조건이 동시에 적용되면 외부조인은 수행되지 않음
      (내부 조인결과가 반환됨 - 해결방법으로 subQuery나 Ansi outer join을 사용해야함)
         
    예)상품테이블과 분류테이블을 이용하여 전체 분류별 상품의 수를 조회하시오
       Alias 는 분류코드, 분류명, 상품의 수이다
       select count(*) from lprod;
       
       select count(*) (distinct prod_lgu) from prod;
       
       (내부조인)
       select a.lprod_gu as 분류코드, 
              a.lprod_nm as 분류명, 
              count(*) as 상품의수
        from lprod a, prod b
        where a.lprod_gu = b.prod_lgu
        group by a.lprod_gu, a.lprod_nm;
        
        (외부조인)
        select a.lprod_gu as 분류코드, 
               a.lprod_nm as 분류명, 
               --count(*) as 상품의수
               count(prod_id) as 상품의수
        from lprod a, prod b
        where a.lprod_gu = b.prod_lgu(+)
        group by a.lprod_gu, a.lprod_nm
        order by 1;
        
        (Ansi 조인)
        select a.lprod_gu as 분류코드, 
               a.lprod_nm as 분류명, 
               --count(*) as 상품의수
               count(prod_id) as 상품의수
        from lprod a
        left outer join prod b on (a.lprod_gu = b.prod_lgu)
        group by a.lprod_gu, a.lprod_nm
        order by 1;
        
        예)2005년 6월 매출정보를 조회하되 모든 상품별 매출정보 조회하시오
        --모든, 전부가 들어가면 아우터조인이다!
        (내부조인)
        select a.prod_name as 상품명,
               sum(b.cart_qty) as 판매수량,
               sum(b.cart_qty * a.prod_price) as 판매금액
            from prod a, cart b
            where a.prod_id = b.cart_prod
              and substr(b.cart_no,1,6) = '200506'
            group by a.prod_name;
        
        (외부조인-일반)
        select a.prod_name as 상품명,
               sum(b.cart_qty) as 판매수량,
               sum(b.cart_qty * a.prod_price) as 판매금액
            from prod a, cart b
            where a.prod_id = b.cart_prod(+)
              and substr(cart_no,1,6) = '200506'
            group by a.prod_name;
            --안나옴
            --Ansi나 서브쿼리고 써야해
            
        (외부조인-Ansi)
        select a.prod_name as 상품명,
               nvl(sum(b.cart_qty),0) as 판매수량,
               nvl(sum(b.cart_qty * a.prod_price), 0) as 판매금액
            from prod a
            left outer join cart b on (a.prod_id = b.cart_prod
              and b.cart_no like '200506%')
            group by a.prod_name;
            
        (subquery )
        select b.prod_name as  상품명,
               nvl(a.qamt,0) as 판매수량,
               nvl(mamt, 0) as 판매금액
         from (select cart_prod,
                      sum(cart_qty) as qamt,
                      sum(cart_qty * prod_price) as mamt
                     from cart, prod
                    where cart_prod = prod_id
                      and cart_no like '200506%'
                 group by cart_prod) a, prod b;
          --괄호안은 서브쿼리 
          --서브쿼리만 실행해도 실행 되어야함!
            
        예) 2005년 6월 매입정보를 조회하되 모든 상품별 매입정보 조회
            Alias 상품명, 매입수량, 구매금액
            (내부조인)
            select a.prod_name as 상품명, 
                   sum(b.buy_qty) as 매입수량, 
                   sum (b.buy_qty * b.buy_cost) as 구매금액
            from prod a, buyprod b
           where a.prod_id = b.buy_prod
             and substr(b.buy_date, 1, 7) = '2005/06'
            group by a.prod_name;
   

            (외부조인-Ansi)--안됨
         select a.prod_name as 상품명, 
                nvl(sum(b.buy_qty),0) as 매입수량, 
                nvl(sum(b.buy_qty * b.buy_cost),0) as 구매금액
            from prod a 
            left join buyprod b on (a.prod_id = b.buy_prod
            and substr(b.buy_date, 1, 7) = '2005/06')
            group by a.prod_name
            order by 3 desc;
            
         예) 사원테이블에서 모든 부서에 대한 사원수를 조회하는 쿼리를 장석하라
            Alias 는 부서코드, 부서명, 사원수
            
            select departments.department_id as 부서코드,
                   departments.department_name as 부서명,
                   count(employees.employee_id) as 사원수
                from employees 
                full outer join departments on (departments.department_id = employees.department_id)
                group by departments.department_id, departments.department_name;
                
        예)2005년 5월달 전체상품에 대하여 입,출고 현황을 조회하시오
            Alias 는 상품코드, 상품명, 입고량, 출고량
        
            --정확한 값이 안나옴       
            select c.prod_id as 상품코드,  --prod 테이블 말고 다른 테이블껄쓰면 전부 나오지 않음
                   c.prod_name as 상품명, 
                   sum(a.buy_qty) as 입고량, 
                   sum(b.cart_qty) as 출고량
            from prod c  
            left outer join buyprod a on (a.buy_prod = c.prod_id)
            left outer join cart b on (b.cart_prod = c.prod_id) 
           where substr(b.cart_no,1,6) = '200505'
            group by c.prod_id, c.prod_name;
          
            
        select b.prod_id as 상품코드,
               b.prod_name as 상품명,
               nvl(sum (a.buy_qty),0) as 입고량,
               nvl(sum(c.cart_qty),0) as 출고량
        from buyprod a
        right outer join prod b (a.buy_prod = b.prod_id
          and  a.buy_date between '20050501' and '20050531') 
        left outer join cart c on (c.cart_prod = b.prod_id
            and c.cart_no like '200505%'
        group by b.prod_id, b.prod_name)
        order by 1;
        --조건 하나하나써줘야 하는데 안됨
                  
        
        
     
        
        
            
        
        


    
    