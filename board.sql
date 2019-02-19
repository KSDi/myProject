create table question(
    id number primary key,
    users_id varchar2(20) references users(id),
    title varchar2(100) not null,
    content clob not null,
    regdate date
);
create sequence seq_qna_id;
insert into question values(seq_qna_id.nextval, 'ksd39487', '테스트용', '테스트를 위한 게시물 입니다.', sysdate,'답변대기');
alter table question add (status varchar2(15) check(status in ('답변완료','답변대기')));
select * from question;
update question set status = '답변대기';
delete from question;
drop sequence seq_board_id;             
select * from cart;
select * from product;
desc product;
update product set category='outer' where category is null;
select * from CONTRAINTS;
select * from USER_CONSTRAINTS;
alter table product drop constraint FK_PRODUCT_CATEGORY;
alter table PRODUCT add constraint FK_PRODUCT_CATEGORY
foreign key(category) references category(category) on delete set null;
drop trigger category_update_cascade;
alter table order_products drop constraint SYS_C004026;
alter table order_products add constraint FK_PRODUCT_ID
foreign key(product_id) references product(model) on delete set null;
--CREATE TRIGGER model_update_cascade
--BEFORE
--UPDATE of model ON product
--FOR EACH ROW
--begin
--    update order_products set product_id =:new.model where product_id =:old.model;
--end;

select * from question;