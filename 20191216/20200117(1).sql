2020-01-17  01)SUBQUERY
    
    --쿼리들을 결합시키는것
    
    - QUERY 안에 포함된 또 다른 쿼리
    - 최종결과를 출력하기 위한 쿼리(바깥쪽 쿼리)를 메인 쿼리라고함
    - 서브쿼리는 SELECT, WHERE, FROM 절에 위치할 수 있음
      (일반적으로 서브쿼리는 일반적으로 SELECT, WHERE 절에 오는것)
      (특히 FROM 절에 나오는 서브쿼리를 IN-LINE SUBQUERY 라고 하며 자체적으로 실행가능해야함)
    - 서브 쿼리는 '( )'안에 기술되며 각 절에서 맨 먼저 실행됨
    - 서브쿼리의 분류
        : 메인쿼리와의 관련성(조인) 여부에 따라 연관성 있는 서브쿼리 연관성 없는 서브쿼리로 분류
        : 반환되는 결과가 하나의 행/열, 다수의 행/열에 따라 분류
    - 서브쿼리가 연산자와 함께 사용되는 경우 반드시 연산자를 오른쪽에 기술 (where절에서 쓰일때)
    
예)사원테이블에서 전체 사원의 평균 급여보다 더 많은 급여를 받는 사원들을 조회하시오
    Alias 는 사원번호, 사원명, 부서명, 급여
   
   (1)메인쿼리 - 원테이블에서 전체 사원의 사원번호, 사원명, 부서명, 급여 조회
             - (조건) 사원의 평균 급여보다 더 많이 급여를 받는
             
    select a.employee_id as 사원번호, 
           a.emp_name as 사원명, 
           b.department_name as 부서명, 
           a.salary as 급여
        from emplyees a, department b
        where a.department_id = b.department_id
        and selary  >= (평균급여_)
    
   (2)서브쿼리 - 사원의 평균급여 
    
    select avg(salary) from employees;
    
   (3)결합
    select a.employee_id as 사원번호, 
           a.emp_name as 사원명, 
           b.department_name as 부서명, 
           a.salary as 급여
      from employees a, departments b
     where a.department_id = b.department_id
       and a.salary  >= (select avg(salary) 
                      from employees);

** in-line 쿼리로 구현
    select a.employee_id as 사원번호, 
           a.emp_name as 사원명, 
           b.department_name as 부서명, 
           a.salary as 급여,
           round(c.savg) as 평균급여
      from employees a, departments b, (select avg(salary) as savg
                                        from employees) c 
                                        --평균급여를 계산해서 테이블형태로 저장(값 하나인 테이블)
    where a.department_id = b.department_id
       and a.salary  >= c.savg;
       
예)사원테이블에서 각 사원의 부서가 상위부서에 없는 부서에 속한 사원수를 조회하시오
    1)메인쿼리 - 사원테이블에서 사원수를 조회
              - (조건) : 사원들의 부서가 부서가 상위부서가 없는 부서
    select count(*)
      from employees
     where department_id = (상위부서가 없는 부서
    
    2)서브쿼리 - 상위부서가 없는 부서
    select department_id
      from departments 
     where department_id is null;--널은 '=' 써서 비교 x
    
    3)결합
     select count(*)
      from employees
     where department_id = (select department_id
                            from departments 
                            where department_id is null);
    --다중행 연산자 in some any all exists

예)사원테이블에서 각 사원의 부서가 상위부서 90 속한 사원수를 조회하시오    
    (any, some 연산자 이용)
    select count(*)
      from employees
     where department_id = any/*(some)*/(select department_id
                            from departments 
                            where department_id = 90);
                            
    (exists 연산자 이용)--관련성있는 서브쿼리(셀프조인)
    select count(*)
      from employees b
     where exists(select 10000 --조건이 맞을때 이 만큼을 출력하라> 없다면 null이 출력됨
                  from employees a 
                  where a.department_id in (select department_id
                                          from departments 
                                          where department_id = 90)
                    and a.employee_id = b.employee_id); --조인
    
    
예)장바구니테이블에서 2005년 6월 판매정보를 조회하시오
    단, 메인쿼리에 조인을 사용하지 말것
    Alias 는 회원명, 상품명, 판매수량
    select (select mem_name 
            from member
            where mem_id = cart_member) as 회원명,
            (select prod_name
             from prod
             where prod_id = cart_prod) as 상품명,
            cart_qty as 판매수량
    from cart
    where cart_no like '200506%';
    
예)사원테이블에서 각 사원의 부서코드를 기준으로 부서별 평균임금을 구하고
    자기가 속한 부서의 평귱임금보다 많은 임금을 받는 사원을 조호히하시오
    select --숙제 
                            
    
                                          
    
    
                      
            