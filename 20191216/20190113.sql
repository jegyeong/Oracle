2020-01-13 3)ROLLUP 과 CUBE 
    - GROUP BY 절에 사용하며 중간 집계를 구할때 사용
    --
    
    1)ROLLUP 
    (사용형식)
    GROUP BY [컬럼명,...], ROLLUP(컬럼명[,컬럼명...]),[컬럼명,...]
        
        -반드시 GROUP BY 절안에 기술
        -ROLLUP 안에 기술된 컬럼명의 순서(오른쪽 > 왼쪽)에 대한 집계
        -ROLLUP 안에 기술된 컬럼명이 n개일 때 n+1개의 집계 반환
        
    예)kor_loan_status 에서 지역별, 년도별 대출액 합계를 구하시오
    (group by 절만 사용)
    
    select region as 지역별,
           substr(period, 1, 4) as 년도,
           sum(loan_jan_amt) as 대출액합계
        from kor_loan_status
        group by region, substr(period,1,4)
        order by 1;
        
    select region as 지역별,
           substr(period, 1, 4) as 년도,
           sum(loan_jan_amt) as 대출액합계,
           gubun as 대출구분
        from kor_loan_status
        group by rollup(region, substr(period,1,4), gubun)
        order by 1;
        
    예)매입테이블(buyprod)을 이용하여 2005년도 월별, 분류별 매입금액합계를 구하라
        단, 월별 합계와 전체 합계를 구하시요
        
        select extract(month from buy_date) as 월별,
               substr(buy_prod,1,4) as 분류,
               sum (buy_qty * buy_cost) as 매입금액합계
               
            from buyprod
            where extract(year from buy_date) = 2005
            group by rollup(extract(month from buy_date), substr(buy_prod, 1,4))
            order by 1;
            
    
    2)CUBE 
    -ROLLUP 과 거의 같은데, 집계의 종류가 ROLLUP 보다 더 다양함
    -ROLLUP 보다 다양한 집계의 종류를 반환
    -CUBE 다음 기술된 컬럼명 수가 n개일 때 2^n가지 종류의 집계를 반환
    -디지게 많이 나옴
    
    예)kor_loan_status 에서 지역별, 년도별 구분별 대출액 합계를 구하시오
    (rollup사용)
    select region as 지역별,
           substr(period,1,4) as 년도,
           gubun as 구분,
           sum(loan_jan_amt) as 대출잔액합계
        from kor_loan_status
     group by rollup(region, substr(period,1,4), gubun)
     order by 1;
     
     (cube 사용)
    select region as 지역별,
           substr(period,1,4) as 년도,
           gubun as 구분,
           sum(loan_jan_amt) as 대출잔액합계
        from kor_loan_status
     group by cube(region, substr(period,1,4), gubun)
     order by 1;
    
    (부분 rollup)
    select region as 지역별,
           substr(period,1,4) as 년도,
           gubun as 구분,
           sum(loan_jan_amt) as 대출잔액합계
        from kor_loan_status
     group by gubun, rollup(region, substr(period,1,4))
     order by 1;
    
          
           