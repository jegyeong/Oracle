2020-01-28-02)����� �ݺ���

1)if��
  - �������α׷� ����� if���� ���� ����
  (�������)
  if ���� then
    ��ɹ�1;
  end if;
   
  if ���� then
    ��ɹ�;
  else
    ��ɹ�2;
  end if;
 
  if ����1 then
    ��ɹ�1;
  elsif ����2 then
    ��ɹ�2;
      :
  end if;
 
  if ����1 then
   if ����2 then
     ��ɹ�1;
   else
     ��ɹ�2
   end if;
   else
   ��ɹ�3;
   end if;
   
   
��) ��ǰ�з����̺��� �з���ȣ 'p302' �ڷᰡ ������ �ڷḦ update�ϰ� 
        �ڷᰡ ������ ���� �ڷḦ insert �Ͻÿ�.
        [�ڷ�]
        lprod_id : 15
        lprod_gu :'p302'
        lprod_nm : 'ȭ��ǰ(������)'
        
        
 declare
    v_num number := 0;
 begin
  select count(*) into v_num
    from lprod
  where lprod_gu = 'p302';
  
 if v_num = 0 then
    insert into lprod values(15,'p302','ȭ��ǰ(������)');
 else
    update lprod
       set lprod_id = 15,
           lprod_nm = 'ȭ��ǰ(������)'
     where lprod_gu = 'p302';
 end if;
 commit;
 end;  

select * from lprod where lprod_gu = 'p302'; 


��)������ ��������� �Է� �޾� ������ ����ϴ� ��� �ۼ�

accept p_bir prompt '��������� �Է�(yyyymmdd) : '
declare
  v_days number := 0;
  v_rem number(2) := 0;
  v_dow varchar2(20);
begin
 v_days := trunc(to_date('&p_bir') - to_date('00010101'))-1;
 v_rem := mod(v_days,7);
 
 if v_rem = 0 then
    v_dow := '��';
 elsif v_rem = 1 then
    v_dow := '��';
 elsif v_rem = 2 then
    v_dow := 'ȭ';
 elsif v_rem = 3 then
    v_dow := '��';
 elsif v_rem = 4 then
    v_dow := '��';
 elsif v_rem = 5 then
    v_dow := '��';
 else
    v_dow := '��';
 end if;
 
 dbms_output.put_line(to_date('&p_bir')||'�� '||v_dow||'����');
end;


2)case when then 
    - java switch-case ��
    (�������)
    case ����[����]
         when ��1 then
            ���1;
         when ��2 then
            ���2;
         when ��3 then
            ���3;
            :
         else  
            ���n;
    end case;
    
��)ȸ�����̺��� ������ �ֺ��� ȸ������ ��տ����� ���Ͽ�
    10�� ~ 30�� : '���� ���ɴ� ����'
    40�� ~ 60�� : '��� ���ɴ� ����'
    70�� �̻�   : '��� ���ɴ� ����' �� ����� ���
    Alias �� ����, ��տ���, ���
    
    (������ �ֺ��� ȸ���� ��� ����)
    select avg(extract(year from sysdate)-extract(year from mem_bir))
        from member
        where mem_job = '�ֺ�';
        
        
            
   select distinct a.mem_job, b.ayear, case when b.ayear >= 10 and b.ayear <= 39 then
                                '���� ���ɴ� ����'
                                when b.ayear >= 40 and b.ayear <= 69 then
                                '��� ���ɴ� ����'
                                else
                                '��� ���ɴ� ����' end as ���
  from member a,(select mem_job,
                      avg(extract(year from sysdate) - extract(year from mem_bir)) as ayear
                 from member
                where mem_job = '�ֺ�'
                group by mem_job) b
 where a.mem_job = b.mem_job;
 
(�͸���)
declare
  v_years number(5,1) :=0; --�ʱⰪ 0
  v_job  varchar2(10) :='�ֺ�';
  v_mess varchar2(50);
 begin
  select avg(extract(year from sysdate) - extract(year from mem_bir)) into v_years
    from member
   where mem_job = '�ֺ�';
   
   --��տ��ɱ��ؼ� 10���� ����
   case trunc(v_years/10) when 1 then v_mess:='���� ���ɴ� ����'; 
        when 2 then v_mess:='���� ���ɴ� ����'; 
        when 3 then v_mess:='���� ���ɴ� ����'; 
        when 4 then v_mess:='��� ���ɴ� ����'; 
        when 5 then v_mess:='��� ���ɴ� ����'; 
        when 6 then v_mess:='��� ���ɴ� ����'; 
        else  v_mess:='��� ���ɴ� ����';  
   end case;
        
      dbms_output.put_line(v_job||'ȸ���� ��� ���� : '||v_years||'�� : '||v_mess);
  end;    
  
 ----------------------------------------------------
 (case when ���)
 
  declare
  v_years number(5,1) :=0; --�ʱⰪ 0
  v_job  varchar2(10) :='�ֺ�';
  v_mess varchar2(50);
 begin
  select avg(extract(year from sysdate) - extract(year from mem_bir)) into v_years
    from member
   where mem_job = '�ֺ�';
  
  case when v_years between 10  and 39 then v_mess := '���� ���ɴ� ����';
       when v_years between 40  and 69 then v_mess := '��� ���ɴ� ����';
       else v_mess := '��� ���ɴ� ����';
  end case;
  
  dbms_output.put_line(v_job||'ȸ���� ��� ���� : '||v_years||'�� : '||v_mess);
  end;    