2019-12-16 사용자 계정 만들기
 -데이터베이스에 접근하는사용자 생성
 -권한부여 
 
 (사용형식)
 CREATE USER 사용자명(이니셜LJG) IDENTIFIED BY 암호(java);

범위선택후 초록 화살표 ㅒㄲ 컨트롤 엔터
 CREATE USER LJG IDENTIFIED BY java; 
>권한부여 grant 
>항상 마지막은 세미콜론;
 GRANT 권한명 .. TO 사용자명;

~ @ at & 이거 이름

-권한명 : CONECT, RESOURCE, DBA

 GRANT 권한명,... TO 사용자명;
  GRANT CONNECT, RESOURCE, DBA TO LJG;

CREATE USER 사용자명(이니셜LJG) IDENTIFIED BY 암호(java);
 CREATE USER LJG IDENTIFIED BY java;
 
 GRANT 권한명,... TO 사용자명;
  GRANT CONNECT, RESOURCE, DBA TO LJG;
  
 
**비밀번호변경
(사용형식)

AlTER USER 사용자명 IDENTIFIED BY 새암호;





  