2020-01-20  01)�����༭������
    --�Ϲ� ���迬����X
    --in some any...
    
��)��ǰ���̺��� ��ǰ�� �з��ڵ尡 'p201'(����ĳ�־�)�� �ܰ����� 
    �� ū �ܰ��� ������ �ִ� ��ǰ�� ��ȸ�Ͻÿ�
    Alias �� ��ǰ�ڵ�, ��ǰ��, �з���, �ǸŰ����̴�.

(������)  
    select a.prod_id as ��ǰ�ڵ�, 
           a.prod_name as ��ǰ��, 
           b.lprod_nm as �з���,
           b.lprod_gu as �з��ڵ�, ---a.prod_lgu
           a.prod_price as �ǸŰ���
     from prod a, lprod b
    where a.prod_lgu = b.lprod_gu
      and a.prod_price >= (��������)

(��������)
    select min(prod_price) --��������
      from prod
     where prod_lgu = 'P201';
  
(����_)    
     select a.prod_id as ��ǰ�ڵ�, 
           a.prod_name as ��ǰ��, 
           b.lprod_nm as �з���,
           b.lprod_gu as �з��ڵ�, ---a.prod_lgu
           a.prod_price as �ǸŰ���
     from prod a, lprod b
    where a.prod_lgu = b.lprod_gu
      and a.prod_price >= (select min(prod_price) --��������
                          from prod
                          where prod_lgu = 'P201');
                          

(�����༭������)--any some in all exists 
      (select prod_price --��������
        from prod
       where prod_lgu = 'P201');
       
       
    select a.prod_id as ��ǰ�ڵ�, 
           a.prod_name as ��ǰ��, 
           b.lprod_nm as �з���,
           b.lprod_gu as �з��ڵ�, ---a.prod_lgu
           a.prod_price as �ǸŰ���
     from prod a, lprod b
    where a.prod_lgu = b.lprod_gu
      and a.prod_price  = any (select prod_price --�������� --any ��� in�ᵵ��
                             from prod
                            where prod_lgu = 'P201');
                            
(����)
�� �μ��� ��ձ޿��� ����ϰ� �ڱ� �Ҽ� �μ��� ��ձ޿����� �� ���� �޿��� �޴� ������� ����
    Alias �� �����ȣ, �����, �ҼӺμ���, �޿�
    
(����)
    select a.employee_id as �����ȣ, 
           a.emp_name as �����, (������ �÷����� a �� �Ƚᵵ �Ǳ��ؤ� �׆� ���ִ°��� ����)
           b.department_name as �ҼӺμ���, 
           a.salary as �޿�
    from employees a, department b
   where a.salary >= (��������)
     and a.department_id = (���������� department_id) 
    
     
(����)
        select a.employee_id as �����ȣ, 
           a.emp_name as �����, --(������ �÷����� a �� �Ƚᵵ �Ǳ��ؤ� �׆� ���ִ°��� ����)
           b.department_name as �ҼӺμ���,
           rount(e.sal) as ��ձ޿�,
           a.salary as �޿�
    from employees a, departments b, (select depatment_id, 
                                            round(avg(salary)) as sal
                                       from employees
                                       group by depratment_id) e
   where a.department_id = b.department_id
     and a.department_id = e.department_id --
     and a.salary >= e.sal
   order by 3;
   
                
    
    
