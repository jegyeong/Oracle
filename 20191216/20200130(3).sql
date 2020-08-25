2020-02-30-03)


(판매수량과 판매금액 합계)
create or replace function fn_cart_01(
    p_id in cart.cart_prod%type)
    
    return number
is
    v_sum number := 0;
begin  
    select sum(cart_qty*prod_price) into v_sum
      from cart, prod
     where cart_prod = prod_id
       and cart_prod = p_id
       and cart_no like '200505%';
       
    return v_sum;
    
    exception
     when others then
      dbms_output.put_line('예외발생 : ' || sqlerrm);
end;

(실행)--아우터 조인효과? 뭔소리야ㅠ

select prod_id as 상품코드,
       prod_name as 상품명,
       nvl(fn_cart_01(prod_id),0) as 판매금액 --내가만든함수
  from prod
  where fn_cart_01(prod_id) >= 300000;
  
  
예)부서코드를 입력받아 해당부서에 소속된 직원수와 급여합계를 출력하는 함수 작성
--함수
CREATE OR REPLACE FUNCTION FN_EMP_01(
  P_DEPTID DEPARTMENTS.DEPARTMENT_ID%TYPE)
  RETURN NUMBER
IS 
   V_SUM NUMBER := 0;
BEGIN
  SELECT SUM(SALARY) INTO V_SUM
    FROM EMPLOYEES
   WHERE DEPARTMENT_ID = P_DEPTID;
   
  RETURN V_SUM;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('예외발생 : '||SQLERRM);
END;
--실행
SELECT DISTINCT A.DEPARTMENT_ID, b.department_name, fn_emp_01(a.DEPARTMENT_ID)
  FROM EMPLOYEES A, DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;
