2020-01-22  03)sequence ��ü
    - �ڵ������� ����. �����ϴ� ���� ��ȯ�ϴ� ��ü
    --���̺���� ������ ���ȴ�
    - ���̺��� ���������� �����ǹǷ� ���� ���̺��� ��밡��
    - ���̺� ����� ������ pk�� ���� ��� ����ϰų� ��������� �����Ǵ� ���� �ʿ��� ��� ��� 
    - �ٸ� dbms������ �÷��� ������ Ÿ�� �� number ���� �Ӽ����� �����Ǵ� ��찡 �̾�
    (�������)
    create sequence ��������
        [start with n]
        [increment by n]
        [maxvalue n|nomaxvalue]
        [minvalue n|nominvalue]
        [minvalue n|nominvalue]
        [cycle|nocycle]
        [order|noorder]
        
        
    ** �ǻ��÷�(Pseudo Colum)-ī���� �÷�
    --------------------------------
    Pseudo Column           ����
    --------------------------------
    ��������.nextval        '��������'��ü�� ���� ��
    ��������.currval        '�ùZ����'��ü�� ���簪
    --------------------------------------------
    ������ ��ü�� ������ �� �ݵ�� ù��° ������� ��������.nextval�� ���Ǿ����
    
    -select���� select��, insert���� subquerrydml select ��, value ��, update���� set���� ���
    
    select * from lprod;
    
    ��) lpord ���̺� ���� �ڷḦ �����Ͻÿ�. 
        ��, lprod_id �� �������� �̿��Ͻʽÿ�
    --------------------------------
    lprod_id    lprod_gu    lprod_nm
    ---------------------------------
        7       P401        ����/CD
        8       P402        ������
        9       P403        ��ȭ
    ----------------------------------
    
    (1)������ ����
    create sequence seq_lprod
        start with 7;
        
    select seq_lprod.curruval from dual;
    
    (2)insert ��
    insert into lprod
    values(seq_lprod.nextval, 'P401', '����/CD');
    
    insert into lprod
    values(seq_lprod.nextval, 'P402', '����');
    
    insert into lprod
    values(seq_lprod.nextval, 'P403', '��ȭ');