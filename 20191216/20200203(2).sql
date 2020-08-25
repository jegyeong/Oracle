2020-02-03-02)package
    -���õ� ������ �ϳ��� ���� ó��
    -�������� ����, Ŀ��, �Լ�, ���ν��� ���� �ϳ��� ���ȭ �Ͽ� ó��
    -���ȭ, ���α׷� ������ ���̼�, ĸ��ȭ, ȿ������ ���� ����
    (�Ϲݻ������)
    
    create [or replace] package
    is
    [���/����/Ŀ�� ����;]
    
    function �Լ��� [(�Ű�����list)]
      return ��ȯŸ��
        :
    procedure ���ν����� [(�Ű�����list)]
    
end ��Ű����;

(��Ű�� ���� �������)
    create or replace package body ��Ű����
    is
      [���/����/Ŀ�� ����;]
      
      function �Լ��� [(�Ű�����list)]
        return ��ȯŸ��
    begin
    
    end �Լ���;
    
    procedure ���ν����� [(�Ű�����list)]
    
    begin
    
    end ���ν�����;
        :
end ��Ű����;



��)�����ȣ�� �Է¹޾� �̸��� ����ϴ� �Լ�,--fn_get_emp_name
    �űԻ���� ����ϴ� ���ν���, --new_emp_proc
    ����� ����� ó���ϴ� ���ν���, --retire_emp_proc
    ���� ������ ó���� �� �ֵ��� ��Ű��(hr_pkg)�� �����Ͻÿ�
    
    (hr_pkg �����)
    create or replace package hr_pkg
    is
        function fn_get_emp_name(p_emp_id employees.employee_id%type) --��ȯ�� ��
          return employees.emp_name%type;
          
        procedure new_emp_proc(p_emp_name varchar2, p_hire_date varchar2); --��ȯ�� ��
    
        procedure retire_emp_proc(p_emp_id employees.employee_id%type);
    end hr_pkg; --�����
    
    (package �� body)
    create or replce package body hr_pkg
    is
        function fn_get_emp_name(p_emp_id employees.employee_id%type)
          return employees.emp_name%type
        is
            v_name employees.emp_name%type;
        begin
            select emp_name into v_name
             from employees
            where employee_id = p_emp_id;
            
            return (v_name, '�ش� ��� ���� ����');
        
        procedure new_emp_proc(p_emp_name varchar2, p_hire_date date)
        is
            v_emp_id employees.employee_id%type;
            v_date date := to_date(p_hire_date);
        begin
            select nvl(max(employee_id), 0) + 1 into v_emp_id
              from employees;
            insert into employees(employee_id, emp_name, hire_date, create_date, up_date_date)
                values(v_emp_id, p_emp_name, v_date, sysdate, sysdate);
                
            exception
                when other then
                  dbms_output.put_line('���ܹ߻� : '||sqlerrm)
        end new_emp_proc;
    
    
    --------------------------------------------------
    
(HK_PKG�����)
CREATE OR REPLACE PACKAGE HR_PKG
IS
FUNCTION FN_GET_EMP_NAME(P_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
    RETURN EMPLOYEES.EMP_NAME%TYPE;
    
    PROCEDURE NEW_EMP_PROC(P_EMP_NAME VARCHAR2, P_HIRE_DATE VARCHAR2);
    
    PROCEDURE RETIRE_EMP_PROC(P_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE);   --����� ���̵�
    END HR_PKG;
    
    
    DROP PACKAGE HK_PKG; --�߸��Ǹ� ����
    
(PACKAGE�� BODY)
CREATE OR REPLACE PACKAGE BODY HR_PKG
IS

    FUNCTION FN_GET_EMP_NAME(P_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE) --��ȯ�� ����
    RETURN EMPLOYEES.EMP_NAME%TYPE; --��ȯ��
    IS
    V_NAME EMPLOYEES.EMP_NAME%TYPE; --�������� ����
    BEGIN
    SELECT EMP_NAME INTO V_NAME --��ȯ�Ǿ�����
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = P_EMP_ID;
    
    RETURN VNL(V_NAME, '�ش� ������� ����');
    END FN_GET_EMP_NAME;
    
    
    PROCEDURE NEW_EMP_PROC(P_EMP_NAME VARCHAR2, P_HIRE_DATE VARCHAR2)
    IS
    V_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
    V_DATE DATE := TO_DATE(P_HIRE_DATE); -- �Ի����� ����ƮŸ������ ��ȯ�ؼ� ������ �ֱ�
    BEGIN
    SELECT NVL(MAX(EMPLOYEE_ID),0)+1 INTO V_EMP_ID --V_EMP_ID�� �־��� 
    FROM EMPLOYEES;
    INSERT INTO EMPLOYEES(EMPLOYEE_ID,EMP_NAME,HIRE_DATE,CREATE_DATE,UPDATE_DATE)
    VALUES(V_EMP_ID, P_EMP_NAME, V_DATE,SYSDATE,SYSDATE);
    COMMIT;
    
    EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('���ܹ߻� : '||SQLERRM);
    ROLLBACK;
    
    END NEW_EMP_PROC; 
    --������ ó��
    PROCEDURE RETIRE_EMP_PROC(P_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
    IS
    V_CNT NUMBER :=0;
    V_NO_DATE EXCEPTION;
    BEGIN
    UPDATE EMPOYEES
       SET RETIRE_DATE :=SYSDATE
     WHERE EMPLOYEE_ID = P_EMP_ID
       AND RETIRE_DATE IS NULL;
       
       V_CNT :=SQL%ROWCOUNT;
       
       IF V_CNT :=0 THEN
       RAISE V_NO_DATE;
       END IF;
       
       EXCEPTION WHEN V_NO_DATE THEN
       DBMS_OUTPUT.PUT_LINE(P_EMP_ID||' �� ��������� ����');
       ROLLBACK;
       WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE(SQLERRM);
       ROLLBACK;
       
    END RETIRE_EMP_PROC;
    END HR_PKG;
    
    (����)
    SELECT HR_PKG.FN_GET
    