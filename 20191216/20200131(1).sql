2020-01-31-01)트리거
    -임이의 이벤트가 발생되면 그 이벤트 전 후에 자동 실행되는 프로시져
    --두번의 쿼리가 같이 실행된다
    (사용형식)
    create trigger 트리거명
        [before|after] [insert|update|delete]
        on 테이블명 
        [for each row] --각각의 행 단위로
        [when 조건]---여기까지는 원인이 되어진 테이블엗 ㅐ한 정보
    begin
        pl/sql 명령
    end;
        .before|after : 이벤트가 발생되기 전에 begin 블록 실행[before]
                        이벤트가 발생된 후에느 begin 블록실행(after)
        .이벤트 : 트리거 실행의 원인이 되는 dml문(insert, update, delete)
                 이벤트는 중복 선언('or'연산자 사용)가능
                 ex)insert or delete or update
        .트리거유형
        (1)문장단위의 트리거 --트리거 딱 1번만 발생시킴
           - 'for each row'가 생략된 트리거-- when 조건도 못씀
           - 오직 한번만 트리거 수행
           - 의사레코드(:new :old)사용불가
        (2)행단위 트리거
           - 이벤트에 포함된 각 행마다 트리거 발생
           - 'for each row' 기술
           - when 조건 사용가능
           - 의사레코드(:new :old) 사용 
           
예)직책테이블(jobs)에 다음 자료를 추가하고 추가 작업이 종료된 후 '새로운 직책코드가 추가 되었음' 이라는 메세지를 출력하는 트리거 작성
    (자료)
    job_id  : java_pg
    job_title : java application programmer
    min_salary : 3500
    max_salary : 12000
    create/update_data : 오늘날쨔
    
    create trigger tg_jobs_insert
        after insert on jobs
    begin 
        dbms_output.put_line('새로운 직책코드가 추가되었음')
    end;
    
    insert into job valuse('java_pg', 'java application programmer', 3500,12000, sysdate, sysdate);
    
    select * from jobs;
    
    rollback;
    
    **생성된 트리거 확인
    select trigger_name from user_triggers;
    --아님 왼쪽 목차의 '트리거'를 눌러서 확인!
    
   예) 오늘이 2005년 8월 1일이라고 가정하고 상품코드 'P201000001'인 상품을 50개 입고 했을 때 
    재고수불테이블의 재고수량을 변경하는 트리거 작성
    단, P201000001의 매입가격은 21000원임

CREATE TRIGGER TG_REMAIN_UPDATE
  AFTER INSERT ON BUYPROD
  FOR EACH ROW --각 행마다 변경되기때문
BEGIN 
  UPDATE REMAIN
     SET REMAIN_I=REMAIN_I+:NEW.BUY_QTY,
         REMAIN_J_99=REMAIN_J_99+:NEW.BUY_QTY, --기존현재고 + 새입고수량
         REMAIN_DATE=TO_DATE('20050801')
   WHERE REMAIN_YEAR='2005'
     AND REMAIN_PROD=:NEW.BUY_PROD;
     
  COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('예외발생 : '||SQLERRM);
END;

DROP TRIGGER TG_REMAIN_UPDATE;

SELECT REMAIN_PROD, REMAIN_I, REMAIN_J_99 FROM REMAIN
 WHERE REMAIN_YEAR='2005' AND REMAIN_PROD='P201000001';

INSERT INTO BUYPROD VALUES('20050801','P201000001',50,21000);
SELECT * FROM BUYPROD WHERE BUY_DATE='20050801'
    

예) 2005년 7월 29일 'g001'회원이 상품코드 'P201000019'상품을 2개 구매한 경우 재고수불테이블을 변경하시오
    (확인)
    select * from remain where remain_year = '2005' and remain_prod = 'P201000019';
    
    (cart 테이블에 insert)          :new.cart_number                :new.cart_qty
    insert into cart values('g001','2005072900001', 'P201000019',2);
                                    :new.cart_member    :new.cart_prod
    (트리거)
    create or replace trigger tg_remain_02
     after insert or update or delete on cart --잘모그겠으면 일케써 
     for each row
    declare 
        v_qty number := 0;
        v_id prod.prod_id %type; --이런 타입이다
    begin
        if inserting then
        v_qty := :new.cart_qty;
        v_id := :new.cart_prod;
    elsif updating then
        v_qty := :new.cart_qty - :old.cart_qty;
        v_id := :new.cart_prod;
    elsif deleting then --delete를 햇다면!
        v_qty := :new.cart_qty - :old.cart_qty;
        v_id := :new.cart_prod;
    end if;
    
    update remain
        set remain_o = remain_o + v_qty,
            remain_j_99 = remain_j_99 - v_qty,
            remain_date = to_date(substr(:new.cart_no,1,8))
      where remain_year = '2005'
        and remain_prod = v_id;
        
    exception 
        when others then
            dbms_output.put_line('예외발생 : ' ||sqlerrm);
    end;
    
    (2)트리거 의사레코드(psuedo record) - 행단위 트리거에서만 사용
    --오라클에서 가상 레코드 
        (i) :new
            .insert와 update 입벤트에서만 사용
            .삽입이나 갱신될 새로운 자료를 지칭
            .delete 시에는 모두 null 값으로 setting
        (ii) :old
            .delete 나 update 이벤트에 사용
            .삭제되거나 갱신될자료를 지칭
            .insert 시에는 모두 null 값으로 setting
            
    (3)이벤트 종류를 구분하기 위한 트리거 함수
        (i)inserting :  이벤투가 insert 문장이면 참(true)값 반환
        (ii)updating :  이벤투가 update 문장이면 참(true)값 반환
        (iii)deleting :  이벤투가 delete 문장이면 참(true)값 반환
    
예)사원테이블에서 퇴직자를 처리하기 위해 retire 테이블을 다음과 같이 생성하시오
    테이블명 : retire 
    컬럼
    (1) employee_id     number(6)   n.n     pk&fk
    (2) department_id   number(6)           
    (3) job_id          varchar2(10)        
    
    create table retire(
    employee_id number(6) not null,
    department_id number(6),
    job_id varchar2(10),    
    
constraint pk_retire primary key (employee_id),
constraint fk_retire foreign key (employee_id)
references employees(employee_id));
    

문제)사원테이블에서 근속연수가 22년 이상된 사원들을 오늘 날짜로 퇴직 처리하고 
     퇴직자는 퇴직자 테이블에서 추가 삽입하는 트리거 작성 
    
    ----------------------숙제
    delete employees

    create or replace trigger tg_retire_01
        after update on employees
        for each row
    begin
        insert into retire values(:new.employee_id, :new.department_id, :new.job_id);
    end;
    
    
    select 
    
        
    