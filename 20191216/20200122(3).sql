2020-01-22  03)sequence 객체
    - 자동적으로 증가. 감소하는 값을 반환하는 객체
    --테이블과는 별개로 사용된다
    - 테이블에서 독립적으로 생성되므로 여러 테이블에서 사용가능
    - 테이블 설계시 적당한 pk가 없는 경우 사용하거나 계속적으로 증가되는 값이 필요한 경우 사용 
    - 다른 dbms에서는 컬럼의 데이터 타입 중 number 값의 속성으로 제공되는 경우가 이씀
    (사용형식)
    create sequence 시퀀스명
        [start with n]
        [increment by n]
        [maxvalue n|nomaxvalue]
        [minvalue n|nominvalue]
        [minvalue n|nominvalue]
        [cycle|nocycle]
        [order|noorder]
        
        
    ** 의사컬럼(Pseudo Colum)-카상의 컬럼
    --------------------------------
    Pseudo Column           내용
    --------------------------------
    시퀀스명.nextval        '시퀀스명'객체의 다음 값
    시퀀스명.currval        '시퉌스명'객체의 현재값
    --------------------------------------------
    시퀀스 객체가 생성된 후 반드시 첫번째 명령으로 시퀀스명.nextval가 사용되어야함
    
    -select문의 select절, insert문의 subquerrydml select 절, value 절, update문의 set절에 사용
    
    select * from lprod;
    
    예) lpord 테이블에 다음 자료를 삽입하시오. 
        단, lprod_id 는 시퀀스를 이용하십시오
    --------------------------------
    lprod_id    lprod_gu    lprod_nm
    ---------------------------------
        7       P401        음반/CD
        8       P402        도서ㅓ
        9       P403        잡화
    ----------------------------------
    
    (1)시퀀스 생성
    create sequence seq_lprod
        start with 7;
        
    select seq_lprod.curruval from dual;
    
    (2)insert 문
    insert into lprod
    values(seq_lprod.nextval, 'P401', '음반/CD');
    
    insert into lprod
    values(seq_lprod.nextval, 'P402', '도서');
    
    insert into lprod
    values(seq_lprod.nextval, 'P403', '잡화');