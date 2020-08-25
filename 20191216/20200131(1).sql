2020-01-31-01)Ʈ����
    -������ �̺�Ʈ�� �߻��Ǹ� �� �̺�Ʈ �� �Ŀ� �ڵ� ����Ǵ� ���ν���
    --�ι��� ������ ���� ����ȴ�
    (�������)
    create trigger Ʈ���Ÿ�
        [before|after] [insert|update|delete]
        on ���̺�� 
        [for each row] --������ �� ������
        [when ����]---��������� ������ �Ǿ��� ���̺�o ���� ����
    begin
        pl/sql ���
    end;
        .before|after : �̺�Ʈ�� �߻��Ǳ� ���� begin ��� ����[before]
                        �̺�Ʈ�� �߻��� �Ŀ��� begin ��Ͻ���(after)
        .�̺�Ʈ : Ʈ���� ������ ������ �Ǵ� dml��(insert, update, delete)
                 �̺�Ʈ�� �ߺ� ����('or'������ ���)����
                 ex)insert or delete or update
        .Ʈ��������
        (1)��������� Ʈ���� --Ʈ���� �� 1���� �߻���Ŵ
           - 'for each row'�� ������ Ʈ����-- when ���ǵ� ����
           - ���� �ѹ��� Ʈ���� ����
           - �ǻ緹�ڵ�(:new :old)���Ұ�
        (2)����� Ʈ����
           - �̺�Ʈ�� ���Ե� �� �ึ�� Ʈ���� �߻�
           - 'for each row' ���
           - when ���� ��밡��
           - �ǻ緹�ڵ�(:new :old) ��� 
           
��)��å���̺�(jobs)�� ���� �ڷḦ �߰��ϰ� �߰� �۾��� ����� �� '���ο� ��å�ڵ尡 �߰� �Ǿ���' �̶�� �޼����� ����ϴ� Ʈ���� �ۼ�
    (�ڷ�)
    job_id  : java_pg
    job_title : java application programmer
    min_salary : 3500
    max_salary : 12000
    create/update_data : ���ó�¹
    
    create trigger tg_jobs_insert
        after insert on jobs
    begin 
        dbms_output.put_line('���ο� ��å�ڵ尡 �߰��Ǿ���')
    end;
    
    insert into job valuse('java_pg', 'java application programmer', 3500,12000, sysdate, sysdate);
    
    select * from jobs;
    
    rollback;
    
    **������ Ʈ���� Ȯ��
    select trigger_name from user_triggers;
    --�ƴ� ���� ������ 'Ʈ����'�� ������ Ȯ��!
    
   ��) ������ 2005�� 8�� 1���̶�� �����ϰ� ��ǰ�ڵ� 'P201000001'�� ��ǰ�� 50�� �԰� ���� �� 
    ���������̺��� �������� �����ϴ� Ʈ���� �ۼ�
    ��, P201000001�� ���԰����� 21000����

CREATE TRIGGER TG_REMAIN_UPDATE
  AFTER INSERT ON BUYPROD
  FOR EACH ROW --�� �ึ�� ����Ǳ⶧��
BEGIN 
  UPDATE REMAIN
     SET REMAIN_I=REMAIN_I+:NEW.BUY_QTY,
         REMAIN_J_99=REMAIN_J_99+:NEW.BUY_QTY, --��������� + ���԰����
         REMAIN_DATE=TO_DATE('20050801')
   WHERE REMAIN_YEAR='2005'
     AND REMAIN_PROD=:NEW.BUY_PROD;
     
  COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('���ܹ߻� : '||SQLERRM);
END;

DROP TRIGGER TG_REMAIN_UPDATE;

SELECT REMAIN_PROD, REMAIN_I, REMAIN_J_99 FROM REMAIN
 WHERE REMAIN_YEAR='2005' AND REMAIN_PROD='P201000001';

INSERT INTO BUYPROD VALUES('20050801','P201000001',50,21000);
SELECT * FROM BUYPROD WHERE BUY_DATE='20050801'
    

��) 2005�� 7�� 29�� 'g001'ȸ���� ��ǰ�ڵ� 'P201000019'��ǰ�� 2�� ������ ��� ���������̺��� �����Ͻÿ�
    (Ȯ��)
    select * from remain where remain_year = '2005' and remain_prod = 'P201000019';
    
    (cart ���̺� insert)          :new.cart_number                :new.cart_qty
    insert into cart values('g001','2005072900001', 'P201000019',2);
                                    :new.cart_member    :new.cart_prod
    (Ʈ����)
    create or replace trigger tg_remain_02
     after insert or update or delete on cart --�߸�װ����� ���ɽ� 
     for each row
    declare 
        v_qty number := 0;
        v_id prod.prod_id %type; --�̷� Ÿ���̴�
    begin
        if inserting then
        v_qty := :new.cart_qty;
        v_id := :new.cart_prod;
    elsif updating then
        v_qty := :new.cart_qty - :old.cart_qty;
        v_id := :new.cart_prod;
    elsif deleting then --delete�� �޴ٸ�!
        v_qty := :new.cart_qty - :old.cart_qty;
        v_id := :new.cart_prod;
    end if;
    
    update remain
        set remain_o = remain_o + v_qty,
            remain_j_99 = remain_j_99 - v_qty,
            remain_date = to_date(substr(:new.cart_no,1,8))
      where remain_year = '2005'
        and remain_prod = v_id;
        
    exception 
        when others then
            dbms_output.put_line('���ܹ߻� : ' ||sqlerrm);
    end;
    
    (2)Ʈ���� �ǻ緹�ڵ�(psuedo record) - ����� Ʈ���ſ����� ���
    --����Ŭ���� ���� ���ڵ� 
        (i) :new
            .insert�� update �Ժ�Ʈ������ ���
            .�����̳� ���ŵ� ���ο� �ڷḦ ��Ī
            .delete �ÿ��� ��� null ������ setting
        (ii) :old
            .delete �� update �̺�Ʈ�� ���
            .�����ǰų� ���ŵ��ڷḦ ��Ī
            .insert �ÿ��� ��� null ������ setting
            
    (3)�̺�Ʈ ������ �����ϱ� ���� Ʈ���� �Լ�
        (i)inserting :  �̺����� insert �����̸� ��(true)�� ��ȯ
        (ii)updating :  �̺����� update �����̸� ��(true)�� ��ȯ
        (iii)deleting :  �̺����� delete �����̸� ��(true)�� ��ȯ
    
��)������̺��� �����ڸ� ó���ϱ� ���� retire ���̺��� ������ ���� �����Ͻÿ�
    ���̺�� : retire 
    �÷�
    (1) employee_id     number(6)   n.n     pk&fk
    (2) department_id   number(6)           
    (3) job_id          varchar2(10)        
    
    create table retire(
    employee_id number(6) not null,
    department_id number(6),
    job_id varchar2(10),    
    
constraint pk_retire primary key (employee_id),
constraint fk_retire foreign key (employee_id)
references employees(employee_id));
    

����)������̺��� �ټӿ����� 22�� �̻�� ������� ���� ��¥�� ���� ó���ϰ� 
     �����ڴ� ������ ���̺��� �߰� �����ϴ� Ʈ���� �ۼ� 
    
    ----------------------����
    delete employees

    create or replace trigger tg_retire_01
        after update on employees
        for each row
    begin
        insert into retire values(:new.employee_id, :new.department_id, :new.job_id);
    end;
    
    
    select 
    
        
    