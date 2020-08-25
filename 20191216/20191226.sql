2019-12-26

01)문자열 함수
    06) REPLACE
        - 주어진 문자열 내의 특정 문자(문자열)을 다른 문자(문자열)로 치환
        - TRIM, LTRIM, LTRIM 은 특정 문자열 내부에 존재하는 공백 제거 기능은 제공하지 않음
        - REPLACE 는 단어 내부의 공백 제거 가능함 --부수적인 기능임
        (사용형식)
        REPLACE(C1, C2 [,C3])
         - C1 문자열에서 문자(열) C2를 찾아 C3 문자(열)로 치환
         - C3가 생략되면 C2 문자(열)을 제거함  
         
    예) 
    select replace('무궁화 꽃이 피었습니다', '화', '와') from dual;
    select replace('무궁화 꽃이 피었습니다', '화') from dual;
    select replace('무궁화 꽃이 피었습니다', '꽃', '와') from dual;
    select replace('무궁화 꽃이 피었습니다', ' ') from dual; --TRIM, LTRIM, LTRIM이 지울 수 없는 공백을 제거함, 유효공백도 제거 가능함
    select replace('무궁화 꽃은  우리나라 꽃입니다', '  ', ' ') from dual;
    
    문제] 회원 테이블에서 '이'씨 성을 가진 회원을 '리'씨로 변환하시오
        Alias는 회원번호, 회원이름, 전화번호이다. 
    select mem_id as 회원번호,
           replace (substr(mem_name, 1, 1), '이', '리'||substr(mem_name,2,2)) as 회원이름,
           mem_hp as 전화번호
      from member
--     where substr(mem_name, 1,1)= '이';이러면 뒤에도 바껴-- where절은 조건이라서 바꾸는 거 쓰면 안돼ㅔ
       where mem_name like '이%';
  rollback;    
    
    7) TRANSLATE
        - 주어진 문자열과 매개변수로 제공된느 문자열의 순번에 대응되는 문자열로 치환
        (사용형식)
        translate(c1, c2, c3)
         - 주어진 문자열 c1에 포함된 문자 중 대응되는 c2의 문자로 c3의 문자를 치환
         - c3문자가 c2 보다 적으면 해당 문자는 제거됨
         
        select('sql developer', 'abcdefghij', '9876543210') from dual;
        select buyer_bankno,
               translate(buyer_bankno, '123456789-', 'abcdefghij#')
          from buyer;
     rollback;
    
    예)회원테이블에서 회원의 집전화번호 중 '-'를 ')'로 전환하시오
    select mem_hometel,
           replace(mem_hometel, '-', ')'),
--           translate(mem_hometel, '0123456789-', '0123456789)')-- 아주 특수한 경우를 제외하고 안써ㅡㅂ니다. 리플레이스를 쓰면되니까
      from member;
      
    8) LENGTH, LENGTHB
        - 문자열에 포함 한 문자의 수(LENGTH)나 전체길이(LENGTHB)를 반환 --LENGTH : 한글도 한글자는 1을 반환함, 바이트는 다르지만 
        (사용형식)
        length(c), length(c)
        - 주어진 문자열 c에 저장된 글자수나 기억공간의 크기(byte)를 반환
        
    예)회원테이블의 주소 (mem_add1)의 글자수와 기억공간의 크기를 조회하시오
        Alias 는 회원이름, 주소, 글자수, 기억공간의 크기
        
        select mem_name as 회원이름,
               mem_add1 as 주소,
               length(mem_add1) as 글자수,
               lengthb(mem_add1) as "기억공간의 크기"--공백있어서 쌍따옴포르 묶음
          from member;
    
    9)INSTR --INDEX OF STRING임
        - 주어진 문자열에서 매개변수로 제공되는 문자(열)의 위치값(INDEX) 반환
        (사용형식)
        INSTR(C1, C2 [M [,N]])
         - C1 문자(열)에서 맨 처음 만나는 C2 문자(열)의 위치값 반환
         - m은 조사위치(index)
         - n은 반복된 횟수(n번째)
        
    예)
    select instr('banana', 'a') from dual;--맨 처음 만나는 a가 왼쪽에서 몇번째냐고 물어보는것
    select instr('banana', 'a', 1, 2) from dual; --두번째 만나는 a를 찾으세요
    select instr('banana', 'a', 3, 2) from dual; --세번째 글자부터 조사해서 두번째 a를 찾으세요
    
    
    문제1] 상품테이블에서 맨 처음 만나는 공백의 위치값을 조회하시오--byte 수가 아니라 글자수를 세는것!
        Alias 는 상품명, 위치값
    select prod_name as 상품명,
           instr(prod_name, ' ') as 위치값
           instr(prod_name, ' ', 1, 2) as 위치값 --이러면 두번째 공백을 찾는 것! 몇번째 글자에 두번째 공백이 있느닞 보는것
      from prod;                                   
    
    
    