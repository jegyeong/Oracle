2019-12-20

1)SELECT ��
    - SELECT ������ �÷��� ��� '*(�ƽ�Ʈ����)'�� ����ϸ� ��� Į���� ��ȸ
    - WHERE���� �����Ǹ� ���̺� ���� ��� ���� ��ȸ
    
��) ȸ�����̺�(member)�� ��� ȸ���� ��� �ڷḦ ��ȸ�Ͻÿ�
 select * from member; 
 
  select * from cart; --ó���� 50����� �ߴµ� ��ũ�ѹٸ� ������ �� ���� ���� 
  
  ��) ȸ�����̺�(member)���� ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ��ȸ�Ͻÿ�
  select mem_id as ȸ����ȣ,
         mem_name as ȸ����,                        --|| �հ��ڸ� �ٿ���
         mem_add1 ||' '||mem_add2 as "��    ��",     --�ֵ���ǥ �Ƚ��� ���� �Ͼ/������ �����ڷ� �ν��ϱ⶧��
         mem_mileage ���ϸ���
    from member ;
        from member;  --- �� �ȵ���
        
        
  ��) ȸ�����̺�(member)���� �������� ������ ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ��ȸ�Ͻÿ�
    select  mem_id as ȸ����ȣ,
            mem_name as ȸ����,                        --|| �հ��ڸ� �ٿ���
            mem_add1 ||' '||mem_add2 as "��    ��",     --�ֵ���ǥ �Ƚ��� ���� �Ͼ/������ �����ڷ� �ν��ϱ⶧��
            mem_mileage ���ϸ���
    from member;
        from member;  --- �� �ȵ���
    where mem_add1 like '����%';   ---���Ǻ����ϱ� / % ������ �ڿ� ��� �͵� �������
                
                
 ��) ȸ�����̺�(member)���� �������� �ߺ����� ���� ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ��ȸ�Ͻÿ�
    select ȸ����ȣ, ȸ����, �ּ�, ���ϸ���
    from member mem_id as ȸ����ȣ,
                mem_name as ȸ����,                        --|| �հ��ڸ� �ٿ���
                mem_add1 ||' '||mem_add2 as "��    ��",     --�ֵ���ǥ �Ƚ��� ���� �Ͼ/������ �����ڷ� �ν��ϱ⶧��
                mem_mileage ���ϸ���
        from member;  --- �� �ȵ���
    where mem_add1 like '����%';   ---���Ǻ����ϱ� / % ������ �ڿ� ��� �͵� �������
    
    
 ��) ȸ�����̺�(member)���� ���ֵ��ø� ��ȸ
    select distinct sub(mem_add1, 1,2)
        from member;
        
        
        ---lprod ? ??/ id ����/gu�� �з��ڵ�/nm �з���

   --prod stock +total ��ü���/ +proper �������/ 
   --department Id�μ��ڵ� / parent ���� �μ��ڵ� /
   --???
        

��) ��ǰ���̺�(prod)���� �ŷ�ó�ڵ带 ��ȸ�ϼ���
    select prod_buyer as  �ŷ�ó�ڵ� -- ���⿡�� �ݷҸ�  / from ���� ���̺�!�� �� �� �ִ�! 
                                    --���� ���� ���صǴ°��� from�� > where �� > select �� �� ������ ����ȴ�>
                                    --��Ī�� from �̳� where ������ �� �� ����
        from prod;

��) ��ǰ���̺�(prod)���� �ŷ�ó�ڵ带 �ߺ����� �ʰ� ��ȸ�ϼ���
     select distinct prod_buyer as  �ŷ�ó�ڵ� 
        from prod
    order by 1 asc; --���ʴ�� ����ϰ� ���ؼ� asc�� ���� ����
    
    
    1) where �� 
        -�ο��� ������ ó���Ҷ� ���
        (�������)
        where �÷��� ������ expr[and|or]{ �÷��� ������ expr....]
            - '������' : ���迬����( >, <, =, >= , <=, !=(<>)) --���� �ʴ� != / <> ���� �� ������� 
            
