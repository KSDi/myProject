select * from USER_TABLES;

create table users (
    id varchar2(10) primary key,
    password varchar2(15) NOT NULL,
    name varchar2(10) NOT NULL,
    phone varchar2(12) NOT NULL
);
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
select * from order_products;
alter table order_products modify (product_opt varchar2(30));
alter table order_products add (count number);
create sequence seq_order_products_id;
