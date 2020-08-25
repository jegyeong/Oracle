2020-02-03-01)트리거
예)사원테이블에서 사원번호 202번 사원의 소속부서가 20번부서에서 40번 부서로
   이동배치되었을때 이 내용을 job_history테이블에 저장하는 트리거를 작성하시오
   
create or replace trigger tg_emp_01
  after  update on employees
  for each row
declare
  v_cnt number:=0;
begin
  select count(*) into v_cnt
    from job_history
   where employee_id=:old.employee_id;
  
  if v_cnt=0 then
    insert into job_history values(:old.employee_id,:old.update_date,
                                   sysdate-1,:old.job_id,:old.department_id,
                                   sysdate,sysdate);
  elsif v_cnt<>0 then
    update job_history
       set start_date=:old.update_date,
           end_date=sysdate-1,
           job_id=:old.job_id,
           department_id=:old.department_id,
           update_date=:old.update_date
     where employee_id=:new.employee_id;
  end if;
end;  

update employees
   set department_id=40
 where employee_id=202;  
 
 
select * from employees where employee_id=202; 

select * from job_history;


예)장바구니테이블에서 2005년 7월 28일 'b001'회원의 자료를 삭제하고
   재고수블테이블의 내용을 변경하는 트리거를 작성하시오(오늘이 2007년 7월 30일)
 
create or replace trigger tg_remain_03
  after delete on cart
  for each row
declare
  v_qty cart.cart_qty%type;
  v_prod_id cart.cart_prod%type;
begin
  v_qty:=-(:old.cart_qty);
  v_prod_id:=(:old.cart_prod);
  
  update remain
     set remain_o=remain_o+v_qty,
         remain_j_99=remain_j_99+v_qty
   where remain_year='2005'
     and remain_prod=v_prod_id;
  
  exception
    when others then
      dbms_output.put_line('예외발생 : '||sqlerrm);
end;      
 --4개의 행이 삭제되어지니까 트리거가 4번 발생됨
 
   
select * from cart 
  where substr(cart_no,1,8)='20050728' 
    and cart_member='b001';
select * from remain
  where remain_prod in ('P302000001','P201000016',   --구매 4건, 삭제되어지는행 4개
                        'P302000002','P201000017');
                        
delete cart                        
 where cart_member='b001'
   and substr(cart_no,1,8)='20050728';
   
   