��)ȸ�����̺��� ���ϸ����� 3000�̻���(����> where��) ȸ���� ��ȸ�Ͻÿ�
    Alias �� ȸ����ȣ, ȸ����, ����, ���ϸ��� -- Alias > ����� Į���� �ǹ��ϴ°�
    
select ȸ����ȣ(mem_id), ȸ����, ����, ���ϸ���  --���̺��� �÷��� 
select mem_id as ȸ����ȣ,
       mem_name as ȸ����,
       mem_job as ����,
       mem_mileage as ���ϸ���
    from member
  where mem_mileage>=3000; --���� ���� ���ذ�
       
       
            
��)ȸ�����̺��� ���ϸ����� 3000�̻���(����> where��) ȸ���� ��ȸ�ϵ�, ���ϸ����� ū �������(����) ����Ͻÿ�
    Alias �� ȸ����ȣ, ȸ����, ����, ���ϸ���
    
select mem_id as ȸ����ȣ,
       mem_name as ȸ����,
       mem_job as ����,
       mem_mileage as ���ϸ���
    from member
  where mem_mileage>=3000
  order by mem_mileage desc, 2;--order by �������� �ϳ��̻� �� �� �־�! ���ϸ��� ������ �����ϰ�, 2>�� �Ȱ��� ����� ������ �̸� ������ ����Ͻʽÿ�
  
��) ȸ�����̺��� 12���� ������ ȸ���� ��ȸ�Ͻÿ�
    Alias ȸ����ȣ, ȸ����, ������Ͽ��� ���� ������
    
select mem_id as ȸ����ȣ, 
       mem_name as ȸ����, 
       mem_bir as ������� --date Ÿ��
    from member 
 where extract(month from mem_bir) = 12;--�÷�����  date Ÿ���϶� ���� �̾Ƴ�����! 
 

��) ��ǰ���̺��� �ǸŰ��� 10��������(100000~199999 ��ǰ�� ��ȸ�Ͻÿ�
    Alisa ��ǰ��ȣ, ��ǰ��, �ǸŰ�
select prod_id as ��ǰ��ȣ,
       prod_name as ��ǰ��,
       prod_price as �ǸŰ�
    from prod 
--where prod_price >= 100000 and prod_price <= 199999;   --&&�� �ƴ϶� �׳� and �����
--where prod_price >= 100000 and prod_price < 200000;  
   where prod_price between 100000 and 199999; 
   ----where not prod_price between 100000 and 199999;   �̷��� ���� �̺κκи� ���ܵ�!
   
��) ��ǰ���̺��� �ŷ�ó�ڵ尡 p10201 �̰ų� p30203�� ��ǰ������ ��ȸ�Ͻÿ�
    Alisa�� ��ǰ��ȣ, ��ǰ��, ���԰�, �ŷ�ó�ڵ�
select prod_id as ��ǰ��ȣ,
       prod_name as ��ǰ��,
       prod_cost as �ǸŰ�,
       prod_buyer as "�ŷ�ó �ڵ�"
     from prod
    where prod_buyer = 'P10201' or prod_buyer = 'P30203'; --���ڿ� �������� ���� ����ǥ char �̴ϱ� 

 2)��������
    - and, or, not 
    - and : ����
        ����1 and ����2 : '����1'�� '����2' �� ���� ��쿡�� ��ü ����� ���̴�
    - or : ����
        ����1 or ����2 : '����1'�� '����2' �߿��� �ϳ��� ���̸� ��ü ����� ���̴�
    - not : ������
        not(!) ���� : '����'�� ����� �ݴ� ���� ��ȯ
    - ������� : not > and > or �����̴�!
    
    age=>20 or age<=30 and gender='����' >>> 30��� ���� ����ã�� > �״����� 20����

    
 3)��Ÿ������(in, any, some, all, exists between, like...)  --������ �����ڴ� �Լ��� �����ȴ�
 
    (1) in ������
     - �־��� �ڷ� �� ��� �ϳ��� ��ġ�ϸ� ��ü ����� ���� ��ȯ
     (�������)
     �÷��� in (��1, ��2,...)
     - or �����ڷ� ġȯ ����  --��1 or ��2 or ...  �̷������� �ᵵ �Ǵµ�, in���� �ٿ��� ������ ���ϴϱ�
     
