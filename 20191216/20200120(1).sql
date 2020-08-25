2020-01-20  01)다중행서브쿼리
    --일반 관계연산자X
    --in some any...
    
예)상품테이블에서 상품의 분류코드가 'p201'(여성캐주얼)의 단가보다 
    더 큰 단가를 가지고 있는 상품을 조회하시오
    Alias 는 상품코드, 상품명, 분류명, 판매가격이다.

(단일행)  
    select a.prod_id as 상품코드, 
           a.prod_name as 상품명, 
           b.lprod_nm as 분류명,
           b.lprod_gu as 분류코드, ---a.prod_lgu
           a.prod_price as 판매가격
     from prod a, lprod b
    where a.prod_lgu = b.lprod_gu
      and a.prod_price >= (서브쿼리)

(서브쿼리)
    select min(prod_price) --최저가격
      from prod
     where prod_lgu = 'P201';
  
(결합_)    
     select a.prod_id as 상품코드, 
           a.prod_name as 상품명, 
           b.lprod_nm as 분류명,
           b.lprod_gu as 분류코드, ---a.prod_lgu
           a.prod_price as 판매가격
     from prod a, lprod b
    where a.prod_lgu = b.lprod_gu
      and a.prod_price >= (select min(prod_price) --최저가격
                          from prod
                          where prod_lgu = 'P201');
                          

(다중행서브쿼리)--any some in all exists 
      (select prod_price --최저가격
        from prod
       where prod_lgu = 'P201');
       
       
    select a.prod_id as 상품코드, 
           a.prod_name as 상품명, 
           b.lprod_nm as 분류명,
           b.lprod_gu as 분류코드, ---a.prod_lgu
           a.prod_price as 판매가격
     from prod a, lprod b
    where a.prod_lgu = b.lprod_gu
      and a.prod_price  = any (select prod_price --최저가격 --any 대신 in써도됨
                             from prod
                            where prod_lgu = 'P201');
                            
(숙제)
각 부서별 평균급여를 계산하고 자기 소속 부서의 평균급여보다 더 많은 급여를 받는 사원정보 조히
    Alias 는 사원번호, 사원명, 소속부서명, 급여
    
(메인)
    select a.employee_id as 사원번호, 
           a.emp_name as 사원명, (유일한 컬럼명은 a 를 안써도 되긴해ㅠ 그넫 써주는것이 좋다)
           b.department_name as 소속부서명, 
           a.salary as 급여
    from employees a, department b
   where a.salary >= (서브쿼리)
     and a.department_id = (서브쿼리의 department_id) 
    
     
(결합)
        select a.employee_id as 사원번호, 
           a.emp_name as 사원명, --(유일한 컬럼명은 a 를 안써도 되긴해ㅠ 그넫 써주는것이 좋다)
           b.department_name as 소속부서명,
           rount(e.sal) as 평균급여,
           a.salary as 급여
    from employees a, departments b, (select depatment_id, 
                                            round(avg(salary)) as sal
                                       from employees
                                       group by depratment_id) e
   where a.department_id = b.department_id
     and a.department_id = e.department_id --
     and a.salary >= e.sal
   order by 3;
   
                
    
    
