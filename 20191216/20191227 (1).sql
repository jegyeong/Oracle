2019-12-27 01)�����Լ�

2)ROUND , TRUNC  
    - �����ڷ��� �ݿø�(ROUND)�� ����(TRUNC) ��� ����
    (�������)
    ROUND(c, n), TRUNC(c, n) -- n�� �ݿø��� �ڸ��� ��Ÿ�� �ڸ���
    -round�� c�� ����� ���� n+1 �ڸ����� �ݿø�
    -trunc�� c�� ����� ���� n+1 �ڸ����� ����
    -n�� ������ ��� �����κ� n�ڸ����� �ݿø�(����)�Ͽ� ��� ��ȯ --n�� ����� �Ҽ��� ���Ϻκ�
    
��)������̺�(employees)���� ������� �޿��� �������� ����Ͽ� ����� ����Ͻÿ�
    ��, �ֱ޾��� �Ҽ��� 2�ڸ����� �ݿø� �Ͻÿ�
    Alias �� �����ȣ, �����, ���޿�, �ֱ޾�
    select employee_id as �����ȣ,
           emp_name as �����,
           salary as ���޿�,
           round(salary/4, 1) as �ֱ޾�1,
           round(salary/4, 0) as �ֱ޾�2,
           round(salary/4) as �ֱ޾�3,--�Ⱦ��� �޸� ���η� ǥ���Ǿ��� , �Ҽ����� ���� �� �ִ�
           round(salary/4, -1) as �ֱ޾�3 --�����κ� ù°�ڸ����� �ݿø�(���̳ʽ� 1)
        from employees;
        
