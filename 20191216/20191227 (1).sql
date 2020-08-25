2019-12-27 01)숫자함수

2)ROUND , TRUNC  
    - 숫자자료의 반올림(ROUND)과 절삭(TRUNC) 기능 수행
    (사용형식)
    ROUND(c, n), TRUNC(c, n) -- n은 반올림된 자리가 나타날 자릿수
    -round는 c에 저장된 값을 n+1 자리에서 반올림
    -trunc는 c에 저장된 값을 n+1 자리에서 절삭
    -n이 음수인 경우 정수부분 n자리에서 반올림(절삭)하여 결과 반환 --n이 양수면 소수점 이하부분
    
예)사원테이블(employees)에서 사원들의 급여를 월단위로 계산하여 결과를 출력하시오
    단, 주급액은 소숫점 2자리에서 반올림 하시오
    Alias 는 사원번호, 사원명, 월급여, 주급액
    select employee_id as 사원번호,
           emp_name as 사원명,
           salary as 월급여,
           round(salary/4, 1) as 주급액1,
           round(salary/4, 0) as 주급액2,
           round(salary/4) as 주급액3,--안쓰면 콤마 제로로 표현되어짐 , 소수점을 없앨 수 있다
           round(salary/4, -1) as 주급액3 --정수부분 첫째자리에서 반올림(마이너스 1)
        from employees;
        
