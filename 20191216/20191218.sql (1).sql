2019-12-18 ������
 **������>���е�    >�ſ� ����� ���
  -���е��� 0�̾ƴ� �Ҽ��� ������ ��ȿ ���� �ڸ����� �ǹ�
  -������ - ���е��� �����Ҽ��� ������ �����ϴ� '0'�� ������ �ǹ�
  ---------------------------------------------------------------
  �Է°�                  ����                   ����Ǵ� ��
  ---------------------------------------------------------------
   1.234                number(4,5)             ����     >�������� ���ؾȰ���
   1.23                 number(3,5)             ����     >��ȿ���ڰ�??
   0.01234              number(4,5)             0.01234  >��ü 5�ڸ� 4-5=1 
   0.0012345            number(3,5)             0.00123  >5-3=2 0.00���ν���, ��ü 5�ڸ��� ������ �ڿ��� ©��
   ---------------------------------------------------------------
   
3. ��¥��
   - date, timestamp 
   - ���ϱ� ���� ��, ���ϱ� ������¾ȴ�

 1) date
   - �⺻ ��¥ �ڷ��� (7byte)
   - �� �� �� �� �� ���� �� ����(����?)
   - +, - �� ������ �����ϴ� 
  (�������) 
   �÷��� date
   -�ý����� �����ϴ� ��¥ ������ sysdate �Լ� �̿�
   -�Ϲ��ڷ�(����, ���ڿ�)�� ��¥ ������ ��ȯ�ϱ� ���ؼ� to_date�Լ��� ���� ��
   
   
   (�ڹ�)
   "123" + 10 > ���ڿ��� �켱�� > ���ڿ��̵ȴ�
   
   (����Ŭ)
   "123" + 10 > ������ �켱�� >133
   
 ��)
 creat table temp04(
    col1 date,
    col2 date);
    
 insert into temp04(col1,col2) values(sysdate, sysdate+20);
 
 sselect * from temp04;
 
 select to_char(col1, 'yyyy-mm-dd hh24:mi:ss') from temp04;
 
 
 2)timestamp 
   -����Ŭ ���� 9i ���� ����
   -10����� 1�ʱ��� ����
   -timestamp, timestamp with time zone, timestamp with local time zone
    (1)timestamp
     -�ð���(time zone)�� ������� ��¥ �ð� ���� ����
    (2)timestamp with time zone
     -�ð���(time zone)dhk skfWk tlrks wjdqh wjwkd
    (3) timestamp with local time zone
     -������ ��ġ�� ������ �ð���(time zone)�� ��¥ �ð� ���� ����
     
     (�������)
    �÷��� timestamp[timestamp with time zone|timestamp with local time zone]
    
��) 
 create table temp05(
    col1 date,
    col2 timestamp,
    col3 timestamp with time zone,
    col4 timestamp with local time zone);
    
    
 insert into temp05(col1,col2,col3,col4)
  values (sysdate,sysdate,sysdate,sysdate);
  
 select * from temp05;
 +
    
    
 
    
   
   
   
    
   