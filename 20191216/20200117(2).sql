2020-01-17  02) ������/������ ��������
    - ���������� ����� �ϳ��� ������ ��ȯ�Ǵ� ��������
    - ���迬����(=, >, <, >=, <=, !=)�� ���
    
��)������̺��� 50�� �μ��� ���� ����� �ִ� �޿����� �� ���� �޿��� �޴� ����� ���Ͻÿ�
    Alias �����ȣ, �����, �μ���, ��å��, �޿�
    
    (1)��������
    select a.employee_id as �����ȣ,
           b.department_name as �����,
           a.emp_name as �μ���, 
           c.job_title as ��å��, 
           a.salary sa�޿�
      from employees a, departments b, jobs c
     where a.department_id = b.department_id --��������//�μ���
       and a.job_id = c.job_id --��������//��å��
       and a.salary >= (50�� �μ��� �ִ�޿�)
        
    (2)�������� - 50���μ��� ���� ��� �� �ִ� �޿�
    select max(salary)
      from employees
     where department_id = 50;
    
    (3)����
    select a.employee_id as �����ȣ,
           b.department_name as �μ���,
           a.emp_name as �����, 
           c.job_title as ��å��, 
           a.salary sa�޿�
      from employees a, departments b, jobs c
     where a.department_id = b.department_id --��������//�μ���
       and a.job_id = c.job_id --��������//��å��
       and a.salary >= (select max(salary)
                          from employees
                         where department_id = 50);
                        
��)2005�� 5�� ��ٱ��� ���̺��� �ִ뱸�ż����� ȸ�������� ��Þ���̿�
    subquery���� ȸ����ȣ, ȸ����, ��ǰ�� --(1)
    subquery���� ȸ����ȣ, ȸ����, ��ǰ��, �ִ뱸�ż��� --(2)
    --3�� �� �ȵ�
    (1)subquery���� ȸ����ȣ, ȸ����, ��ǰ�� --(1)
    select (select mem_id 
              from member
             where mem_id = cart_prod) as ȸ����ȣ, 
           (select mem_name
              from member 
             where mem_id = cart_prod)as ȸ����, 
           (select prod_name
              from prod
           cart_prod = prod_id)as ��ǰ��
      from members a, prod b, cart c
     where cart_no like '200505%'
       and cart_qty =(select max cart_qty
                        from cart); -- ��� �̰� Ʋ�� �ڵ忹��
           
           
            
        select c.cart_member  as ȸ����ȣ, 
               a.mem_name as ȸ����, 
               b.prod_name as ��ǰ��
          from member a, prod b, cart c
         where a.mem_id = c.cart_member
           and b.prod_id = c.cart_prod
           and c.cart_no like '200505%'
           and c.cart_qty =(select max(cart_qty)
                              from cart);
            
            
    select c.cart_member  as ȸ����ȣ, 
           a.mem_name as ȸ����, 
           b.prod_name as ��ǰ��,
           d.mqty as �ִ뱸�ż���
      from member a, prod b, cart c, (select max(cart_qty) as mqty
                                        from cart
                                       where cart_no like '200505%') d
     where a.mem_id = c.cart_member
       and b.prod_id = c.cart_prod
       and c.cart_no like '200505%'
       and c.cart_qty = d.mqty;
            
            
��)2005�� 5�� ��� ȸ���� ���ż��� ��, ���űݾ� ���� ���Ͻÿ�
    ��, ansi outer join �� ������� ����
        ���ž� ���� ����� 5�� ��ȸ�Ұ�
    Alias �� ȸ����ȣ,���ż���
    
    select cart_member as ȸ����ȣ, 
           sum(cart_qty) as ���ż��� 
      from cart
     where cart_no like '200505%'
       and rownum <= 5
     group by cart_memeber
     order by 2 desc;
        
    select cart_qty as ���ż��� 
      from cart
     where cart_no like '200505%'
       and rownum <= 5
     group by cart_memeber
     order by 2 desc;
            
__________________________________________________________________________________�ϼ�     
 select a.cart_member as ȸ����ȣ,
        b.sqty as ���ż���
   from (select distinct cart_member
           from cart
          where cart_no like '200505%') a, 
        (select cart_member, sum(cart_qty) as sqty
           from cart
          where cart_no like '200505%'
          group by cart_member
          order by 2 desc) b
  where a.cart_member = b.cart_member
    and rownum <= 5;
    
    
        
    
    
        
    
    
        