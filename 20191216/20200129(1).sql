2020-01-29  01)�ݺ���

1)LOOP��
    -�ݺ������� �⺻���� ���� ����
    -java�� DO���� ����ѱ��
    (�������)
    LOOP 
        ��ɹ�(��);
        [EXIT WHEN ����;]
    END LOOP;
     :������ ���̸� �ݺ��� ���
     
declare
    v_cnt number := 0;
    v_res number := 0;
begin
  loop
    v_cnt := v_cnt + 1;
    exit when v_cnt > 100;
    if mod(v_cnt, 2) <> 0 then -- <> => �����ʴ�
        v_res := v_res + v_cnt;
    end if;
  end loop;
  
  dbms_output.put_line('Ȧ���� �� = '||v_res);
end;


��)�������� 5���� ���
declare
    v_cnt number := 1;
    v_res number := 0;
begin
  loop
    v_res := v_cnt * 5;
    exit when v_cnt > 9;
    dbms_output.put_line(5||'*'||v_cnt||'='||v_res);
    v_cnt := v_cnt + 1;
  end loop;
    end;
    
��)ù���� 100��, 2�Ϻ��� ������ 2�辿 �����Ҷ� ���ʷ� 300������ �Ѵ� ������ ����� �ϼ��� �׶����� ������ �ݾ��� ���Ͽ���
(loop�� ���)
declare
    v_days : =1;
    v_sum := 0;
    v_amt := 100;
begin
    loop 
    v_sum := v_sum + v_amt;
    exit when v_sum >= 3000000; --�����̸� ��
    v_amt := v_amt *2;
    v_days := v_days *2 ;
    end loop;
    
    dbms_output.put_line('���� : ' || v_days);
    dbms_output.put_line('�ݾ� : ' || v_sum);
end;