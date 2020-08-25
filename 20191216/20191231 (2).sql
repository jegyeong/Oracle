2019-12-31 2)변환함수
-데어터의 형을 사용된 위치에서 임시로 형 변환
-CAST, TO_DATE, TO_CHAR, TO_NUMBER --TO_CHAR 용도가 제일 많다! 


    1)CAST
     - 주어진 자료를 정의된 타입으로 형변환
     (사용형식)
     CAST(expr as 타입)
     - 'expr' 로 정의된 자료를 '타입'dmfh qusghks
     
     예)
     select cast(1234 as char(8)) from dual; --이 위치에서 문자열이 되는것
     
     예)사원테이블에서 사원명 char(50)으로 변환하여 출력하시오 
        Alias 는 사원번호, 사원명, 전화번호이다
        select employee_id || ' ' || emp_name || ' ' ||phone_number,
               employee_id || ' ' || cast(emp_name as char(30)) || ' ' ||phone_number --고정길이로 된것 > 그래서 공백출력
            from employees;
            
     예) 장바구니 테이블(cart)에서 장바구니번호에서 날짜를 추출한 후 결제 마감일(3일후)을 조히하시오(2005년 4월 1 ~ 10일 자료만 검색)
         Alias 회원번호, 장바구니 번호, 구매일, 결제종료일
            select cart_member as 회원번호, --substr
                   cart_no  as 장바구니번호,
                   to_date(substr(cart_no, 1, 8)) as 구매일, --날짜로 쓰고싶어서 to_date 쓰는것
                   cast (substr(cart_no, 1, 8) as date) + 3 as 결제종료일 --이미 날짜타입이라서 to date로 변화시킬 필요가 없다
                from cart
--                where cart_no not like substr(cart_no, 1, 8) < '20050411%'; --like는 부등호 하나만써야해

--                where substr(cart_no, 1, 8) >= '20050401' and substr(cart_no, 1, 8) <= '20050410':
--                where substr(cart_no, 1, 8) between '20050401' and '20050410';
                
    
    2)TO_CHAR --가장 널리쓰임! --원본타입 뭐든지 다 된다! 문자열 >문자열도 가능 ex)고정길이 > 가변길이...등등... 출력을 위한 목적 
     - 숫자, 문자열, 날짜 형식의 자료를 문자열 자료로 변환 --잡동사니 데이터를 문자열로 바꿀때 사용된다
     - 형식문자열을 지정하여 FORMAT된 형식의 결과를 반환
     (사용형식)
      TO_CHAR(c1 [,fmt])
      - 'fmt'는 출력하고자 하는 형식을 지정하는 형식지정 문자열
      - c1이 문자열 인 경우 char, clob타입을 varchar2형식으로 변환
      
      날짜형식지정문자열
      ---------------------------------------
      형식문자열                 의미
      ---------------------------------------
      AD,CC,BC                  기원전/후 --몇세기 인지 추가로 나타내고 싶을때 
      YYYY, YY, YY Y            년도
      Q                         분기
      MONTH, MON, MM, RM        월
      W, WW, IW                 주 --iw : 주차 ex) 1월 1일 부터 34주차...
      DD, DDD, J                일 --DDD : 1월1일부터 경과된 일 수 
      DAY, DY, D                요일
      AM, PM, A.M, P.M          오전/오후
      HH, HH12,HH24             시간
      MI                        분
      SS, SSSSS                 초 --SS : 일반적인 초 , 오늘 0시0분0초부터 경과된 초 : SSSSS 
      "  "                      사용자정의
      ----------------------------------------
      select to_char(sysdate, 'yyyy"년"  q"분기"') from dual; --년 이 형식지정문자열에 없을때 넣고싶으면 " " 를 쓰는 것
      
      
      select to_char(sysdate, 'yyyy-mm-dd am hh24:mi:ss ww') from dual; 
      select to_char(to_date('20191220'), 'yyyy-mm-dd am hh24:mi:ss ww') from dual;--시간 지정안하면 0시 0분 0초로 인식한다
      
      예)장바구니테이블에서 장바구니번호(cart_no)를 사용하여 판매일(월 일) 별 판매금액 합계를 구하시오
         단, 2005년 5월에 판매된 거래에 대해서 조회하시오
         Alias 는 판매일, 수량합계, 판매액합계
         --cart_member  회원?? . cart_no 장바구늬 번호 , cart_qty 수량 , cart_prod 상품??
         
         select substr to_char(to_date(substr(cart_no, 5, 4),'0000' 'mm- dd'))  as 판매일, --5번째에서 4글자를 떼라
                sum(cart_qty) as 수량합계,
                sum(cart_qty * prod_price) as 판매액합계
            from cart, prod
            where cart_prod = prod_id
              and cart_no like '200502%'
--              and substr(cart_no, 1, 8) between '20050501' and '20050531'
            group by substr to_char(to_date(substr(cart_no, 5, 4),'0000' 'mm- dd')) --그냥 요 괄호안이 틀린거임1
            order by 1;
            --외안돼?
            
            
      **숫자 형식 지정 문자열
      -----------------------------
      형식문자열            의미
      -----------------------------
        9              숫자와 대응되어 유효숫자가 대응되는 위치의 '9' : 유효숫자반환
                       '9'와 대응되는 데이터가 무효의 '0'이면 공백처리 --왼쪽의 0
                       ex) 형식지정 문자열 : '999999'
                           데이터 :          001234 --공백2개 >1234
                                            010012 --공백1개 >10012
                                            001000 --공백2개 >1000
                                           1223456 --크기 달라서 오류처리된다 >오류
                           ------------------------
        0              숫자와 대응되어 유효숫자가 대응되는 위치의 '0' : 유효숫자반환
                       '9'와 대응되는 데이터가 무효의 '0'이면 0을 삽입해서 출력한다
                        ex) 형식지정 문자열 : '000000'
                           데이터 :          001234 - 001234
                                            010012 - 010012
                                            001000 - 001000
                                           1223456 --크기 달라서 오류처리된다
                           ------------------------
        ,(comma) .(period)  해당위치에 ,와 .응 삽입하여 반환
        $(L)                화폐기호($, 시스템에서 설정된 화폐기호) 출력
        mi                  음수인 경우 우측에 '-'부호 출력
        pr                  음수인 경우 '-'대신 자료를 '< >'로 묶어 출력
        ------------------------------------------------------------------------
        
        예)상품테이블에서 상품 판매가격이 15만원 이상인 상품을 조회하시오
            단, 가격출력시 화폐기호와 자리점(3자리마다 ',')을 넣어 출력할것 
            --LGU :분류코드  buyer : 업체코드 stock : 재고량(total~ 전체 재고량, proper~ 적정재고량)
            
            Alias 는 상품번호, 상품명, 가격
            
            select prod_id as 상품번호,
                   prod_name as 상품명,
                   to_char(prod_price, 'L9,999,999') as 가격1,
                   to_char(prod_price, 'L0,000,000') as 가격2
              from prod
             where prod_price >= 150000;
             
             


                
                
                   
                           
      
      
     
