2020-01-15  01)ANSI Inner join ����
    (�������)
    select �÷���...
      from ���̺��
     inner join ���̺��2 on ��������
     --���ε� ����� ���εǾ�����!
      [and �Ϲ�����... > ���̺�1,2���� ���� �����϶�] 
    [inner join ���̺��2 on ��������
    ...]
    [where �Ϲ�����...]
    
��) 2005�� 3�� ��ǰ�� ���������� ��ȸ�Ͻÿ�
    Alias �� ��ǰ��ȣ, ��ǰ��, ���Լ���, ���Աݾ�
    by prod �� ��������
    (�Ϲ�����)
    select a.buy_prod as ��ǰ��ȣ,
           b.prod_name as ��ǰ��,
--           count(*) as ����Ƚ��,
           sum (a.buy_qty) as ���Լ���,
           sum (a.buy_qty * a.buy_cost) as ���Աݾ�
        from buyprod a, prod b
    where a.buy_prod = b.prod_id                        --��������
      and a.buy_date between '20050301' and '20050331'  --�Ϲ�����
    group by a.buy_prod, b.prod_name;
    
    (ANSI ����)
      select a.buy_prod as ��ǰ��ȣ,
           b.prod_name as ��ǰ��,
--           count(*) as ����Ƚ��,
           sum (a.buy_qty) as ���Լ���,
           sum (a.buy_qty * a.buy_cost) as ���Աݾ�
        from buyprod a
        inner join prod b on (a.buy_prod = b.prod_id --��������
         and a.buy_date between '20050301' and '20050331')
        group by a.buy_prod, b.prod_name;
    
��)��ǰ���̺� ����� ��ǰ�� ���Ͽ�  ��ǰ��ȣ, ��ǰ��, �з���, �ŷ�ó����
    ��ȸ�Ͻÿ�
    (�Ϲ�����)
    select a.prod_id as ��ǰ��ȣ,
           a.prod_name as ��ǰ��,
           c.prod_nm as �з�ó, 
           c.buyer_name as �ŷ�ó��
        from prod a, buyer b, lprod c 
        where a.prod_buyer = b.buyer_id
        and a.prod_lgu = c.prod_gu;
    
    (ANSI ����)    
    select a.prod_id as ��ǰ��ȣ,
           a.prod_name as ��ǰ��,
           c.prod_nm as �з�ó,
           c.buyer_name as �ŷ�ó��
        from prod a --�ϳ��� ���
        inner join buyer b on (a.prod_buyer = b.buyer_id) --��������
        inner join lprod c on (a.prod_lgu = c.lprod_gu);  --��������
        
��)2005�⵵ ȸ���� ������� ��ȸ�Ͻÿ�.
    ��, ���԰Ǽ��� 5ȸ�̻��̰� ������� 500���� �̻��� ȸ���� ���Ͽ� 
    ȸ����ȣ, ȸ����, ���ŰǼ�, ���Աݾ��� ��ȸ�Ͻÿ�
    
    select a.mem_id as ȸ����ȣ,
           a.mem_name as ȸ����,
           count(*) as ���ŰǼ�,          
           sum (b.prod_price * c.cart_qty) as ���Աݾ�
        from member a, prod b, cart c
    where a.mem_id = c.cart_member
      and c.cart_prod = b.prod_id
      and substr(cart_no,1,4) = '2005'
       group by a.mem_id, a.mem_name
      having count(*) >= 5 and sum(b.prod_price * c.cart_qty) >= 5000000
      order by 4 desc;
    
    (ANSI)  
         select a.mem_id as ȸ����ȣ,
           a.mem_name as ȸ����,
           count(*) as ���ŰǼ�,          
           sum (b.prod_price * c.cart_qty) as ���Աݾ�
        from member a
        inner join cart c on (a.mem_id = c.cart_member) 
        inner join prod b on (c.cart_prod = b.prod_id)
        and c.cart_prod = b.prod_id
        and substr(cart_no,1,4) = '2005'
        group by a.mem_id, a.mem_name --�����Լ��� �Ϲ�Į���� �ײ���� �׻�����
        having count(*) >= 5 and sum(b.prod_price * c.cart_qty) >= 5000000
        order by 1;
        --�����Լ��� having �� ! 
        --select from where groupby having by, oder by ������ 

