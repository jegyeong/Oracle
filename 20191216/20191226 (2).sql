2019-12-26 (2)
2) �����Լ�

    1) �������Լ�
        - ABS, SIGN, POWER, SQRT, 
        (1) ABS(n)
         - n�� ���밪�� ��ȯ
        (2) SIGN(n)
         - n�� ��ȣ�� ���� �����̸� -1, ����̸� 1, 0�̸� 0�� ��ȯ --n�� ũ��� �������, ���� ��ȣ�� �Ǵ�, 
        (3)POWER(e, y)
         - e�� y��(e�� y�� �ŵ� ����) �� ��ȯ
        (4) SQRT
         - n�� ���� �� ��ȯ
         
   --�ڹٴ� ���ڿ켱, ����Ŭ�� ���ڿ켱 
   select ('12') + 12 from dual;
   --�ڹٴ� 1212�� ����

    ��)ȸ�����̺��� ȸ���� ���̰� 50�� �̻��� ȸ�������� ��ȸ�Ͻÿ�
        Alias  �� ȸ����ȣ, ȸ����, �ֹι�ȣ, ����
        ��, ���̴� �ֹι�ȣ�� �̿��Ͽ� ���ϰ� 50�� �̻��� ȸ���� ������ sign �Լ��� ����Ͻÿ�
        --�ȵ�, �׳� ���̱��ϴ°͸� ������
   
        select mem_id as ȸ����ȣ,
               mem_name as  
               mem_regno1||'-'||mem_regno2 as �ֹι�ȣ,
               case when substr(mem_regno1, 1, 1) = '0' then --case when: �ڹ��� if ���̶�� �����ϸ� ��
                    extract(year from sysdate) - to_number('20'||substr(mem_regno1, 1,2))
                     -- extract(year from sysdate) : �ý��� �����ͷκ��� ������ �̴°�
               else 
                    extract(year from sysdate) - to_number('19'||substr(mem_regno1, 1,2))
                end case as ����
--             extract(year from sysdate) - substr(mem_regno1, 1 , 2) as ���� 
          from member;       
        
    ��) ��ǰ���̺��� ��ǰ�� �ǸŰ��� 10���� �ʰ��̸� '����ǰ', 10�����̸� '������ǰ', 10���� �̸��̸� '������ǰ' �̶�� ������ ����Ͻÿ�
    
    select prod_id ��ǰ��ȣ,
           prod_name ��ǰ�̸�,
           prod_price �ǸŰ���,
           case when sign(prod_price-100000)=0 then '������ǰ'--10�����̸� 0, �ʰ��� 1, �̸��̸� -1
                when sign(prod_price-100000)=1 then '����ǰ'
                else  '������ǰ' end as ��� --end �� case when ���� �����°�
            from prod;
            
    ��) 20mb�� �� byte ���� ���Ͻÿ� (2�� 10�� byte = 1KB, 2�� 10�� KB�� 1MB)
        =>1MB = (2�� 10�� X 2�� 10��) byte => 2�� (10+10)��
        
        select to_char(20*power(2,20), '99,999,990')||'byte' from dual;
        
    2)GREATEST, LEAST --�� ������ ������ �ϴ°��̱� ������ ó���ӵ��� ������ �����ɸ���, ���� �Ⱦ�, ������ Ÿ���� �ʿ�X
    - �־��� �� �� ���� ū ���� ���� ���� ���� ��ȯ
    (�������) 
    - GREATEST(m1, m2, m3...) - ������ (m1, m2, m3...) �� ���� ū ��
    - LEAST(m1, m2, m3...) - ������ (m1, m2, m3...) �� ���� ���� ��
    **�ϳ��� �÷��� ����� �� �� �ִ�/�ּ� ���� ���� �� => min(c), max(c) ���
    
    ��) 
    select greatest(100, '��', '��') from dual;--�ȵ�
    
    ��) ȸ�����̺��� ȸ������ �����ϰ� �ִ� ���ϸ����� ��ȸ�Ͽ� 2000���� ������ 2000���� �����ϴ� ������ �ۼ��Ͻÿ�
    
    (���ϸ����� 2000�̸��� ȸ��
    select mem_name, mem_mileage
        from member
        where mem_mileage<2000;
        
    (2000�̸��� ȸ���� ���ϸ��� ����)
    update member
        set mem_mileage = (select greatest(mem_mileage, 2000) from member);--����ڰ� ���� ���ϸ����� 2000�� ���ؼ� �� ū ���� ��ȯ
        set (mem_id,mem_mileage)=(select mem_id,greatest(mem_mileage,2000)
                        from b)
        where a.mem_id = b.mem_id;--�ȵ�
        
    select mem_id, mem_name, greatest(mem_mileage, 2000)
        from member;
        
        rollback;
        
        
        
               
               