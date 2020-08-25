alter table memberjoin add mem_zipno number;
alter table memberjoin add mem_zipcode number;
alter table memberjoin add mem_gender number;
alter table memberjoin add mem_mail1 number;
alter table memberjoin add mem_mail2 number;
alter table memberjoin add mem_bir number;



alter table MEMBERJOIN add (zipnum int);

alter table MEMBERJOIN drop column zip_no;

ALTER TABLE MEMBERJOIN DROP COLUMN mem_zipno;

ALTER TABLE MEMBERJOIN MODIFY(mem_gender varchar2(100));

ALTER TABLE MEMBERJOIN MODIFY(mem_hp number);

ALTER TABLE MEMBERJOIN MODIFY(mem_mail1 varchar2(100));

ALTER TABLE MEMBERJOIN MODIFY(mem_mail2 varchar2(100));


create table faq(
    faq_no varchar2(50) not null,
    faq_title varchar2(100) not null,
    faq_content varchar2(300) not null,
    constraint pk_faq primary key(faq_no)
);


create table court(
    cou_no varchar2(50) not null,
    cou_name varchar2(100) not null,
    cou_loc varchar2(200) not null,
    constraint pk_court primary key(cou_no)
);

create table a_terminology(
    a_ter_no varchar2(50) not null,
    a_ter_name varchar2(100) not null,
    a_ter_content varchar2(300) not null,
    constraint pk_a_terminology primary key(a_ter_no)
);

create table related_law(
    rel_l_no varchar2(50) not null,
    rel_l_content varchar2(300) not null,
    rel_l_name varchar2(100) not null,
    constraint pk_related_law primary key(rel_l_no)
);

create table member(
    mem_id varchar2(50) not null,
    mem_pass varchar2(100) not null,
    mem_name varchar2(50) not null,
    mem_addr varchar2(200) not null,
    mem_tel varchar2(50) not null,
    mem_email varchar2(100) not null,
    mem_regno varchar2(50) not null,
    constraint pk_member primary key(mem_id)
);

create table auction(
    auc_no varchar2(50) not null,
    auc_price varchar2(50) not null,
    mem_id varchar2(50) not null,
    constraint pk_auction primary key(auc_no),
    CONSTRAINT fk_member FOREIGN KEY(mem_id)
        REFERENCES member(mem_id)
);

create table blacklist(
    mem_id varchar2(50) not null,
    CONSTRAINT fk_blacklist_member FOREIGN KEY(mem_id)
        REFERENCES member(mem_id)
);

create table a_article(
    a_art_no varchar2(50) not null,
    a_art_loc varchar2(300) not null,
    a_art_court varchar2(100) not null,
    cat_a_no varchar2(50) not null,
    cat_b_no varchar2(50) not null,
    cat_c_no varchar2(50) not null,
    a_art_low varchar2(100) not null,
    a_art_area varchar2(100) not null,
    a_art_cnt number not null,
    a_art_inter varchar2(50) not null,
    a_art_tour number not null,
    a_art_day date not null,
    a_art_result varchar2(50) not null,
    a_art_name varchar2(100) not null,
    a_art_appr varchar2(200) not null,
    constraint pk_a_article primary key(a_art_no),
    CONSTRAINT fk_a_article_category_a FOREIGN KEY(cat_a_no)
        REFERENCES category_a(cat_a_no),
    CONSTRAINT fk_a_article_category_b FOREIGN KEY(cat_b_no)
        REFERENCES category_b(cat_b_no),
    CONSTRAINT fk_a_article_category_c FOREIGN KEY(cat_c_no)
        REFERENCES category_c(cat_c_no)
);

create table category_a(
    cat_a_no varchar2(50) not null,
    cat_a_name varchar2(100) not null,
    constraint pk_category_a primary key(cat_a_no)
);

create table category_b(
    cat_b_no varchar2(50) not null,
    cat_b_name varchar2(100) not null,
    cat_a_no varchar2(50) not null,
    constraint pk_category_b primary key(cat_b_no),
    CONSTRAINT fk_category_a FOREIGN KEY(cat_a_no)
        REFERENCES category_a(cat_a_no)
);

