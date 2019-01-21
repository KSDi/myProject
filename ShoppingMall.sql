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

desc authority;