create table j_meetboardReply(
  re_no number primary key,
  m_no number not null,
  brd_no number not null,
  re_content varchar2(500) not null,
  re_reg_date date default sysdate,
  re_update_date date,
  del_yn char(1) default 'n',
);

ALTER TABLE j_meetboardReply ADD CONSTRAINT fk_re_brd_no
FOREIGN KEY(brd_no) REFERENCES j_meetboard(brd_no);

ALTER TABLE j_meetboardReply ADD CONSTRAINT fk_re_m_no
FOREIGN KEY(m_no) REFERENCES j_member(m_no);
