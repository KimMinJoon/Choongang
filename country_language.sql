select * from country_language;

drop table country_language;

create table country_language (
	code varchar2(10) primary key,
	c_l varchar2(2) not null,
	value varchar2(30) not null
);

Insert into country_language (CODE,C_L,VALUE) values ('defult_l','l','해당없음');
Insert into country_language (CODE,C_L,VALUE) values ('defult_c','c','해당없음');