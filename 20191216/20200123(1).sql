2020-01-23   01)synonym(동의어) 객체 

    - 오라클 객체에 별도의 이름을 부여
    - 다른 소유자의 테이블에 접근하는 경우 '스키마명, 테이블명' 형식을 취하기 때문에 접근 지정명이 복잡해짐 
     -> 이를 간단하게 지정하기 위해서 주로 사용
     
    select * from[ip.소유자계정명.]lprod;
    (사용형식)
    create [or replace][public] synonym 동의어명
        for 객체명;
         - public : 공개동의어
         - '객체명' : 동의어 부여 대사 객체이름 
         
예)
    create or replace synonym emp for employees;
    
    select emp_name, salary, department_id 
        from kbs;--이러면 안떠
        
    select emp_name, salary, department_id 
        from emplouees kbs;
        
    select sysdate from dual;
    
    create or replace synonym d1 for sys.dual;
    
    select to_chart (sysdate, 'yyyy-mm-dd am hh24:mi:ss')from d1;
    
    
    
    