2020-01-21  02)���������� �̿���  insert/update/delete

���������̺� ����(remain)
---------------------------------------------
�÷���     ������Ÿ��(ũ��)   nullable    key
---------------------------------------------
remain_year  char(4)        n,n         pk
remain_prod  varchar(10)    n,n         pk/fk
remain_j_00  number(5) --�������
remain_i     number(5) --�԰����(buyprod
remain_o     number(5) --������(cart
remain_j_99  number(5) --�� ���, (�⸶���)
remain_date  date      --�����Ǿ�����
---------------------------------------------

 create table remain(
 remain_year  char(4) not null,
 remain_prod  varchar(10) not null,
 remain_j_00  number(5), 
 remain_i     number(5),
 remain_o     number(5), 
 remain_j_99  number(5),
 remain_date  date,
    
 constraint pk_remain primary key(remain_year, remain_prod),
 constraint fk_remain foreign key(remain_prod)
    references prod(prod_id));--�����ض�
    
    
 ��)remain ���̺� ���� ���ǿ� �°� �ڷḦ �Է��Ͻÿ�
    (����)
    - �⵵ : 2005��
    - ��ǰ�ڵ� : ��ǰ���̺�(prod)�� ��ǰ�ڵ�
    - ������� : ��ǰ���̺�(prod)�� �������(prod_properstock)
    - �԰���� : 0
    - ������ : 0
    - �⸻��� : ��ǰ���̺�(prod)�� �������(prod_properstock)
    - ó������ : 2004�� 12�� 31��
    
    --�ѳ��� �Է� > values �� 
    --�ϰ��Է� > �������� ���
    insert into remain (remain_year, remain_prod, remain_j_00,remain_i,
                        remain_o, remain_j_99, remain_date)
        select '2005', prod_id, prod_properstock,0,0,prod_properstock, '20041231'
            from prod;
            
    **�������� �̿��� ���̺� ����
    create table remain2 as
        select * from remain;
        --remain2�� �⺻Ű�� �ܷ�Ű�� ���ٴ� �͸��� remain ���̺�� �ٸ���
        --�⺻Ű�� �ܷ�Ű�� ������!
        --�������� ����� ���� ����x
        
    2)���������� �̿��� data update
    
    ��)2005�� 1�� 31���� �������� ��ǰ�� �԰��������ȸ�Ͽ� ��� �������̺��� �����Ͻÿ�
    ��������) : 2005�� 1�� ��ǰ�� �԰������ ��ȸ

    SELECT BUY_PROD,SUM(BUY_QTY)
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
    GROUP BY BUY_PROD;
    
    (��������) : �������� ����� REMAIN���̺� ����
    --UPDATE ���̺�� �ٲ�� ���� I,J_99,DATE
    UPDATE REMAIN A
      SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE) = (--��������
        
        
    (����)
    UPDATE REMAIN A
    SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE) = (
        SELECT REMAIN_I+B.IAMT,
               REMAIN_J_00+REMAIN_I+B.IAMT-REMAIN_O,
               '20050131'
          FROM (SELECT BUY_PROD,SUM(BUY_QTY) AS IAMT
                    FROM BUYPROD
                WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
                GROUP BY BUY_PROD) B
            WHERE A.REMAIN_PROD =B.BUY_PROD)
    where a.remain_prod in (select distinct buy_prod
                            from buyprod
                            where buy_date between '20050101' and '20050131');
    rollback;
    
    
    UPDATE REMAIN A
    SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE) = (
        SELECT REMAIN_I+B.IAMT,
               REMAIN_J_00+REMAIN_I+B.IAMT-REMAIN_O,
               '20050131'
          FROM (SELECT BUY_PROD,SUM(BUY_QTY) AS IAMT
                    FROM BUYPROD
                WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
                GROUP BY BUY_PROD) B
            WHERE A.REMAIN_PROD =B.BUY_PROD)
    where a.remain_prod in (select distinct buy_prod
                            from buyprod
                            where buy_date between '20050201' and '20050331');
    
    
                            
    UPDATE REMAIN A
    SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE) = (
        SELECT REMAIN_I - B.IAMT,
               REMAIN_J_00+  REMAIN_I - B.IAMT-REMAIN_O,
               '200504%'
          FROM (SELECT BUY_PROD,SUM(BUY_QTY) AS IAMT
                    FROM cart
                WHERE BUY_DATE like '200504%'
                GROUP BY BUY_PROD) B
            WHERE A.REMAIN_PROD =B.BUY_PROD)
    where a.remain_prod in (select distinct buy_prod
                            from buyprod
                            where buy_date between '20050201' and '20050331');
    
    