update employees 
    set salary =  salary + (salary * 0.13);
    
    ����]������̺��� ���ʽ��� ����Ͽ� ���ɾ��� ����Ͻÿ�
        ���ʽ� = �޿� * ��������(commission_pct)
        ���ɾ� = �޿� + ���ʽ�
        Alias �� �����ȣ, �����, �޿�, ��������, ���ʽ�, ���ɾ� 
        
        select employee_id as �����ȣ,
               emp_name as �����,
               salary as �޿�,
               commission_pct as ��������,
               nvl(salary * commission_pct, 0) as ���ʽ�, -- nvl null���� ���ص� null���� ���� �ʰ�
               round (salary + nvl(salary * commission_pct, 0)) as ���ɾ�   -- ���� ��� �ʿ��ϸ� �� �Ȱ��� ����������
        from employees;
    
    
    ��)������̺��� �μ���(group by) ������� ��ձ޿��� ������ 2�ڸ����� ����Ͽ� ����Ͻÿ�(�μ���ȣ ������--�ȹ�����, �μ��� ���ϰ�, ������ ���󵵵�
    Alias �� �μ���ȣ(department_id), ��ձ޿� --���� order by
    
    select department_id as �μ���ȣ, 
           round (avg(salary), 2) as ��ձ޿�1, --�̵��� ���� 1��!
           trunc (avg(salary)) as ��ձ޿�2      --��� �ڸ��� ������;;����,, 
        from employees
      group by department_id --group by�� where�� ������, �ش��ϴ� Į���� �ٽ������(select���� ���� �Ϲ� Į���� ������ �� ����
--      order by department_id; 
--      order by ��ձ޿� desc; -- ��������, ��Ī�� �� ���� ������ �Ȥ��°��� ���� , ��
      --order by ������ slect���� �÷���| select ���� �÷� index
      order by 2 desc;
      
    ��)������̺��� �μ���(group by) ������� ��ձ޿��� ������ 2�ڸ����� ����Ͽ� ����Ͻÿ�(�μ���ȣ ������--�ȹ�����, �μ��� ���ϰ�
        Alias �� �μ���ȣ(department_id), �μ���(department�÷���), ��ձ޿�
        
           select department_id as �μ���ȣ,
                  department_name as �μ���,
           round (avg(empoyees.salary), 2) as ��ձ޿�1, --�̵��� ���� 1��!
           trunc (avg(empolyees.salary)) as ��ձ޿�2      --��� �ڸ��� ������;;����,, 
        from employees, departments --�̷��� join
        where empoyees.department_id = department.department_id --department_id�� �ΰ� �� 
      group by empoyees.department_id, department.department_id
      order by 2 desc;      

 -------������ �����ؼ� �Ʒ���ó�� ����
          select a.department_id as �μ���ȣ,
                  b.department_name as �μ���,
           round (avg(a.salary), 2) as ��ձ޿�1, --�̵��� ���� 1��!
           trunc (avg(a.salary)) as ��ձ޿�2      --��� �ڸ��� ������;;����,, 
        from employees a, departments b --�̰�  ���� �����ؼ� a,b �� ����
        where a.department_id = b.department_id --department_id�� �ΰ� �� 
      group by a.department_id, b.department_id;--�̷��� null�� ��������  �������ε� �������� �׷���???
      
      4)FLOOR,CELL
      - ����� �������� ��ȯ���� �� ���
        (1)FLOOR(n)
            - n�� ���ų� ���� �� �߿� n�� ���� ����� ����
        (2)CEIL(n)
            - n�� ���ų� ū�� �߿� n�� ���� ����� ����
            
        select floor(10.4),
               floor(-10.4),
               ceil(10.4),
               ceil(10),--n�� �ڱ� �ڽ��� ��� �׳� n�� ��µȴ�
               ceil(-10.4)
        from dual;
        
        
    5)MOD, REMAINDER -- �������� �߰� �̻��� ���̸� ���� ���� �޶���, �߰� ������ ���̸� ���� �Ȱ�, �⺻���� mod�����ϱ�
        - �������� ��ȯ
        MOD(c, n), REMAINDER(c, n)
        - c�� ���� n���� ���� ������ ��ȯ
        - mod : c - (n * floor(c/n))
        - remainder : c - (n * round(c/n)
        ��) 13�� 3���� ���� ������
        mod(13, 3) : 13 - 3 * floor(13/3)
                    =13 - 3 * floor(4.33333)
                    =13 - 3 * 4 => 13 - 12 =1
        REMAINDER(13, 3) : 13 - 3 * floor(13/3)
                    =13 - 3 * round(4.33333)
                    = 1
        ��)14�� 3���� ���� ������
         mod(14, 3) : 14 - 3 * floor(14/3)
                    =14 - 3 * floor(4.6666)
                    =14 - 3 * 4 => 14 - 12 = 2
        REMAINDER(14, 3) : 14 - 3 * floor(14/3)
                    =14 - 3 * round(4.6666 )= 14- 3*5
                    = -1
                    
    select mod(13, 3), remainder(13, 3),
           mod(14, 3), remainder(14, 3)
        from dual;
                    
    select mod(113, 21), remainder(113, 21),
           mod(149, 8), remainder(149, 8)
        from dual;        
  
    --������ ������������ �˷��ִ� ��
        select case when trunc (mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 0 then '�Ͽ���'  
                    when trunc(mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 1  then '������'   
                    when trunc(mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 2 then 'ȭ����'   
                    when trunc(mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 3 then '������'   
                    when trunc(mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 4 then '�����'   
                    when trunc(mod(sysdate - to_date('00010101', 'yyyymmdd'),7)-1) = 5 then '�ݿ���'     
                    else '�����' end "����"
            from dual;
            
    6)WIDTH_BUCKET --��ü ���Ѱ��� ���Ѱ�,,,����,,,
        - ������ ������ ���ǵ� ���� ���� ������ INDEX ���� ��ȯ
        (�������)
        WITH_BUCKET(c, min, max, n)
        - c : �񱳴���� �� �Ǵ� ���� ����� �÷���
        - min : ������ ���� ��
        - max : ������ ���� ��
        - n : ������ ����
    ��)
    select width_bucket(75, 1, 100, 10) from dual; --0������ 100���� 10���� �������� �����Ͽ� 75�� � ������ ���ԵǴ����� ǥ����
    
    ����)ȸ�����̺��� ���ϸ����� 1-10000���̸� 10�� �������� ������ 
        ��ȸ���� ������ ���ϸ����� ���� ����� �ο��Ͻÿ�, �� ����  ���ϸ��� ���� ����� �ο��Ͻÿ�.
        ex)8000 ����Ʈ�� 3���, 5����Ʈ�� 10���...
        Alias �� ȸ����ȣ, ȸ����, ���ϸ���, ���
        
        select mem_id as ȸ����ȣ,
               mem_name as ȸ����,
               mem_mileage as ���ϸ���,
               width_bucket (mem_mileage, 1, 10000, 10) as ���1,
               width_bucket (mem_mileage, 10000, 1, 10) as ���2
            from member;
            
            
        ��)������̺��� ������� �޿��� 3���� ������� �����ϰ� ��޿� ���� 
            1����̸� '�� �ӱݱ�', 2����̸� '����� �ӱݱ�', 3����̸� '�� �ӱݱ�'�� ������ ����ϴ� ���� �ۼ�
            Alias �� �����ȣ, �����, ��å�ڵ�, �޿�, ���, ���
            �ӱ��� ���Ѱ��� 2000, ���Ѱ��� 30000 �̴�
            
            select employee_id as �����ȣ,
                   emp_name as �����,
                   job_id as ��å�ڵ�,
                   salary as �޿�,
                   width_bucket(salary, 2000, 30000, 3)|| ' ���' as ���,
                   --case when + ����
                   case when width_bucket(salary, 2000, 30000, 3)=1 then '�� �ӱݱ�'
                        when width_bucket(salary, 2000, 30000, 3)=2 then '����� �ӱ���'
                        else '���ӱݱ�' end as ���
                from employees;
                   
    
            
 
        
        
        
        
