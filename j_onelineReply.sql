create table J_OneLineReply(
  reply_no number primary key,
  brd_no number not null,
  content varchar2(500) not null,
  reg_date date default sysdate,
  update_date date,
  m_no number not null,
  del_yn char(1) default 'n',
  delete_date date
);

ALTER TABLE J_OneLineReply ADD CONSTRAINT fk_orl_brd_no
FOREIGN KEY(brd_no) REFERENCES j_onelineboard(brd_no);