update employees 
    set salary =  salary + (salary * 0.13);
    
    문제]사원테이블에서 보너스를 계산하여 수령액을 계산하시오
        보너스 = 급여 * 영업실적(commission_pct)
        수령액 = 급여 + 보너스
        Alias 는 사원번호, 사원명, 급여, 영업실적, 보너스, 수령액 
        
        select employee_id as 사원번호,
               emp_name as 사원명,
               salary as 급여,
               commission_pct as 영업실적,
               nvl(salary * commission_pct, 0) as 보너스, -- nvl null값을 곱해도 null값이 되지 않게
               round (salary + nvl(salary * commission_pct, 0)) as 수령액   -- 변수 없어서 필요하면 또 똑같이 만들어줘야함
        from employees;
    
    
    예)사원테이블에서 부서별(group by) 사원들의 평균급여를 수숫점 2자리까지 계산하여 출력하시오(부서번호 순으로--안배운거임, 부서는 유일값, 지금은 몰라도됨
    Alias 는 부서번호(department_id), 평균급여 --정렬 order by
    
    select department_id as 부서번호, 
           round (avg(salary), 2) as 평균급여1, --이둘의 편차 1임!
           trunc (avg(salary)) as 평균급여2      --모두 자리를 버리고;;웅앵,, 
        from employees
      group by department_id --group by는 where절 다음에, 해당하는 칼럼을 다써줘야혀(select절에 나온 일반 칼럼은 생략할 수 없다
--      order by department_id; 
--      order by 평균급여 desc; -- 내림차순, 별칭을 쓸 수는 있지만 안ㅆ는것이 좋아 , ㄴ
      --order by 절에는 slect절의 컬럼명| select 절의 컬럼 index
      order by 2 desc;
      
    예)사원테이블에서 부서별(group by) 사원들의 평균급여를 수숫점 2자리까지 계산하여 출력하시오(부서번호 순으로--안배운거임, 부서는 유일값
        Alias 는 부서번호(department_id), 부서명(department컬럼에), 평균급여
        
           select department_id as 부서번호,
                  department_name as 부서명,
           round (avg(empoyees.salary), 2) as 평균급여1, --이둘의 편차 1임!
           trunc (avg(empolyees.salary)) as 평균급여2      --모두 자리를 버리고;;웅앵,, 
        from employees, departments --이러면 join
        where empoyees.department_id = department.department_id --department_id가 두개 라서 
      group by empoyees.department_id, department.department_id
      order by 2 desc;      

 -------위에꺼 복잡해서 아래꺼처럼 쓴다
          select a.department_id as 부서번호,
                  b.department_name as 부서명,
           round (avg(a.salary), 2) as 평균급여1, --이둘의 편차 1임!
           trunc (avg(a.salary)) as 평균급여2      --모두 자리를 버리고;;웅앵,, 
        from employees a, departments b --이걸  먼저 설정해서 a,b 로 쓰긔
        where a.department_id = b.department_id --department_id가 두개 라서 
      group by a.department_id, b.department_id;--이러면 null이 없어졌어  같은값인데 없어져서 그런거???
      
      4)FLOOR,CELL
      - 가까운 정수값을 반환받을 때 사용
        (1)FLOOR(n)
            - n과 같거나 작은 수 중에 n에 가장 가까운 정수
        (2)CEIL(n)
            - n과 같거나 큰수 중에 n에 가장 가까운 정수
            
        select floor(10.4),
               floor(-10.4),
               ceil(10.4),
               ceil(10),--n이 자기 자신인 경우 그냥 n이 출력된다
               ceil(-10.4)
        from dual;
        
        
    5)MOD, REMAINDER -- 나머지가 중간 이상의 값이면 서로 값이 달라짐, 중간 이하의 값이면 둘이 똑같, 기본으로 mod생각하기
        - 나머지를 반환
        MOD(c, n), REMAINDER(c, n)
        - c의 값을 n으로 나눈 나머지 반환
        - mod : c - (n * floor(c/n))
        - remainder : c - (n * round(c/n)
        예) 13을 3으로 나눈 나머지
        mod(13, 3) : 13 - 3 * floor(13/3)
                    =13 - 3 * floor(4.33333)
                    =13 - 3 * 4 => 13 - 12 =1
        REMAINDER(13, 3) : 13 - 3 * floor(13/3)
                    =13 - 3 * round(4.33333)
                    = 1
        예)14를 3으로 나눈 나머지
         mod(14, 3) : 14 - 3 * floor(14/3)
                    =14 - 3 * floor(4.6666)
                    =14 - 3 * 4 => 14 - 12 = 2
        REMAINDER(14, 3) : 14 - 3 * floor(14/3)
                    =14 - 3 * round(4.6666 )= 14- 3*5
                    = -1
                    
    select mod(13, 3), remainder(13, 3),
           mod(14, 3), remainder(14, 3)
        from dual;
                    
    select mod(113, 21), remainder(113, 21),
           mod(149, 8), remainder(149, 8)
        from dual;        
  
    --오늘이 무슨요일인지 알려주는 것
        select case when trunc (mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 0 then '일요일'  
                    when trunc(mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 1  then '월요일'   
                    when trunc(mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 2 then '화요일'   
                    when trunc(mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 3 then '수요일'   
                    when trunc(mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 4 then '목요일'   
                    when trunc(mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 5 then '금요일'     
                    else '토요일' end "요일"
            from dual;
            
    6)WIDTH_BUCKET --전체 하한값과 상한값,,,웅앵,,,
        - 설정된 구간에 정의된 값이 속한 구간의 INDEX 값을 반환
        (사용형식)
        WITH_BUCKET(c, min, max, n)
        - c : 비교대상의 값 또는 값이 저장된 컬럼명
        - min : 구간의 하한 값
        - max : 구간의 상한 값
        - n : 구간의 갯수
    예)
    select width_bucket(75, 1, 100, 10) from dual; --0점에서 100점을 10개의 구간으로 분할하여 75가 어떤 구간에 포함되는지를 표시함
    
    ㅇㅖ)회원테이블에서 마일리지를 1-10000사이를 10개 구간으로 나누고 
        각회원이 보유한 마일리지에 따라 등급을 부여하시오, 단 많은  마일리지 부터 등급을 부여하시오.
        ex)8000 포인트는 3등급, 5포인트는 10등급...
        Alias 는 회원번호, 회원명, 마일리지, 등급
        
        select mem_id as 회원번호,
               mem_name as 회원명,
               mem_mileage as 마일리지,
               width_bucket (mem_mileage, 1, 10000, 10) as 등급1,
               width_bucket (mem_mileage, 10000, 1, 10) as 등급2
            from member;
            
            
        예)사원테이블에서 사원들의 급여를 3개의 등급으로 구분하고 등급에 따라 
            1등급이면 '저 임금군', 2등급이면 '평균적 임금군', 3등급이면 '고 임금군'을 비고란에 출력하는 쿼리 작성
            Alias 는 사원번호, 사원명, 직책코드, 급여, 등급, 비고
            임금의 하한값은 2000, 상한값은 30000 이다
            
            select employee_id as 사원번호,
                   emp_name as 사원명,
                   job_id as 직책코드,
                   salary as 급여,
                   width_bucket(salary, 2000, 30000, 3)|| ' 등급' as 등급,
                   --case when + 조건
                   case when width_bucket(salary, 2000, 30000, 3)=1 then '저 임금군'
                        when width_bucket(salary, 2000, 30000, 3)=2 then '평균적 임군굼'
                        else '고임금군' end as 비고
                from employees;
                   
    
            
 
        
        
        
        