��) ��ǰ���̺��� ��ǰ �з��ڵ尡 'p101', 'p201', 'p301' �� ���� �ڷḦ ��ȸ�Ͻÿ�
    Alias ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �ǸŰ����̴�
    (or ������ ���)
    select prod_id as ��ǰ�ڵ�,
           prod_name as ��ǰ��,
           prod_lgu as �з��ڵ�,
           prod_price as �ǸŰ���
        from prod
      where prod_lgu='P101' or prod_lgu='P201' or prod_lgu='P301';
      
      select prod_id as ��ǰ�ڵ�,
           prod_name as ��ǰ��,
           prod_lgu as �з��ڵ�,
           prod_price as �ǸŰ���
        from prod
      where prod_lgu in ('P101', 'P201', 'P301'); 
  
   
** in, any, some, all �����ڴ� Subquery�� ���� ����
    - in ���� '( )' �� ���� �� Ȯ���� ���
��)��ǰ���̺��� ���� �з��ڵ�� �з����� ����Ͻÿ�
  select �з��ڵ�� �з���, 
  select LPROD_GU AS �з��ڵ��,
         LPROD_NM AS �з���
    FROM LPROD                                     --1ST�� ����� 
   WHERE LPROD_GU IN (SELECT PROD_LGU FROM PROD);  --�ϴ� ������ �ͼ� �и��� �ض� 
   
   --���� FROM���� �״��� WHERE 
   
   
    (2) ANY ������
     - ����� IN�� ����, �ٸ� ��������� �ٸ�
     (�������)
     �÷��� ���迬���� ANY (��1, ��2, ��3, ....)
     - IN �����ڸ� ANY�� ��ȯ�ϸ� '=ANY'�̴�
     
��) ��ǰ���̺��� ��ǰ �з��ڵ尡 'p101', 'p201', 'p301' �� ���� �ڷḦ ��ȸ�Ͻÿ�
    Alias ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �ǸŰ����̴�
    
    (ANY ������ ���)
      select prod_id as ��ǰ�ڵ�,
           prod_name as ��ǰ��,
           prod_lgu as �з��ڵ�,
           prod_price as �ǸŰ���
        from prod
      where prod_lgu =ANY ('P101', 'P201', 'P301');  
     --IN�� ���迬���ڸ� ��������  ANY�� ���迬���ڸ� �Բ��� �� �ִ�
--     where prod_lgu >ANY ('P101', 'P201', 'P301');   --�̷��� ���� p101���� ū �ڸ��� ��� ��µȴ�
--     where prod_lgu >'P101';    --���� �����̶� �Ȱ�������� ����ȴ�

    select LPROD_GU AS �з��ڵ��,
         LPROD_NM AS �з���
    FROM LPROD                                     --1ST�� ����� 
   WHERE LPROD_GU  exists (SELECT PROD_LGU FROM PROD);  -- exists �ݵ�� ���������� �Բ� ���!
   
   
   (3)between ������
    - ������ ������ �� ���
    - and �����ڷ� ġȯ����
    (�������)
     �÷��� between ��1 and ��2
        - '��1' ���� '��2' ������ ����

��) ȸ�����̺��� ���̰� 40���� ȸ���� ��ȸ�Ͻÿ�
    Alias�� ȸ����ȣ, ȸ����, ����, �������
    
--(and ������ �̿�)
select mem_id as ȸ����ȣ, 
       mem_name as ȸ����, 
       extract (year from sysdate) - extract(year from mem_bir) as ����, 
       mem_bir as �������  
    from member 
    where extract(year from sysdate) - extract(year from mem_bir) > 40 and
          extract(year from sysdate) - extract(year from mem_bir) <50;
 
 --(between ������ �̿�)         
select mem_id as ȸ����ȣ, 
       mem_name as ȸ����, 
       extract (year from sysdate) - extract(year from mem_bir) as ����, 
       mem_bir as �������  
    from member 
    where extract (year from sysdate) - extract(year from mem_bir) between 40 and 49;
          
    

   
        
            
                              
  