create table j_member (
	m_no number primary key,
	m_email varchar2(30) not null,
	m_passwd varchar2(20) not null,
  	m_nick varchar2(15) not null,
	m_reg_date date default sysdate,
	m_del_yn char(1) default 'n',
	l_code varchar2(5),
	c_code varchar2(5)
);

create table country_language (
	code varchar2(10) primary key,
	c_l varchar2(2) not null,
	value varchar2(30) not null
);
