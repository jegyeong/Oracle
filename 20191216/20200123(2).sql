2020-01-23  02)index 객체

    - 데이터의 검색 효울을 증가시키기 위한 바앙ㄴ
    - where 절이 사용되는 쿼리에서 처리 속도 증대
    - 데이터의 그룹화나 sort(order by) 의 처리속도 증가
    - dbms 의 부담을 덜어줌
    - 인덱스가 구성되면 유지관리에 시간과 공간이 소요
      (삽입/삭제/변경 동작이 많은 테이블에는 인덱스의 유지관리에 많은 시간 소요ㅛ)
      
    Unique/non-unique index 
     - index : 중복값을 허용하지 않는 인덱스(기본키, 외래키로 만들어지는 인덱스)
             : 기본키, 외래키 인텍스를 제외하고 null도 허용되나 한번만 사용가능
     - non-unique : 중복 및 null 값 허용
     - single/Composite index
       single : 하나의 컬럼으로 구성된 인덱스
       Composite : 두개 이상의 컬럼으로 구성된 인덱스
     
     . 자동/수동 index
   - 테이블생성시 pk 또는 Unique constraint 조건기술시 생성
   - 수동 : creat index 명령으로 생성
  . 인덱스 구성방식에 따른 분류
   - Normal Index : 기본인덱스(B-Tree index)
    . 트리구조로 구성
    . 컬럼값과 rowid를 기반으로 저장위치 계산
  - Bitmap Index : 컬럼값과 rowid를 2진수로 조합하여 주소계산
    . 수정/삭제/삽입이 많이 발생하는 경우 비효율적
  - Function-Based Index : 인덱스 구성컬럼에 함수가 사용된 경우 
    . 보통 함수기반 인덱스는 기본인덱스 방식에 함수가 추가된 형식임
    
    
    (사용형식)
    create [unique|bitmap] index 인덱스명
        on 테이블명(컬럼명1 [,컬럼명2,...]) [asc|desc]
        
create index idx_member on member (mem_regno1, mem_regno2);
     
create index idx_mem_02 on member (substr(mem_name,2));

select mem_name, mem_add1, mem_job
    from member
    where mem_name = '오철희';
 
select mem_name, mem_add1, mem_job
    from member
    where substr(mem_name,2) = '철희';
    
drop 


    **인덱스 재구성
(사용형식)
alter index 인덱스명 rebuild 
    - 기존 테이블과 인덱스가 다른 workspace로 이동된 후
    - 삭제/수정 등의 작업이 많이 발생된 후 
    
    
