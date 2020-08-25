2020-01-17  01)SUBQUERY
    
    --�������� ���ս�Ű�°�
    
    - QUERY �ȿ� ���Ե� �� �ٸ� ����
    - ��������� ����ϱ� ���� ����(�ٱ��� ����)�� ���� ���������
    - ���������� SELECT, WHERE, FROM ���� ��ġ�� �� ����
      (�Ϲ������� ���������� �Ϲ������� SELECT, WHERE ���� ���°�)
      (Ư�� FROM ���� ������ ���������� IN-LINE SUBQUERY ��� �ϸ� ��ü������ ���డ���ؾ���)
    - ���� ������ '( )'�ȿ� ����Ǹ� �� ������ �� ���� �����
    - ���������� �з�
        : ������������ ���ü�(����) ���ο� ���� ������ �ִ� �������� ������ ���� ���������� �з�
        : ��ȯ�Ǵ� ����� �ϳ��� ��/��, �ټ��� ��/���� ���� �з�
    - ���������� �����ڿ� �Բ� ���Ǵ� ��� �ݵ�� �����ڸ� �����ʿ� ��� (where������ ���϶�)
    
��)������̺��� ��ü ����� ��� �޿����� �� ���� �޿��� �޴� ������� ��ȸ�Ͻÿ�
    Alias �� �����ȣ, �����, �μ���, �޿�
   
   (1)�������� - �����̺��� ��ü ����� �����ȣ, �����, �μ���, �޿� ��ȸ
             - (����) ����� ��� �޿����� �� ���� �޿��� �޴�
             
    select a.employee_id as �����ȣ, 
           a.emp_name as �����, 
           b.department_name as �μ���, 
           a.salary as �޿�
        from emplyees a, department b
        where a.department_id = b.department_id
        and selary  >= (��ձ޿�_)
    
   (2)�������� - ����� ��ձ޿� 
    
    select avg(salary) from employees;
    
   (3)����
    select a.employee_id as �����ȣ, 
           a.emp_name as �����, 
           b.department_name as �μ���, 
           a.salary as �޿�
      from employees a, departments b
     where a.department_id = b.department_id
       and a.salary  >= (select avg(salary) 
                      from employees);

** in-line ������ ����
    select a.employee_id as �����ȣ, 
           a.emp_name as �����, 
           b.department_name as �μ���, 
           a.salary as �޿�,
           round(c.savg) as ��ձ޿�
      from employees a, departments b, (select avg(salary) as savg
                                        from employees) c 
                                        --��ձ޿��� ����ؼ� ���̺����·� ����(�� �ϳ��� ���̺�)
    where a.department_id = b.department_id
       and a.salary  >= c.savg;
       
��)������̺��� �� ����� �μ��� �����μ��� ���� �μ��� ���� ������� ��ȸ�Ͻÿ�
    1)�������� - ������̺��� ������� ��ȸ
              - (����) : ������� �μ��� �μ��� �����μ��� ���� �μ�
    select count(*)
      from employees
     where department_id = (�����μ��� ���� �μ�
    
    2)�������� - �����μ��� ���� �μ�
    select department_id
      from departments 
     where department_id is null;--���� '=' �Ἥ �� x
    
    3)����
     select count(*)
      from employees
     where department_id = (select department_id
                            from departments 
                            where department_id is null);
    --������ ������ in some any all exists

��)������̺��� �� ����� �μ��� �����μ� 90 ���� ������� ��ȸ�Ͻÿ�    
    (any, some ������ �̿�)
    select count(*)
      from employees
     where department_id = any/*(some)*/(select department_id
                            from departments 
                            where department_id = 90);
                            
    (exists ������ �̿�)--���ü��ִ� ��������(��������)
    select count(*)
      from employees b
     where exists(select 10000 --������ ������ �� ��ŭ�� ����϶�> ���ٸ� null�� ��µ�
                  from employees a 
                  where a.department_id in (select department_id
                                          from departments 
                                          where department_id = 90)
                    and a.employee_id = b.employee_id); --����
    
    
��)��ٱ������̺��� 2005�� 6�� �Ǹ������� ��ȸ�Ͻÿ�
    ��, ���������� ������ ������� ����
    Alias �� ȸ����, ��ǰ��, �Ǹż���
    select (select mem_name 
            from member
            where mem_id = cart_member) as ȸ����,
            (select prod_name
             from prod
             where prod_id = cart_prod) as ��ǰ��,
            cart_qty as �Ǹż���
    from cart
    where cart_no like '200506%';
    
��)������̺��� �� ����� �μ��ڵ带 �������� �μ��� ����ӱ��� ���ϰ�
    �ڱⰡ ���� �μ��� ����ӱݺ��� ���� �ӱ��� �޴� ����� ��ȣ���Ͻÿ�
    select --���� 
                            
    
                                          
    
    
                      
            