2020-01-29  03)

2)while��
    - ������ �ο��Ͽ� ������ �����Ǹ� �ݺ��� �����ϴ� ��ɱ���
    - ��޾���� while ���� ���� ��� ����
    (�������)
    while ���� loop
        ��ɹ�(��);
            :
    end loop;
    
    
 ��) 2005�� 5�� ��ǰ�� �԰������ ����ϴ� Ŀ���� �ۼ��Ͻÿ�
 declare
    v_prod buyprod.buy_prod%type;
    v_prod_name prod.prod_name%type;
    v_qty number := 0;
    v_res varchar2(100);
    
    cursor cur_buyprod_01
    is
    select buy_prod, prod_name, sum(buy_qty)
      from buyprod, prod
     where buy_date between '20050501' and '20050531'
       and buy_prod = prod_id
     group by buy_prod, prod_name
     order by buy_prod;
begin
    open cur_buyprod_01;
    dbms_output.put_line('--------------------------------------------------------------');
    dbms_output.put_line('  ��ǰ�ڵ�             ��ǰ��                  ��ǰ����      ');
    dbms_output.put_line('---------------------------------------------------------------');
    fetch cur_buyprod_01 into v_prod, v_prod_name, v_qty;
    while cur_buyprod_01%found loop
        v_res := lpad(v_prod, 11, ' ')|| '   ' || rpad(v_prod_name, 32, ' ') || lpad(v_qty, 5, ' ');
        dbms_output.put_line(v_res);
        fetch cur_buyprod_01 into v_prod, v_prod_name, v_qty;
    end loop;
    
    close cur_buyprod_01;
end;


��)Ű����� ȸ���� ������ �Է� �޾� �ش����� ������ �ִ� ȸ���� ȸ����ȣ, ȸ����, ���ϸ����� ����϶�.
    ��, �� ���� ���ϸ��� �հ踦 ����ϴ� �͸����� �ۼ��϶�(while�� ���)
    
    accept p_job prompt 'ȸ�� ������ : '
    declare
        v_id member.mem_id%type;
        v_name member.mem_name%type;
        v_mileage member.mem_mileage%type;
        v_mileage_amt number := 0;
        
       
    
     cursor cur_member_02(cp_job member.mem_job%type)
    is
    v_job := to_number('&p_job');
    select mem_id, mem_name, mem_mileage, sum(mem_mileage)
        from member
        group by mem_id, mem_name, mem_mileage;
    
    begin
        open cur_member_02('&p_job');
        
        fetch cur_member_02 into v_mem_id, v_name, v_mileage;
        while cur_member_02%found loop
          dbms_output.put_line(v_mem_id||', '||v_name||', '||v_mileage);
          v_mileage_amt := v_milleage_amt + v_mileage;
          fetch cur_member_02 into v_mem_id, v_name, v_mileage;
        end loop;
        dbms_output.put_line('--------------------------------------');
        dbms_output.put_line('���ϸ��� �հ� :' ||v_mileage_amt);
        
        close cur_member_01;
end;
        
        
        
        
    

