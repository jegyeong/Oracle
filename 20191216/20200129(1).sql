2020-01-29  01)반복문

1)LOOP문
    -반복구조의 기본적인 형식 제공
    -java의 DO문과 비슷한기능
    (사용형식)
    LOOP 
        명령문(들);
        [EXIT WHEN 조건;]
    END LOOP;
     :조건이 참이면 반복을 벗어남
     
declare
    v_cnt number := 0;
    v_res number := 0;
begin
  loop
    v_cnt := v_cnt + 1;
    exit when v_cnt > 100;
    if mod(v_cnt, 2) <> 0 then -- <> => 같지않다
        v_res := v_res + v_cnt;
    end if;
  end loop;
  
  dbms_output.put_line('홀수의 합 = '||v_res);
end;


예)구구단의 5단을 출력
declare
    v_cnt number := 1;
    v_res number := 0;
begin
  loop
    v_res := v_cnt * 5;
    exit when v_cnt > 9;
    dbms_output.put_line(5||'*'||v_cnt||'='||v_res);
    v_cnt := v_cnt + 1;
  end loop;
    end;
    
예)첫날에 100원, 2일부터 전날의 2배씩 저축할때 최초로 300만원이 넘는 날까지 경과된 일수와 그때까지 저축한 금액을 구하여라
(loop문 사용)
declare
    v_days : =1;
    v_sum := 0;
    v_amt := 100;
begin
    loop 
    v_sum := v_sum + v_amt;
    exit when v_sum >= 3000000; --거짓이면 돔
    v_amt := v_amt *2;
    v_days := v_days *2 ;
    end loop;
    
    dbms_output.put_line('날수 : ' || v_days);
    dbms_output.put_line('금액 : ' || v_sum);
end;