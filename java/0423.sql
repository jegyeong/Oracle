insert into court values(court_seq.nextval,'�̸�', '�ּ�', '��ȭ��ȣ');


insert into court values(court_seq.nextval,'����������� �������ù���', '(63584)����Ư����ġ�� �������� ���ֵ��� 8690 (��ȫ��)','064)730-0550');

select count(*) as totalCount from faq;

commit;

insert into faq values(faq_seq.nextval, '����', '����');

insert into faq values(faq_seq.nextval, '����������� �������� ä���ڷ�, �ε���������� �������� ��3ä���ڷ� �Ͽ� ������Ǻ�ä���� ���з��� �Ͽ��µ�, ��3ä���� ���� �ε����� ��ŵǾ� ä������ ������ ���Ǿ��� ��쿡, ������Ǻ�ä�ǿ� ���� �з��� ������ ���ٸ� ������Ǻ�ä���� ���з��� ä���ڰ� ����ǿ��� �����ϰ� ����������� ä���� ���� ���׿��� ���з� ������ �޾� �� �� �ִ��� �ñ��մϴ�. ����, ����ǿ������δ� ������ ���޹��� �� ���ٸ�, ������Ǻ�ä�� ���з��� ���з��� �����ϴ� �з� �� �߽�(����)����� ���� �ʰ� �ٷ� �з� �� �߽�(����)����� �޾Ƶ� ������ ���� �� �ִ��� �ñ��մϴ�.', 
                '������Ǻ�ä���� ���з��� ä���ڰ� ��������ڿ��� ���� ������ ���޹������� �з� �� �߽ɸ���̳� �з� �� ���θ���� �޾� ��������� ��û�Ͽ��� �ϸ�, �߽ɸ���̳� ���θ���� ���� Ȯ���ǰ� ���� �� ����ǿ��� �����ϰ� ������ ������ ���� �����ϴ�. 
                
                ');
                        
                        
                        commit;
---��������                       
insert into notice values(notice_seq.nextval, '��ȣ', '����', '��¥', 'cnt', '����', '�ۼ���');

--���ù��� //�����ʿ�
insert into related_law values(related_law_seq.nextval, '��������', '�����Ӵ�����ȣ��');

insert into related_law values(related_law_seq.nextval, '��������', '������');

--��ſ�� a_terminology �� �� .. 10����
insert into a_terminology values(a_terminology_seq.nextval, '�̸�', '����');

insert into a_terminology values(a_terminology_seq.nextval, 'ȯ��', 
                        '
                        ������ȹ��������� ���Ͽ� ������ȹ������ �ǽ��Ҷ��� �ʿ������� �߻��ϴ� ������������ ��ȯ������ ���Ѵ�.
                        
                        ');
                        
--��з� category_a
insert into category_a values(category_a_seq.nextval, 'ī�װ���');
--�ߺз� category_b
insert into category_a values(category_a_seq.nextval, 'ī�װ���', 'ī�װ���з���ȣ');
--�Һз� category_c
insert into category_a values(category_a_seq.nextval, 'ī�װ���', 'ī�װ��ߺз���ȣ');


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
--����
alert table
--�߰�
ALTER TABLE related_law ADD(USER_NAME VARCAHR2(13)); 

ALTER table related_law add (rel_l_question varchar2(500));
ALTER table related_law add (rel_l_noti_con varchar2(1000));
ALTER table related_law add (rel_l_answer varchar2(1000));

--�̸�����
[����] ALTER TABLE ���̺�� RENAME COLUMN �����÷��� TO �ٲ��÷���;

ALTER TABLE LAW_CATEGORY ADD CONSTRAINT cat_law_no FOREIGN KEY cat_law_no REFERENCES [���̺��] ([�÷���])

ALTER TABLE related_law RENAME COLUMN rel_l_name TO rel_l_title;


commit;

alter table related_law modify rel_l_question not null;


alter table related_law add constraint ON UPDATE CASCADE foreign key

--ī�װ��� �ֱ�
insert into LAW_CATEGORY values(LAW_CATEGORY_seq.nextval, 'ī�װ� �̸�', 'ī�װ� ��ȣ');

insert into LAW_CATEGORY values(LAW_CATEGORY_seq.nextval, 
        '
        ��Ÿ����
        ', 
        '10');
commit;
----------------------------------------------���ù���
insert into LAW_CATEGORY values(LAW_CATEGORY_seq.nextval, 'ī�װ� �̸�', 'ī�װ� ��ȣ');
insert into related_law values(related_law_seq.nextval, 'ī�װ� ����', '����', '����', '���');
insert into related_law values(related_law_seq.nextval, '11','�Ӵ뺸������ ����û��', 
            '���� 1997. 10. �Ӵ�Ⱓ�� 2������ �ϴ� �����Ӵ�������� ü���Ͽ��µ� ���� �� �ȵǾ� ���ð��� �� �Ӵ뺸������ ū ������ �϶��Ͽ����ϴ�. �Ӵ��ο��� �Ӵ�Ⱓ���� ������ �Ӵ뺸������ ������ û���� �� �������� ?
            ',
            '�����Ӵ�����ȣ�� ��7���� ������ ���� �Ǵ� �������� �������ÿ� ���� ������������ ��Ÿ �δ��� �����̳� ���������� �������� ���Ͽ� ������� �ƴ��ϰ� �� ������ ����ڴ� �巡�� ���Ͽ� �� ������ û���� �� �ִٰ� �����ϰ� �ֽ��ϴ�. ���� �������� ������Ȳ�� ��ȭ�� ���ð��ݰ� �Ӵ뺸������ �޶��Կ� ���� ���� ������ �Ӵ뺸������ �α� ������ �Ӵ뺸���ݰ� ���� �� �δ��ϰ� ������ ������ �Ӵ��ο��� �巡�� ���Ͽ� ���������� ������ �Ӵ뺸�������� �����Ͽ� �� ���� û���� ���� ������ ���� ������ �̿� ���� ���ʰ� ���� ������ ��� ���� �Ӵ뺸������ �϶��ϸ� ����û���� �����ȴٰ� ���������� ���� �� �����ϴ�.
            ');   
            commit;
            


select substr('cou_loc', ' ', '1')
    from court;

--�̰� �Ǵ°�
select instr(cou_loc, ' ', 1) from court;    

select substr(cou_loc, (select instr(cou_loc, ' ', 1) from court), '1') from court;

select substr(cou_loc, ' ', '1')


select substr(cou_loc, ' ',; 

select substr(cou_loc, instr(cou_loc, ' ', 1) ,  instr(cou_loc, ' ', 2)- instr(cou_loc, ' ', 1) ) from court;