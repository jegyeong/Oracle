--member, prod, cart
--������ ���̺��� ����ϰ� �������� BUYER �� ������ ���ΰ��ݾ�
SELECT
    mem_id, mem_pass, mem_name,  mem_regno1,  mem_regno2,  mem_bir,   mem_zip,   
    mem_add1, mem_add2, mem_hometel, mem_comtel, mem_hp, mem_mail, mem_job, mem_like, mem_memorial, 
    mem_memorialday, mem_mileage, mem_delete
    , prod_id, prod_name, prod_cost, prod_price, prod_mileage
    , prod_buyer, buyer_name
    FROM member left outer join cart on(mem_id = cart_member)
                left outer join prod on(cart_prod = prod_id)
                left outer join buyer on(prod_buyer=buyer_id)
    where mem_id = 'a001';
    
--�̳����� ����Ϸ��� �̸� �س�
SELECT
    mem_id, mem_pass, mem_name,  mem_regno1,  mem_regno2,  mem_bir,   mem_zip,   
    mem_add1, mem_add2, mem_hometel, mem_comtel, mem_hp, mem_mail, mem_job, mem_like, mem_memorial, 
    mem_memorialday, mem_mileage, mem_delete
    , prod_id, prod_name, prod_cost, prod_price, prod_mileage
    , prod_buyer, buyer_name
    FROM member left outer join cart on(mem_id = cart_member)
                left outer join (
                SELECT BUYER_NAME, PROD.*
                FROM PROD INNER JOIN BUYER ON(PROD_BUYER = BUYER_ID)
                ) on(prod_buyer=buyer_id)
    where mem_id = 'a001';
    
--��ǰ���� ��ȸ, �ŷ�ó�� ���� ��ȸ, prod, buyer -> �ֵ����� ������ ����
--�ŷ�ó�� ���� ��ǰ�� ��ȸ�Ұ� -> INNER JOIN
SELECT BUYER_NAME, PROD.*
FROM PROD INNER JOIN BUYER ON(PROD_BUYER = BUYER_ID);

SELECT '<result property="'|| LOWER(COLUMN_NAME)||'" column="'||COLUMN_NAME||'"/>'
FROM COLS
WHERE TABLE_NAME = 'MEMBER';

    SELECT 'private '||DECODE(DATA_TYPE, 'NUMBER ', 'Integer ', 'String ')     || LOWER(COLUMN_NAME)||';' FROM COLS WHERE TABLE_NAME ='BUYER';
    
    
    SELECT
    buyer_id,
    buyer_name,
    buyer_lgu,
    buyer_bank,
    buyer_bankno,
    buyer_bankname,
    buyer_zip,
    buyer_add1,
    buyer_add2,
    buyer_comtel,
    buyer_fax,
    buyer_mail,
    buyer_charger,
    buyer_telext
FROM
    buyer;
    