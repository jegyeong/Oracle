2020-01-28  01)변수/상수
1)선언형식
  식별자[CONSTANT] 데이터타입 [:=초기값];
  - CONSTANT : 상수선언
  - 데이터타입 : 표준 SQL의 데이터타입과 INTEGER, BOOLEAN 등이 사용
        INTEGER [binary_integer, pis_integer]
            : 2147483647 ~ -2147483648까지 사용가능
        BOOLEAN 
            : 참(TRUE), 거짓(FALSE), NULL 값 처리
        레코드타입 
            (1)%type : 참조형 데이터타입
            (사용형식)
            식별자 테이블명, 컬럼명%type[:=초기값];
            - '테이블명.컬럼명'과 동일한 타입/크기의 기억공간 선언
            
            (2)%ROWTYPE 
            (사용형식)
            식별자 테이블명, 컬럼명%rowtype[:=초기값];
            - '테이블'의 행구조와 동일한 타입/크기의 기억공간 선언


예)회원테이블에서 마일리지가 가장 많이 보유한 남성회원의 정보를 조회하는 익명불록을 작성하시오
    
    select mem_id, mem_name, mem_mileage
     from member a, (select mem_id,
                            mem_mileage as maxm
                        from member
                        
     where substr(mem_regno2, 1, 1) = '1'
        or substr(mem_regno2, 1, 1) = '3'
        order by 3 desc;
        
        
        
      select a.mem_id, a.mem_name, b.maxm
     from member a, (select mem_id,
                            mem_mileage as maxm
                        from member
                       where substr(mem_regno2, 1, 1) = '1'
                         or substr(mem_regno2, 1, 1) = '3'
                        order by 2 desc) b
        where a.mem_id = b.mem_id 
        and rownum = 1;
        
(익명블록)
declare
  v_id member.mem_id%type;
  v_name member.mem_name%type;
  v_mile number:=0;
  v_res varchar2(100);
begin
  select a.mem_id, a.mem_name, b.maxm into v_id, v_name, v_mile
    from member a, (select mem_id,
                           mem_mileage as maxm
                      from member
                     where substr(mem_regno2,1,1) = '1' --남성회원 조건
                        or substr(mem_regno2,1,1) = '3'
                     order by 2 desc) b
   where a.mem_id = b.mem_id
     and rownum = 1;
     
    v_res:=v_id||', '||v_name||', '||v_mile;
    
    dbms_output.put_line(v_res); --출력
end;


예)키보드로 부서번호를 입력받아 해당부서의 급여 총액을 출력하는 익명블록 작성

(부서의 급여총액)
select a.department_id, b.department_name, sum(a.salary)
  from employees a, departments b 
  where a.department_id = b.department_id
    and  a.department_id = 50
  group by a.department_id, b.department_name
  order by 3 desc; 
  
 데이터베이스 스키마 서비스 접속
 (익명블록)
accept p_id prompt '부서번호 입력(10-110) : ' --d입력받아서 p_id 에 넣어줘라!
declare 
    v_id employees.department_id % type;
    v_name departments.department_name % type;
    v_sal number(10) = 0;
begin
    v_id := to_number('&p_id'); --문자로 바꿔라
    select b.department_name, sum(a.salary) into v_name
  from employees a, departments b 
  where a.department_id = b.department_id
    and  a.department_id = 50
  group by a.department_id, b.department_name
  order by 3 desc;
  
exception 
    when other then
    dbms_ouput.put_line('오류발생 : ' :||sqlerrm);

------------------------------------------------------------------

accept p_id prompt '부서번호 입력 (10-110) : '
declare
  v_id employees.department_id%type;
  v_name departments.department_name%type;
  v_sal number(10) := 0;

begin
v_id := to_number('&p_id');
select b.department_name, sum(a.salary) into v_name, v_sal
  from employees a, departments b
 where a.department_id = b.department_id
   and a.department_id = v_id
 group by b.department_name
 order by 2 desc;
 --출력
dbms_output.put_line('------------------------------------');
dbms_output.put_line('부서코드     부서명          급여총액');
dbms_output.put_line('------------------------------------');
dbms_output.put_line('  '||v_id||'        '||v_name||'          '||v_sal);
 
 exception
    when others then
      dbms_output.put_line('오류발생 : '||sqlerrm);
end;
  
    
