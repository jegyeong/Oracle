2020-01-02  2)�����Լ�(�׷��Լ�)

    - �����ڷḦ Ư���׸�(�÷�)�� �������� �׷����� ���� ����ó���� ����--���� ������� �ȵ�
    - SUM, AVG(���), COUNT(����: ���Ǽ�), MIN, MAX--�ڵ��� ���� GROUP BY�� ����, �ȳ����� ��ü���̺��� �ϳ��� ������ 
    - Ư���� ���(���̺� ��ü�� �ϳ��� �׷����� ����)�� �����ϰ� GROUP BY �� �Բ� ����
    - �����Լ��� ������ �ο��Ǹ� WHERE ���� ����ó���� �Ұ����ϸ� �ݵ�� HAVING ���� ó���ؾ��� --WHERE�� �� �� ����
    - GROUP BY ������ ����Ǵ� �׸��� SELECT ������ �����Լ��� ������ ��� �Ϲ� �׸�(�ʼ� ���)�� �׷��� �ʿ��� �Ϲ� �÷����� ����
        --������� > WHERE, GROUP BY > HAVING > ORDER BY �ٲ� �� ���� > ������ �̼������ �����
    - GROUP BY ������ ����Ǵ� �׸������ �׷��� �ٽ� �ұ׷����� ���� --���ʿ��� ���������� �׷��� ��%���� 
    --�׷� > Ư���� �� �� �Ȱ��� ���� ���� �ֵ鳢�� �׷����� ���°�! (�÷��� ���� ������ �ֵ鳢��)
    --select���� ������ 
    --sum ���� �÷����� ������ �� ����
    --�Լ��� �ݵ�� ���� �ǵ�������Ѵ�! > �ݵ�� �Լ��� ����� ��ġ��
    ----select�� from�� �� �ʼ�
    
    
        1)SUM
         - Ư�� Į������ ���� ��ȯ
         (�������)
          SUM(c1)
          - c1 �÷��� ���� ���Ͽ� ��ȯ
          - �������� �÷��� ���� ���� �� ����
        
        ��) ������̺��� ������� �޿� ���� ���Ͻÿ�
        select sum(salary)--���̺� ��ü�� �ϳ��� �׷����� �����ϱ� group by�� �ʿ����
            from employees;
        
        ��) ������̺��� �μ��� ������� �޿� ���� �μ��ڵ� ������ ����Ͻÿ�    
        select departmemt_id,
               sum(salary)
            from employees; --���� | ~ ���� ������ group by�� ���;���
            
        select departmemt_id,
               to_char(sum(salary), '$999,999.9') as �޿���
            from employees
            group by department_id --select���� �Ĵٺ���
            order by 1; --�μ��ڵ� ������ ����Ͻÿ�(ù��°�ϱ� 1�� �ᵵ�ǰ� department_id ���̤� �ᵵ��
            
        ��)��ٱ������̺�(cart)���� 2005�� 6�� ��ǰ�� �Ǹż����հ踦 ���Ͻÿ�
            Alias �� ��ǰ��ȣ, �Ǹż�����  --cart member ȸ����ȣ��!, cart_prod : ��ǰ��ȣ
            select cart_prod as ��ǰ��ȣ,
                   sum(cart_qty) as �Ǹż�����
                from cart --cart �ȿ� �� ���ԵǴϱ� ���̺� 2�� �� �ʿ� ����
                where substr(cart_no, 1, 6) = 200506 --�������� ���̸� �Ǵϱ� 6�ڸ��� �ʿ���
--                like --�̰ɷδ� ��������?
                --���� ���� ���ϴ°��� count�̴�

                group by cart_prod; --�־�����? ��ǰ��~ �̶����� �������ϱ� //��ǰ�� �ٲ����� ����� �ϴϱ�!
                
        
        ��)�������̺�(buyprod)���� 2005�� 4�� ���ں� ���Լ����հ� ���Աݾ����� ���Ͻÿ�
            Alias �� ����, ���Լ�����, ���Աݾ���
            select buy_date as ����,
                   sum(buy_qty) as ���Լ�����,
                   sum(buy_cost * buy_qty) as ���Աݾ���
                from buyprod
