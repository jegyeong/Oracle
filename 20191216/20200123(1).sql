2020-01-23   01)synonym(���Ǿ�) ��ü 

    - ����Ŭ ��ü�� ������ �̸��� �ο�
    - �ٸ� �������� ���̺� �����ϴ� ��� '��Ű����, ���̺��' ������ ���ϱ� ������ ���� �������� �������� 
     -> �̸� �����ϰ� �����ϱ� ���ؼ� �ַ� ���
     
    select * from[ip.�����ڰ�����.]lprod;
    (�������)
    create [or replace][public] synonym ���Ǿ��
        for ��ü��;
         - public : �������Ǿ�
         - '��ü��' : ���Ǿ� �ο� ��� ��ü�̸� 
         
��)
    create or replace synonym emp for employees;
    
    select emp_name, salary, department_id 
        from kbs;--�̷��� �ȶ�
        
    select emp_name, salary, department_id 
        from emplouees kbs;
        
    select sysdate from dual;
    
    create or replace synonym d1 for sys.dual;
    
    select to_chart (sysdate, 'yyyy-mm-dd am hh24:mi:ss')from d1;
    
    
    
    