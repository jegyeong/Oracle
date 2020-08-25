2020-01-23  03)PL/SQL(PROCEDURE Language SQL)
 - 표준 SQL 에 부족한 변수, 비교, 분기, 반복 등의 기능이 추가된 SQL
 - block 구조로 구성되어 모듈화 캡슐화 기능도 제공
 - dbms 가 미리 컴ㅂ파일 하여 보관하고 실행시 호출하기 때문에 빠를 처리속도 
 - 문법 등에 표준이 없음
 - 각 dbms에 따라 상이한 사용형식
  - Anonymous block, stored procedure, user function, package, trigger
 
 
 1) Anonymous block(익명블록)
  . 기본 블록구조
  . 이름이 없는 블록구조
  (구성)
declare
  선언부 - 변수, 상수, 커서 선언
  
begin
  실행부 - 비지니스 로직을 구현하는 QUERY
  
   [exception
        예외처리 영억]
        
end;
    
declare
    v_num number:=1000000;
    v_message varchar2(50);
begin
    v_message:='나의 첫번째 PL/SQL 블록';
    
    dbms_output.put_line(v_message || ' ' || v_num);
end;

accept v_name prompt '내 이름 : ' 
declare
   v_mess varchar2(100);
   v_add varchar2(70):='대전시 유성구 봉명동';
begin
   v_mess := '&v_name' ||', ' || v_add;
   dbms_output.put_line(v_mess);
end;