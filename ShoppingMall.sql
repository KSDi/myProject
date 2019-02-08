select * from USER_TABLES;

create table users (
    id varchar2(10) primary key,
    password varchar2(15) NOT NULL,
    name varchar2(10) NOT NULL,
    phone varchar2(12) NOT NULL
);
select * from users;
desc authority;
drop table users;
desc users;
desc seq_authority_id;
select * from users;
create table authority(
    id number primary key,
    users_id varchar2(20) references users(id),
    role varchar2(15) check(role like '%ROLE\_%' escape '\')
);
alter table users add (email varchar2(30));
desc authority;

create table orders (
    u_id varchar2(25) primary key,
    buyer_id varchar2(10) references users(id),
    regdate date not null
);
select * from orders;
alter table orders add (addr varchar2(150));
alter table orders add (cost number);
create table order_products(
    id number primary key,
    order_id references orders(u_id),
    product_id references product(model)
);
update orders set status='배송준비';
select * from orders;
update orders set delivery_name ='김상돈';
desc orders;
alter table orders add (delivery_name varchar2(15));
alter table orders add (status varchar2(10) check (status in('배송준비','배송중','배송완료')));
alter table orders modify (status varchar2(12));
desc order_products;
select * from orders;
select * from order_products;
alter table orders modify (regdate systimestamp);
alter table order_products modify (product_opt varchar2(30));
alter table order_products add (count number);
create sequence seq_order_products_id;
select * from product;
select * from cart;
