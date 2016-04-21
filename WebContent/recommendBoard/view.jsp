<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../projectcss.css">
<script language="javascript">
/* function pwdpopup(){
	var purl = "deleteForm.do?brd_no="+${brd_no}+"&pageNum="+${pageNum};
	var pname = "pwdpopup";
	var pwidth = 250;
	var pheight = 100;
	var pleft = (screen.availWidth-pwidth)/2;
	var ptop = (screen.availHeight-pheight)/2;
	var poption = "scrollbars=no,status=no,toolbar=no,resizable=0,location=no,menu=no," +
	                "width=" + pwidth + ",height=" + pheight + ",left=" + pleft + ",top=" + ptop;
	window.open(purl, pname, poption);
} */

function chk() {
	alert("로그인 후 사용하실 수 있습니다.");
}
</script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
$(function() {
	$('#btnLike').click(function(){
		$.ajax({
			type : "POST",
			url : "../recommendBoard/recommendChk.jsp",
			data : {
				"brd_no" : $('#like_brd_no').val()
			},
			success : function(data){
				if ($.trim(data) == "TRUE") {
					$('#btnLike').text("좋아요 취소");
				} else if($.trim(data) == "FALSE"){
					$('#btnLike').text("좋아요");
				}
			} 
		});
	});
});
function textCheck() {
	var counter = document.getElementById("counter");
	var re_content = document.getElementById("re_content");
	counter.innerHTML = 
		re_content.value.length + "/" + re_content.maxLength;
	if(re_content.value.length >= re_content.maxLength){
		alert("최대 " + re_content.maxLength + "글자 까지 작성할수 있습니다.");
	}
}

function isSubmit(number) {
	/* alert("m_no : " + number); */
		if(number == null || number == "" || number == "null"){
			if (confirm("이 서비스는 로그인이 필요한 서비스 입니다. 로그인 하시겠습니까?")) {
				location.href = "${pageContext.request.contextPath}/member/login.do";
			} else {
				return false;
			}
		}else{
			return true;
		}
		return false;	
}

function deleteRpChk(re_no, brd_no, pageNum){
	if(confirm("정말 삭제하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/recommendBoard/deleteReply.do?re_no="+re_no+"&brd_no="+brd_no+"&pageNum="+pageNum;	
	}else{
		return;
	}
}

</script>
</head>
<body>
	
	
	<c:if test="${not empty jrb }">
	<table class="tab" align="center" width="70%" cellspacing="0" cellpadding="0">
		<caption><h2>게시글 보기</h2></caption>
		<tr>
			<td>제목</td>
			<td>${jrb.brd_subject}</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td>${jrb.m_nick}</td>
		</tr>

		<tr>
			<td>말머리</td>
			<td>${jrb.rc_value}</td>
		</tr>

		<tr>
			<td>조회수</td>
			<td>${jrb.brd_readcount}</td>
		</tr>

		<tr>
			<td>추천수</td>
			<td>${jrb.recocount}</td>
		</tr>

		<tr>
			<td>IP</td>
			<td>${jrb.brd_ip}</td>
		</tr>

		<c:if test="${null ne jrb.brd_update_date}">
		<tr>
			<td>작성일</td>
			<td>${jrb.brd_reg_date}</td>
		</tr>
		<tr>
			<td>최근수정일</td>
			<td>${jrb.brd_update_date}</td>
		</tr>
		</c:if>
		<c:if test="${null eq jrb.brd_update_date}">
		<tr>
			<td>작성일</td>
			<td>${jrb.brd_reg_date}</td>
		</tr>
		</c:if>
		<tr>
			<td>내용</td>
			<td><pre>${jrb.brd_content}</pre></td>
		</tr>
	</table>
	</c:if>
	
	<p>
	
	<div align="center">
	<c:if test="${null ne m_no}">
		<button id="btnLike">
		<c:if test="${recommend > 0 }">
			좋아요 취소
		</c:if>
		<c:if test="${recommend <= 0 }">
			좋아요
		</c:if>
		</button>
	</c:if>
	<c:if test="${null eq m_no}">
		<button id="disableBtnLike" onclick="chk()">좋아요</button>
	</c:if>
		<input type="hidden" id="like_brd_no" value="${brd_no}">
	</div>

	<p>
	
	<div align="center">
		<button
			onclick="location.href='list.do?pageNum=${pageNum}'">목록</button>
		<c:if test="${null ne m_no}">
			<c:if test="${m_no == jrb.m_no}">
				<button onclick="location.href='updateForm.do?brd_no=${brd_no}&pageNum=${pageNum}'">수정</button>
				<button onclick="location.href='deleteForm.do?brd_no=${brd_no}&pageNum=${pageNum}'">삭제</button>
			</c:if>
			<button onclick="location.href='writeForm.do?brd_no=${brd_no}&pageNum=${pageNum}'">답변</button>
		</c:if>
	</div>
	
	<p>
	
	<center>
	<div style="border: 1px solid; padding: 10px 10px 10px 10px;" class="wrap">
		<form action="">
			<hr>
			<c:if test="${not empty rpList}">
				<c:forEach var="jrr" items="${rpList}">
					${jrr.m_nick}/${jrr.re_reg_Date}/${jrr.re_content}
					<c:if test="${not empty m_no}">
						<c:if test="${m_no == jrr.m_no}">
							<input type="button" value="수정">
							<input type="button" value="삭제" onclick="deleteRpChk(${jrr.re_no},${brd_no},${pageNum})">
						</c:if>
						<hr>
					</c:if>
				</c:forEach>
			</c:if>		
		</form>
	</div>
	
	<p>
	
	<div style="border: 1px solid; padding: 10px 10px 10px 10px;" class="wrap">
		<form action="insertReply.do" name="frm" onsubmit="return isSubmit(${sessionScope.m_no})">
			<input type="hidden" name="m_no" value="${sessionScope.m_no }">
			<input type="hidden" name="brd_no" class= "${brd_no}" value="${brd_no}">
			<input type="hidden" name="pageNum" value="${pageNum}">
			<textarea rows="3" cols="50" maxlength="150" id="re_content"
				name="re_content" required="required" onkeyup="textCheck()"></textarea>
			<span id="counter">0/150</span> <input
				style="height: 40px; width: 100px;" type="submit" value="등록">
		</form>
	</div>
	</center>
</body>
</html>