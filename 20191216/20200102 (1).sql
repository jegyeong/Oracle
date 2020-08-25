2019-01-02 01)숫자변환함수

    1)to_number
        - 숫자로 변환 가능한 문자열을 숫자형 자료로 변환
        (사용형식)
        to_number(c1 [,fm])
         - 'fmt'는 to_char의 숫자 변환 문자열과 동일
         - 'c1'은 숫자변환 가능한 문자열
         
         예)
         select to_number('1234','9,999'),
                to_number(sysdate),
                to_number('p101')
            from dual; --오류.. 변환 불가능한것을 변환하려고 시도했기 때문에
        
        select to_number('1234','9999') --(,)가 들어가면 연산 불가능한 숫자가 되어버림~~~
--                to_number(sysdate),
--                to_number('p101')
            from dual;
            
        select substr(cart_no, 5, 4) from cart; --substr을 쓰는건 문자열> 문자열에서뗀다고 해도 문자열 왼쪽정렬> 문자!
        select to_number(substr(cart_no, 5, 4)) from cart; --오른쪽정렬 > 숫자! 
        select to_char(substr(cart_no, 5, 4), 'mmdd') from cart; --오류남, 일단 날짜형으로 바꿔줘야해
        select to_date(substr(cart_no, 5, 4), 'mmdd') from cart; --연도까지 같이나오니까 연도 짜르기 위해서 to_char 붙여야해
        select to_char(to_date(substr(cart_no, 5, 4), 'mmdd'),'mm"월" dd"일"') from cart; --날짜니까 to_char 붙여줄 수 있어
        --to_char 을 할때 문자열과 문자열로 변환할때 조심해야해! 항상 되는건 아니고 되는게 있기 때문에 한 두 단계 더 거쳐야 할 수도 있어
        --문자열 자체를 가지고 날짜 타입으로 바로 안돼 날짜> 연도 빼고> 월 일 붙이기 ! 이거를 순서대로 해야해! 아님 안돼!
        
    2)to_date
        -날짜형식의 문자형을 date 형으로 변환
        ( 사용형식)
        to_date(c1, [,fmt])
        - c1은 날짜로 변환 가능한 문자열
        - 'fmt'는 to_char 함수의 날짜변환 문자열과 동일
        
        예)
        select to_date('20200131') 
--               to_date(20200131),
--               to_date(20201131)
            from dual;
            
        select to_date('20200131'),
               to_date('20200131', 'yyyy/mm/dd'),
               to_date(20200131, 'yyyymmddhh24miss') --여기 변환 안돼ㅠㅠto char로 변환해줘야해
--               to_date(20200131),
--               to_date(20201131)
            from dual;
        
            select to_date('20200131'),
               to_date('20200131', 'yyyy/mm/dd'),
               to_char(to_date(20200131, 'yyyymmddhh24miss'),'yyyy/mm/ddhh24:mi:ss') --여기 변환 안돼ㅠㅠto char로 변환해줘야해
--               to_date(20200131),
--               to_date(20201131)
            from dual;
            
          select to_date('20200131'),
               to_date('20200131', 'yyyy/mm/dd'),
               to_char(to_date(20200131, 'yyyymmddhh24miss'),'yyyy/mm/ddhh24:mi:ss) --여기 변환 안돼ㅠㅠto char로 변환해줘야해
--               to_date(20200131),
--               to_date(20201131)
            from dual;
         