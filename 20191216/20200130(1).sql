2020-01-30-01)for문

    - 제어변수를 이용한 반복기능 제공
    - 기능은 고급언어의 for문과 동일
    --반복의 횟수를 알고있을때! 모를때는 while 문
    (사용형식)
    for 제어변수 in[reverse] 초기값...최종값 --제어변수 : 별도로 선언하지 않아도됨!
    loop
     명령문(들);
    end loop;
    
    예)
    declare
        v_base number := 5;
    begin
        for i in 1..9 loop
        dbms_output.put_line(v_base||'*'|| i || '=' || v_base * i);
        end loop;
    end;
    
2)커서에서 사용하는 for문
(사용형식)
for 레코드 in 커서명(매개변수, 매개변수,...)
loop
    명령문(들);
end loop;

예)사원테이블에서 부서번호 60번에 속한 사워느이 이름을 출력하는 커서를 작성

declare
    cursor cur_emp_01
    is
      select emp_name, salary
        from employees
       where department_id = 60;
begin
    for rec_emp in cur_emp_01 
    loop
      dbms_output.put_line(rec_emp.emp_name || ', ' || rec_emp.salary);
    end loop;
end;


3) 커서에서 사용하는 for문
(사용형식)
for 레코드 in (커서정의)
loop
    명령문(들);
end loop;

declare
begin
    for rec_emp in (select emp_name, salary
                      from employees
                     where department_id = 60)
    loop
      dbms_output.put_line(rec_emp.emp_name || ', ' || rec_emp.salary);
    end loop;
end;