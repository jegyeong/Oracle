2020-01-20  3)merge 명령
    - 조건을 비교하여 조건에 일치하는 자료가 없으면 insert 문을
      조건에 일치하는 자료가 있으면 update 문을 수행하는 명령문
      
      (사용형식)
    merge into 테이블명
        using (insert 나 update 가 될마 데이터 원천) on (updte 될 조건)
    when matched then
        update 
            set 컬럼명1 = 값1 [, 컬럼명2 = 값 2, ....]
    where 조건
    
    when not matched then
        insert(컬럼명1 [,컬럼명2, ...]) values(값1, [,값2,...])
        where 조건;
        
예) 상품분류 테이블에서 다음 자료를 추가 또는 수정하시오
    순번 : 7
    분류코드 : 'P401'
    분류명 : 'DVD'
    
    순번 : 10 
    분류코드 : 'P501'
    분류명 : '농산물'
    
    update lprod
        set lprod_nm = 'DVD',
            lprod_id = 11,
        where lprod_lgu = 'P401'; 
    rollback;
    
    merge into lprod a
        using dual on (lprod_gu = 'P401')
    when matched then
        update 
            set lprod_id = 11,
                lprod_nm = 'DVD',
            --where lprod_gu ='P401'
    when not matched then
            insert (a.lprod_id, a.lprod_gu, a.lprod_nm) values (11, 'P401', 'DVD');
            