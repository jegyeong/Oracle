2020-01-22  01)�ڷ� ����(delete)
    (�������)
    delete ���̺��
    [where ����]
    - '����'�� ���������� ����ϴ� ��� in(exists) �����ڸ� ����Ͽ� �ټ����� ���� ����
    
    select * from remain2
    where remain_j_00 <= 10;
    
    delete remain2;
    
    delete remain2;
   
   rollback;
   
��)2005�� 3�� �԰�� ��ǰ�ڵ忡 �ش��ϴ� ��ǰ������ remain2 ���̺��� �����Ͻÿ�
     delete remain2
     where remain_prod in (��������)
     
     (��������) 2005�� 3�� �԰�� ��ǰ�� ��ǰ�ڵ�
     select distinct buy_prod
     from buy_prod
     where between '20050301' and '20050331';
     
     (����)
     delete remain2
     where remain_prod in ( select distinct buy_prod
                            from buyprod
                            where buy_date between '20050301' and '20050331');
                            
    rollback;
    
    
    (exists ������ ���)
    delete remain2
     where exists in ( select 1
                            from buyprod
                            where buy_date between '20050301' and '20050331')
                            and remain_prod = buy_prod;
                            
    select count(*) from remain2;
    
    ��)��ٱ��� ���̺��� 2005�� 7�� 19�� �Ǹŵ� ��ǰ�� �ش� �ŷ�ó ������ �����Ͻÿ�
     delete buyer
     where buyer_id in (��������)
     
     (��������) 2005�� 7�� 19�Ͽ� �ǸŵȻ�ǰ�� �ش� �ŷ���ó ����
     select prod_buyer
     from prod, cart 
     where pro_id = cart_prod 
     and cart_no like '20050719%'
     
     (����)
       delete buyprod
     where prod_buyer in (select prod_buyer
                        from prod, cart 
                        where pro_id = cart_prod 
                        and cart_no like '20050719%');