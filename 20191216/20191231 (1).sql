2019-12-31 01)날짜형 함수
 - 날짜 집계 형변환 남음
 
    1)SYSDATE --(시스템이 제공해주는 날짜)
     - 시스템에서 제공하는 날짜정보 반환
     - 덧셈과 뺄셈은 가능하지만, 나눗셈과 곱셈은 불가능하다(결과는 덧셈은 일수를 더한 날자, 뺄셈은 일수를 뺀 날짜)
     
     예)
     select sysdate as 현재시각, --기본적으로 년, 월, 일 만 나옴
            sysdate - 30 "한 달 전 날짜",
            sysdate + 30 "한 달 후 날짜",
            sysdate - to_date('20100810')--3430일 인거
       from dual;
       
    **시스템이 제공하는 시각 정보에서 필요한 요소(날, 년, 시간 등)을 추출한 경우 : EXTRACT 함수사용
       
       예)사원테이블에서 입사일자(hite_date)를 이용하여 15년이상 근속한 사원을 조회하시오
       --사원테이블에는 모든 사원이 있어야한다, 근무하고 있는지 아닌지만 하나의 필드로 관리하면됨
        Alias 는 사원번호, 사원명, 입사일, 근속연수
        select employee_id as 사원번호,
               emp_name as 사원명,
               hire_date as 입사일자,
               extract(year from sysdate) - extract (hire_date) as 근속연수 --입사일에서 sysdate ,
               --날짜정보를 이용해서 특정한 정보 뽑을때는 substring 쓰지말고 extract쓰3
            from empolyees
           where extract(year from sysdate) - extract(year from hire_date) >= 15
             and retire_date is null;
             
             select * from employees
             where retire_date is null;-- 이때 '='을 쓰면 안되고 'is' 를 써야함!
--안됨             

    2)MONTHS_BETWEEN
     - 매개변수로 제공된 두 날짜 사이의 달수를 반환
     (사용형식)
     months_between(d1, d2)
     -d1, d2는 날짜 타입의 자료여야함
     
     예)회원테이블에서 오늘 날짜를 기준으로 회원들의 나이를 월 단위로 나타내시오
        월은 소숫점 1자리에서 반올림 하시오
        Alias 는 회원번호, 이름, 생년월일, 개월수
        
        select mem_id as 회원번호,
               mem_name as 이름,
               mem_bir as 생년월일,
               round(months_between(sysdate, mem_bir)) as 개월수 -- 계산에서 얻을 수 있는 값 : 유도속성 > 저장X
               --round(months_between(sysdate, mem_bir),0)라고 쓴거나 같다
            from member;
            
        select to_char(mem_bir,'yyyy-mm-dd hh24:mi:ss') from member;
       
           
    3)EXTRACT
     -날짜자료에서 필요한 요소(년,월,일,시,분,초)FMF CNFNC
     (사용형식)--fmt : 포멧문자열, 형식지정문자열
     EXTRACT(fmt from d1)
        -'fmt'는 필요한 요소를 나타내는 단오(year, month, day, hour, minute,second)
        -d1은 날짜형 자료
        -결과는 숫자형으로 반환
        
    예) 사원테이블에서 7월에 입사한 사원정보를 조회하시오
        Alias 는 사원번호 사원명 입사일 급여
        select employee_id as 사원번호,
               emp_name as 사원명,
               hire_date as 입사일,
               salary as 급여
            from employees
            where extract(month from hire_date)= 7;
            
    예) 회원테이블에서 이번달 생일인 회원정보를 추출하시오
        Alias 는 회원번호, 회원명, 생년월일, 마일리지
        select mem_id as 회원번호,
               mem_name as 회원명,
               mem_bir as 생년월일,
               mem_mileage as 마일리지
            from member 
            where extract (month from mem_bir) = extract (month from sysdate);--is는 null  비교할때만 쓴다! 여기는 = 써도됑
        
    
    4)ADD_MONTHS
        - 주어진 날짜 자료에 정의된 값 만큼 월을 더한 날짜를 반환
        (사용형식)
        ADD_MONTHS(d1, n)
         -d1은 날짜정보
         -n은 더해줄 개월 수
         
    예)
    select add_months(sysdate, 3) from dual;
    
    예)회원테이블에서 생일 축하 메시지를 3일전에 발송하려한다,
        오늘로부터 3개월후에 생일인 사람인 회원을 찾아 문자발송일을 조회하시오
        Alias 는 회원번호, 회원명, 생일, 문자발송일
        select mem_id as 회원번호,
               mem_name as 회원명,
               extract (month from mem_bir)||'월'||
               extract(day from mem_bir) as 생일,
--               add_month((day from mem_bir), 3) || 3 as 문자발송일
               to_date (to_char(extract (year from sysdate))||--연도뽑기 (시스템에서)>문자열바꾸기
               to_char(extract(month from mem_bir),'99')|| 
               --생일에서 month뽑기, '99'안쓰면 날짜로 변환 불가능 1월 1개 12월 2개니까> 문자열로 바꾸
               to_char (extract(day from mem_bir),'99'))-3 as 문자발송일
            from member
            where extract(month from mem_bir)=extract(month from add_month(sysdate,3)));
 --안됨           
            select add_months(sysdate, 8) from dual;
            

    5)LAST_DAY, NEXT_DAY
        5-1. LAST_DAY
            -주어진 날짜의 해당 월의 마지막을 반환
            (사용형식)
            LAST DAY(d1)
            -d1 날짜에 포함된 월의 마지막 일자 반환
            
            select last_day(to_date('20000910')) from dual;
        
        5-2. NEXT_DAY
            - 매개변수가 나타내고 있는 날짜 이후 주어진 요일의 가장 빠른 날짜 반환
            (사용형식)
            NEXT_DAY(d1, c1)
            -d1 기준일자
            -c1 구하려는 요일을 표현하는 문자열(월, 화./...일) --오늘은 제외!
            
        예) 
        select next_day(to_date('20180705'),'화')from dual;
            
        
    
    6)