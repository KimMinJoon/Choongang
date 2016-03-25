create table j_board (
	brd_no number primary key, -- 게시글 번호 프라이머리키
	brd_subject varchar2(50) not null, -- 게시글 제목
	brd_content varchar2(4000) not null, -- 게시글내용
	brd_category varchar2(10), -- 게시판말머리
	brd_readcount number default 0, --읽은 횟수
	brd_recommend number default 0, --추천받은 수
	brd_ip varchar2(20) not null, --작성자 ip
	brd_del_yn char(1) default 'n' check (brd_del_yn in ('y','n')),--도메인무결성
	brd_reg_date date default sysdate, --게시등록일
	brd_update_date date  --게시 수정일
	
	--외래키 설정해야될 속성들
	brd_writer number not null, -- m_no과 참조된 외래키
	brd_language varchar2(10) not null, -- j_code 과 참조된 외래키 
	brd_boardcode varchar2(10) not null -- j_code 과 참조된 외래키
);


select * from user_tables;



drop table j_board; --테이블삭제
drop table j_member; --테이블삭제
drop table board1; --테이블삭제
drop table j_boardcode; --테이블삭제



create table j_boardcode ( -- 게시판코드 테이블 생성
	boardcode number primary key,
	boardname varchar2(10) not null
);

-- 게시판에 m_no 외래키 설정
ALTER TABLE j_board ADD CONSTRAINT fk_writer
FOREIGN KEY(brd_writer) REFERENCES j_member(m_no);

-- 게시판에 code 외래키 설정
ALTER TABLE 컨트리 랭귀지 ADD CONSTRAINT fk_code
FOREIGN KEY(code) REFERENCES 컨트리랭귀지(code);




--boardcode 외래키 설정 삭제 예제
ALTER TABLE j_board DROP CONSTRAINT fk_boardcode;

