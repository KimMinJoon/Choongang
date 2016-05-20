<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
<title>Insert title here</title>
<script type="text/javascript">
	function chk(pageNum, m_no) {
			if(m_no == null || m_no == "" || m_no == "null"){
				if (confirm("이 서비스는 로그인이 필요한 서비스 입니다. 로그인 하시겠습니까?")==true) {
					location.href = "../module/main.jsp?pgm=/member/login.jsp";
				} else {
					return;
				}
			}else{
				location.href = "${pageContext.request.contextPath}/meetBoard/writeForm.do?pageNum="+pageNum;
			}
	}
	function locate(pageNum){
		var searchType = document.getElementById("searchType");
		var searchTxt = document.getElementById("searchTxt");
		location.href="meetlist.do?pageNum=" + pageNum + "&searchType=" + searchType.value + "&searchTxt=" + searchTxt.value;
	}
</script>
</head>
<body>

	<!-- Page Content -->
    <div class="container">

        <!-- Page Heading/Breadcrumbs -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Meet
                    <small>모임</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="../module/main.jsp">Home</a>
                    </li>
                    <li class="active">Meet</li>
                </ol>
            </div>
        </div>
	</div>

	<p>
	<p>

	<table class="tab" align="center" width="70%">
		<tr height="30">
			<th width="5%"></th>
			<th width="8%">말머리</th>
			<th width="23%">제목</th>
			<th width="8%">글쓴이</th>
			<th width="8%">작성일</th>
			<th width="8%">희망언어</th>
			<th width="5%">조회수</th>
			<th width="5%">추천수</th>
		</tr>
		<c:set var="tot" value="${total }"></c:set>
		<c:forEach var="brd" items="${list}">
		<c:if test="${ not empty list}">
			<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
				<td class="default">${tot}</td>
				<td class="default">
				<c:if test="${brd.c_value_cate eq '말머리 없음'}">
					<font class="category"> </font>
				</c:if>
				<c:if test="${brd.c_value_cate ne '말머리 없음'}">
					<font class="category"> [${brd.c_value_cate}] </font>
				</c:if>
				</td>
				<td class="subject">
					<a href="view.do?brd_no=${brd.brd_no}&pageNum=${nowPage}">${brd.brd_subject}</a> 
					<c:if test="${ brd_readcount > 10}">
						<img src='../images/hot.gif'>
					</c:if>
				</td>
				<td class="nickname">${brd.m_nick}</td>
				<td class="default">${brd.brd_reg_date}</td>
				<td class="default">${brd.c_value_lang}</td>
				<td class="default">${brd.brd_readcount}</td>
				<td class="default">${brd.brd_recommend}</td>
			</tr>
		</c:if>
		<tr height="1" bgcolor="#e2e2e2"><td colspan="8"></td></tr>
		<c:set var="tot" value="${tot - 1 }"></c:set>
		</c:forEach>
		<c:if test="${empty list}">
			<tr height="1" bgcolor="#e2e2e2"><td colspan="8"></td></tr>
			<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
				<td colspan="8" class="default">데이터가 없습니다</td>
			</tr>
		</c:if>
	</table>
	
	<br>
	
	<div class="list">
		<c:if test="${startPage > pagePerBlock}">
			<a href="javascript:locate(${startPage-pagePerBlock})">[이전]</a>
			<a href="javascript:locate(1)">[1]</a>
			...
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<c:if test="${i eq nowPage}">
				<b class="b">[${i}]</b>
			</c:if>
			<c:if test="${i ne nowPage}">
				<a href="javascript:locate(${i})">[${i}]</a>
			</c:if>
		</c:forEach>
		<c:if test="${totalPage > endPage}">
			...
			<a href="javascript:locate(${totalPage})">[${totalPage}]</a>
			<a href="javascript:locate(${startPage + pagePerBlock})">[다음]</a>
		</c:if>
		
		<c:if test="${empty m_no}">
			<c:set var="m_no" value="null" />
		</c:if>
		
		<p>
		<p>
		<button onclick="chk(${nowPage},${m_no})" name="writeBtn">글쓰기</button>
		<p>
		
		<select id="searchType">
			<c:if test="${searchType eq 'all' }">
				<option value="all" selected="selected">제목 + 내용</option>
			</c:if>
			<c:if test="${searchType ne 'all' }">
				<option value="all">제목 + 내용</option>
			</c:if>
			<c:if test="${searchType eq 'brd_content' }">
				<option value="brd_content" selected="selected">내용</option>
			</c:if>
			<c:if test="${searchType ne 'brd_content' }">
				<option value="brd_content">내용</option>
			</c:if>
			<c:if test="${searchType eq 'brd_subject' }">
				<option value="brd_subject" selected="selected">제목</option>
			</c:if>
			<c:if test="${searchType ne 'brd_subject' }">
				<option value="brd_subject">제목</option>
			</c:if>
			<c:if test="${searchType eq 'm_nick' }">
				<option value="m_nick" selected="selected">글쓴이</option>
			</c:if>
			<c:if test="${searchType ne 'm_nick' }">
				<option value="m_nick">글쓴이</option>
			</c:if>
		</select>
		<input type="text" id="searchTxt" value="${searchTxt}">
		<input type="submit" value="검색" onclick="locate(1)">
	</div>
	
</body>
</html>