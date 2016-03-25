create table j_member (
	m_no number primary key,
	m_email varchar2(30) not null unique,
	m_passwd varchar2(20) not null,
  	m_nick varchar2(15) not null unique,
	m_reg_date date default sysdate,
	m_del_yn char(1) default 'n',
	c_code varchar2(30),
	l_code varchar2(30)
);


select * from j_member;

--drop table j_member;