2020-01-02  2)집계함수(그룹함수)

    - 원본자료를 특정항목(컬럼)을 기준으로 그룹으로 묶어 집계처리를 수행--절대 까먹으면 안돼
    - SUM, AVG(평균), COUNT(개수: 행의수), MIN, MAX--뒤따라서 거의 GROUP BY가 나옴, 안나오면 전체테이블을 하나로 묶을때 
    - 특정한 경우(테이블 전체를 하나의 그룹으로 간주)를 제외하고 GROUP BY 와 함께 사용됨
    - 집계함수에 조건이 부여되면 WHERE 절로 조건처리가 불가능하며 반드시 HAVING 절로 처리해야함 --WHERE절 쓸 수 없다
    - GROUP BY 다음에 기술되는 항목은 SELECT 절에서 집계함수를 제외한 모든 일반 항목(필수 기술)과 그룹이 필요한 일반 컬럼으로 구성
        --기술순서 > WHERE, GROUP BY > HAVING > ORDER BY 바꿀 수 없어 > 무조건 이순서대로 써야해
    - GROUP BY 다음에 기술되는 항목순으로 그룹이 다시 소그룹으로 묶임 --왼쪽에서 오른쪽으로 그룹이 무%ㄲ임 
    --그룹 > 특정한 값 중 똑같은 값을 가진 애들끼리 그룹으로 묶는것! (컬럼의 값이 동일한 애들끼리)
    --select절을 봐야해 
    --sum 안의 컬럼명을 생략할 수 없다
    --함수는 반드시 값을 되돌려줘야한다! > 반드시 함수가 실행된 위치에
    ----select절 from절 은 필수
    
    
        1)SUM
         - 특정 칼럼값의 합을 반환
         (사용형식)
          SUM(c1)
          - c1 컬럼의 합을 구하여 반환
          - 여러가지 컬럼의 합을 구할 수 없다
        
        예) 사원테이블에서 사원들의 급여 합을 구하시오
        select sum(salary)--테이블 전체를 하나의 그룹으로 놓으니까 group by가 필요없다
            from employees;
        
        예) 사원테이블에서 부서별 사원들의 급여 합을 부서코드 순으로 출력하시오    
        select departmemt_id,
               sum(salary)
            from employees; --오류 | ~ 별이 나오면 group by가 나와야해
            
        select departmemt_id,
               to_char(sum(salary), '$999,999.9') as 급여합
            from employees
            group by department_id --select절을 쳐다봐라
            order by 1; --부서코드 순으로 출력하시오(첫뻔째니까 1을 써도되고 department_id 르ㅜㄹ 써도됨
            
        예)장바구니테이블(cart)에서 2005년 6월 상품별 판매수량합계를 구하시오
            Alias 는 상품번호, 판매수량합  --cart member 회원번호임!, cart_prod : 상품번호
            select cart_prod as 상품번호,
                   sum(cart_qty) as 판매수량합
                from cart --cart 안에 다 포함되니까 테이블 2개 쓸 필요 없다
                where substr(cart_no, 1, 6) = 200506 --월까지만 쓰ㅜ면 되니까 6자리만 필요혀
--                like --이걸로는 어케하지?
                --행의 수를 구하는것이 count이다

                group by cart_prod; --왜쓰느냐? 상품별~ 이란말이 나왔으니까 //상품을 다꺼내서 묶어야 하니까!
                
        
        예)매입테이블(buyprod)에서 2005년 4월 일자별 매입수량합과 매입금액합을 구하시오
            Alias 는 일자, 매입수량합, 애입금액합
            select buy_date as 일자,
                   sum(buy_qty) as 매입수량합,
                   sum(buy_cost * buy_qty) as 매입금액합
                from buyprod