--                where substr(buy_date,1,6) = 200504
                where buy_date between to_date('20050401') and to_date('20050430')
                group by buy_date
                order by 1;
        
        
        
 
 2020-01-03 --------------------------------------------------------       
        ��) ȸ�����̺��� ��� ȸ������ ���ϸ��� ���� ���Ͻÿ�
        --group by �ʿ����! �ϳ��� �������
        
        select sum(mem_mileage)
            from member;
        --group by mem_name;
        --group by ���� �ǹ̰� ����Ф� �̷��� ȸ������ �Ǵϱ�
    
        ��) ȸ�����̺��� ���� ȸ������ ���� ���ϸ��� ���� ���Ͻÿ�
         
         select case when (substr(mem_regno2,1,1) = '1' or
                          substr(mem_regno2,1,1) = '3') then '����ȸ��'
                     when (substr(mem_regno2,1,1) = '2' or
                          substr(mem_regno2,1,1) = '4') then '����ȸ��' 
                    end as  ����,
                sum(mem_mileage)
            from member
            group by case when (substr(mem_regno2,1,1) = '1' or
                          substr(mem_regno2,1,1) = '2') then '����ȸ��'
                     when (substr(mem_regno2,1,1) = '2' or
                          substr(mem_regno2,1,1) = '4') then '����ȸ��' 
                    end;
             
        ��)ȸ�����̺��� �������� ȸ���� ���ϸ��� ���� ���Ͻÿ�   
            select substr(mem_add1,1,2) as ������,
                   sum(mem_mileage) as ���ϸ�����
                from member
                group by substr(mem_add1,1,2);
                
        ��) ������̺��� 2005�� ���Ŀ� �Ի��� ����鿡 ���Ͽ� �μ��� �޿� �հ踦 ���Ͻÿ� --�μ��� �̰� �������� �ϰڴ�
        --2005�� ���Ŀ� �Ի��� ����� > �Ϲ�����
            select department_id as �μ��ڵ�,
               sum (salary) as �޿��հ�
              from employees
             where extract (year from hire_date) >= 2005 --2005�� �Ի��� : �Ի����� date Ÿ���̶� substr ���� ����� (���ڿ� �ƴ�!) 
--             where substr(hire_date, 1, 4) = 2005 --��¥�� substr ���� ����, like ���� �ȵ�
          group by department_id;
--                having substr(hire_date, 1, 4) = 2005;


        ��) ��ٱ��� ���̺��� 2005�� 5�� �ڷῡ�� ��ǰ�� �Ǹż������� ���ϵ� �Ǹż����հ谡 30�� �̻��� ��ǰ�� ��ȸ�Ͻÿ�
            select cart_prod as ��ǰ,
               sum(cart_qty) as �Ǹż�����
              from cart
