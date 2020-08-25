2020-01-22-02)view 객체
- 가상의 테이블
- 뷰는 테이블이나 또다른 뷰를 기반으로 생성
-(사용)
    .여러 테이블에 분산되어 저장된 정보를 하나의 결과로 반환 할 때
    .복잡한 연산이나 조인, 서브쿼리르 사용하는 쿼리가 자주 반복
    .특정 테이블의 정보를 다른 사용자에게 노출하지 말아애 하는 경우(보안)
    (사용형식)
    
    create view [or replace] [force| noforce] view 뷰 이름[(컬럼리스트)]
    as
     select 문
     [with check option [constraint 조건]]
     [with read only];
     
     
     .(컬럼리스트) : 생성되는 뷰에 부여할 컬럼명, 생략하면 원본테이블(뷰)의 컬럼명이 사용
     . or replace : 생성하려는 뷰와 동일한 이름의 뷰가 이미 존재하면 기존의 뷰를 대치
     .force| noforce : default는 noforce,기준이 되는 테이블이 없어도 뷰를 
                        생성시킬 때 force옵션 사용
     .with check option : 뷰의 생성에 사용된 select문의 where절 조건을  만족시키지
                            못하는 데이터를 뷰에  삽입하거나 뷰의 내용을 변경하지 못하도록 함. 
     .with read only  : 읽기 전용 뷰 생성                   
    
    예) 회원테이블에서 마일리지가 3000이상인 회원 회원번호, 회원명, 마일리지, 직업을 조회하여
        view_mem_01 이름의 view를 생성하시오.
    create or replace view view_mem_01
    as
        select mem_id as 회원번호,
              mem_name as 회원명,
              mem_mileage as  마일리지,
              mem_job as 직업
         from member
         where mem_mileage>=3000;         
       
      select * from view_mem_01;
      
     기존의  s001 안은정 3200 공무원의 마일리지를  바꾸려고 함
      
      update view_mem_01
         set 마일리지=55000
       where 회원번호='s001';--안은정의 마일리지를 뷰에서 찾아서 55000으로 바꿈
       
       select mem_id,mem_name,mem_mileage
         from member
        where mem_id='s001';
       --멤버 테이블에서 안은정이의 마일리지를 변경된걸 확인하는 거
    
     create or replace view view_lprod_01/*뷰 이름 바꿔줌*/(id,gubun,name)
      as 
           select * from lprod
            where lprod_id>=5;
          
          WITH READ ONLY;  
            
            
            select * from view_lprod_01;
  -----------------------------------------------------------------------------          
 (12번 가공농산물 행 삽입하는 줄)
            insert into view_lprod_01(ID,GUBUN,NAME)
                values(12,'P504','가공농산물')
                
              SELECT * FROM LPROD; 
  ---------------------------------------------------------------------------------
  ( 아이디가 11와 같은 행을 삭제)
  DELETE VIEW_LPROD_01
  WHERE ID=11;
   
    
    
 (with check option)
     create or replace view view_mem_01
    as
        select mem_id as 회원번호,
              mem_name as 회원명,
              mem_mileage as  마일리지,
              mem_job as 직업
         from member
         where mem_mileage>=3000 
        
       with check option;
    
    select * from view_mem_01;
    
    
    (1) view_mem_id 에서 회원번호'v001' 회원(이진영)의 마일리지를 5000으로 변경
    
    update view_mem_01
         set 마일리지=50000
       where 회원번호='v001';
       
  select * from view_mem_01; --바뀐거 확인하는 줄
    
    
     (2) view_mem_id 에서 회원번호'v001' 회원(이진영)의 마일리지를 500으로 변경
     update view_mem_01
         set 마일리지=500 -- 오류발생
       where 회원번호='v001';
       
  select * from view_mem_01; 
  
  
 ------------------------------------------------------------------------ 
  
  create or replace view view_lprod_01/*뷰 이름 바꿔줌*/(id,gubun,name)
      as 
           select * from lprod
            where lprod_id>=5
          
          WITH READ ONLY     --두개 동시사용 불가능
          with check option; 
            