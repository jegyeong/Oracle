2020-02-30-03)


(�Ǹż����� �Ǹűݾ� �հ�)
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
      dbms_output.put_line('���ܹ߻� : ' || sqlerrm);
end;

(����)--�ƿ��� ����ȿ��? ���Ҹ��ߤ�

select prod_id as ��ǰ�ڵ�,
       prod_name as ��ǰ��,
       nvl(fn_cart_01(prod_id),0) as �Ǹűݾ� --���������Լ�
  from prod
  where fn_cart_01(prod_id) >= 300000;
  
  
��)�μ��ڵ带 �Է¹޾� �ش�μ��� �Ҽӵ� �������� �޿��հ踦 ����ϴ� �Լ� �ۼ�
--�Լ�
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
      DBMS_OUTPUT.PUT_LINE('���ܹ߻� : '||SQLERRM);
END;
--����
SELECT DISTINCT A.DEPARTMENT_ID, b.department_name, fn_emp_01(a.DEPARTMENT_ID)
  FROM EMPLOYEES A, DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;
