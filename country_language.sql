select * from country_language;

drop table country_language;

create table j_country_language (
	code varchar2(10) primary key,
	c_l varchar2(2) not null,
	value varchar2(30) not null
);