2020-01-23  02)index ��ü

    - �������� �˻� ȿ���� ������Ű�� ���� �پӤ�
    - where ���� ���Ǵ� �������� ó�� �ӵ� ����
    - �������� �׷�ȭ�� sort(order by) �� ó���ӵ� ����
    - dbms �� �δ��� ������
    - �ε����� �����Ǹ� ���������� �ð��� ������ �ҿ�
      (����/����/���� ������ ���� ���̺����� �ε����� ���������� ���� �ð� �ҿ��)
      
    Unique/non-unique index 
     - index : �ߺ����� ������� �ʴ� �ε���(�⺻Ű, �ܷ�Ű�� ��������� �ε���)
             : �⺻Ű, �ܷ�Ű ���ؽ��� �����ϰ� null�� ���ǳ� �ѹ��� ��밡��
     - non-unique : �ߺ� �� null �� ���
     - single/Composite index
       single : �ϳ��� �÷����� ������ �ε���
       Composite : �ΰ� �̻��� �÷����� ������ �ε���
     
     . �ڵ�/���� index
   - ���̺������� pk �Ǵ� Unique constraint ���Ǳ���� ����
   - ���� : creat index �������� ����
  . �ε��� ������Ŀ� ���� �з�
   - Normal Index : �⺻�ε���(B-Tree index)
    . Ʈ�������� ����
    . �÷����� rowid�� ������� ������ġ ���
  - Bitmap Index : �÷����� rowid�� 2������ �����Ͽ� �ּҰ��
    . ����/����/������ ���� �߻��ϴ� ��� ��ȿ����
  - Function-Based Index : �ε��� �����÷��� �Լ��� ���� ��� 
    . ���� �Լ���� �ε����� �⺻�ε��� ��Ŀ� �Լ��� �߰��� ������
    
    
    (�������)
    create [unique|bitmap] index �ε�����
        on ���̺���(�÷���1 [,�÷���2,...]) [asc|desc]
        
create index idx_member on member (mem_regno1, mem_regno2);
     
create index idx_mem_02 on member (substr(mem_name,2));

select mem_name, mem_add1, mem_job
    from member
    where mem_name = '��ö��';
 
select mem_name, mem_add1, mem_job
    from member
    where substr(mem_name,2) = 'ö��';
    
drop 


    **�ε��� �籸��
(�������)
alter index �ε����� rebuild 
    - ���� ���̺��� �ε����� �ٸ� workspace�� �̵��� ��
    - ����/���� ���� �۾��� ���� �߻��� �� 
    
    