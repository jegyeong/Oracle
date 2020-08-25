--member, prod, cart
--세개의 테이블이 사용하고 마지막에 BUYER 를 가져다 붙인거잖아
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
    
--이너조인 상용하려면 미리 해놔
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
    
--상품정보 조회, 거래처명 같이 조회, prod, buyer -> 주데이터 가진애 왼쪽
--거래처가 없는 상품은 조회불가 -> INNER JOIN
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
    