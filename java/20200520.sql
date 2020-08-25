CREATE TABLE GRADE(
  CODE CHAR(4),
  TEXT VARCHAR2(10),
  CONSTRAINTS PK_GRADE PRIMARY KEY(CODE)
);

INSERT INTO grade (code, text) VALUES ('G001', '����');
INSERT INTO grade (code, text) VALUES ('G002', '�ʴ���');
INSERT INTO grade (code, text) VALUES ('G003', '����');
INSERT INTO grade (code, text) VALUES ('G004', '����');
INSERT INTO grade (code, text) VALUES ('G005', '�ڻ�');

commit;

CREATE TABLE LICENSE(
  CODE CHAR(4),
  TEXT VARCHAR2(40),
  CONSTRAINTS PK_LICENSE PRIMARY KEY(CODE)
);

INSERT INTO license (code, text) VALUES ('L001', '����ó�����');
INSERT INTO license (code, text) VALUES ('L002', '�������ȱ��');
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
--���⿡ �ڰ����� �ȳ��� ���� -> ���� ������ �̷������ �ʾƼ�?

CREATE TABLE STD_LICENSE(
  STD_CODE CHAR(4), LIC_CODE CHAR(4),
  constraints pk_std_license primary key(std_code, lic_code),
  CONSTRAINTS FK_STD_CODE_DDITSTUDENT FOREIGN KEY(STD_CODE) REFERENCES DDITSTUDENT(CODE),
  CONSTRAINTS FK_LIC_CODE_LICENSE FOREIGN KEY(STD_CODE) REFERENCES LICENSE(CODE)
);
COMMIT;
DROP TABLE STD_LICENSE;
--������� �ȵ�
--STD���̼��� �ܷ�Ű ������ �߰��� LIC_CODE�� �ٲٱ�

INSERT INTO dditstudent (
    code,    name,    birthday,    age,
    gr_code,    gen,    career
) 
SELECT 'S'|| LPAD(ROWNUM, 3, '0'), MEM_NAME, MEM_BIR, 23,
        'G003', 'M', '���� ���'
FROM MEMBER;        

COMMIT;


SELECT * FROM DDISTUDENT;

--LOWNUM S�� ���� ->
--Ŀ�Ծȵ�
--

INSERT INTO STD_LICENSE (STD_CODE, LIC_CODE)
VALUES ('S001', 'L001');
INSERT INTO STD_LICENSE (STD_CODE, LIC_CODE)
VALUES ('S001', 'L002');
COMMIT;

SELECT *
FROM DDITSTUDENT A INNER JOIN GRADE B ON (GR_CODE = B.CODE)
WHERE A.CODE = 'S001';

--���λ��! (�Ƚ�ǥ�� 
--���� �̷��� ������ �ϱ� ���ؼ� 
SELECT A.CODE, NAME, TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') BIRTHDAY, AGE,
        B.TEXT GRADE, DECODE(GEN, 'M', '��', '��') GEN, CAREER, C.LIC_CODE
FROM DDITSTUDENT A INNER JOIN GRADE B ON (GR_CODE = B.CODE)
               LEFT OUTER JOIN STD_LICENSE C ON(A.CODE = C.STD_CODE)
               LEFT OUTER JOIN LICENSE D ON (C.LIC_CODE = D.CODE)
WHERE A.CODE = 'S002';
--�ƿ������λ��!
--����° ������ �տ� ��� �� �ڿ� ���� ���� -> OUTER JOIN

--saveMember.setMem_id(rs.getString("MEM_ID"));
select 'vo.set'||
        SUBSTR(COLUMN_NAME,1,1)||
        SUBSTR(LOWER(COLUMN_NAME),2)||'(rs.get'||
        DECODE(DATA_TYPE,'NUMBER','Int','String')||
        '("'|| column_name||'"));'
from COLS
where table_name = 'DDITSTUDENT';


 SELECT   CODE,    NAME,    AGE,  DECODE(GEN, 'M', '��', '��') GEN 
 FROM    DDITSTUDENT;
 

 
 select * 
 from DDITSTUDENT
 where code='S001';
 
INSERT INTO DDITSTUDENT VALUES((select max(to_number(Substr(code,2)))+1), ?, ?, ?, ?, ?);

SELECT 'S'|| LPAD(TO_NUMBER(SUBSTR(MAX(CODE), 2))+1, 3, 0) 
FROM DDITSTUDENT;
