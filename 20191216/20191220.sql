2019-12-20

1)SELECT 문
    - SELECT 절에서 컬럼명 대신 '*(아시트릭스)'를 사용하면 모든 칼럼을 조회
    - WHERE절이 생략되면 테이블 내의 모든 행을 조회
    
예) 회원테이블(member)의 모든 회원의 모든 자료를 조회하시오
 select * from member; 
 
  select * from cart; --처음에 50개라고 뜨는데 스크롤바를 내리면 더 많이 나왕 
  
  예) 회원테이블(member)에서 회원번호, 회원명, 주소, 마일리지를 조회하시오
  select mem_id as 회원번호,
         mem_name as 회원명,                        --|| 앞과뒤를 붙여라
         mem_add1 ||' '||mem_add2 as "주    소",     --쌍따옴표 안스면 오류 일어나/공백은 구별자로 인식하기때문
         mem_mileage 마일리지
    from member ;
        from member;  --- 왜 안되지
        
        
  예) 회원테이블(member)에서 거주지가 대전인 회원번호, 회원명, 주소, 마일리지를 조회하시오
    select  mem_id as 회원번호,
            mem_name as 회원명,                        --|| 앞과뒤를 붙여라
            mem_add1 ||' '||mem_add2 as "주    소",     --쌍따옴표 안스면 오류 일어나/공백은 구별자로 인식하기때문
            mem_mileage 마일리지
    from member;
        from member;  --- 왜 안되지
    where mem_add1 like '대전%';   ---조건붙으니까 / % 붙으면 뒤에 어떤게 와도 상관없다
                
                
 예) 회원테이블(member)에서 거주지를 중복하지 말고 회원번호, 회원명, 주소, 마일리지를 조회하시오
    select 회원번호, 회원명, 주소, 마일리지
    from member mem_id as 회원번호,
                mem_name as 회원명,                        --|| 앞과뒤를 붙여라
                mem_add1 ||' '||mem_add2 as "주    소",     --쌍따옴표 안스면 오류 일어나/공백은 구별자로 인식하기때문
                mem_mileage 마일리지
        from member;  --- 왜 안되지
    where mem_add1 like '대전%';   ---조건붙으니까 / % 붙으면 뒤에 어떤게 와도 상관없다
    
    
 예) 회원테이블(member)에서 거주도시를 조회
    select distinct sub(mem_add1, 1,2)
        from member;
        
        
        ---lprod ? ??/ id 순번/gu가 분류코드/nm 분류명

   --prod stock +total 전체재고/ +proper 적정재고/ 
   --department Id부서코드 / parent 상위 부서코드 /
   --???
        

예) 상품테이블(prod)에서 거래처코드를 조회하세욘
    select prod_buyer as  거래처코드 -- 여기에는 콜롬명  / from 에는 테이블!만 올 수 있다! 
                                    --제일 먼저 실해되는것이 from절 > where 절 > select 절 이 순서로 실행된다>
                                    --별칭은 from 이나 where 절에서 쓸 수 없다
        from prod;

예) 상품테이블(prod)에서 거래처코드를 중복되지 않게 조회하세요
     select distinct prod_buyer as  거래처코드 
        from prod
    order by 1 asc; --차례대로 출력하게 위해서 asc는 생략 가능
    
    
    1) where 절 
        -부여된 조건을 처리할때 사용
        (사용형식)
        where 컬럼명 연산자 expr[and|or]{ 컬럼명 연산자 expr....]
            - '연산자' : 관계연산자( >, <, =, >= , <=, !=(<>)) --같지 않다 != / <> 순서 다 맞춰야함 
            
예)회원테이블에서 마일리지가 3000이상인(조건> where절) 회원을 조회하시오
    Alias 는 회원번호, 회원명, 직업, 마일리지 -- Alias > 출력한 칼럼을 의미하는것
    
select 회원번호(mem_id), 회원명, 직업, 마일리지  --테이블가서 컬럼명 
select mem_id as 회원번호,
       mem_name as 회원명,
       mem_job as 직업,
       mem_mileage as 마일리지
    from member
  where mem_mileage>=3000; --조껀 땜에 써준거
       
       
            
예)회원테이블에서 마일리지가 3000이상인(조건> where절) 회원을 조회하되, 마일리지가 큰 사람부터(정렬) 출력하시오
    Alias 는 회원번호, 회원명, 직업, 마일리지
    
select mem_id as 회원번호,
       mem_name as 회원명,
       mem_job as 직업,
       mem_mileage as 마일리지
    from member
  where mem_mileage>=3000
  order by mem_mileage desc, 2;--order by 다음에는 하나이상 쓸 수 있어! 마일리지 순으로 정렬하고, 2>는 똑같은 사람ㅇ 있을때 이름 순으로 기술하십시오
  
예) 회원테이블에서 12월이 생일인 회원을 조회하시오
    Alias 회원번호, 회원명, 생년월일에서 월만 꺼내서
    
select mem_id as 회원번호, 
       mem_name as 회원명, 
       mem_bir as 생년월일 --date 타입
    from member 
 where extract(month from mem_bir) = 12;--컬럼에서  date 타입일때 월만 뽑아내려면! 
 

