2020-01-20  3)merge ���
    - ������ ���Ͽ� ���ǿ� ��ġ�ϴ� �ڷᰡ ������ insert ����
      ���ǿ� ��ġ�ϴ� �ڷᰡ ������ update ���� �����ϴ� ��ɹ�
      
      (�������)
    merge into ���̺��
        using (insert �� update �� �ɸ� ������ ��õ) on (updte �� ����)
    when matched then
        update 
            set �÷���1 = ��1 [, �÷���2 = �� 2, ....]
    where ����
    
    when not matched then
        insert(�÷���1 [,�÷���2, ...]) values(��1, [,��2,...])
        where ����;
        
��) ��ǰ�з� ���̺��� ���� �ڷḦ �߰� �Ǵ� �����Ͻÿ�
    ���� : 7
    �з��ڵ� : 'P401'
    �з��� : 'DVD'
    
    ���� : 10 
    �з��ڵ� : 'P501'
    �з��� : '��깰'
    
    update lprod
        set lprod_nm = 'DVD',
            lprod_id = 11,
        where lprod_lgu = 'P401'; 
    rollback;
    
    merge into lprod a
        using dual on (lprod_gu = 'P401')
    when matched then
        update 
            set lprod_id = 11,
                lprod_nm = 'DVD',
            --where lprod_gu ='P401'
    when not matched then
            insert (a.lprod_id, a.lprod_gu, a.lprod_nm) values (11, 'P401', 'DVD');
            