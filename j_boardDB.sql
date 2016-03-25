create table j_board (
	brd_no number primary key, -- 게시글 번호 프라이머리키
	brd_writer number not null, -- 게시글 작성자
	brd_subject varchar2(50) not null, -- 게시글 제목
	brd_content varchar2(4000) not null, -- 게시글내용
	brd_category varchar2(10) not null, -- 게시판말머리
	brd_readcount number default 0, --읽은 횟수
	brd_recommend number default 0, --추천받은 수
	brd_ip varchar2(20) not null, --작성자 ip
	brd_del_yn char(1) default 'n',
	code varchar2(10) not null,
	boardcode number, --게시판코드 번호
	brd_reg_date date not null, --게시등록일
	brd_update_reg_date date not null --게시 수정일
);

create table j_boardcode ( -- 게시판코드 테이블 생성
	boardcode number primary key,
	boardname varchar2(10) not null
);

-- 게시판에 m_no 외래키 설정
ALTER TABLE j_board ADD CONSTRAINT fk_writer
FOREIGN KEY(brd_writer) REFERENCES j_member(m_no);

-- 게시판에 boardcode 외래키 설정
ALTER TABLE j_board ADD CONSTRAINT fk_boardcode
FOREIGN KEY(boardcode) REFERENCES j_boardcode(boardcode);


