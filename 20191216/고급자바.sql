create table mymember(
    mem_id varchar2(15) not null, --ȸ�� id 
    mem_name varchar2(30) not null, --ȸ�� �̸� 
    mem_tel varchar2(14) not null, --��ȭ��ȣ 
    mem_addr varchar2(70) not null, 
    constraint pk_mymember primary key (mem_id)
    
);

insert into mymember (mem_id, mem_name, mem_tel, mem_addr)
values();