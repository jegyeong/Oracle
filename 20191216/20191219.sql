2019-12-19 

1)자료입력
    -INSERT 문으로 지원
    (사용형식)
     INSERT INTO 테이블명[(컬럼명, 컬럼명, ...)] VALUES(값, 값,...);  --여러개라서 복수 
    -'(컬럼명, 컬럼명,...)' 은 생략 가능하나 생략하면 테이블에 존재하는 모든 컬럼에 적용될 값을 VALUES 절에서 기술해야함
    -'(컬럼명, 컬럼명,...)' 이 생략되면 값(데이터)을 기술 하는 순서는 테이블 내의 컬럼 순서와 일치해야함
    -'(컬럼명, 컬럼명,...)' 이 기술되면 기술된 순서에 맞춰 해당 컬럼에 저장될 값만 기술 가능. 단, 컬럼이 NOT NULL 로 기술되어 있으면 생략할 수 없다
    
 예) 다음에 주어진 자료를 거래처테이블(AUSTOMER)에 저장하는 쿼리 작성
    [자료] 
    거래처번호 : 'AC101'
    거래처명 : '삼보컴퓨터 주식회사'
    거래처주소 : '서울시 영등포구 당산2동 123-4567'
    대표자명 : '이삼보'
    
    거래처번호 : 'A201'
    거래처명 : '주식회사 A2M'
    거래처주소 : '대전시 유성구 대덕대로 123 테크노 4로 67'
    대표자명 : '박투엠'
    
    --문자열 데이터 정의 하기 위해서는 작은 따옴표 쓰기 
INSERT INTO ACUSTOMER(ACUSTOMID,ACUSTNAME,ACUSTADDR,ACEONAME)
    VALUES('AC1001','삼보컴퓨터주식회사','서울시영등포구당산2동123-4567',
            '이삼보');  --->>>줄바꿔도 상관없다
            

SELECT *FROM ACUSTOMER; --확인하기위해서

--CEO명 없이 자료 넣고 싶어
INSERT INTO ACUSTOMER VALUES( ); --오류 : 컬럼명 생략되면 다 기술해줘야함
INSERT INTO ACUSTOMER VALUES( 'A201','주식회사 A2M''대전시 유성구 대덕대로 123 테크노 4로 67'); -- 오류틈
INSERT INTO ACUSTOMER VALUES('A201','주식회사 A2M','대전시 유성구 대덕대로 123 테크노 4로 67',''); --화이트 스페이스('') 필요함 >>NULL처리가 된다
INSERT INTO ACUSTOMER( ) VALUES( ); --이러면 오류가 나온다 왜죠?
SELECT *FROM ACUSTOMER;        


    거래처번호 : 'A202'
    거래처명 : '(주)와토시스'
    거래처주소 : '대전시 대덕구 법동 123-45'
    대표자명 : 
 
 -- 대표자명 빼고 값을 입력하기 위해서 컬럼명 3개만 쓰고 자료도 3개만 씀! 그럼 자동으로 NULL처리됨
 INSERT INTO ACUSTOMER(ACUSTOMID,ACUSTNAME,ACUSTADDR) VALUES('A202','(주)와토시스', '대전시 대덕구 법동 123-45');   
 
 
    거래처번호 : 'A203'
    거래처명 : '(주)소프트상추'
    거래처주소 : 
    대표자명 : '김상추'
    
INSERT INTO ACUSTOMER(ACUSTOMID,ACUSTNAME,ACEONAME)
        VALUES('A203','(주)소프트상추','김상추') --오류뜸 ACUSTADDR > NOT NULL인데 NULL이 되니까
        
        --컬럼 생략가능한데, NOT NULL만 생략 가능 
    

문제] 상품테이블(GOODS)에 다음 자료를 입력하십오
    [자료]
    상품번호 : 'PI10101'
    상품명 : '무선 광 마우스'
    가격 : 15000
    거래처 : 주식회사 A2M -->'A201'로 바꿔서 해야혀
    
    
    상품번호 : 'P10201'
    상품명 : 'MS OFFICES 2018'
    가격 : 350000
    거래처 : (주)소프트상추--'A203'
    
INSERT INTO GOODS VALUES('PI10101','무선 광 마우스',15000,'A201');

    SELECT * FROM GOODS; 
    
INSERT INTO GOODS VALUES('P10201','MS OFFICES 2018'350000,'A203');


**상품 테이블에서 무선광마우스를 납품한 회사명과 대표자를 조회하시오--왜 이렇게 쓰는지만 알아두면됨
    SELECT ACUSTNAME AS 회사명, 
           ACEONAME AS 대표자
     FROM GOODS A, ACUSTOMER B
    WHERE A.ACUSTOMID=B.ACUSTOMID
      AND A.CNAME LIKE '무선%';
    