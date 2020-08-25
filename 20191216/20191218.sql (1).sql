2019-12-18 수요일
 **스케일>정밀도    >매우 희귀한 경우
  -정밀도는 0이아닌 소수점 이하의 유효 숫자 자리수를 의미
  -스케일 - 정밀도의 값은소수점 이하의 존재하는 '0'의 갯수를 의미
  ---------------------------------------------------------------
  입력값                  선언                   저장되는 값
  ---------------------------------------------------------------
   1.234                number(4,5)             오류     >뭔말인지 이해안가ㅠ
   1.23                 number(3,5)             오류     >유효숫자가??
   0.01234              number(4,5)             0.01234  >전체 5자리 4-5=1 
   0.0012345            number(3,5)             0.00123  >5-3=2 0.00으로시작, 전체 5자리라 나머지 뒤에는 짤림
   ---------------------------------------------------------------
   
3. 날짜형
   - date, timestamp 
   - 더하기 빼기 됨, 곱하기 나누기는안댜

 1) date
   - 기본 날짜 자료형 (7byte)
   - 년 월 일 시 분 초의 값 지정(저장?)
   - +, - 의 연산이 가능하다 
  (사용형식) 
   컬럼명 date
   -시스템이 제공하는 날짜 정보는 sysdate 함수 이용
   -일반자료(숫자, 문자열)를 날짜 형으로 변환하기 위해서 to_date함수가 제공 됨
   
   
   (자바)
   "123" + 10 > 문자열이 우선임 > 문자열이된다
   
   (오라클)
   "123" + 10 > 정수가 우선임 >133
   
 예)
 creat table temp04(
    col1 date,
    col2 date);
    
 insert into temp04(col1,col2) values(sysdate, sysdate+20);
 
 sselect * from temp04;
 
 select to_char(col1, 'yyyy-mm-dd hh24:mi:ss') from temp04;
 
 
 2)timestamp 
   -오라클 버전 9i 이후 제공
   -10억분의 1초까지 제공
   -timestamp, timestamp with time zone, timestamp with local time zone
    (1)timestamp
     -시간대(time zone)와 상관없이 날짜 시간 정보 저장
    (2)timestamp with time zone
     -시간대(time zone)dhk skfWk tlrks wjdqh wjwkd
    (3) timestamp with local time zone
     -서버가 위치한 지역의 시간대(time zone)와 날짜 시간 정보 저장
     
     (사용형식)
    컬럼명 timestamp[timestamp with time zone|timestamp with local time zone]
    
예) 
 create table temp05(
    col1 date,
    col2 timestamp,
    col3 timestamp with time zone,
    col4 timestamp with local time zone);
    
    
 insert into temp05(col1,col2,col3,col4)
  values (sysdate,sysdate,sysdate,sysdate);
  
 select * from temp05;
 +
    
    
 
    
   
   
   
    
   