-------------------------------------------------------------------------------------------        
��)2008�⵵ ȸ���� ������� ��ȸ�Ͻÿ�. ��, ���ŰǼ��� 5ȸ �̻��̰�, ������� 500���� �̻��� ȸ���� ���Ͽ� 
    Alias �� ȸ����ȣ, ȸ����, ���ŰǼ�, ���Աݾ�
    
    select c.mem_id as ȸ����ȣ,
           c.mem_name as ȸ����,
           count(*) as ���ŰǼ�, --inner join �϶��� �ƽ�Ʈ���� �� �� ����!
           sum(b.prod_price * a.cart_qty) as ���űݾ�
     from cart a, prod b, member c
     where substr(a.cart_no,1,4) = '2008'
     --where cart_no like '2005%'�� �ᵵ��
     having count(
---------------------------------------------------------------------------------------

��)2005�⵵ �����ڷ�(cart)�� �̿��Ͽ� �ŷ�ó�� ������� ��ȸ�Ͻÿ�
    �ŷ�ó��ȣ, �ŷ�ó��, �ǸŰǼ�, �Ǹűݾ�
     --proud_lgu ��ǰ �з��ڵ���!
    select b.buyer_id as �ŷ�ó��ȣ, 
           b.buyer_name as �ŷ�ó��, 
           count(*) as �ǸŰǼ�, 
           sum(a.cart_qty * c.prod_price)as �Ǹűݾ�
       from cart a, buyer b, prod c
       where a.cart_prod = c.prod_id
         and b.buyer_id = c.prod_buyer
         and substr(a.cart_no,1,4) = '2005'
       group by b.buyer_id, b.buyer_name
       order by 1 desc;
       
       --���輱 �����Ѵ� > �ݵ�� ������ ���´�
       
       (ANSDI)
       select b.buyer_id as �ŷ�ó��ȣ, 
           b.buyer_name as �ŷ�ó��, 
           count(*) as �ǸŰǼ�, 
           sum(a.cart_qty * c.prod_price)as �Ǹűݾ�
       from cart a
       inner join  prod c on (a.cart_prod = c.prod_id)
       inner join buyer b on (b.buyer_id = c.prod_buyer)
       where substr(a.cart_no,1,4) = '2005'
       group by b.buyer_id, b.buyer_name
       order by 1 desc;
       
��)��ٱ��� ���̺��� �ڷḦ Ȱ���Ͽ� 2005�� 5�� ��ǰ �з��� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�
    Alias �з��ڵ�, �з���, �Ǹž��հ�
 (�Ϲ�����)--�ٽýẸ��
    select b.lprod_gu as �з��ڵ�, 
           b.lprod_nm as �з���, 
           sum (c.prod_price * a.cart_qty) as �Ǹž��հ�
      from cart a, lprod b, prod c
      where substr(a.cart_no,1,6) = '200505' 
           --cart_no like '200505%'
       and a.cart_prod = c.prod_id
       and b.lprod_gu = c.prod_lgu
  group by b.lprod_gu, b.lprod_nm;
  
  (ANSI ����)
    select b.lprod_gu as �з��ڵ�, 
           b.lprod_nm as �з���, 
           sum (c.prod_price * a.cart_qty) as �Ǹž��հ�
      from lprod b
     inner join prod c on (b.lprod_gu = c.prod_lgu)
     inner join cart a on (a.cart_prod = c.prod_id)
     where substr(a.cart_no,1,6) = '200505'
  group by c.prod_id, c.prod_lgu;
  
  
  (ANSI)
  select b.lprod_gu as �з��ڵ�, 
           b.lprod_nm as �з���, 
           sum (c.prod_price * a.cart_qty) as �Ǹž��հ�
      from prod c
      inner join cart a on (a.cart_prod = c.prod_id)
      inner join lprod b on (b.lprod_gu = c.prod_lgu) 
      where substr(a.cart_no,1,6) = '200505' 
           --cart_no like '200505%'
   group by b.lprod_gu, b.lprod_nm;
      
       
       
       
       
       
       