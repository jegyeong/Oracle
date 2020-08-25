2020-01-14  4)null �����Լ�

1) is null, is not null 
    -�÷��� ����� ���� null ������ ���θ� �Ǵ�
    -null �� '='�� �񱳺Ұ��� 
    
��) ������̺��� �μ��ڵ尡 null�� ����� ��ȸ�Ͻÿ�
    select employee_id as �����ȣ,
           emp_name as �����,
           department_id as �μ��ڵ�,
           salary as �޿�,
           job_id as ��å�ڵ�
        from employees
     --where department_id = null;
     where department_id is null;
     
��)������̺��� commission_pct(��������)�� null�� �ƴѻ���� ��ȸ�Ͻÿ�
    select employee_id as �����ȣ,
           emp_name as �����,
           department_id as �μ��ڵ�,
           commission_pct as ��������,
           salary as �޿�
        from employees
        where commission_pct is not null;
        
��)������̺��� ���������� ���� ���ʽ��� ����ϰ� ���޾��� ��ȸ�ϴ� ������ �ۼ��Ͻʽÿ�
    ���޾� = ���� + ���ʽ�
    ���ʽ� = ���� * �������� * 50%
    
    select employee_id as �����ȣ,
           emp_name as �����,
           salary as ���޿�,
           commission_pct as ��������,
           salary * commission * 0.5 as ���ʽ�,
           salary + (salary * commission * 0.5) as ���޾�
        from employees;
        --���������� null�̸� ����ε� ���� �ȳ��ͤФ�
        --�̰��� �ذ��ϱ� ���Ѱ��� nulló�� �Լ�
        
2)NVL 
    -�Ű������� ���ǵ� Į������ 'null'���� �Ǵ��Ͽ� Ư����(���ǵ�) ���� ��ȯ
    (�������)
    NVL(c, v) 
     - 'c'�� ����� ���� null�̸� v ���� ��ȯ�ϰ� null�� �ƴϸ� c �� ����� ���� ��ȯ
      select employee_id as �����ȣ,
           emp_name as �����,
           salary as ���޿�,
           nvl(commission_pct, 0) as ��������,
           salary *nvl(commission_pct, 0) * 0.5 as ���ʽ�,
           salary + nvl((salary * commission_pct * 0.5), 0) as ���޾�
        from employees; 

3)NVL2 
    -���ǵ� �÷����� 'null'���ο� ���� ���� �ٸ� ���� ��ȯ
    (�������)
    NVL2(c, v1, v2)
 . 'c'�� ����� ���� 'null'�� �ƴϸ� 'v1'�� ��ȯ�ϰ�, 'null'�̸� 'v2'�� ��ȯ
 
 ��) ��ǰ���̺��� ��ǰ�� ����(prod_color)�� 'null'�̸� '������������'�� ����Ͻÿ�
 select prod_id as ��ǰ�ڵ�,
       prod_name as ��ǰ��,
       prod_color as "��ǰ����"
  from prod;
  
  (NVL �Լ� ����)
  select prod_id as ��ǰ�ڵ�,
       prod_name as ��ǰ��,
       nvl(prod_color,'�������� ����') as "��ǰ����" --�޸��յ��� Ÿ���� ���ƾ���
  from prod;
  
  
  (NVL2 �Լ� ����)  --NVL2(c, v1, v2) => null�� �ƴϸ� v1�� null�̸� v2����ȯ
  select prod_id as ��ǰ�ڵ�,
       prod_name as ��ǰ��,
       nvl2(prod_color, prod_color, '�������� ����') as "��ǰ����"  
  from prod;
  
update member
    set mem_like = null
    where mem_like ='���';
    
��) ȸ�����̺��� ��̰� null�̸� '��̾���', null�� �ƴϸ� '�������'�� 
    ����Ͽ� ȸ�������� ��ȸ�Ͻÿ�
    
    select mem_id as ȸ����ȣ,
           mem_name as ȸ����,
           mem_like as ���,
           nvl2(mem_like, '�������', '��̾���')
      from member;
      
    
           
