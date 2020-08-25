insert into court values(court_seq.nextval,'이름', '주소', '전화번호');


insert into court values(court_seq.nextval,'제주지방법원 서귀포시법원', '(63584)제주특별자치도 서귀포시 일주동로 8690 (서홍동)','064)730-0550');

select count(*) as totalCount from faq;

commit;

insert into faq values(faq_seq.nextval, '제목', '내용');

insert into faq values(faq_seq.nextval, '근저당권자인 ‘갑’을 채무자로, 부동산소유자인 ‘병’을 제3채무자로 하여 근저당권부채권을 가압류를 하였는데, 제3채무자 병의 부동산이 경매되어 채무자인 갑에게 배당되었을 경우에, 근저당권부채권에 대한 압류의 경합이 없다면 근저당권부채권을 가압류한 채권자가 집행권원을 제출하고 근저당권자인 채무자 갑의 배당액에서 가압류 지분을 받아 올 수 있는지 궁금합니다. 만일, 집행권원만으로는 배당액을 지급받을 수 없다면, 근저당권부채권 가압류를 본압류로 이전하는 압류 및 추심(전부)명령을 받지 않고 바로 압류 및 추심(전부)명령을 받아도 배당액을 받을 수 있는지 궁금합니다.', 
                '근저당권부채권을 가압류한 채권자가 근저당권자에게 배당된 배당금을 지급받으려면 압류 및 추심명령이나 압류 및 전부명령을 받아 집행법원에 신청하여야 하며, 추심명령이나 전부명령이 없이 확정판결 정본 등 집행권원을 제출하고서 배당금을 수령할 수는 없습니다. 
                
                ');
                        
                        
                        commit;
---공지사항                       
insert into notice values(notice_seq.nextval, '번호', '제목', '날짜', 'cnt', '내용', '작성자');

--관련법률 //수정필요
insert into related_law values(related_law_seq.nextval, '법률내용', '주택임대차보호법');

insert into related_law values(related_law_seq.nextval, '법률내용', '법률명');

--경매용어 a_terminology ㄱ ㄴ .. 10개씩
insert into a_terminology values(a_terminology_seq.nextval, '이름', '내용');

insert into a_terminology values(a_terminology_seq.nextval, '환지', 
                        '
                        토지구획정리사업에 의하여 토지구획정리를 실시할때에 필연적으로 발생하는 인접토지와의 교환분합을 말한다.
                        
                        ');
                        
--대분류 category_a
insert into category_a values(category_a_seq.nextval, '카테고리명');
--중분류 category_b
insert into category_a values(category_a_seq.nextval, '카테고리명', '카테고리대분류번호');
--소분류 category_c
insert into category_a values(category_a_seq.nextval, '카테고리명', '카테고리중분류번호');


CREATE TABLE LAW_CATEGORY (
        CAT_LAW_NO VARCHAR2(50) NOT NULL,
        CAT_LAW_NAME VARCHAR2(100) NOT NULL,
        CAT_LAW_NUM VARCHAR2(50) NOT NULL,
        constraint pk_LAW_CATEGORY primary key(CAT_LAW_NO)
);

drop table LAW_CATEGORY;

commit;

create table related_law(
    rel_l_no varchar2(50) not null,
    rel_l_content varchar2(300) not null,
    rel_l_name varchar2(100) not null,
    constraint pk_related_law primary key(rel_l_no)
)



create table related_law(
    rel_l_no varchar2(50) not null,
    rel_l_catNum varchar2(50) not null,
    rel_l_title varchar2(50) not null,
    rel_l_question varchar2(500) not null,
    rel_l_answer varchar2(1000) not null,
    rel_l_noti_ti varchar2(1000),
    rel_l_noti_con varchar2(1000)
    
    
)
--삭제
alert table
--추가
ALTER TABLE related_law ADD(USER_NAME VARCAHR2(13)); 

ALTER table related_law add (rel_l_question varchar2(500));
ALTER table related_law add (rel_l_noti_con varchar2(1000));
ALTER table related_law add (rel_l_answer varchar2(1000));

--이름변경
[문법] ALTER TABLE 테이블명 RENAME COLUMN 원래컬럼명 TO 바꿀컬럼명;

ALTER TABLE LAW_CATEGORY ADD CONSTRAINT cat_law_no FOREIGN KEY cat_law_no REFERENCES [테이블명] ([컬럼명])

ALTER TABLE related_law RENAME COLUMN rel_l_name TO rel_l_title;


commit;

alter table related_law modify rel_l_question not null;


alter table related_law add constraint ON UPDATE CASCADE foreign key

--카테고리에 넣기
insert into LAW_CATEGORY values(LAW_CATEGORY_seq.nextval, '카테고리 이름', '카테고리 번호');

insert into LAW_CATEGORY values(LAW_CATEGORY_seq.nextval, 
        '
        기타사항
        ', 
        '10');
commit;
----------------------------------------------관련법률
insert into LAW_CATEGORY values(LAW_CATEGORY_seq.nextval, '카테고리 이름', '카테고리 번호');
insert into related_law values(related_law_seq.nextval, '카테고리 숫자', '제목', '질문', '대답');
insert into related_law values(related_law_seq.nextval, '11','임대보증금의 감액청구', 
            '저는 1997. 10. 임대기간을 2년으로 하는 주택임대차계약을 체결하였는데 그후 얼마 안되어 주택가격 및 임대보증금이 큰 폭으로 하락하였습니다. 임대인에게 임대기간만료 전에는 임대보증금의 감액을 청구할 수 없는지요 ?
            ',
            '주택임대차보호법 제7조는 약정한 차임 또는 보증금이 임차주택에 관한 조세·공과금 기타 부담의 증감이나 경제사정의 변동으로 인하여 상당하지 아니하게 된 때에는 당사자는 장래에 대하여 그 증감을 청구할 수 있다고 규정하고 있습니다. 따라서 임차인은 경제상황의 변화로 주택가격과 임대보증금이 급락함에 따라 당초 약정한 임대보증금이 인근 주택의 임대보증금과 비교할 때 부당하게 과다한 때에는 임대인에게 장래를 향하여 객관적으로 적정한 임대보증금으로 감액하여 줄 것을 청구할 수는 있으나 아직 법원에 이에 관한 선례가 없기 때문에 어느 정도 임대보증금이 하락하면 감액청구를 인정된다고 단정적으로 말할 수 없습니다.
            ');   
            commit;
            


select substr('cou_loc', ' ', '1')
    from court;

--이거 되는거
select instr(cou_loc, ' ', 1) from court;    

select substr(cou_loc, (select instr(cou_loc, ' ', 1) from court), '1') from court;

select substr(cou_loc, ' ', '1')


select substr(cou_loc, ' ',; 

select substr(cou_loc, instr(cou_loc, ' ', 1) ,  instr(cou_loc, ' ', 2)- instr(cou_loc, ' ', 1) ) from court;