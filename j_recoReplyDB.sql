create table j_recoReply(
  re_no number primary key,
  re_content varchar2(500) not null,
  re_reg_date date default sysdate,
  re_up_date date,
  re_del_yn char(1) default 'n',
  re_del_date date,
  m_no number not null,
  brd_no number not null
);

ALTER TABLE j_recoReply ADD CONSTRAINT fk_jrb_brd_no
FOREIGN KEY(brd_no) REFERENCES j_recommendboard(brd_no);

select * from j_recoReply;
delete from j_recoReply;
