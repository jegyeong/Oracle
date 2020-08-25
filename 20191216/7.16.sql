SELECT NVL(MAX(DELIV_NO), 0)+1 FROM OR_DELIVERY;

SELECT COUNT (*)
FROM OR_DELIVERY A INNER JOIN EMPLOYEE B ON (A.EMP_NO = B.EMP_NO)
						   LEFT OUTER JOIN (
						   	SELECT DISTINCT D.OR_NO, E.PROD_NO, E.PROD_NAME
						   	FROM OR_PLIST D INNER JOIN PROD E ON (D.PROD_NO = E.PROD_NO)
						   ) C ON (A.OR_NO = C.OR_NO);
                           
SELECT Z.* ,
			V.PROD_NO, V.PROD_NAME, V.PROD_STANDARD,
			Y.EMP_NO, Y.EMP_NAME,
			V.ORP_QTY
		FROM OR_DELIVERY Z INNER JOIN EMPLOYEE Y ON (Z.EMP_NO = Y.EMP_NO)
						   LEFT OUTER JOIN(
						   		SELECT W.PROD_NO, W.PROD_NAME, W.PROD_STANDARD, X.ORP_QTY, X.OR_NO
						   		FROM OR_PLIST X INNER JOIN PROD W ON (X.PROD_NO = W.PROD_NO)
						   ) V ON (Z.OR_NO = V.OR_NO)			
		WHERE DELIV_NO = #{deliv_no};
        
    
    
INSERT INTO or_shipment (
    ship_no, deliv_no, emp_no, ship_date,
    ship_p_date, ship_prog
) VALUES (

);


INSERT INTO OR_SHIPMENT (
		    SHIP_NO, DELIV_NO, EMP_NO, 
		    SHIP_DATE, SHIP_P_DATE, SHIP_PROG
		) VALUES (
			1, 2, '2020070708', '20190809', '20190809', 'B001' 
		);
        
        
        select * from rule;
        