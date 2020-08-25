2020-01-30-02)저장프로시져(stored procedure)
  - 서버에 저장된 처리 모듈
  - 미리 컴파일되어 저장
  - 클라이언트에게 처리루틴 공유기능 제공(기능의 캡슐화로 일관성 유지)
  - 서버보호 및 일관성 유지 기능
  - 반환값이 없음
  (사용형식)
  create [or replace] procedure 프로시져 이름[(
     변수명 [in|out|inout] 타입명[:=[default] expr],...)]
  [is|as]
  begin
    명령문(들);
    
    [exception
      예외처리문;]
  end; 
  
예)2005년 6월 30일 기준으로 장바구니테이블에서 6월 판매된 상품의 판매수량을 구한 뒤
  재고수불 테이블을 update 하는 프로시져 작성
  
(6월 판매된 상품의 판매수량)
select cart_prod, sum(cart_qty)
  from cart
 where cart_no like '200506%'
 group by cart_prod; 
  
(update 하는 프로시져 작성)

create or replace procedure proc_remain_01(
   p_prod in cart.cart_prod%type, p_qty in cart.cart_qty%type)
is

begin
   update remain
      set remain_o=remain_o+p_qty,
          remain_j_99=remain_j_00+remain_i-remain_o-p_qty,
          remain_date=to_date('20050630')
    where remain_year='2005'
      and remain_prod=p_prod;
      
   exception
     when others then
       dbms_output.put_line('오류발생 : '||sqlerrm);
end;
  
2)프로시져 실행명령
  (1)독립실행
     exec[execute] 프로시져(매개변수,...);
  
  (2)익명블록(함수 등)에서 실행
     프로시져(매개변수,...);
  
(실행을 위한 커서가 포함된 익명블록 작성)   

declare
   cursor cur_cart_06
   is
     select cart_prod, sum(cart_qty) as samt
       from cart
      where cart_no like '200506%'
      group by cart_prod; 
begin
   for rec_cart in cur_cart_06
   loop
      proc_remain_01(rec_cart.cart_prod, rec_cart.samt);
   end loop;
end;   

예)회원테이블에서 회원번호를 입력 받아 회원정보를 출력하는 프로시져 작성

create or replace procedure proc_member_01(
  p_id in member.mem_id%type)
is
  v_name member.mem_name%type;
  v_addr1 member.mem_add1%type;
  v_addr2 member.mem_add2%type;
begin
  select mem_name,mem_add1,mem_add2 into v_name,v_addr1,v_addr2
    from member
   where mem_id = p_id;
   
  dbms_output.put_line('회원명 : '|| v_name);
  dbms_output.put_line('주  소 : '|| v_addr1||' '||v_addr2);
end;

execute proc_member_01('b001');

예)키보드로 월을 입력받아 해당월의 매출건수와 매출수량합계, 매출금액합계를 구하는
   프로시져 작성
   procedure명 : proc_cart_02
   
   
create or replace procedure proc_cart_02(
  p_mon in varchar2, p_cnt out number, p_qty out number, p_sum out number)
is
  v_no varchar2(6):='2005'||p_mon;
begin
  select count(*),sum(cart_qty),sum(cart_qty*prod_price) into p_cnt,p_qty,p_sum
    from cart,prod
   where cart_prod=prod_id
     and substr(cart_no,1,6)=v_no;
end;
   
(실행블록)
accept ap_mon  prompt '월을 2자리로 입력 : '
declare
  v_cnt number:=0;
  v_qty number:=0;
  v_sum number:=0;
begin 
  proc_cart_02('&ap_mon',v_cnt,v_qty,v_sum);
  
  dbms_output.put_line('&ap_mon'||'매출 현황');
  dbms_output.put_line('-------------------------');
  dbms_output.put_line('매출건수 : '||lpad(v_cnt,13,' '));
  dbms_output.put_line('매출수량 : '||lpad(to_char(v_qty,'9,999'),13,' '));
  dbms_output.put_line('매출금액 : '||lpad(to_char(v_sum,'999,999,999'),13,' '));
  dbms_output.put_line('-------------------------');
end;  
   
예)사원테이블에서 부서번호 60번 부서에 속한 사원들의 급여를 20% 올려 저장하는 
   프로시져를 작성하시오, 또 처리 건수도 출력하시오
   procedure명 : proc_emp_02

create or replace procedure  proc_emp_02(
  p_emp_id in employees.employee_id%type, p_sal in employees.salary%type)
is
begin
  update employees
     set salary=salary+(salary*0.2),
         update_date=sysdate
   where employee_id=p_emp_id; 
   
  commit; 
end;

(실행블록)
declare
  v_cnt number:=0;
  cursor cur_emp_03
  is
    select employee_id, salary
      from employees
     where department_id=60; 
begin
  for rec_emp in cur_emp_03
  loop
    v_cnt:=v_cnt+1;
    proc_emp_02(rec_emp.employee_id,rec_emp.salary);
  end loop;  
  
  dbms_output.put_line('처리건수 : '||v_cnt);
end;  