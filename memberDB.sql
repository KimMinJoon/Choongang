select * from member1;

create table j_member (
	m_no number primary key,
	m_email varchar2(30) not null,
	m_reg_date date not null default sysdate,
	m_nick varchar2(20) not null unique,
	m_passwd varchar2(20) not null ,
	lang_code varchar2(10) not null,
	m_del_yn char(1) not null default 'n'
));