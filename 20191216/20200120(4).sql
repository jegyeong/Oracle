2020-01-20  03)���տ�����

2020-01-21- 01)����(set)
    - union, union all, intersect, minus
    - �� select ���� ���� �÷��� ���� ������ Ÿ���� �����ؾ���
    - ��������� �Ǿտ� ����� select ���� ������ ��
    - ��뷮 ������Ÿ��(blob, clob, bfile ��)�� ��� �Ұ�
    - order by ���� �� ������ query �������� ��� ���� 
    

    
 1) union, union all
    - �������� ����� ��ȯ
    - union �� �ߺ�����, union all �� �ߺ� ���
��) ȸ�����̺��� ������ �ڿ����̰� �ְ����� ������ ȸ�������� ���տ����ڸ� ����Ͽ� ��ȸ�Ͻÿ�
   Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ����
   
   (������ �ڿ���)
   select mem_id as ȸ����ȣ, 
          mem_name as ȸ����, 
          mem_mileage as ���ϸ���, 
          mem_job as ����
    from member
   where mem_job = '�ڿ���'
    -----------------------------------------------------   
   (�ְ����� ����)
   select mem_id as ȸ����ȣ, 
          mem_name as ȸ����, 
          mem_mileage as ���ϸ���, 
          mem_job as ����,
          substr(mem_add1,1,2) as ������
    from member
   where mem_add1 like '����%'
    -----------------------------------------------------
 (union ���)
 select mem_id as ȸ����ȣ,
       mem_name as ȸ����,
       mem_mileage as ���ϸ���,
       mem_job as ����,
       substr(mem_add1,1,2) as  ������
    from member
    where mem_job='�ڿ���'
    
    union
    
    select mem_id as ȸ����ȣ,
       mem_name as ȸ����,
       mem_mileage as ���ϸ���,
       mem_job as ����,
       substr(mem_add1,1,2) as  ������
    from member
    where mem_add1 like '����%'
    order by 1;
    -----------------------------------------------------    
    
       (or ������)
 select mem_id as ȸ����ȣ,
       mem_name as ȸ����,
       mem_mileage as ���ϸ���,
       mem_job as ����,
       substr(mem_add1,1,2) as  ������
    from member
    where mem_add1 like '����%'or mem_job='�ڿ���'
    order by 1;
    
    -----------------------------------------------------
     (union all ���)
 select mem_id as ȸ����ȣ,
       mem_name as ȸ����,
       mem_mileage as ���ϸ���,
       mem_job as ����,
       substr(mem_add1,1,2) as  ������
    from member
    where mem_job='�ڿ���'
    
    union all
    
    select mem_id as ȸ����ȣ,
       mem_name as ȸ����,
       mem_mileage as ���ϸ���,
       mem_job as ����,
       substr(mem_add1,1,2) as  ������
    from member
    where mem_add1 like '����%'
    order by 1;
    
    
 ��) ������̺�, �μ����̺�, ��å���̺��� ���̺��̸�, ���̺���, �ڷ���� ����ϴ� ������ �ۼ��Ͻÿ�
   
   select 'EMPLOYEES' as ���̺��,
          '������̺�' as "���̺� ����",
          count(*) as �ڷ��
     from employees

    union

    select 'DPARTMENTS' as ���̺��,
          '�μ����̺�' as "���̺� ����",
          count(*) as �ڷ��
     from departments
     
     union
     
     select 'JOBS' as ���̺��,
          '��å���̺�' as "���̺� ����",
          count(*) as �ڷ��
     from jobs;

��) 2005�� 2���� ���ŵ� ���İ� 2005�� 4���� ���ŵ� ��ǰ�� ��� ��ȸ�Ͻÿ�
Alias�� ��ǰ��ȣ, ��ǰ��, ���ż�����

select buy_prod as ��ǰ��ȣ, 
       prod_name as ��ǰ��, 
       sum(buy_qty) as ���ż�����
  from buyprod, prod
 where buy_prod = prod_id
   and buy_date between '20050201' and '20050228'
 group by buy_prod, prod_name
 
 union all
 
select buy_prod as ��ǰ��ȣ, 
       prod_name as ��ǰ��, 
       sum(buy_qty) as ���ż�����
  from buyprod, prod
 where buy_prod = prod_id
   and buy_date between '20050401' and '20050430'
 group by buy_prod, prod_name
 order by 1;
 
 
 2)intersect
    - ������(���� �κ�)�� ��ȯ

��)2005�� 4���� �Ǹŵ� ��ǰ�̸鼭 2005�� 6������ �Ǹŵ� ��ǰ�� ��� ��ȸ�Ͻÿ�
    Alias ��ǰ��ȣ, ��ǰ��, �Ǹż�����
    select cart_prod as ��ǰ��ȣ, 
           prod_name as ��ǰ��, 
           sum(cart_qty) as �Ǹż�����
        from cart, prod
        where cart_no like '200504%'
        and cart_prod = prod_id
        --group by cart_prod, prod_name
        
    intersect  
        
    select cart_prod as ��ǰ��ȣ, 
           prod_name as ��ǰ��, 
           sum(cart_qty) as �Ǹż�����
        from cart, prod
        where cart_no like '200506%'
        and cart_prod = prod_id
        group by cart_prod,  prod_name
        order by 1;
        
 3)minus
    - �������� ��ȯ
    - A minus b : A�� ���� ������� B���� ����� ������ ���� ��ȯ
     (�����ϰ� A���� ���ԵǾ��ִ� ����� ��ȯ)
     
    select cart_prod as ��ǰ��ȣ, 
       prod_name as ��ǰ��
  from cart, prod
 where substr(cart_no, 1, 6) = '200504'
   and cart_prod = prod_id
 group by cart_prod, prod_name
 
 minus
 
 select cart_prod as ��ǰ��ȣ, 
       prod_name as ��ǰ��
  from cart, prod
 where substr(cart_no, 1, 6) = '200506'
   and cart_prod = prod_id
 group by cart_prod, prod_name
 order by 1;
         
    

  