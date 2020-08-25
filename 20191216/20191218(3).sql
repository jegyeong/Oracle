--�ŷ�ó ���̺� ����   �������� 

 CREATE TABLE ACUSTOMER(
   ACUSTOMID CHAR(4) NOT NULL,                                     --�⺻Ű
   ACUSTNAME VARCHAR2(50) NOT NULL,
   ACUSTADDR VARCHAR2(100),
   ACEONAME VARCHAR2(30),
   
   CONSTRAINT pk_acustomer PRIMARY KEY(ACUSTOMID));  --�⺻Ű
   

--��ǰ ���̺� ����
 
 CREATE TABLE GOODS(
    GID CHAR(6) NOT NULL, --�⺻Ű
    GNAME VARCHAR2(50) NOT NULL,
    GPRICE NUMBER(7)   default 0,       --���ڴϱ� �ѹ�, default 0 �ȳ����� ���� 0�̴� 
    ACUSTOMID CHAR(4) NOT NULL, --�ܷ�Ű
    
    --���߿� �⺻Ű�� �� Į�� �ȿ� �ִ°� ����ϱ� 
    --fk_(�����̺��)_�ܷ��� ������ ���̺��--> �� ���̺���� ���� ����
    CONSTRAINT pk_goods PRIMARY KEY(GID), --�⺻Ű
    CONSTRAINT fk_goods_acustomer FOREIGN KEY(ACUSTOMID) --�޸� �� , �ܷ�Ű
      REFERENCES ACUSTOMER(ACUSTOMID));
      
      --�ܷ�Ű 3���ε� 3���̺��� ������ > 3��Ʈ �������
      --�ܷ�Ű 3���ε� 2���� ���� ���̺��� �����Դٸ� �ĸ���� �����
      
      
 DROP TABLE ACUSTOMID   
 --��������. (�ܷ�Ű) �̰��� �����ϰ� �ִ� ���̺��� �ֱ⶧���� �������� �ʴ´�. �����ϰ� �ִ� ���̺��� ���� ����� ����� �ִ�. �ܷ�Ű ���� ����� ����� ����
 
 
 --�����פ��� ����
 CREATE TABLE CUSTOMER(
    CUSID CHAR(4) NOT NULL,                 --�⺻Ű
    CUSNAME VARCHAR2(30) NOT NULL,
    CUSADDR VARCHAR(100) NOT NULL,
    CUSTELNO VARCHAR2(30),
    
    CONSTRAINT pk_customer PRIMARY KEY(CUSID)); --����Űpk, �ܷ�Ű ���̴ϱ� �Ƚ��ذ�
    
    
 ---��ٱ��� ���̺� ����   
 CREATE TABLE SHCART(
    CUSID CHAR(4) NOT NULL, --�ܷ�Ű & �⺻Ű
    GID CHAR(6) NOT NULL,   --�ܷ�Ű & �⺻Ű
    SHDATE DATE NOT NULL,
    SHQTY NUMBER(4),   --��ȣ�� ���� �ڸ��� 
    
    CONSTRAINT pk_shcart PRIMARY KEY(GID,CUSID),    --�⺻Ű�� ���׿� �پ� �� �־�
    CONSTRAINT fk_shcart_goods FOREIGN KEY(GID)     --�ܷ�Ű�� ��ó�� �ٸ��� ���� �����, ������ ���� �ᵵ ��
        REFERENCES GOODS (GID),
    CONSTRAINT fk_shcart_customer FOREIGN KEY (CUSID)
        REFERENCES CUSTOMER (CUSID));
        
        
--�ŷ�ó ���̺� ����
 CREATE TABLE PUCH (    
    ACUSTOMID CHAR(4) NOT NULL,   --�⺻Ű & �ܷ�Ű
    GID CHAR(6) NOT NULL,         --�⺻Ű & �ܷ�Ű  
    PUDATE DATE DEFAULT SYSDATE ,        --  SYSDATE �ý����� �����ϴ� ��¥ �ֱ� ���ؼ� 
    PUQTY CHAR(4) NOT NULL,
    
    CONSTRAINT pk_puch PRIMARY KEY(ACUSTOMID,GID),   --�⺻Ű
    CONSTRAINT fk_puch_acustomer FOREIGN KEY(ACUSTOMID)  --�ܷ�Ű
        REFERENCES ACUSTOMER (ACUSTOMID), 
    CONSTRAINT fk_puch_goods FOREIGN KEY(GID)
        REFERENCES GOODS (GID));
        
        
        -----ǥ������ �����̸��� ���� ��������
        ------>���� �̵��� ���� ���� ���� ���� ����
        
    
        
 
    
 
    
    
   
   
   