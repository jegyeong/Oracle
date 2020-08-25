INSERT ALL
INTO or_estimate (
    EST_NO, EMP_NO, EST_DATE, EST_PRICE, EST_PROG
) VALUES (
    #{est_no}, #{emp_no}, sysdate, #{est_price}, #{est_prog}
)
INTO BUYER (
    BUYER_NO ,BUYER_NAME, CHARGER_NAME, BUYER_TEL
)VALUES (
    #{buyer_no}, #{buyer_name}, #{charger_name}, #{buyer_tel}
)
INTO OR_EST_P(
    PROD_NO, EST_NO, EST_QTY
)VALUES(
    #{PROD_NO}, #{EST_NO), #{EST_QTY}
)
SELECT EST_NO
FORM OR_ESTIMATE
WHERE EST_NO IS NOT NULL;

SELECT * FROM DUAL;

INSERT ALL
INTO or_estimate (
    EST_NO, EMP_NO, EST_DATE,
    EST_PRICE, EST_PROG, BUYER_NO, BUYER_NAME
) VALUES (
    1, 2, sysdate, 3,4,
   3, 6
)
INTO BUYER (
    BUYER_NO ,BUYER_NAME, CHARGER_NAME, BUYER_TEL

)VALUES (
    1, 2, 2, 3
)
INTO OR_EST_P(
    PROD_NO, EST_NO, EST_QTY
)VALUES(
    4, 5, 6
)
SELECT * FROM DUAL;