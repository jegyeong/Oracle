2020-01-14  02) ���̺� ����
 - ���̺� �ϳ��� �����͸����� ó���� �� ���� ��� �ش� �ڷḦ ������ �ִ� ���̺� ��� ������ �����ؾ���
 - ��, 2�� �̻��� ���̺��� �ʿ��� �ڷḦ �����ϴ� ������ ����(join)�̶�� �Ѵ�
 - join �� �����ϱ� ���ؼ� ���� ���꿡 �����ϴ� ���̺� ���̿� �ݵ�� ����(relationship)�� �����ؾ���
   (������ �÷��� ����)
 - ����� �÷� ���� �� ������(���迬����)�� ���ǽ�(��������)�� ����
 - n���� ���̺��� ���� ���꿡 �����ϴ¤� �Ť��� ��� n-1���� ���� ������ �ʿ�
 --����� Į�� ���̸� �������ִ� ���ǽ��� ���;���, �̰� ��������
 (�������)
select [���̺�Ī.]�÷���,...
  from ���̺��1, [���̺�Ī1], ���̺��2, [���̺�Ī2][,...]
 where [���̺�Ī1.]�÷��� = [���̺�Ī2.]�÷���
  [and [���̺�Īm.]�÷��� = [���̺�Īn.]�÷���...
  [and �Ϲ�����...]
 
 
 ����� Į���� �������� ���� > �̳�����,  �ƿ������ε� �ִ�. �̳����ΰ� �ƿ��� ���ΰ� �Բ��� �ƿ��� ���� ���õȴ�
 �̷���, �Ⱦ�����? �� ����� > �̰� ������ ���������� �����
 
 1) Cartesian Product 
  - ������ ��� ����� ������ �����ϴ� ����
  - A���̺��� 100�� 10��, B���̺��� 50�� 7���̰� �� �� ���̺� ���Ͽ� Catesian Product�� �����ϸ� 5000��(��) 17��(��)�� ��� 
  - ���������� �߸� ����ǰų� ���������� �����ϴ� ��� �߻�
  - ANSI ���ο��Ŵ� Cross join �̶�� �Ѵ�
  - Ư���� ���� �̿ܿ��� ����Ǵ� ���� ����
  
  ��)��ǰ���̺�� ȸ�����Ϻ��� �����Ͻÿ�
  
   select * from prod, member;
   
   select 74  *  24 from dual; 
   
   select count(*)
    from cart, buyprod;  
    --�������ɸ�
    
2)Equi-Join
 - ���� ����(Inner Join)�̶�� ��
 - ���� ���ǿ� �������('=')�� ���
 - �������ǿ� �����ʴ� �ڷ�� ����
 
��) ������̺��� �Ի����� 2005�� 1�� 1�� ���� �Ի��� ������ ��ȸ�Ͻÿ�
    Alias �� �����ȣ, �����, �μ��ڵ�, �μ���, �޿��̴�
    select a.employee_id as �����ȣ,
           a.emp_name as �����,
           a.department_id as �μ��ڵ�,
           b.department_name as �μ���,
           a.salary as �޿�
      from employees a, departments b --��Ī���ذ�! , ���ϸ��� ����Ǵϱ� �� ���־�
     where a.hire_date >= to_date ('20050101') --�Ϲ����� 
       and a.department_id = b.department_id;   --��������
       --a,b�� �Ⱦ��� �˼��� ���� 
       
    
    
    select distinct a.employee_id as �����ȣ,
           b.department_name as �μ���,
           a.salary as �޿�
      from employees a, departments b --��Ī���ذ�! , ���ϸ��� ����Ǵϱ� �� ���־�
     where a.hire_date >= to_date ('20050101') --�Ϲ����� 
       and a.department_id = b.department_id
  order by 3;   
  
  
��) ��ٱ��� ���̺��� 2005�� 5�� ��ǰ�� �Ǹ������� ��ȸ�Ͻÿ�
    Alias �� ��ǰ�ڵ�, ��ǰ��, �Ǹż���, �ܰ�, �Ǹűݾ��հ�
    
    select b.prod_id as ��ǰ�ڵ�,
           b.prod_name as ��ǰ��,
           sum (a.cart_qty) as �Ǹż����հ�,
           sum (a.cart_qty * b.prod_price) as �Ǹűݾ��հ�
      from cart a, prod b
     where a.cart_no like '200505%' --�Ϲ�����
     --substr
       and a.cart_prod = b.prod_id  --��������
       group by b.prod_id, b.prod_name;
 
 
��) �������̺�(buyprod)�� ������ �̿��Ͽ� 2005�� 1�� �ŷ�ó�� ���Աݾ� �հ踦 ���Ͻÿ�,
    ��, Alias �� �ŷ�ó�ڵ�, �ŷ�ó��, ���Լ����հ�, ���Աݾ��հ�
    select c.buyer_id as �ŷ�ó�ڵ�,
           c.buyer_name as �ŷ�ó��,
           sum (a.buy_qty) as ���Լ����հ�,
           sum (a.buy_cost * a.buy_qty) as ���Աݾ��հ�
      from buyprod a, prod b, buyer c
     where a.buy_date between '20050101' and '20050131'
     --extract (year from a.buy_date)= 2005 and extract (month from a.buy_date)= 1
       and c.buyer_id = b.prod_buyer
       and b.prod_id = a.buy_prod
       group by c.buyer_id, c.buyer_name;
       --group by select�� �ƴѰ� �پ���
       
--�ϳ��� ���̺�� �˻����� ���Ҷ� > ������ ���̺��� ������ �Ѵ�

    
    
    
    
    
    
   
  
 