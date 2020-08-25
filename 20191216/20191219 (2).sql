2019-12-19
    2)자료수정
     -UPDATE 문으로 지원
     (사용형식) 
     
   UPDATE 테이블명 --테이블안에는 반ㄷ시 내용이 있어야함!
      SET 컬럼명=값  ----변경할 값!(새로운값)
          컬럼명=값,... 
   [WHERE 조건];  --생략가능  >>뭔소리인질 잘 모르겠음
   
예)상품테이블에서 '무선 광 마우스'(P10101)의 판매가를 20000원으로 수정하시오

UPDATE GOODS 
  SET GPRICE -20000:
  
  SELECT * FROM GOODS); --where 없으면 다바꾸ㅏ는건줄 알아 
  
ROLLBACK; 은 최후의 커밋한 상태ㅗ 돌아감 

UPDATE GOODS 
    SET GPRICE -20000:
  WHERE GNAME LIKE '무선%'
 
 SELECT * FROM GOODS;
 
 예제) 회원테이블(MEMBER)에서 직업(MEM_JOB)이 '학생'인 회원의 마일리지(MEM_MILEAGE)를 모두 3000으로 변경하시오
 
 UPDATE MEMBER
    SET MEM_MILEAGE=3000--변경할 값
        MEM_PASS='AAA'
  WHERE MEM_JOB='학생';
  
  SELECT MEN_NAME, MEM_MILEAGE, MEM_PASS
    FROM MEMBER
   WHERE MEM_JOB='학생';
   
ROLLBACK;

