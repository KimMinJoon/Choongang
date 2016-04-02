<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../projectcss.css">
</head>
<body>

	<%
		String m_no = (String) session.getAttribute("m_no");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String pageNum = request.getParameter("pageNum");
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		J_RecommendBoard jrb = jrbd.select(brd_no);
		System.out.println("view에서 받은 m_no값~ :" + jrb.getM_no());
		if (jrb != null) {
			jrbd.updateHit(brd_no);
	%>
	<table border="1" width="80%">
		<caption>게시판 상세내용</caption>
		<tr>
			<th>제목</th>
			<td><%=jrb.getBrd_subject()%></td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td><%=jrb.getM_nick()%></td>
		</tr>

		<tr>
			<th>말머리</th>
			<td><%=jrb.getRc_value()%></td>
		</tr>

		<tr>
			<th>조회수</th>
			<td><%=jrb.getBrd_readcount()%></td>
		</tr>

		<tr>
			<th>추천수</th>
			<td><%=jrb.getBrd_recommend()%></td>
		</tr>

		<tr>
			<th>IP</th>
			<td><%=jrb.getBrd_ip()%></td>
		</tr>

		<%
			if (jrb.getBrd_update_date() != null) {
		%>
		<tr>
			<th>작성일</th>
			<td><%=jrb.getBrd_reg_date()%></td>
		</tr>
		<tr>
			<th>최근수정일</th>
			<td><%=jrb.getBrd_reg_date()%></td>
		</tr>
		<%
			} else {
		%>
		<tr>
			<th>작성일</th>
			<td><%=jrb.getBrd_reg_date()%></td>
		</tr>
		<%
			}
		%>

		<tr>
			<th>내용</th>
			<td><pre><%=jrb.getBrd_content()%></pre></td>
			<!-- pre는 입력한 내용을 잇는 그래도 보여줌  -->
		</tr>
		<%
		} else {
	%>
		<tr><td>데이터가 없습니다.</td></tr>
	<%
		}
	%>
	</table>
	
	<div align="center">
		<button
			onclick="location.href='../module/main.jsp?pgm=/recommendBoard/list.jsp?pageNum=<%=pageNum%>'">게시판
			목록</button>
		<%
			System.out.println(m_no);//1
			System.out.println(jrb.getM_no());//0
			if (m_no != null) {
				if (Integer.parseInt(m_no) == jrb.getM_no()) {
		%>
		<button
			onclick="location.href='../module/main.jsp?pgm=/recommendBoard/updateForm.jsp?num=<%=brd_no%>&pageNum=<%=pageNum%>'">수정하기</button>

		<button
			onclick="location.href='../module/main.jsp?pgm=/recommendBoard/deleteForm.jsp?num=<%=brd_no%>&pageNum=<%=pageNum%>'">삭제하기</button>
		<%
			}
			}
		%>
		<button
			onclick="location.href='../module/main.jsp?pgm=/recommendBoard/writeForm.jsp?num=<%=brd_no%>&pageNum=<%=pageNum%>'">답변</button>
	</div>

</body>
</html>