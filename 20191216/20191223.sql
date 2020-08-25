2019-12-23 월요일

1) between 연산자 > 범위를 지정할 때 --and 를 사용해서 할 수도 있다
    예) 상품테이블(prod)에서 상품의 분류가 'P102'에서 'P302'에 속한 상품을 조회하시오 
        --복수개를 조회할때  in , any 연산자??
        Alias 상품번호, 상품명, 분류코드, 거래처코드 
    select prod_id as 상품번호, 
               prod_name as 상품명,
               prod_lgu as 분류코드,
               prod_buyer as 거래처코드
         from prod  --테이블명만
     where prod_lgu >='P102' and  prod_lgu <='P302';   --따옴표 안은 대문자 소문자 반드시 구별, and 앞뒤로 컬럼명 + 관계연산자 + 조건 반드시 구성
    
     
     (between 연산자 사용)
    select prod_id as 상품번호, 
               prod_name as 상품명,
               prod_lgu as 분류코드,
               prod_buyer as 거래처코드
         from prod  --테이블명만
     where prod_lgu between 'P102' and 'P302';    --r관계연산자 필요 없엉   
     

2) LIKE 연산자
    - 와일드카드('%', '_')를 사용하는 패턴을 비교  -- 와일트카드 ; 대치 문자열 , ????뭔소리지
                                               --관계연산자 안씀
                                               --패턴이 **문자열**로 표현되어 진다 
                                               --날짜나 숫자형은 되도록이면 like 를 안쓴느 것이 좋다
 (사용형식)
    컬럼명 like 패턴문자열 
    -'%' : '%'가 사용된 위치에 모든 문자열과 대응
     EX)'박%' -- 박으로 시작되는 모든 문자열이면 참이다!
        -> '박' 으로 시작되는 모든 문자열, null값도 포함되어진다,
         '%박' -> '박'으로만 끝나면 참이다
         '%가%' -> '가'가 중간에만 들어가면 된다--문자열 중간에 '가' 문자열이 있으면 조건이 참
         
    예)회원테이블에서 '김'씨 성을 가진 회원을 검색하시오
        Alias 는 회원번호, 회원명, 직업, 마일리지
        select mem_id as 회원번호,
               mem_name as 회원명,
               mem_job as 직업,
               mem_mileage as 마일리지
            from member
        where mem_name like '김%'; --컬럼명 like 패턴?  --like 너무 남발하면 안된다, 왜냐면 시간이 오래걸려
        
    예)회원테이블에서 주소지가 서울이 회원을 조회하시오
        Alias 회원번호, 회원명, 주소, 직업, 마일리지
        select mem_id as 회원번호,
               mem_name as 회원명,
               mem_add1||' '||mem_add2 as 주소, --||가 더하기(문자열 결합 연산자, 자바의 + 와 똑같음 / ' ' > 공백넣고 싶어서 넣은것
               mem_job as 직업,
               mem_mileage as 마일리지
            from member
        where  mem_add1 like '서울%'; --조건 
        --역정교화 : 정교화를 하면서 얻는 손해가 이득보다 크니까 zip, add01, add2 이렇게 나눈거
    예)회원테이블에서 여성회원을 조회하시오
    Alias  회원번호, 회원명, 주민번호, 마일리지
    select mem_id as 회원번호,
           mem_name as 회원명,
           mem_regno1||'-'||mem_regno2 as 주민번호,
           '여성회원' as 성별,
           mem_mileage as 마일리지
        from member
    where mem_regno2 like '2%' 
       or mem_regno2 like '2%';
           
**'m001'회원의 주민번호를 '010315-4555555'로 변경하시오

    update member 
        set mem_regno1='010315',
            mem_regno2='4555555'
        where mem_id='m001'; 
    commit; --하드디스크에 저장시키는 것, 고정시키는 것

    update member 
        set mem_regno1='0003195'
            mem_regno2='4110222'
        where mem_id='x0011';
    commit;
    
    --여기 안됨
    
예)회원테이블에서 12월에 생일이 있는 회원을 조회하여 회원이 갖고있는 마일리지의 10%를 추가 지급하시오
    (생일은 주민번호 앞 자리로 조회)
    단, Alias 는 회원번호, 이름, 생년월일, 추가지급마일리지, 마일리지
    select mem_id as 회원번호,
           mem_name as 이름,
           mem_bir as 생년월일,
           mem_mileage*0.1 as 추가지급마일리지,
           mem_mileage*1.1 as 마일리지      --mem_mileage + mem_mileage*0.1
        from member
    where substr(mem_regno1, 3, 2)='12'; --자바랑 다름 3에서 2개 라는 뜻
    
    
        
    -'_' : '_' 는 사용된 위치에서 하나의 문자열과 대응
     ex) '_길동' => 성씨가 한글자이고 이름이 '길동'인 사람
    
        
 예)회원테이블에서 12월에 생일이 있는 회원을 조회하여 회원이 갖고있는 마일리지의 10%를 추가 지급하시오
    (생일은 주민번호 앞 자리로 조회)
    단, Alias 는 회원번호, 이름, 생년월일, 추가지급마일리지, 마일리지
    select mem_id as 회원번호,
           mem_name as 이름,
           mem_regno1 as 생년월일,
           mem_mileage*0.1 as 추가지급마일리지,
           mem_mileage*1.1 as 마일리지      --mem_mileage + mem_mileage*0.1
        from member
    where mem_regno1 not like '__12%'; --_2개라서 앞자리 2개는 상관없다 & 뒷자리는 상관 없다 / not쓰면 12월 생이 아닌 나머지 사람들
    
    
    

