2019-12-26

01)���ڿ� �Լ�
    06) REPLACE
        - �־��� ���ڿ� ���� Ư�� ����(���ڿ�)�� �ٸ� ����(���ڿ�)�� ġȯ
        - TRIM, LTRIM, LTRIM �� Ư�� ���ڿ� ���ο� �����ϴ� ���� ���� ����� �������� ����
        - REPLACE �� �ܾ� ������ ���� ���� ������ --�μ����� �����
        (�������)
        REPLACE(C1, C2 [,C3])
         - C1 ���ڿ����� ����(��) C2�� ã�� C3 ����(��)�� ġȯ
         - C3�� �����Ǹ� C2 ����(��)�� ������  
         
    ��) 
    select replace('����ȭ ���� �Ǿ����ϴ�', 'ȭ', '��') from dual;
    select replace('����ȭ ���� �Ǿ����ϴ�', 'ȭ') from dual;
    select replace('����ȭ ���� �Ǿ����ϴ�', '��', '��') from dual;
    select replace('����ȭ ���� �Ǿ����ϴ�', ' ') from dual; --TRIM, LTRIM, LTRIM�� ���� �� ���� ������ ������, ��ȿ���鵵 ���� ������
    select replace('����ȭ ����  �츮���� ���Դϴ�', '  ', ' ') from dual;
    
    ����] ȸ�� ���̺��� '��'�� ���� ���� ȸ���� '��'���� ��ȯ�Ͻÿ�
        Alias�� ȸ����ȣ, ȸ���̸�, ��ȭ��ȣ�̴�. 
    select mem_id as ȸ����ȣ,
           replace (substr(mem_name, 1, 1), '��', '��'||substr(mem_name,2,2)) as ȸ���̸�,
           mem_hp as ��ȭ��ȣ
      from member
--     where substr(mem_name, 1,1)= '��';�̷��� �ڿ��� �ٲ�-- where���� �����̶� �ٲٴ� �� ���� �ȵŤ�
       where mem_name like '��%';
  rollback;    
    
    7) TRANSLATE
        - �־��� ���ڿ��� �Ű������� �����ȴ� ���ڿ��� ������ �����Ǵ� ���ڿ��� ġȯ
        (�������)
        translate(c1, c2, c3)
         - �־��� ���ڿ� c1�� ���Ե� ���� �� �����Ǵ� c2�� ���ڷ� c3�� ���ڸ� ġȯ
         - c3���ڰ� c2 ���� ������ �ش� ���ڴ� ���ŵ�
         
        select('sql developer', 'abcdefghij', '9876543210') from dual;
        select buyer_bankno,
               translate(buyer_bankno, '123456789-', 'abcdefghij#')
          from buyer;
     rollback;
    
    ��)ȸ�����̺��� ȸ���� ����ȭ��ȣ �� '-'�� ')'�� ��ȯ�Ͻÿ�
    select mem_hometel,
           replace(mem_hometel, '-', ')'),
--           translate(mem_hometel, '0123456789-', '0123456789)')-- ���� Ư���� ��츦 �����ϰ� �Ƚ�Ѥ��ϴ�. ���÷��̽��� ����Ǵϱ�
      from member;
      
    8) LENGTH, LENGTHB
        - ���ڿ��� ���� �� ������ ��(LENGTH)�� ��ü����(LENGTHB)�� ��ȯ --LENGTH : �ѱ۵� �ѱ��ڴ� 1�� ��ȯ��, ����Ʈ�� �ٸ����� 
        (�������)
        length(c), length(c)
        - �־��� ���ڿ� c�� ����� ���ڼ��� �������� ũ��(byte)�� ��ȯ
        
    ��)ȸ�����̺��� �ּ� (mem_add1)�� ���ڼ��� �������� ũ�⸦ ��ȸ�Ͻÿ�
        Alias �� ȸ���̸�, �ּ�, ���ڼ�, �������� ũ��
        
        select mem_name as ȸ���̸�,
               mem_add1 as �ּ�,
               length(mem_add1) as ���ڼ�,
               lengthb(mem_add1) as "�������� ũ��"--�����־ �ֵ������� ����
          from member;
    
    9)INSTR --INDEX OF STRING��
        - �־��� ���ڿ����� �Ű������� �����Ǵ� ����(��)�� ��ġ��(INDEX) ��ȯ
        (�������)
        INSTR(C1, C2 [M [,N]])
         - C1 ����(��)���� �� ó�� ������ C2 ����(��)�� ��ġ�� ��ȯ
         - m�� ������ġ(index)
         - n�� �ݺ��� Ƚ��(n��°)
        
    ��)
    select instr('banana', 'a') from dual;--�� ó�� ������ a�� ���ʿ��� ���°�İ� ����°�
    select instr('banana', 'a', 1, 2) from dual; --�ι�° ������ a�� ã������
    select instr('banana', 'a', 3, 2) from dual; --����° ���ں��� �����ؼ� �ι�° a�� ã������
    
    
    ����1] ��ǰ���̺��� �� ó�� ������ ������ ��ġ���� ��ȸ�Ͻÿ�--byte ���� �ƴ϶� ���ڼ��� ���°�!
        Alias �� ��ǰ��, ��ġ��
    select prod_name as ��ǰ��,
           instr(prod_name, ' ') as ��ġ��
           instr(prod_name, ' ', 1, 2) as ��ġ�� --�̷��� �ι�° ������ ã�� ��! ���° ���ڿ� �ι�° ������ �ִ��� ���°�
      from prod;                                   
    
    
    