select * from users;
insert into users values('admin', '1111', '관리자', sysdate);

drop table subcategory;
drop table category;
create table category(
    category varchar2(30) primary key
);
create table subcategory(
    subcategory varchar2(30) primary key,
    category varchar2(30) constraint FK_SUBCATEGORY_CATEGORY 
    references category(category) on delete set null
);
desc cart;
select * from cart;
select * from USER_CONSTRAINTS where table_name ='CART';
create table cart(
id number primary key,
model varchar2(30) not null,
user_id varchar2(20) references users(id),
opt varchar2(30) not null,
count number not null
);

create sequence seq_cart_id;

select * from cart;
drop table cart;
select * from users;
insert into category values('MEN');
insert into category values('WOMEN');
insert into category values('ACC');

create table product(
    model varchar2(30) primary key,
    category varchar2(30) references category(category),
    manufacturer varchar2(30) not null,
    price number not null,
    discount number(2,2) not null,
    image varchar2(50) not null,
    content clob not null,
    count number,
    regdate date not null
);

select * from product;
insert into product 
values('coat-a', 'outer', 'polo', 300000, 0.1, 'coat-a.jpg', 
       '올 겨울을 버틸 캐시미어 롱코트', 10, sysdate);
insert into product        
values('coat-b', 'outer', 'polo', 200000, 0.15, 'coat-b.jpg', 
       '롱코트 시대는 끝났다. 이젠 숏코트!', 20, sysdate);
insert into product        
values('coat-c', 'outer', 'polo', 500000, 0.3, 'coat-c.jpg', 
       '귀욤귀욤열매를 먹은 떡볶이코트~', 15, sysdate);
insert into product        
values('coat-d', 'outer', 'polo', 300000, 0.2, 'coat-d.jpg', 
       '가을타는 당신을 위한 트랜치코트', 5, sysdate);

--Product table 제약조건 수정
select * from USER_CONSTRAINTS where table_name ='CATEGORY';
select * from USER_CONSTRAINTS where table_name ='PRODUCT';
alter table CATEGORY drop constraint SYS_C007139;

alter table PRODUCT add constraint FK_PRODUCT_CATEGORY
foreign key(category) references category(category) on delete set null;

select * from category;
delete from category where category ='GG';
select * from product;
update product set category='shoes' where category is null;
drop trigger cart_update_cascade;
delete from product where model='coat-c';
select * from cart;

alter table CART drop constraint SYS_C007149;
alter table CART add constraint FK_CART_MODEL foreign key(model) references
product(model) on delete cascade;

desc cart;
select * from user_triggers;
update product set model = 'coat-bb' where model='coat-b';
update product set price=150000 where model='mintchocolatepizza';
select * from user_triggers;


select * from 
			(select rownum rnum, a.* from
				(select * from board 
				 order by regdate desc) a where rownum <= 10)
		where rnum >= 6;


--on update Trigger
--CREATE TRIGGER cart_update_cascade
--BEFORE
--UPDATE of model ON product
--FOR EACH ROW
--begin
--    update cart set model =:new.model where model =:old.model;
--end;
desc users;
create table authority(
    id number primary key,
    users_id varchar2(20) references users(id),
    role varchar2
)

