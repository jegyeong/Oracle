2019-12-19
    2)�ڷ����
     -UPDATE ������ ����
     (�������) 
     
   UPDATE ���̺�� --���̺�ȿ��� �ݤ��� ������ �־����!
      SET �÷���=��  ----������ ��!(���ο)
          �÷���=��,... 
   [WHERE ����];  --��������  >>���Ҹ����� �� �𸣰���
   
��)��ǰ���̺��� '���� �� ���콺'(P10101)�� �ǸŰ��� 20000������ �����Ͻÿ�

UPDATE GOODS 
  SET GPRICE -20000:
  
  SELECT * FROM GOODS); --where ������ �ٹٲ٤��°��� �˾� 
  
ROLLBACK; �� ������ Ŀ���� ���¤� ���ư� 

UPDATE GOODS 
    SET GPRICE -20000:
  WHERE GNAME LIKE '����%'
 
 SELECT * FROM GOODS;
 
 ����) ȸ�����̺�(MEMBER)���� ����(MEM_JOB)�� '�л�'�� ȸ���� ���ϸ���(MEM_MILEAGE)�� ��� 3000���� �����Ͻÿ�
 
 UPDATE MEMBER
    SET MEM_MILEAGE=3000--������ ��
        MEM_PASS='AAA'
  WHERE MEM_JOB='�л�';
  
  SELECT MEN_NAME, MEM_MILEAGE, MEM_PASS
    FROM MEMBER
   WHERE MEM_JOB='�л�';
   
ROLLBACK;

