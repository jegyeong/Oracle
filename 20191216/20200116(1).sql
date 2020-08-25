2020-01-16  01)�ܺ�����(outer join)
    - ���� ����(inner join, equal-join)������ ���������� �������� �ʤ��� �����ʹ� �˻����� ����
    - �ܺ����ο����� ���ڶ�� ���̺� null ���� �����Ͽ� ��� ���� �˻� �ǵ��� ��ȸ�ϴ� ���
    - �������� ����(���� ��)�� �ƴ϶� ������ ����
    --�������� �����ϸ� ������ �ڷḦ �������� �ؼ� ���� ����� ����? > �����ʱ���
    --�ܺ����� ������ �ʿ� null�� �� �ְ� ���� >������ ����
    --��ü �ڷῡ ���ؼ�, ��� �ڷῡ ���ؼ� ��� ���� �ܺ������� ���� 
    --������ ���� ���� ���� ������ �ƴϴ�! > �������� ���ٴ� ��
    
    (�������-�Ϲ� outer join)
    - ���� ���ǽĿ��� ������ ���� �÷��� �ڿ� '(+)' �����ڸ� �߰�
        select �÷��� list
          from ���̺� list
         where �÷��� = �÷��� (+)....
         
    (�������- Ansi outer join)
        select �÷��� list
          from ���̺�1 list
          left|right|full [outer] join ���̺��2 on(�������� [ --left|right|full ���� �������� ������ ���� 
          --left�� ���̺� 1�� ���̺�2 ���� ������  ���ʴ� �����ϸ� full
          and �Ϲ�����...] -- ���̺�� 1�� 2�� ���ѵ� ���̸� and �ڿ��ٰ� ����
                :
         [where �Ϲ�����] --�Ѱ�����
         
    (���ǻ���)
    - 3�� �̻��� ���̺��� ���Ǵ� ��� ��� �ܺ������� ��� ��� �������ǿ� '(+)' �����ڸ� ����ؾ���
    - �ѹ��� �� ���̺� ���ؼ��� �ܺ������� �� �� ����. ��, a, b, c ���̺��� ������� �ܺ� ������ �����ϴ� ��� a�� 
      �������� b���̺��� �ܺ��������� ���܎O���ٸ� c�� �������� b���̺� �ܺ������� ������ �� ����
    - '(+)' �����ڰ� ���� ���ǰ� �ٸ� ������ or �����ڷ� ���ս�ų �� ����
    - '(+)' �����ڴ� IN �����ڿ� ���� ����� �� ���� 
    -- ��ȣ�ȿ� + �� �ѹ���!
    - �Ϲ� �ܺ����� ���ǰ� �Ϲ������� ���ÿ� ����Ǹ� �ܺ������� ������� ����
      (���� ���ΰ���� ��ȯ�� - �ذ������� subQuery�� Ansi outer join�� ����ؾ���)
         
    ��)��ǰ���̺�� �з����̺��� �̿��Ͽ� ��ü �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�
       Alias �� �з��ڵ�, �з���, ��ǰ�� ���̴�
       select count(*) from lprod;
       
       select count(*) (distinct prod_lgu) from prod;
       
       (��������)
       select a.lprod_gu as �з��ڵ�, 
              a.lprod_nm as �з���, 
              count(*) as ��ǰ�Ǽ�
        from lprod a, prod b
        where a.lprod_gu = b.prod_lgu
        group by a.lprod_gu, a.lprod_nm;
        
        (�ܺ�����)
        select a.lprod_gu as �з��ڵ�, 
               a.lprod_nm as �з���, 
               --count(*) as ��ǰ�Ǽ�
               count(prod_id) as ��ǰ�Ǽ�
        from lprod a, prod b
        where a.lprod_gu = b.prod_lgu(+)
        group by a.lprod_gu, a.lprod_nm
        order by 1;
        
        (Ansi ����)
        select a.lprod_gu as �з��ڵ�, 
               a.lprod_nm as �з���, 
               --count(*) as ��ǰ�Ǽ�
               count(prod_id) as ��ǰ�Ǽ�
        from lprod a
        left outer join prod b on (a.lprod_gu = b.prod_lgu)
        group by a.lprod_gu, a.lprod_nm
        order by 1;
        
        ��)2005�� 6�� ���������� ��ȸ�ϵ� ��� ��ǰ�� �������� ��ȸ�Ͻÿ�
        --���, ���ΰ� ���� �ƿ��������̴�!
        (��������)
        select a.prod_name as ��ǰ��,
               sum(b.cart_qty) as �Ǹż���,
               sum(b.cart_qty * a.prod_price) as �Ǹűݾ�
            from prod a, cart b
            where a.prod_id = b.cart_prod
              and substr(b.cart_no,1,6) = '200506'
            group by a.prod_name;
        
        (�ܺ�����-�Ϲ�)
        select a.prod_name as ��ǰ��,
               sum(b.cart_qty) as �Ǹż���,
               sum(b.cart_qty * a.prod_price) as �Ǹűݾ�
            from prod a, cart b
            where a.prod_id = b.cart_prod(+)
              and substr(cart_no,1,6) = '200506'
            group by a.prod_name;
            --�ȳ���
            --Ansi�� ���������� �����
            
        (�ܺ�����-Ansi)
        select a.prod_name as ��ǰ��,
               nvl(sum(b.cart_qty),0) as �Ǹż���,
               nvl(sum(b.cart_qty * a.prod_price), 0) as �Ǹűݾ�
            from prod a
            left outer join cart b on (a.prod_id = b.cart_prod
              and b.cart_no like '200506%')
            group by a.prod_name;
            
        (subquery )
        select b.prod_name as  ��ǰ��,
               nvl(a.qamt,0) as �Ǹż���,
               nvl(mamt, 0) as �Ǹűݾ�
         from (select cart_prod,
                      sum(cart_qty) as qamt,
                      sum(cart_qty * prod_price) as mamt
                     from cart, prod
                    where cart_prod = prod_id
                      and cart_no like '200506%'
                 group by cart_prod) a, prod b;
          --��ȣ���� �������� 
          --���������� �����ص� ���� �Ǿ����!
            
        ��) 2005�� 6�� ���������� ��ȸ�ϵ� ��� ��ǰ�� �������� ��ȸ
            Alias ��ǰ��, ���Լ���, ���űݾ�
            (��������)
            select a.prod_name as ��ǰ��, 
                   sum(b.buy_qty) as ���Լ���, 
                   sum (b.buy_qty * b.buy_cost) as ���űݾ�
            from prod a, buyprod b
           where a.prod_id = b.buy_prod
             and substr(b.buy_date, 1, 7) = '2005/06'
            group by a.prod_name;
   

            (�ܺ�����-Ansi)--�ȵ�
         select a.prod_name as ��ǰ��, 
                nvl(sum(b.buy_qty),0) as ���Լ���, 
                nvl(sum(b.buy_qty * b.buy_cost),0) as ���űݾ�
            from prod a 
            left join buyprod b on (a.prod_id = b.buy_prod
            and substr(b.buy_date, 1, 7) = '2005/06')
            group by a.prod_name
            order by 3 desc;
            
         ��) ������̺��� ��� �μ��� ���� ������� ��ȸ�ϴ� ������ �弮�϶�
            Alias �� �μ��ڵ�, �μ���, �����
            
            select departments.department_id as �μ��ڵ�,
                   departments.department_name as �μ���,
                   count(employees.employee_id) as �����
                from employees 
                full outer join departments on (departments.department_id = employees.department_id)
                group by departments.department_id, departments.department_name;
                
        ��)2005�� 5���� ��ü��ǰ�� ���Ͽ� ��,��� ��Ȳ�� ��ȸ�Ͻÿ�
            Alias �� ��ǰ�ڵ�, ��ǰ��, �԰�, ���
        
            --��Ȯ�� ���� �ȳ���       
            select c.prod_id as ��ǰ�ڵ�,  --prod ���̺� ���� �ٸ� ���̺����� ���� ������ ����
                   c.prod_name as ��ǰ��, 
                   sum(a.buy_qty) as �԰�, 
                   sum(b.cart_qty) as ���
            from prod c  
            left outer join buyprod a on (a.buy_prod = c.prod_id)
            left outer join cart b on (b.cart_prod = c.prod_id) 
           where substr(b.cart_no,1,6) = '200505'
            group by c.prod_id, c.prod_name;
          
            
        select b.prod_id as ��ǰ�ڵ�,
               b.prod_name as ��ǰ��,
               nvl(sum (a.buy_qty),0) as �԰�,
               nvl(sum(c.cart_qty),0) as ���
        from buyprod a
        right outer join prod b (a.buy_prod = b.prod_id
          and  a.buy_date between '20050501' and '20050531') 
        left outer join cart c on (c.cart_prod = b.prod_id
            and c.cart_no like '200505%'
        group by b.prod_id, b.prod_name)
        order by 1;
        --���� �ϳ��ϳ������ �ϴµ� �ȵ�
                  
        
        
     
        
        
            
        
        


    
    