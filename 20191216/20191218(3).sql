--거래처 테이블 생성   상싲걱으로 

 CREATE TABLE ACUSTOMER(
   ACUSTOMID CHAR(4) NOT NULL,                                     --기본키
   ACUSTNAME VARCHAR2(50) NOT NULL,
   ACUSTADDR VARCHAR2(100),
   ACEONAME VARCHAR2(30),
   
   CONSTRAINT pk_acustomer PRIMARY KEY(ACUSTOMID));  --기본키
   

--상품 테이블 생성
 
 CREATE TABLE GOODS(
    GID CHAR(6) NOT NULL, --기본키
    GNAME VARCHAR2(50) NOT NULL,
    GPRICE NUMBER(7)   default 0,       --숫자니까 넘버, default 0 안넣으면 값이 0이다 
    ACUSTOMID CHAR(4) NOT NULL, --외래키
    
    --이중에 기본키는 내 칼럼 안에 있는것 기술하기 
    --fk_(내테이블명)_외래로 가져온 테이블명--> 내 테이블명은 생략 가능
    CONSTRAINT pk_goods PRIMARY KEY(GID), --기본키
    CONSTRAINT fk_goods_acustomer FOREIGN KEY(ACUSTOMID) --콤마 ㄴ , 외래키
      REFERENCES ACUSTOMER(ACUSTOMID));
      
      --외래키 3개인데 3테이블에서 가져옴 > 3세트 써줘야함
      --외래키 3개인데 2개를 같은 테이블에서 가져왔다면 컴마찍고 쓰면됨
      
      
 DROP TABLE ACUSTOMID   
 --안지워짐. (외래키) 이것을 참조하고 있는 테이블이 있기때문에 지워지지 않는다. 참조하고 있는 테이블을 먼저 지우면 지울수 있다. 외래키 먼저 지우면 지우기 가능
 
 
 --히원테ㅇ블 생성
 CREATE TABLE CUSTOMER(
    CUSID CHAR(4) NOT NULL,                 --기본키
    CUSNAME VARCHAR2(30) NOT NULL,
    CUSADDR VARCHAR(100) NOT NULL,
    CUSTELNO VARCHAR2(30),
    
    CONSTRAINT pk_customer PRIMARY KEY(CUSID)); --고정키pk, 외래키 없이니까 안써준거
    
    
 ---장바구니 테이블 생성   
 CREATE TABLE SHCART(
    CUSID CHAR(4) NOT NULL, --외래키 & 기본키
    GID CHAR(6) NOT NULL,   --외래키 & 기본키
    SHDATE DATE NOT NULL,
    SHQTY NUMBER(4),   --괄호안 숫자 자리수 
    
    CONSTRAINT pk_shcart PRIMARY KEY(GID,CUSID),    --기본키는 한항에 다쓸 수 있어
    CONSTRAINT fk_shcart_goods FOREIGN KEY(GID)     --외래키는 출처가 다르면 따로 써야해, 같으면 같이 써도 됨
        REFERENCES GOODS (GID),
    CONSTRAINT fk_shcart_customer FOREIGN KEY (CUSID)
        REFERENCES CUSTOMER (CUSID));
        
        
--거래처 테이블 생성
 CREATE TABLE PUCH (    
    ACUSTOMID CHAR(4) NOT NULL,   --기본키 & 외래키
    GID CHAR(6) NOT NULL,         --기본키 & 외래키  
    PUDATE DATE DEFAULT SYSDATE ,        --  SYSDATE 시스템이 제공하는 날짜 넣기 위해서 
    PUQTY CHAR(4) NOT NULL,
    
    CONSTRAINT pk_puch PRIMARY KEY(ACUSTOMID,GID),   --기본키
    CONSTRAINT fk_puch_acustomer FOREIGN KEY(ACUSTOMID)  --외래키
        REFERENCES ACUSTOMER (ACUSTOMID), 
    CONSTRAINT fk_puch_goods FOREIGN KEY(GID)
        REFERENCES GOODS (GID));
        
        
        -----표준적인 영문이름을 쓰는 것이좋다
        ------>많은 이들이 쓰는 것을 쓴느 것이 좋다
        
    
        
 
    
 
    
    
   
   
   