2020-01-28  01)����/���
1)��������
  �ĺ���[CONSTANT] ������Ÿ�� [:=�ʱⰪ];
  - CONSTANT : �������
  - ������Ÿ�� : ǥ�� SQL�� ������Ÿ�԰� INTEGER, BOOLEAN ���� ���
        INTEGER [binary_integer, pis_integer]
            : 2147483647 ~ -2147483648���� ��밡��
        BOOLEAN 
            : ��(TRUE), ����(FALSE), NULL �� ó��
        ���ڵ�Ÿ�� 
            (1)%type : ������ ������Ÿ��
            (�������)
            �ĺ��� ���̺��, �÷���%type[:=�ʱⰪ];
            - '���̺��.�÷���'�� ������ Ÿ��/ũ���� ������ ����
            
            (2)%ROWTYPE 
            (�������)
            �ĺ��� ���̺��, �÷���%rowtype[:=�ʱⰪ];
            - '���̺�'�� �౸���� ������ Ÿ��/ũ���� ������ ����


��)ȸ�����̺��� ���ϸ����� ���� ���� ������ ����ȸ���� ������ ��ȸ�ϴ� �͸�ҷ��� �ۼ��Ͻÿ�
    
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
        
(�͸���)
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
                     where substr(mem_regno2,1,1) = '1' --����ȸ�� ����
                        or substr(mem_regno2,1,1) = '3'
                     order by 2 desc) b
   where a.mem_id = b.mem_id
     and rownum = 1;
     
    v_res:=v_id||', '||v_name||', '||v_mile;
    
    dbms_output.put_line(v_res); --���
end;


��)Ű����� �μ���ȣ�� �Է¹޾� �ش�μ��� �޿� �Ѿ��� ����ϴ� �͸��� �ۼ�

(�μ��� �޿��Ѿ�)
select a.department_id, b.department_name, sum(a.salary)
  from employees a, departments b 
  where a.department_id = b.department_id
    and  a.department_id = 50
  group by a.department_id, b.department_name
  order by 3 desc; 
  
 �����ͺ��̽� ��Ű�� ���� ����
 (�͸���)
accept p_id prompt '�μ���ȣ �Է�(10-110) : ' --d�Է¹޾Ƽ� p_id �� �־����!
declare 
    v_id employees.department_id % type;
    v_name departments.department_name % type;
    v_sal number(10) = 0;
begin
    v_id := to_number('&p_id'); --���ڷ� �ٲ��
    select b.department_name, sum(a.salary) into v_name
  from employees a, departments b 
  where a.department_id = b.department_id
    and  a.department_id = 50
  group by a.department_id, b.department_name
  order by 3 desc;
  
exception 
    when other then
    dbms_ouput.put_line('�����߻� : ' :||sqlerrm);

------------------------------------------------------------------

accept p_id prompt '�μ���ȣ �Է� (10-110) : '
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
 --���
dbms_output.put_line('------------------------------------');
dbms_output.put_line('�μ��ڵ�     �μ���          �޿��Ѿ�');
dbms_output.put_line('------------------------------------');
dbms_output.put_line('  '||v_id||'        '||v_name||'          '||v_sal);
 
 exception
    when others then
      dbms_output.put_line('�����߻� : '||sqlerrm);
end;
  
    
