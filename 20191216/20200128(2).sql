2020-01-28-02)제어문과 반복문

1)if문
  - 응용프로그램 언어의 if문과 같은 형식
  (사용형식)
  if 조건 then
    명령문1;
  end if;
   
  if 조건 then
    명령문;
  else
    명령문2;
  end if;
 
  if 조건1 then
    명령문1;
  elsif 조건2 then
    명령문2;
      :
  end if;
 
  if 조건1 then
   if 조건2 then
     명령문1;
   else
     명령문2
   end if;
   else
   명령문3;
   end if;
   
   
예) 상품분류테이블에서 분류번호 'p302' 자료가 있으면 자료를 update하고 
        자료가 없으면 다음 자료를 insert 하시오.
        [자료]
        lprod_id : 15
        lprod_gu :'p302'
        lprod_nm : '화장품(여성용)'
        
        
 declare
    v_num number := 0;
 begin
  select count(*) into v_num
    from lprod
  where lprod_gu = 'p302';
  
 if v_num = 0 then
    insert into lprod values(15,'p302','화장품(여성용)');
 else
    update lprod
       set lprod_id = 15,
           lprod_nm = '화장품(여성용)'
     where lprod_gu = 'p302';
 end if;
 commit;
 end;  

select * from lprod where lprod_gu = 'p302'; 


예)본인의 생년월일을 입력 받아 요일을 계산하는 블록 작성

accept p_bir prompt '생년월일을 입력(yyyymmdd) : '
declare
  v_days number := 0;
  v_rem number(2) := 0;
  v_dow varchar2(20);
begin
 v_days := trunc(to_date('&p_bir') - to_date('00010101'))-1;
 v_rem := mod(v_days,7);
 
 if v_rem = 0 then
    v_dow := '일';
 elsif v_rem = 1 then
    v_dow := '월';
 elsif v_rem = 2 then
    v_dow := '화';
 elsif v_rem = 3 then
    v_dow := '수';
 elsif v_rem = 4 then
    v_dow := '목';
 elsif v_rem = 5 then
    v_dow := '금';
 else
    v_dow := '토';
 end if;
 
 dbms_output.put_line(to_date('&p_bir')||'은 '||v_dow||'요일');
end;


2)case when then 
    - java switch-case 문
    (사용형식)
    case 변수[수식]
         when 값1 then
            명령1;
         when 값2 then
            명령2;
         when 값3 then
            명령3;
            :
         else  
            명령n;
    end case;
    
예)회원테이블에서 직업이 주부인 회원들의 평균연령을 구하여
    10대 ~ 30대 : '젊은 연령대 분포'
    40대 ~ 60대 : '장년 연령대 분포'
    70대 이상   : '노년 연령대 분포' 를 비고난에 출력
    Alias 는 직업, 평균연령, 비고
    
    (직업이 주부인 회원의 평균 연령)
    select avg(extract(year from sysdate)-extract(year from mem_bir))
        from member
        where mem_job = '주부';
        
        
            
   select distinct a.mem_job, b.ayear, case when b.ayear >= 10 and b.ayear <= 39 then
                                '젊은 연령대 분포'
                                when b.ayear >= 40 and b.ayear <= 69 then
                                '장년 연령대 분포'
                                else
                                '노년 연령대 분포' end as 비고
  from member a,(select mem_job,
                      avg(extract(year from sysdate) - extract(year from mem_bir)) as ayear
                 from member
                where mem_job = '주부'
                group by mem_job) b
 where a.mem_job = b.mem_job;
 
(익명블록)
declare
  v_years number(5,1) :=0; --초기값 0
  v_job  varchar2(10) :='주부';
  v_mess varchar2(50);
 begin
  select avg(extract(year from sysdate) - extract(year from mem_bir)) into v_years
    from member
   where mem_job = '주부';
   
   --평균연령구해서 10으로 나눔
   case trunc(v_years/10) when 1 then v_mess:='젊은 연령대 분포'; 
        when 2 then v_mess:='젊은 연령대 분포'; 
        when 3 then v_mess:='젊은 연령대 분포'; 
        when 4 then v_mess:='장년 연령대 분포'; 
        when 5 then v_mess:='장년 연령대 분포'; 
        when 6 then v_mess:='장년 연령대 분포'; 
        else  v_mess:='노년 연령대 분포';  
   end case;
        
      dbms_output.put_line(v_job||'회원의 평균 연령 : '||v_years||'세 : '||v_mess);
  end;    
  
 ----------------------------------------------------
 (case when 사용)
 
  declare
  v_years number(5,1) :=0; --초기값 0
  v_job  varchar2(10) :='주부';
  v_mess varchar2(50);
 begin
  select avg(extract(year from sysdate) - extract(year from mem_bir)) into v_years
    from member
   where mem_job = '주부';
  
  case when v_years between 10  and 39 then v_mess := '젊은 연령대 분포';
       when v_years between 40  and 69 then v_mess := '장년 연령대 분포';
       else v_mess := '노년 연령대 분포';
  end case;
  
  dbms_output.put_line(v_job||'회원의 평균 연령 : '||v_years||'세 : '||v_mess);
  end;    