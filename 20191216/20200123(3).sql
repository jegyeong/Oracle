2020-01-23  03)PL/SQL(PROCEDURE Language SQL)
 - ǥ�� SQL �� ������ ����, ��, �б�, �ݺ� ���� ����� �߰��� SQL
 - block ������ �����Ǿ� ���ȭ ĸ��ȭ ��ɵ� ����
 - dbms �� �̸� �Ĥ����� �Ͽ� �����ϰ� ����� ȣ���ϱ� ������ ���� ó���ӵ� 
 - ���� � ǥ���� ����
 - �� dbms�� ���� ������ �������
  - Anonymous block, stored procedure, user function, package, trigger
 
 
 1) Anonymous block(�͸���)
  . �⺻ ��ϱ���
  . �̸��� ���� ��ϱ���
  (����)
declare
  ����� - ����, ���, Ŀ�� ����
  
begin
  ����� - �����Ͻ� ������ �����ϴ� QUERY
  
   [exception
        ����ó�� ����]
        
end;
    
declare
    v_num number:=1000000;
    v_message varchar2(50);
begin
    v_message:='���� ù��° PL/SQL ���';
    
    dbms_output.put_line(v_message || ' ' || v_num);
end;

accept v_name prompt '�� �̸� : ' 
declare
   v_mess varchar2(100);
   v_add varchar2(70):='������ ������ ����';
begin
   v_mess := '&v_name' ||', ' || v_add;
   dbms_output.put_line(v_mess);
end;