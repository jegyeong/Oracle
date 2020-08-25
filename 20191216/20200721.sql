UPDATE INTO OR_ESTIMATE
	SET 
		EST_PROG = 'OR01'
		WHERE EST_NO = 9;
        
UPDATE or_estimate
    SET
        est_prog = 'OR01'
WHERE
    est_no = 9;
    
    
    COMMIT;
    
UPDATE orderp
SET
      or_status = #{or_status}
WHERE
    or_no = #{or_no}
    AND   buyer_no =:v1
    AND   emp_no =:v2
    AND   est_no =:v3
    AND   or_date =:v4
    AND   or_req_date =:v5
    AND   or_status =:v6;
    
    commit;
    
UPDATE or_delivery
    SET
        deliv_prog = #{deliv_prog}
WHERE
    deliv_no = #{deliv_no};
    
    
    COMMIT;
    
UPDATE or_shipment
    SET
        ship_prog = #{ship_prog}
WHERE
    ship_no = #{ship_no};
    
    SELECT COUNT(*)
    	FROM OR_SHIPMENT A INNER JOIN EMPLOYEE B ON (A.EMP_NO = B.EMP_NO)
						   INNER JOIN OR_DELIVERY E ON (A.DELIV_NO = E.DELIV_NO)
						   LEFT OUTER JOIN(
                                SELECT DISTINCT W.OR_NO, V.DELIV_NO, W.OR_REQ_DATE, F.BUYER_NO, F.BUYER_NAME
                                FROM ORDERP W INNER JOIN OR_DELIVERY V ON (W.OR_NO = V.OR_NO) 
                                			  INNER JOIN BUYER F ON (W.BUYER_NO = F.BUYER_NO)
                           ) C ON (A.DELIV_NO = C.DELIV_NO) 
                           LEFT OUTER JOIN(
						   		SELECT DISTINCT S.OR_NO, R.DELIV_NO, S.PROD_NO, O.PROD_NAME
                                FROM OR_PLIST S INNER JOIN OR_DELIVERY R ON(S.OR_NO = R.OR_NO)
                                                INNER JOIN PROD O ON (S.PROD_NO = S.PROD_NO)
						   ) D ON (A.DELIV_NO = D.DELIV_NO);

commit;