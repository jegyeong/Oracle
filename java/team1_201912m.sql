create table notice_file(
    file_no varchar2(50) not null,
    file_addr varchar2(200) not null,
    notice_no varchar2(50) not null,
    constraint pk_notice_file primary key(file_no),
    CONSTRAINT fk_notice_file_notice FOREIGN KEY(notice_no)
        REFERENCES notice(notice_no)
);

alter table notice drop column notice_file;

alter table notice add(notice_cnt number);

alter table court add(cou_tel varchar2(50));

commit;