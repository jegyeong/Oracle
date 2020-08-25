2019-12-26 (2)
2) 숫자함수

    1) 수학적함수
        - ABS, SIGN, POWER, SQRT, 
        (1) ABS(n)
         - n의 절대값을 반환
        (2) SIGN(n)
         - n의 부호에 따라 음수이면 -1, 양수이면 1, 0이면 0을 반환 --n의 크기는 관계없음, 단지 부호만 판단, 
        (3)POWER(e, y)
         - e에 y승(e의 y번 거듭 곱한) 값 반환
        (4) SQRT
         - n의 평방근 값 반환
         
   --자바는 문자우선, 오라클은 숫자우선 
   select ('12') + 12 from dual;
   --자바는 1212가 나옴

    예)회원테이블에서 회원의 나이가 50세 이상인 회원정보를 죄회하시오
        Alias  는 회원번호, 회원명, 주민번호, 나이
        단, 나이는 주민번호를 이용하여 구하고 50세 이상인 회원의 구별은 sign 함수를 사용하시오
        --안됨, 그냥 나이구하는것만 보세요
   
        select mem_id as 회원번호,
               mem_name as  
               mem_regno1||'-'||mem_regno2 as 주민번호,
               case when substr(mem_regno1, 1, 1) = '0' then --case when: 자바의 if 문이라고 생각하면 됨
                    extract(year from sysdate) - to_number('20'||substr(mem_regno1, 1,2))
                     -- extract(year from sysdate) : 시스템 데이터로부터 연도를 뽑는것
               else 
                    extract(year from sysdate) - to_number('19'||substr(mem_regno1, 1,2))
                end case as 나이
--             extract(year from sysdate) - substr(mem_regno1, 1 , 2) as 나이 
          from member;       
        
    예) 상품테이블에서 상품의 판매가가 10만원 초과이면 '고가상품', 10만원이면 '적정상품', 10만원 미만이면 '저가상품' 이라고 비고란에 출력하시오
    
    select prod_id 상품번호,
           prod_name 상품이름,
           prod_price 판매가격,
           case when sign(prod_price-100000)=0 then '적정상품'--10만원이면 0, 초과면 1, 미만이면 -1
                when sign(prod_price-100000)=1 then '고가상품'
                else  '저가상품' end as 비고 --end 가 case when 문이 끝나는것
            from prod;
            
    예) 20mb는 몇 byte 인지 구하시오 (2의 10승 byte = 1KB, 2의 10승 KB는 1MB)
        =>1MB = (2의 10승 X 2의 10승) byte => 2의 (10+10)승
        
        select to_char(20*power(2,20), '99,999,990')||'byte' from dual;
        
    2)GREATEST, LEAST --이 순으로 정렬을 하는것이기 때문에 처리속도가 굉장히 오래걸린다, 거의 안씀, 데이터 타입이 필요X
    - 주어진 값 중 제일 큰 값과 제일 작은 값을 반환
    (사용형식) 
    - GREATEST(m1, m2, m3...) - 나열된 (m1, m2, m3...) 중 가장 큰 값
    - LEAST(m1, m2, m3...) - 나열된 (m1, m2, m3...) 중 가장 작은 값
    **하나의 컬럼에 저장된 값 중 최대/최소 값을 구할 때 => min(c), max(c) 사용
    
    예) 
    select greatest(100, '나', '가') from dual;--안됨
    
    예) 회원테이블에서 회원들이 보유하고 있는 마일리지를 조회하여 2000보다 작으면 2000으로 변경하는 쿼리를 작성하시오
    
    (마일리지가 2000미만인 회원
    select mem_name, mem_mileage
        from member
        where mem_mileage<2000;
        
    (2000미만인 회원의 마일리지 변경)
    update member
        set mem_mileage = (select greatest(mem_mileage, 2000) from member);--사용자가 가진 마일리지와 2000을 비교해서 더 큰 값을 반환
        set (mem_id,mem_mileage)=(select mem_id,greatest(mem_mileage,2000)
                        from b)
        where a.mem_id = b.mem_id;--안됨
        
    select mem_id, mem_name, greatest(mem_mileage, 2000)
        from member;
        
        rollback;
        
        
        
               
               