create table question(
    id number primary key,
    users_id varchar2(20) references users(id),
    title varchar2(100) not null,
    content clob not null,
    regdate date
);
create sequence seq_board_id;
insert into question values(seq_board_id.nextval, 'ksd39487', '테스트용', '테스트를 위한 게시물 입니다.', sysdate);
alter table question add (status varchar2(15) check(status in ('답변완료','답변대기')));
select * from question;
update question set status = '답변대기';