create table category_c(
    cat_c_no varchar2(50) not null,
    cat_c_name varchar2(100) not null,
    cat_b_no varchar2(50) not null,
    constraint pk_category_c primary key(cat_c_no),
    CONSTRAINT fk_category_b FOREIGN KEY(cat_b_no)
        REFERENCES category_b(cat_b_no)
);

create table interest(
    int_no varchar2(50) not null,
    mem_id varchar2(50) not null,
    a_art_no varchar2(50) not null,
    constraint pk_interest primary key(int_no),
    CONSTRAINT fk_interest_member FOREIGN KEY(mem_id)
        REFERENCES member(mem_id),
    CONSTRAINT fk_interest_a_article FOREIGN KEY(a_art_no)
        REFERENCES a_article(a_art_no)
);

create table image(
    img_no varchar2(50) not null,
    img_addr varchar2(200) not null,
    a_art_no varchar2(100) not null,
    constraint pk_image primary key(img_no),
    CONSTRAINT fk_image_a_article FOREIGN KEY(a_art_no)
        REFERENCES a_article(a_art_no)
);

create table com_question(
    com_que_no varchar2(50) not null,
    com_que_title varchar2(100) not null,
    com_que_content varchar2(300) not null,
    com_que_writeid varchar2(50) not null,
    com_que_writeday date not null,
    cat_a_no varchar2(500) not null,
    constraint pk_com_question primary key(com_que_no),
    CONSTRAINT fk_com_question_category_a FOREIGN KEY(cat_a_no)
        REFERENCES category_a(cat_a_no)
);

create table answer_file(
    ans_f_no varchar2(50) not null,
    ans_f_addr varchar2(200) not null,
    com_que_no varchar2(50) not null,
    constraint pk_answer_file primary key(ans_f_no),
    CONSTRAINT fk_answer_file_com_question FOREIGN KEY(com_que_no)
        REFERENCES com_question(com_que_no)
);

create table com_answer(
    com_ans_no varchar2(50) not null,
    com_ans_title varchar2(100) not null,
    com_ans_content varchar2(300) not null,
    com_ans_writeid varchar2(50) not null,
    com_ans_writeday date not null,
    cat_a_no varchar2(50) not null,
    constraint pk_com_answer primary key(com_ans_no),
    CONSTRAINT fk_com_answer_category_a FOREIGN KEY(cat_a_no)
        REFERENCES category_a(cat_a_no)
);

create table question_file(
    que_f_no varchar2(50) not null,
    que_f_addr varchar2(200) not null,
    com_ans_no varchar2(50) not null,
    constraint pk_question_file primary key(que_f_no),
    CONSTRAINT fk_question_file_com_answer FOREIGN KEY(com_ans_no)
        REFERENCES com_answer(com_ans_no)
);

create table a_form(
    a_form_no varchar2(50) not null,
    a_form_name varchar2(100) not null,
    constraint pk_a_form primary key(a_form_no)
);

create table form_file(
    form_f_no varchar2(50) not null,
    form_f_addr varchar2(300) not null,
    a_form_no varchar2(100) not null,
    constraint pk_form_file primary key(form_f_no),
    CONSTRAINT fk_form_file_a_form FOREIGN KEY(a_form_no)
        REFERENCES a_form(a_form_no)
);

commit;



select 'private ' ||
        decode(lower(data_type), 'number', 'int ', 'String ') ||
        lower(column_name) || ';'
  from cols
 where lower(table_name) = 'FAQ';
 
 
 create table notice_file(
    file_no varchar2(50) not null,
    file_addr varchar2(200) not null,
    notice_no varchar2(50) not null,
    constraint pk_notice_file primary key(file_no),
    CONSTRAINT fk_notice_file_notice FOREIGN KEY(notice_no)
        REFERENCES notice(notice_no)
);

alter table notice drop column notice_file;
