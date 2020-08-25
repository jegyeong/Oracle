3) lpad, rpad --빈공간에 문자열이나 숫자열을 채워넣는것
              --자르는 순서 아님! 저장하는 순서임!
              --자르는 쪽이 왼족이면 lpad, 오른쪽이면 rpad
    - 주어진 공간에 특정 문자(열)을 채움
    (사용형식)
    lpad(n, c1 [,c2])
    rpad(n, c1 [,c2])
        -'n'으로 지정된 길이에 문자(열) c1을 채우고 남는 공간은 c2를 채워 반환
        -lpad 는 오른쪽부터 채움(왼쪽에 c2를 채움)
        -rpad 는 왼쪽부터 채움(오른쪽에 c2를 채움)
        -c2가 생략되면 공백 처리 됨
        -기억장소의 크기 'n'이 c1보다 작은경우 c1은 잘려 기억됨
        
        
예) 
select lpad('123', 10, '*') from dual; --테이블은 써야하지마 특정한 테이블에 존재하지 않는 문자열이나 이런걸 출력하고 싶을때는 dual : 가상의 테이블
select lpad('123', 10) from dual; --왼쪽 공백처리됨
select lpad('12345678', 5, '#') as "컬럼" from dual;
select lpad('12345678', 5, '#') from dual;


예) 장바구니 테이블(cart) 에서 수량(cart_qty)를 5자리에 출력하되 오른쪽 빈공간을 채우시오, 단 2005년 5월 판매정보만 조회하시오
    Alias 는 회원번호, 장바구니번호, 수량이다
    
    select cart_member as 회원번호,
           mem_name as 회원명
           cart_no as 장바구니번호,
           rpad(cart_qty, 6) as 수량
        from cart
    where cart_no like '200505%'  --데이터 타입을 먼저 봐서 문자열이 아니면 문자열\로 바꿔야함, 오토캐스팅이 안될 수 도 있으니까,
      and cart_mmber = mrm_id;   --
      

4) LTRIM, LTRIM, TRIM --데이터가 끝나고 시작된 공백////???
                      --매개변수 기술 c1,c1..char 은 문자열
                      --n은 숫자
                      --ltrim 왼쪽에서, rtrim 오른쪽에서 찾아서 지운다, 모를때는 trim
    -문자열 좌, 우에 발생된 무효의 공백 제거에 주료 사용
    (사용형식)
    ltrim (c1, [,c2])
    rtrim (c1, [,c2])
    trim (c)
        - ltrim, rtrim에서 c2가 기술되면 c1에서 c2를 찾아 제거
        - c2가 생략되면 공백을 제거
        - trim은 양쪽 모두의 공백 제거 
        - 데이터 내부의 공백은 함수 연산에서 제외
        
ㅇㅖ)
    select ltrim('abccacd','a') from dual; -- 문자열 전체에서 a를 찾아서 지우는 거 아님!, 맨처음 만나는 것만 찾아 지운다, 반복해서 찾지 못함
    select ltrim('   abcc   acd   ') from dual; --무효의 공백만 삭제할 수 있다, 왼쪽에 있는 공백만 지운다
    
   alter table lprod
    modify lprod_nm char(40);   --바꿀때 modify라는 예약어 사용함

select lprod_id, lprod_gu
    from lprod 
    where lprod_nm = '전자제품'; --원칙적으로는 안나와야혀
--  where trim(lprod_nm)='전자제품'; --원칙적으로 공백 제거해야해1 
    
    --사칙연산할때 회로1개? 가산기밖에 없음 감산기가 없음 27-5 => 27+(-5)로 계산  sign bit 0양수 1음수???2의 보수///????뭔소리야ㅡㅡㅡㅡㅡㅡ
    --MSB,Lsb????///
    
rollback; --alter에 의해서 구조가 바껴버리면 롤백이 안됨!

alter table lprod 
    modify lprod_nm varchar2(40); --이렇게 변경해야함

update lprod
    set lprod_nm = trim(lprod_nm);
    
    commit; --롤백시켜도 원상태로 변횐되지 않는다
    
    
5)SUBSTR --부분 문자열 , 자바와 사용형식이 다름!, 의미가 다름, 자바 0부터 카운팅, 오라클은 0안쓰고 1부터 시작함!
    - 부분 문자열을 추출하여 반환
    (사용형식)
    substr(c1, m, [,n])
    - 주어진 문자열 c1에서 m번째에서 n개만큼 문자를 추출하여 변환 --n오라클에서는 갯수, 자바는 자리
    - 'n'이 생략되가나 'n'의 값이 문자열 갯수보다 큰 경우 m번째 이후의 모든 문자열 추출
    -m이 음수이면 뒤쪽부터(오른쪽) 처리
    
select substr('무궁화 꽃이 피었습니다', 2, 3) as "컬럼" from dual;
               1 2 34 56 78 9101112   
select substr('무궁화 꽃이 피었습니다', 10, 5) as "컬럼" from dual; --글자 전부 다 라는 뜻, 남은 두글자는 무시된다!
               1 2 34 56 78 9101112   
select substr('무궁화 꽃이 피었습니다', 10) as "컬럼" from dual;--개수 생략하면 전체
               1 2 34 56 78 9101112   
select substr('무궁화 꽃이 피었습니다', -8, 2) as "컬럼" from dual;--마이너스면 뒤에서부터 카운팅
               1 2 34 56 78 9101112    
               
예) 장바구니 테이블(cart)에서 2005년 4월 판매가 발생된 날짜를 중복되지 않게 조회하시오
    Alias 는 판매일이다
select  distinct to_date (substr(cart_no, 1, 8),'yyyy-mm-dd') as 판매일  --distinct : 중복 허락하지 않는다
    from cart
 where cart_no like '200504%' 
 order by 1;
 

예)상품 테이블에서 제품명에 '여성'으로 시작하는 제품을 조회하시오
     Alias 는 제품코드, 제품명, 매입가격, 거래처코드
     단, like 연산자를 사용하지 말 것
     
select prod_id as 제품코드, --lgu : 분류 
       prod_name as 제품명,
       to_char(prod_cost, 'l9,999,990') as 매입가격, --L빼면 원화기호 없이 찍힘
                                                    --to_char이 변환함수임! 
       prod_buyer as 거래처코드
    from prod 
    where substr(prod_name, 1, 2)='여성';.

    
