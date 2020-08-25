2020-01-29  03)

2)while문
    - 조건을 부여하여 조건이 만족되면 반복을 수행하는 명령구조
    - 고급언어의 while 문과 같은 기능 수행
    (사용형식)
    while 조건 loop
        명령문(들);
            :
    end loop;
    
    
 예) 2005년 5월 상품별 입고수량을 출력하는 커서를 작성하시오
 declare
    v_prod buyprod.buy_prod%type;
    v_prod_name prod.prod_name%type;
    v_qty number := 0;
    v_res varchar2(100);
    
    cursor cur_buyprod_01
    is
    select buy_prod, prod_name, sum(buy_qty)
      from buyprod, prod
     where buy_date between '20050501' and '20050531'
       and buy_prod = prod_id
     group by buy_prod, prod_name
     order by buy_prod;
begin
    open cur_buyprod_01;
    dbms_output.put_line('--------------------------------------------------------------');
    dbms_output.put_line('  상품코드             상품명                  상품수량      ');
    dbms_output.put_line('---------------------------------------------------------------');
    fetch cur_buyprod_01 into v_prod, v_prod_name, v_qty;
    while cur_buyprod_01%found loop
        v_res := lpad(v_prod, 11, ' ')|| '   ' || rpad(v_prod_name, 32, ' ') || lpad(v_qty, 5, ' ');
        dbms_output.put_line(v_res);
        fetch cur_buyprod_01 into v_prod, v_prod_name, v_qty;
    end loop;
    
    close cur_buyprod_01;
end;


예)키보드로 회원의 직업을 입력 받아 해당직을 가지고 있는 회원의 회원번호, 회원명, 마일리지를 출력하라.
    단, 맨 끝에 마일리지 합계를 출력하는 익명블록을 작성하라(while문 사용)
    
    accept p_job prompt '회원 직업명 : '
    declare
        v_id member.mem_id%type;
        v_name member.mem_name%type;
        v_mileage member.mem_mileage%type;
        v_mileage_amt number := 0;
        
       
    
     cursor cur_member_02(cp_job member.mem_job%type)
    is
    v_job := to_number('&p_job');
    select mem_id, mem_name, mem_mileage, sum(mem_mileage)
        from member
        group by mem_id, mem_name, mem_mileage;
    
    begin
        open cur_member_02('&p_job');
        
        fetch cur_member_02 into v_mem_id, v_name, v_mileage;
        while cur_member_02%found loop
          dbms_output.put_line(v_mem_id||', '||v_name||', '||v_mileage);
          v_mileage_amt := v_milleage_amt + v_mileage;
          fetch cur_member_02 into v_mem_id, v_name, v_mileage;
        end loop;
        dbms_output.put_line('--------------------------------------');
        dbms_output.put_line('마일리지 합계 :' ||v_mileage_amt);
        
        close cur_member_01;
end;
        
        
        
        
    

