2020-02-03-02)package
    -관련된 업무를 하나로 묶어 처리
    -복수개의 변수, 커서, 함수, 프로시져 등을 하나로 모듈화 하여 처리
    -모듈화, 프로그램 설계의 용이성, 캡슐화, 효율적인 성능 제공
    (일반사용형식)
    
    create [or replace] package
    is
    [상수/변수/커서 선언문;]
    
    function 함수명 [(매개변수list)]
      return 반환타입
        :
    procedure 프로시저명 [(매개변수list)]
    
end 패키지명;

(패키지 본문 사용형식)
    create or replace package body 패키지명
    is
      [상수/변수/커서 선언문;]
      
      function 함수명 [(매개변수list)]
        return 반환타입
    begin
    
    end 함수명;
    
    procedure 프로시저명 [(매개변수list)]
    
    begin
    
    end 프로시져명;
        :
end 패키지명;



예)사원번호를 입력받아 이름을 출력하는 함수,--fn_get_emp_name
    신규사원을 등록하는 프로시져, --new_emp_proc
    퇴사한 사원을 처리하는 프로시져, --retire_emp_proc
    위의 업무를 처리할 수 있도록 패키지(hr_pkg)를 구성하시오
    
    (hr_pkg 선언부)
    create or replace package hr_pkg
    is
        function fn_get_emp_name(p_emp_id employees.employee_id%type) --반환값 있
          return employees.emp_name%type;
          
        procedure new_emp_proc(p_emp_name varchar2, p_hire_date varchar2); --반환값 없
    
        procedure retire_emp_proc(p_emp_id employees.employee_id%type);
    end hr_pkg; --선언부
    
    (package 의 body)
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
            
            return (v_name, '해당 사원 정보 없음');
        
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
                  dbms_output.put_line('예외발생 : '||sqlerrm)
        end new_emp_proc;
    
    
    --------------------------------------------------
    
(HK_PKG선언부)
CREATE OR REPLACE PACKAGE HR_PKG
IS
FUNCTION FN_GET_EMP_NAME(P_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
    RETURN EMPLOYEES.EMP_NAME%TYPE;
    
    PROCEDURE NEW_EMP_PROC(P_EMP_NAME VARCHAR2, P_HIRE_DATE VARCHAR2);
    
    PROCEDURE RETIRE_EMP_PROC(P_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE);   --퇴사자 아이디
    END HR_PKG;
    
    
    DROP PACKAGE HK_PKG; --잘못되면 실행
    
(PACKAGE의 BODY)
CREATE OR REPLACE PACKAGE BODY HR_PKG
IS

    FUNCTION FN_GET_EMP_NAME(P_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE) --반환값 있음
    RETURN EMPLOYEES.EMP_NAME%TYPE; --반환값
    IS
    V_NAME EMPLOYEES.EMP_NAME%TYPE; --지역변수 선언
    BEGIN
    SELECT EMP_NAME INTO V_NAME --반환되어질값
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = P_EMP_ID;
    
    RETURN VNL(V_NAME, '해당 사원정보 없음');
    END FN_GET_EMP_NAME;
    
    
    PROCEDURE NEW_EMP_PROC(P_EMP_NAME VARCHAR2, P_HIRE_DATE VARCHAR2)
    IS
    V_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
    V_DATE DATE := TO_DATE(P_HIRE_DATE); -- 입사일을 데이트타입으로 변환해서 변수에 넣기
    BEGIN
    SELECT NVL(MAX(EMPLOYEE_ID),0)+1 INTO V_EMP_ID --V_EMP_ID에 넣어줌 
    FROM EMPLOYEES;
    INSERT INTO EMPLOYEES(EMPLOYEE_ID,EMP_NAME,HIRE_DATE,CREATE_DATE,UPDATE_DATE)
    VALUES(V_EMP_ID, P_EMP_NAME, V_DATE,SYSDATE,SYSDATE);
    COMMIT;
    
    EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('예외발생 : '||SQLERRM);
    ROLLBACK;
    
    END NEW_EMP_PROC; 
    --퇴직자 처리
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
       DBMS_OUTPUT.PUT_LINE(P_EMP_ID||' 번 사원정보가 없음');
       ROLLBACK;
       WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE(SQLERRM);
       ROLLBACK;
       
    END RETIRE_EMP_PROC;
    END HR_PKG;
    
    (실행)
    SELECT HR_PKG.FN_GET
    