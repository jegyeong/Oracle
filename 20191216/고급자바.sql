create table mymember(
    mem_id varchar2(15) not null, --회원 id 
    mem_name varchar2(30) not null, --회원 이름 
    mem_tel varchar2(14) not null, --전화번호 
    mem_addr varchar2(70) not null, 
    constraint pk_mymember primary key (mem_id)
    
);

insert into mymember (mem_id, mem_name, mem_tel, mem_addr)
values();