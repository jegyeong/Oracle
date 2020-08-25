2019-12-17 자료형
1.문서자료형
-문자열 자료를 저장하기위한 자료형
-' '로 묶어 표현


-char, nchar, varchar, varchar2, long , clob
-char : 고정길이 데이터 타입(마련된 기억장소 보다 데이터 가 작으면 오른쪽 끝에 공백이 들어감, 크면 저장안됨) [공백이 오른쪽에 생기는 이유 > 글자는 항상 왼쪽 정령
-var=가변적인 것이라는뜻 varchar >기억장소 넘는거나 작은거 자름> 효율적> 검색할때 매우 유용
-varchar2 : 오로지 오라클에서만 지원 > 사실 varchar와 똑같다 > 데이터 길이만큼 저장하고 나머지는 버림
-long : 쓰긴 쓰는데 없뎃X  권고 쓰지마라,  기억장소 2기가
-clob(씨엘로비) : 4기가까지 쓸 수 있다. 

-한글 한글자는 3byte 임

-테이블이름 ex) TMP01, TMP02 .. 는 중복될 수 없고, 컬럼명 ex) COL1, COL2 ...는 중복될 수 있다.

1)char
 -  고정길이문자열을 지정
 - 최대 2000 Byte 까지 저장가능
 - 기억공간이 남으면 남는 기억공간(오른쪽)은 공백 처리
 (사용형식)
 컬럼명 CHAR(크기[BYTE|CHAR])  >>뭔소리인지 모르겠음..
 ()생략가능한것, |로 나눠져있으면 둘 중에 하나는 써야함, 둘다는 못씀 생략함
 -'[BYTE|CHAR]'는 생략 가능. 생갹하면 BYTE 간주됨
 -한글을 저장할 때 2000 BYTE 를 초과하는 자료를 저장할 수 없음
 >길이가 고정되어야할 필요성이 있을 때 (기본키) 
  예) 
  COL1 CHAR(50) > COL1의 기억공간은 50 BYTE >자동으로 BYTE로 간주됨
  NANE CHAR(20 BYTE) > NAME 기억장소(항목명,컬럼명)는 20BYTE로 확보됨
  NAME CHAR(20 CHAR) > 영문자인 경우는 20BYTE 한글인 경우는 최대 60BYTE 
  
  >아직 잘 몰라두됑, 일단은 뜻만 알면됑
  
  CREATE TABLE TMP01(
   COL1 CHAR(20),
   COL2 CHAR(20 BYTE),
   COL3 CHAR(20 CHAR));
   
   INSERT INTO TMP02 (COL1,CO2,COL3) VALUES('ABCDEFG', '대한민국의 수도', '대한민국페루칠레,몽골,하노이!');
   
   SELECT * FROM TMP01;
   
   SELECT LENGTB(COL1), LENGTB(COL2),  LENGTB(COL3) FROM TMP01;
   
 
   
   2)varchar2 
   -가변길이 문자열 저장(데이터의 크기만큼 저장하고 빈공간을 없앤다
   -최대 4000 BYTE 까지 저장 가능(영어 4000자 한글 약 1300자)
   -문자자료를 기억공간 왼쪽부터 저장하고 남는 기억공간은 잘라냄
   (사용형식)
   컬럼명 varchar2(크기[BYTE|CHAR])
   -'[BYTE|CHAR]'가 생략되면 BYTE로 간주
   -전체크기 4000 BYTE를 초과할 수 없음
 예)
    COL1 varchar2(20) > 최대 20 BYTE 확보
    
    CREATE TABLE TMP02(
    COL1 varchar2 (20),
    COL2 varchar2 (20 BYTE),
    COL3 varchar2 (20 CHAR));
    
    INSERT INTO TMP02  VALUES('IT POSTED', '대전시', '대전시 중구 대흥동 500번지 영민빌');
    INSERT INTO TMP02  VALUES('PESIMON', '데이터베이스', '대전시 중구 대흥동');
    
    SELECT * FROM TMP02;
    SELECT * FROM TMP01;
    
    SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3) FROM TMP02;
    

    3)VARCHAR
    - varchar2와 동일한 형식으로 자료 저장
    - oracle에서 varchar2 사용을 권고
    
    4)long
    -가변길이 데이터 저장에 사용
    -최대 2GB까지 사용가능
    -한 테이블에 하나의 항목만 long타입으로 정의
    -오라클에서 지원이 중단(clob로 대치)
    (사용형식)
    컬럼명 long 
    
    예) 
    create table tmp03(
     col1 long,
     col2 varchar2(4000));
    
    INSERT into tmp03(col1,col2) values('boyhood', '테이블 생성 예제');
    
    select * from tmp03;
 
 
 2.숫자 자료형
  -number 자료형이 존재
  -실수(소수점을 내부에 포함하는 수), 정수 모두 표현가능
  (사용형식)
  컬럼명 number[(정밀도[,스케일))]
   ***정밀도>스케일 경우
   > 정밀도 : 전체 자리수  , 스케일 : 소수점 자리수 
   -표현 범위 : 1.0e-30 ~ 9.9999....99e125(소숫점 이하는 38자리)(10^125)
      >e는 곱하기???  
    -스케일이 음수면 정수부분의 스케일이 가리키는 자리수에서  반올림
   컬렴명 number   >
   컬럼명 number(50)    >이러면 50단위의 숫자 처리가능
   컬럼명 number(10,3)  >정수부분 7자리, 소수점 이하 3자리(스케일까지 쓴거)
   컬럼면(*,3)  > *(오라클이 허용하는 수치 범위내면 된다)정수부분은 오라클이 허용하는 만큼, 소수부분만 3자리로 제한 
      ()>면 스케일이 0이다
   예) 
   -------------------------------------------------------------
   입력값                  정의                      기억되는 값
   -------------------------------------------------------------
   7,123,456.87         number                      7,123,456.87
   7,123,456.87         number(*,1)                 7,123,456.9
   7,123,456.87         number()                    7,123,457
   7,123,456.87         number(10)                  7,123,457
   7,123,456.87         number(6)                   오류  > 왜오류지?
   7,123,456.87         number(9,-2)                7,123,4500
  
 