--            where cart_no like '200505%'   �̰� �ᵵ��
             where substr(cart_no, 1, 6) = 200505
          group by cart_prod 
        having sum(cart_qty) >= 20;
        
        
        2)count 
            - �׷� ���� ���� ��(�ڷ��)
            - count(*|c1)
            
        ��) ������̺��� ��ü ������� ��ȸ�Ͻÿ� --��ü���̺��� �ϳ��� �׷� > �׷���� �Ƚᵵ��!
            select count(*),
                   count(employ_id), --�⺻Ű
                   count(salary) --�ٸ�Į�� �ƹ��ų� �ᵵ��
                from employees;
        
        ��) ������̺��� �μ��� ������� ��ȸ�Ͻÿ�
            select department_id as �μ��ڵ�,
             count(*) as �����,
              sum (salary) as �޿��հ�
             from employees
            group by department_id
            order by 1;
         
         ��) ��ǰ���̺��� �ŷ�ó�� �ŷ���ǰ�� ���� ��ȸ�Ͻÿ�
       select prod_buyer as �ŷ�ó�ڵ�,
              count(*) as �ŷ���ǰ�Ǽ� 
         from prod
        group by prod_buyer
        order by 2 desc; --�ŷ�ó ������ ����
        
        ��)ȸ�����̺��� �������� ȸ������ ��ȸ�Ͻÿ�
            select substr(mem_add1,1,2) as ������,
                   count(*) as ȸ���� 
            from member
            group by substr(mem_add1,1,2);
        
        
        ��)��ٱ������̺��� ȸ���� 2005�� 5~6�� ȸ���� ����ȸ���� ��ȸ�ϵ� ����Ƚ���� 5ȸ �̻��� ȸ���� ��ȸ�Ͻÿ�
            select cart_member as ȸ���ڵ�, --like �ϳ��� ������ ���������� �� �� �ְ� ������ ������
                    count(*) as ����Ƚ��
              from cart
             where  substr(cart_no,1,6)between '200505' and '200506'
          group by cart_member
      having count(*)>= 5
      order by 1;
      
      
        ��)ȸ�����̺��� ȸ������ ���(mem_like)�� ȸ������ ���Ͻÿ�
            select mem_like as ���,
                   count(*) as ȸ����
                from member
                group by mem_like;
                   
        
        ��)��ٱ��� ���̺��� 2005�� 5~6�� ȸ����, ��ǰ�� ����Ƚ���� ���ż��� ���� ���Ͻÿ� (��, 3�� �̻� ����
--            select cart_member as ȸ���ڵ�,
--                    count(*) as ����Ƚ��,
--                    sum(cart_qty) as ���ż�����,
--                    cart_prod as ��ǰ�ڵ�,
--                    count(*) as ���ż���,
--                    sum(count(*)) as ���ż�����
--                    from cart
--                    where substr(cart_no,1,6) between '200505' and '200506'
--                    group by cart_member,cart_prod;
                    
            select cart_member as ȸ���ڵ�,
                   cart_prod as ��ǰ�ڵ�,-- ����
                   count(distinct cart_no) as ����Ƚ��, --10�� �� ���Ŵ� 1�� �ѰŴϱ�
                   sum(cart_qty) as ���ż�����
                from cart
                where substr(cart_no, 1, 6) >= '200505' 
                  and substr(cart_no, 1, 6) <= '200506'
                group by cart_member, cart_prod --��ǰ�ڵ�� �ߺ��Ǿ������ʴ´�, 
                                                --group by �� ���� �߰� ������ �ȳ��� rollup �̳� cube �� ���� �߰����谡 ����!
                order by 1;
                   
        3) avg
         - �׷����� ���� ������ ��հ�
         (�������)
         avg(c1)
          - c1�� ����� ���� ��� ��� ��ȯ
        ��) ������̺��� �μ��� ��ձ޿�. �޿��հ�, �ο���
        select department_id as �μ��ڵ�,
               avg(salary) as  "��ձ޿�(avg)",
               sum(salary) as �޿��հ�,
               count(*) as �μ����ο���,
               sum(salary)/count(*) as "��ձ޿�(���)"
            from employees
            group by department_id 
            order by 1;
            
   20200113---------------------------------     
        ��)kor_loan_status ���̺��� �̿��Ͽ� �� �õ���, ���к� ��� ���� �ܾ��� ���Ͻÿ�
         ��, �����ܾ��հ谡 2������ �Ѵ� ���� ��ȸ�Ͻÿ�
        select region as �õ�,
               gubun as ���ⱸ��,
               to_char(sum(loan_jan_amt), '9,999,999.9') as ��մ����ܾ��հ�,
               to_char(avg(loan_jan_amt), '9,999,999.9') as ��մ����ܾ�
            from kor_loan_status 
            group by region, gubun
            having sum(loan_jan_amt) >= 200000 --where ���� �ȵ�
            order by region;
       
       ��)kor_loan_status ���̺��� �̿��Ͽ� 2012 ~ 2013�� �� �õ���, ���� �����ܾ� �հ�� ��� �����ܾ��� ���Ͻÿ�.
         ��, �����ܾ� �ܾ� �հ谡 5������ �Ѵ� ���� ��ȸ�Ͻÿ�
         select region as �õ���,
                substr(period,5,2)  as ����,
                to_char(sum(loan_jan_amt), '9,999,999.9') as �����ܾ��հ�,
                to_char(avg(loan_jan_amt), '9,999,999.9') as ��մ����ܾ�
            from kor_loan_status
            where substr(period, 1, 4) between '2012' and '2013'
            group by region, substr(period, 5, 2) --�׷��Ҷ��� ���� �ʿ��ѰŴϱ�
            having sum(loan_jan_amt) >= 50000;
            order by 1, 2;
         
        --join    
        ��)��ٱ��� ���̺�� ȸ�����̺��� �̿��Ͽ� 2005�� 4�� ~ 5�� ���� ȸ�� ���� ����ݾ��հ�,
            ����Ǽ�, ��ո������ ���Ͻÿ�.
            select substr(mem_regno2, 1, 1)  as ȸ������,
                   sum(cart_qty * prod_price) as ����ݾ��հ�,
                   count(*) as ����Ǽ�,
                   round(avg (cart_qty * prod_price)) as ��ո����
                from member, cart,prod 
                where cart_member = mem_id --��������
                  and cart_prod = prod_id --��������
                  and substr(cart_no,1,6) between '200504' and '200505'
                group by str(mem_regno2,1,1);
        
        ��)ȸ�����̺��� ��������, ������ ���ϸ��� �հ� , ȸ����, ��ո��ϸ����� ���Ͻÿ�
            select substr(mem_add1,1,2) as ������,
                   mem_job as ����,
                   sum(mem_mileage) as ���ϸ�����,
                   round (avg(mem_mileage)) as  ��ո��ϸ���
            from member 
            group by substr(mem_add1,1,2), mem_job
            order by 1;
            
    4)MAX, MIN 
        - �Ű������� �����Ǵ� �÷��� �� �ִ밪(MAX), �ּҰ�(MIN)�� ���Ͽ� ��ȯ
        - �̵� �Լ��� ����ϸ� ���� ���̺��� �ڷḦ ��������(MIN), ��������(MAX) ���� ������ ��
          ù��° ���� ���� ��ȯ-PROCESS TIME �� �ټ� �ҿ��
    
    ��)������̺��� �� �μ��� ���� ���� �޿��� ���� ���� �޿��� ���Ͻÿ�
        select department_id as �μ��ڵ�,
               count(*) as �����,
               max(salary) as  �ִ�޿�,
               min(salary) as �ּұ޿�
            from employees
            group by department_id;
            
            
           
            select case when substr(mem_regno2, 1, 1) = '1' or 
                             substr(mem_regno2, 1, 1) = '3' then '����'
                        when substr(mem_regno2, 1, 1 )= '2' or
                             substr(mem_regno2, 1, 1) = '4' then '����'
                        end as ȸ������,
                   sum(cart_qty * prod_price) as ����ݾ��հ�,
                   count(*) as ����Ǽ�,
                   round(avg (cart_qty * prod_price)) as ��ո����
                from member, cart,prod 
                where cart_member = mem_id --��������
                  and cart_prod = prod_id --��������
                  and substr(cart_no,1,6) between '200504' and '200505'
                group by case when substr(mem_regno2, 1, 1) = '1' or 
                             substr(mem_regno2, 1, 1) = '3' then '����'
                        when substr(mem_regno2, 1, 1 )= '2' or
                             substr(mem_regno2, 1, 1) = '4' then '����'
                        end;
            
                
        
            
            
            
               
                   
                   
        
        
        