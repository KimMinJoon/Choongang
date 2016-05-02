create view oneline_list_v
as
select 
  m_nick, 
  brd_no, 
  fc_date_check(brd_reg_date) as brd_reg_date, 
  brd_content, 
  brd_del_yn, 
  a.m_no,
  (select 
    count(*) 
   from J_ONELINEREPLY c 
   where 
    c.brd_no = a.brd_no) rep_count 
from J_OneLineBoard a, j_member b 
where 
  a.m_no = b.m_no 
  and brd_del_yn = 'n';