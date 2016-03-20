create table j_member (
	m_no number not null,
	m_email varchar2(30) not null,
	m_reg_date date default sysdate,
	m_passwd varchar2(20) not null,
	m_del_yn char(1) default 'n',
	l_code varchar2(5),
	c_code varchar2(5)
);