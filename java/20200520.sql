CREATE TABLE GRADE(
  CODE CHAR(4),
  TEXT VARCHAR2(10),
  CONSTRAINTS PK_GRADE PRIMARY KEY(CODE)
);

INSERT INTO grade (code, text) VALUES ('G001', '고졸');
INSERT INTO grade (code, text) VALUES ('G002', '초대졸');
INSERT INTO grade (code, text) VALUES ('G003', '대졸');
INSERT INTO grade (code, text) VALUES ('G004', '석사');
INSERT INTO grade (code, text) VALUES ('G005', '박사');

commit;

CREATE TABLE LICENSE(
  CODE CHAR(4),
  TEXT VARCHAR2(40),
  CONSTRAINTS PK_LICENSE PRIMARY KEY(CODE)
);

INSERT INTO license (code, text) VALUES ('L001', '정보처리기사');
INSERT INTO license (code, text) VALUES ('L002', '정보보안기사');
INSERT INTO license (code, text) VALUES ('L003', 'SQLD');
INSERT INTO license (code, text) VALUES ('L004', 'SQLP');

CREATE TABLE DDITSTUDENT(
  CODE CHAR(4),
  NAME VARCHAR2(20),
  BIRTHDAY DATE,
  AGE NUMBER(3),
  GR_CODE CHAR(4),
  GEN CHAR(1),
  CAREER VARCHAR2(100),
  CONSTRAINTS PK_DDITSTUDENT PRIMARY KEY (CODE),
  CONSTRAINTS FK_DDITSTUDENT_GRADE FOREIGN KEY(GR_CODE) REFERENCES GRADE(CODE)
);
--여기에 자격증을 안넣은 이유 -> 완전 종속이 이루어지지 않아서?

CREATE TABLE STD_LICENSE(
  STD_CODE CHAR(4), LIC_CODE CHAR(4),
  constraints pk_std_license primary key(std_code, lic_code),
  CONSTRAINTS FK_STD_CODE_DDITSTUDENT FOREIGN KEY(STD_CODE) REFERENCES DDITSTUDENT(CODE),
  CONSTRAINTS FK_LIC_CODE_LICENSE FOREIGN KEY(STD_CODE) REFERENCES LICENSE(CODE)
);
COMMIT;
DROP TABLE STD_LICENSE;
--여기부터 안됨
--STD라이센스 외래키 위에서 중간꺼 LIC_CODE로 바꾸기

INSERT INTO dditstudent (
    code,    name,    birthday,    age,
    gr_code,    gen,    career
) 
SELECT 'S'|| LPAD(ROWNUM, 3, '0'), MEM_NAME, MEM_BIR, 23,
        'G003', 'M', '대충 경력'
FROM MEMBER;        

COMMIT;


SELECT * FROM DDISTUDENT;

--LOWNUM S로 시작 ->
--커밋안됨
--

INSERT INTO STD_LICENSE (STD_CODE, LIC_CODE)
VALUES ('S001', 'L001');
INSERT INTO STD_LICENSE (STD_CODE, LIC_CODE)
VALUES ('S001', 'L002');
COMMIT;

SELECT *
FROM DDITSTUDENT A INNER JOIN GRADE B ON (GR_CODE = B.CODE)
WHERE A.CODE = 'S001';

--조인사용! (안시표준 
--대졸 이렇게 나오게 하기 위해서 
SELECT A.CODE, NAME, TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') BIRTHDAY, AGE,
        B.TEXT GRADE, DECODE(GEN, 'M', '남', '여') GEN, CAREER, C.LIC_CODE
FROM DDITSTUDENT A INNER JOIN GRADE B ON (GR_CODE = B.CODE)
               LEFT OUTER JOIN STD_LICENSE C ON(A.CODE = C.STD_CODE)
               LEFT OUTER JOIN LICENSE D ON (C.LIC_CODE = D.CODE)
WHERE A.CODE = 'S002';
--아우터조인사용!
--세번째 조인은 앞에 결과 와 뒤에 꺼의 조인 -> OUTER JOIN

--saveMember.setMem_id(rs.getString("MEM_ID"));
select 'vo.set'||
        SUBSTR(COLUMN_NAME,1,1)||
        SUBSTR(LOWER(COLUMN_NAME),2)||'(rs.get'||
        DECODE(DATA_TYPE,'NUMBER','Int','String')||
        '("'|| column_name||'"));'
from COLS
where table_name = 'DDITSTUDENT';


 SELECT   CODE,    NAME,    AGE,  DECODE(GEN, 'M', '남', '여') GEN 
 FROM    DDITSTUDENT;
 

 
 select * 
 from DDITSTUDENT
 where code='S001';
 
INSERT INTO DDITSTUDENT VALUES((select max(to_number(Substr(code,2)))+1), ?, ?, ?, ?, ?);

SELECT 'S'|| LPAD(TO_NUMBER(SUBSTR(MAX(CODE), 2))+1, 3, 0) 
FROM DDITSTUDENT;