--                where substr(buy_date,1,6) = 200504
                where buy_date between to_date('20050401') and to_date('20050430')
                group by buy_date
                order by 1;
        
        
        
 
 2020-01-03 --------------------------------------------------------       
        예) 회원테이블에서 모든 회원들의 마일리지 합을 구하시오
        --group by 필요없음! 하나만 있으면돼
        
        select sum(mem_mileage)
            from member;
        --group by mem_name;
        --group by 쓰는 의미가 없어ㅠㅠ 이러면 회원별이 되니까
    
        예) 회원테이블에서 성별 회원들의 성별 마일리지 합을 구하시오
         
         select case when (substr(mem_regno2,1,1) = '1' or
                          substr(mem_regno2,1,1) = '3') then '남성회원'
                     when (substr(mem_regno2,1,1) = '2' or
                          substr(mem_regno2,1,1) = '4') then '여성회원' 
                    end as  성별,
                sum(mem_mileage)
            from member
            group by case when (substr(mem_regno2,1,1) = '1' or
                          substr(mem_regno2,1,1) = '2') then '남성회원'
                     when (substr(mem_regno2,1,1) = '2' or
                          substr(mem_regno2,1,1) = '4') then '여성회원' 
                    end;
             
        예)회원테이블에서 거주지별 회원의 마일리지 합을 구하시오   
            select substr(mem_add1,1,2) as 거주지,
                   sum(mem_mileage) as 마일리지합
                from member
                group by substr(mem_add1,1,2);
                
        예) 사원테이블에서 2005년 이후에 입사한 사원들에 대하여 부서별 급여 합계를 구하시오 --부서별 이거 기준으로 하겠다
        --2005년 이후에 입사한 사원들 > 일반조건
            select department_id as 부서코드,
               sum (salary) as 급여합계
              from employees
             where extract (year from hire_date) >= 2005 --2005년 입사자 : 입사일은 date 타입이라서 substr 쓰지 말라고 (문자열 아님!) 
--             where substr(hire_date, 1, 4) = 2005 --날짜에 substr 쓰지 말라구, like 쓰면 안돼
          group by department_id;
--                having substr(hire_date, 1, 4) = 2005;


        예) 장바구니 테이블에서 2005년 5월 자료에서 제품별 판매수량합을 구하되 판매수량합계가 30개 이상인 제품남 조회하시오
            select cart_prod as 제품,
               sum(cart_qty) as 판매수량합
              from cart
