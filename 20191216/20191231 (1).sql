2019-12-31 01)��¥�� �Լ�
 - ��¥ ���� ����ȯ ����
 
    1)SYSDATE --(�ý����� �������ִ� ��¥)
     - �ý��ۿ��� �����ϴ� ��¥���� ��ȯ
     - ������ ������ ����������, �������� ������ �Ұ����ϴ�(����� ������ �ϼ��� ���� ����, ������ �ϼ��� �� ��¥)
     
     ��)
     select sysdate as ����ð�, --�⺻������ ��, ��, �� �� ����
            sysdate - 30 "�� �� �� ��¥",
            sysdate + 30 "�� �� �� ��¥",
            sysdate - to_date('20100810')--3430�� �ΰ�
       from dual;
       
    **�ý����� �����ϴ� �ð� �������� �ʿ��� ���(��, ��, �ð� ��)�� ������ ��� : EXTRACT �Լ����
       
       ��)������̺��� �Ի�����(hite_date)�� �̿��Ͽ� 15���̻� �ټ��� ����� ��ȸ�Ͻÿ�
       --������̺��� ��� ����� �־���Ѵ�, �ٹ��ϰ� �ִ��� �ƴ����� �ϳ��� �ʵ�� �����ϸ��
        Alias �� �����ȣ, �����, �Ի���, �ټӿ���
        select employee_id as �����ȣ,
               emp_name as �����,
               hire_date as �Ի�����,
               extract(year from sysdate) - extract (hire_date) as �ټӿ��� --�Ի��Ͽ��� sysdate ,
               --��¥������ �̿��ؼ� Ư���� ���� �������� substring �������� extract��3
            from empolyees
           where extract(year from sysdate) - extract(year from hire_date) >= 15
             and retire_date is null;
             
             select * from employees
             where retire_date is null;-- �̶� '='�� ���� �ȵǰ� 'is' �� �����!
--�ȵ�             

    2)MONTHS_BETWEEN
     - �Ű������� ������ �� ��¥ ������ �޼��� ��ȯ
     (�������)
     months_between(d1, d2)
     -d1, d2�� ��¥ Ÿ���� �ڷῩ����
     
     ��)ȸ�����̺��� ���� ��¥�� �������� ȸ������ ���̸� �� ������ ��Ÿ���ÿ�
        ���� �Ҽ��� 1�ڸ����� �ݿø� �Ͻÿ�
        Alias �� ȸ����ȣ, �̸�, �������, ������
        
        select mem_id as ȸ����ȣ,
               mem_name as �̸�,
               mem_bir as �������,
               round(months_between(sysdate, mem_bir)) as ������ -- ��꿡�� ���� �� �ִ� �� : �����Ӽ� > ����X
               --round(months_between(sysdate, mem_bir),0)��� ���ų� ����
            from member;
            
        select to_char(mem_bir,'yyyy-mm-dd hh24:mi:ss') from member;
       
           
    3)EXTRACT
     -��¥�ڷῡ�� �ʿ��� ���(��,��,��,��,��,��)FMF CNFNC
     (�������)--fmt : ���乮�ڿ�, �����������ڿ�
     EXTRACT(fmt from d1)
        -'fmt'�� �ʿ��� ��Ҹ� ��Ÿ���� �ܿ�(year, month, day, hour, minute,second)
        -d1�� ��¥�� �ڷ�
        -����� ���������� ��ȯ
        
    ��) ������̺��� 7���� �Ի��� ��������� ��ȸ�Ͻÿ�
        Alias �� �����ȣ ����� �Ի��� �޿�
        select employee_id as �����ȣ,
               emp_name as �����,
               hire_date as �Ի���,
               salary as �޿�
            from employees
            where extract(month from hire_date)= 7;
            
    ��) ȸ�����̺��� �̹��� ������ ȸ�������� �����Ͻÿ�
        Alias �� ȸ����ȣ, ȸ����, �������, ���ϸ���
        select mem_id as ȸ����ȣ,
               mem_name as ȸ����,
               mem_bir as �������,
               mem_mileage as ���ϸ���
            from member 
            where extract (month from mem_bir) = extract (month from sysdate);--is�� null  ���Ҷ��� ����! ����� = �ᵵ��
        
    
    4)ADD_MONTHS
        - �־��� ��¥ �ڷῡ ���ǵ� �� ��ŭ ���� ���� ��¥�� ��ȯ
        (�������)
        ADD_MONTHS(d1, n)
         -d1�� ��¥����
         -n�� ������ ���� ��
         
    ��)
    select add_months(sysdate, 3) from dual;
    
    ��)ȸ�����̺��� ���� ���� �޽����� 3������ �߼��Ϸ��Ѵ�,
        ���÷κ��� 3�����Ŀ� ������ ����� ȸ���� ã�� ���ڹ߼����� ��ȸ�Ͻÿ�
        Alias �� ȸ����ȣ, ȸ����, ����, ���ڹ߼���
        select mem_id as ȸ����ȣ,
               mem_name as ȸ����,
               extract (month from mem_bir)||'��'||
               extract(day from mem_bir) as ����,
--               add_month((day from mem_bir), 3) || 3 as ���ڹ߼���
               to_date (to_char(extract (year from sysdate))||--�����̱� (�ý��ۿ���)>���ڿ��ٲٱ�
               to_char(extract(month from mem_bir),'99')|| 
               --���Ͽ��� month�̱�, '99'�Ⱦ��� ��¥�� ��ȯ �Ұ��� 1�� 1�� 12�� 2���ϱ�> ���ڿ��� �ٲ�
               to_char (extract(day from mem_bir),'99'))-3 as ���ڹ߼���
            from member
            where extract(month from mem_bir)=extract(month from add_month(sysdate,3)));
 --�ȵ�           
            select add_months(sysdate, 8) from dual;
            

    5)LAST_DAY, NEXT_DAY
        5-1. LAST_DAY
            -�־��� ��¥�� �ش� ���� �������� ��ȯ
            (�������)
            LAST DAY(d1)
            -d1 ��¥�� ���Ե� ���� ������ ���� ��ȯ
            
            select last_day(to_date('20000910')) from dual;
        
        5-2. NEXT_DAY
            - �Ű������� ��Ÿ���� �ִ� ��¥ ���� �־��� ������ ���� ���� ��¥ ��ȯ
            (�������)
            NEXT_DAY(d1, c1)
            -d1 ��������
            -c1 ���Ϸ��� ������ ǥ���ϴ� ���ڿ�(��, ȭ./...��) --������ ����!
            
        ��) 
        select next_day(to_date('20180705'),'ȭ')from dual;
            
        
    
    6)