예) 상품테이블에서 판매가가 10만원대인(100000~199999 상품을 조회하시오
    Alisa 상품번호, 상품명, 판매가
select prod_id as 상품번호,
       prod_name as 상품명,
       prod_price as 판매가
    from prod 
--where prod_price >= 100000 and prod_price <= 199999;   --&&가 아니라 그냥 and 써야혀
--where prod_price >= 100000 and prod_price < 200000;  
   where prod_price between 100000 and 199999; 
   ----where not prod_price between 100000 and 199999;   이렇게 쓰면 이부부분만 제외됨!
   
예) 상품테이블에서 거래처코드가 p10201 이거나 p30203인 상품정보를 조회하시오
    Alisa는 상품번호, 상품명, 매입가, 거래처코드
select prod_id as 상품번호,
       prod_name as 상품명,
       prod_cost as 판매가,
       prod_buyer as "거래처 코드"
     from prod
    where prod_buyer = 'P10201' or prod_buyer = 'P30203'; --문자열 묶을려면 작은 따옴표 char 이니까 

 2)논리연산자
    - and, or, not 
    - and : 논리곱
        조건1 and 조건2 : '조건1'과 '조건2' 가 참인 경우에만 전체 결과가 참이다
    - or : 논리합
        조건1 or 조건2 : '조건1'과 '조건2' 중에서 하나라도 참이면 전체 결과가 참이다
    - not : 논리부정
        not(!) 조건 : '조건'의 결과의 반대 값을 반환
    - 수행순서 : not > and > or 순서이다!
    
    age=>20 or age<=30 and gender='여자' >>> 30살과 여자 먼저찾고 > 그다음에 20을함

    
 3)기타연산자(in, any, some, all, exists between, like...)  --나머지 연산자는 함수로 제공된다
 
    (1) in 연산자
     - 주어진 자료 중 어느 하나와 일치하면 전체 결과가 참을 반환
     (사용형식)
     컬러명 in (값1, 값2,...)
     - or 연산자로 치환 가능  --값1 or 값2 or ...  이런식으로 써도 되는데, in으로 줄여서 쓴느게 편하니까
     
예) 상품테이블에서 상품 분류코드가 'p101', 'p201', 'p301' 에 속한 자료를 조회하시오
    Alias 상품코드, 상품명, 분류코드, 판매가격이다
    (or 연산자 사용)
    select prod_id as 상품코드,
           prod_name as 상품명,
           prod_lgu as 분류코드,
           prod_price as 판매가격
        from prod
      where prod_lgu='P101' or prod_lgu='P201' or prod_lgu='P301';
      
      select prod_id as 상품코드,
           prod_name as 상품명,
           prod_lgu as 분류코드,
           prod_price as 판매가격
        from prod
      where prod_lgu in ('P101', 'P201', 'P301'); 
  
   
** in, any, some, all 연산자는 Subquery와 자주 사용됨
    - in 다음 '( )' 의 값이 미 확정인 경우
예)상품테이블에서 사용된 분류코드와 분류명을 출력하시오
  select 분류코드와 분류명, 
  select LPROD_GU AS 분류코드와,
         LPROD_NM AS 분류명
    FROM LPROD                                     --1ST로 실행됨 
   WHERE LPROD_GU IN (SELECT PROD_LGU FROM PROD);  --일단 가지고 와서 분리를 해라 
   
   --실행 FROM먼저 그다음 WHERE 
   
   
    (2) ANY 연산자
     - 기능은 IN과 같다, 다만 사용형식이 다름
     (사용형식)
     컬럼명 관계연산자 ANY (값1, 값2, 값3, ....)
     - IN 연산자를 ANY로 변환하면 '=ANY'이다
     
예) 상품테이블에서 상품 분류코드가 'p101', 'p201', 'p301' 에 속한 자료를 조회하시오
    Alias 상품코드, 상품명, 분류코드, 판매가격이다
    
    (ANY 연산자 사용)
      select prod_id as 상품코드,
           prod_name as 상품명,
           prod_lgu as 분류코드,
           prod_price as 판매가격
        from prod
      where prod_lgu =ANY ('P101', 'P201', 'P301');  
     --IN은 관계연산자를 못쓰지만  ANY는 관계연산자를 함께쓸 수 있다
--     where prod_lgu >ANY ('P101', 'P201', 'P301');   --이렇게 쓰면 p101보다 큰 자리가 모두 출력된다
--     where prod_lgu >'P101';    --위의 문장이랑 똑같은결과가 도출된다

    select LPROD_GU AS 분류코드와,
         LPROD_NM AS 분류명
    FROM LPROD                                     --1ST로 실행됨 
   WHERE LPROD_GU  exists (SELECT PROD_LGU FROM PROD);  -- exists 반드시 서브쿼리와 함께 사용!
   
   
   (3)between 연산자
    - 범위를 지정할 때 사용
    - and 연산자로 치환가능
    (사용형식)
     컬럼명 between 값1 and 값2
        - '값1' 에서 '값2' 범위를 지정

예) 회원테이블에서 나이가 40대인 회원을 조회하시오
    Alias는 회원번호, 회원명, 나이, 생년월일
    
--(and 연산자 이용)
select mem_id as 회원번호, 
       mem_name as 회원명, 
       extract (year from sysdate) - extract(year from mem_bir) as 나이, 
       mem_bir as 생년월일  
    from member 
    where extract(year from sysdate) - extract(year from mem_bir) > 40 and
          extract(year from sysdate) - extract(year from mem_bir) <50;
 
 --(between 연산자 이용)         
select mem_id as 회원번호, 
       mem_name as 회원명, 
       extract (year from sysdate) - extract(year from mem_bir) as 나이, 
       mem_bir as 생년월일  
    from member 
    where extract (year from sysdate) - extract(year from mem_bir) between 40 and 49;
          
    

   
        
            
                              
  