--            where cart_no like '200505%'   이거 써도됨
             where substr(cart_no, 1, 6) = 200505
          group by cart_prod 
        having sum(cart_qty) >= 20;
        
        
        2)count 
            - 그룹 내의 행의 수(자료수)
            - count(*|c1)
            
        예) 사원테이블에서 전체 사원수를 조회하시오 --전체테이블이 하나의 그룹 > 그룹바이 안써도됨!
            select count(*),
                   count(employ_id), --기본키
                   count(salary) --다른칼럼 아무거나 써도됨
                from employees;
        
        예) 사원테이블에서 부서별 사원수를 조회하시오
            select department_id as 부서코드,
             count(*) as 사원수,
              sum (salary) as 급여합계
             from employees
            group by department_id
            order by 1;
         
         예) 상품테이블에서 거래처별 거래상품의 수를 조회하시오
       select prod_buyer as 거래처코드,
              count(*) as 거래상품의수 
         from prod
        group by prod_buyer
        order by 2 desc; --거래처 순으로 정렬
        
        예)회원테이블에서 거주지별 회원수를 조회하시오
            select substr(mem_add1,1,2) as 거주지,
                   count(*) as 회원수 
            from member
            group by substr(mem_add1,1,2);
        
        
        예)장바구니테이블에서 회원별 2005년 5~6월 회원별 구매회수를 조회하되 구매횟수가 5회 이상인 회원만 조회하시오
            select cart_member as 회원코드, --like 하나의 구간만 결정됐을때 쓸 수 있고 지금은 못ㅆ므
                    count(*) as 구매횟수
              from cart
             where  substr(cart_no,1,6)between '200505' and '200506'
          group by cart_member
      having count(*)>= 5
      order by 1;
      
      
        예)회원테이블에서 회원들의 취미(mem_like)별 회원수를 구하시오
            select mem_like as 취미,
                   count(*) as 회원수
                from member
                group by mem_like;
                   
        
        예)장바구니 테이블에서 2005년 5~6월 회원별, 제품별 구매횟수와 구매수량 합을 구하시오 (단, 3번 이상 산사람
--            select cart_member as 회원코드,
--                    count(*) as 구매횟수,
--                    sum(cart_qty) as 구매수량합,
--                    cart_prod as 제품코드,
--                    count(*) as 구매수량,
--                    sum(count(*)) as 구매수량합
--                    from cart
--                    where substr(cart_no,1,6) between '200505' and '200506'
--                    group by cart_member,cart_prod;
                    
            select cart_member as 회원코드,
                   cart_prod as 제품코드,-- 기준
                   count(distinct cart_no) as 구매횟수, --10번 샀어도 구매는 1번 한거니까
                   sum(cart_qty) as 구매수량합
                from cart
                where substr(cart_no, 1, 6) >= '200505' 
                  and substr(cart_no, 1, 6) <= '200506'
                group by cart_member, cart_prod --제품코드는 중복되어지지않는다, 
                                                --group by 를 쓰면 중간 집꼐가 안나옴 rollup 이나 cube 를 쓰면 중간집계가 나옴!
                order by 1;
                   
        3) avg
         - 그룹으로 묶인 집단의 평균값
         (사용형식)
         avg(c1)
          - c1에 저장된 값의 산술 평균 반환
        예) 사원테이블에서 부서별 평균급여. 급여합계, 인원수
        select department_id as 부서코드,
               avg(salary) as  "평균급여(avg)",
               sum(salary) as 급여합계,
               count(*) as 부서별인원수,
               sum(salary)/count(*) as "평균급여(계산)"
            from employees
            group by department_id 
            order by 1;
            
   20200113---------------------------------     
        예)kor_loan_status 테이블을 이용하여 각 시도별, 구분별 평균 대출 잔액을 구하시오
         단, 대출잔액합계가 2조원이 넘는 값만 조회하시오
        select region as 시도,
               gubun as 대출구분,
               to_char(sum(loan_jan_amt), '9,999,999.9') as 평균대출잔액합계,
               to_char(avg(loan_jan_amt), '9,999,999.9') as 평균대출잔액
            from kor_loan_status 
            group by region, gubun
            having sum(loan_jan_amt) >= 200000 --where 절은 안됨
            order by region;
       
       예)kor_loan_status 테이블을 이용하여 2012 ~ 2013년 각 시도별, 월별 대출잔액 합계와 평균 대출잔액을 구하시오.
         단, 대출잔액 잔액 합계가 5조원이 넘는 값만 조회하시오
         select region as 시도별,
                substr(period,5,2)  as 월별,
                to_char(sum(loan_jan_amt), '9,999,999.9') as 대출잔액합계,
                to_char(avg(loan_jan_amt), '9,999,999.9') as 평균대출잔액
            from kor_loan_status
            where substr(period, 1, 4) between '2012' and '2013'
            group by region, substr(period, 5, 2) --그룹할때는 월만 필요한거니까
            having sum(loan_jan_amt) >= 50000;
            order by 1, 2;
         
        --join    
        예)장바구니 테이블과 회원테이블을 이용하여 2005년 4월 ~ 5월 사이 회원 성별 매출금액합계,
            매출건수, 평균매출액을 구하시오.
            select substr(mem_regno2, 1, 1)  as 회원성별,
                   sum(cart_qty * prod_price) as 매출금액합계,
                   count(*) as 매출건수,
                   round(avg (cart_qty * prod_price)) as 평균매출액
                from member, cart,prod 
                where cart_member = mem_id --조인조건
                  and cart_prod = prod_id --조인조건
                  and substr(cart_no,1,6) between '200504' and '200505'
                group by str(mem_regno2,1,1);
        
        예)회원테이블에서 거주지별, 직업별 마일리지 합과 , 회원수, 평균마일리지를 구하시오
            select substr(mem_add1,1,2) as 거주지,
                   mem_job as 직업,
                   sum(mem_mileage) as 마일리지합,
                   round (avg(mem_mileage)) as  평균마일리지
            from member 
            group by substr(mem_add1,1,2), mem_job
            order by 1;
            
    4)MAX, MIN 
        - 매개변수로 제공되는 컬럼값 중 최대값(MAX), 최소값(MIN)을 구하여 반환
        - 이들 함수로 사용하면 원본 테이블의 자료를 오름차순(MIN), 내림차순(MAX) 으로 정렬한 후
          첫번째 행의 값을 반환-PROCESS TIME 이 다소 소요됨
    
    예)사원테이블에서 각 부서별 가장 많은 급여와 가장 적은 급여를 구하시오
        select department_id as 부서코드,
               count(*) as 사원수,
               max(salary) as  최대급여,
               min(salary) as 최소급여
            from employees
            group by department_id;
            
            
           
            select case when substr(mem_regno2, 1, 1) = '1' or 
                             substr(mem_regno2, 1, 1) = '3' then '남성'
                        when substr(mem_regno2, 1, 1 )= '2' or
                             substr(mem_regno2, 1, 1) = '4' then '여성'
                        end as 회원성별,
                   sum(cart_qty * prod_price) as 매출금액합계,
                   count(*) as 매출건수,
                   round(avg (cart_qty * prod_price)) as 평균매출액
                from member, cart,prod 
                where cart_member = mem_id --조인조건
                  and cart_prod = prod_id --조인조건
                  and substr(cart_no,1,6) between '200504' and '200505'
                group by case when substr(mem_regno2, 1, 1) = '1' or 
                             substr(mem_regno2, 1, 1) = '3' then '남성'
                        when substr(mem_regno2, 1, 1 )= '2' or
                             substr(mem_regno2, 1, 1) = '4' then '여성'
                        end;
            
                
        
            
            
            
               
                   
                   
        
        
        