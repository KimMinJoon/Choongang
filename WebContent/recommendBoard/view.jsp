<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
<script type="text/javascript" src="../js/jquery.js"></script>
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
	
	<!-- Page Content -->
    <div class="container">
        <!-- Page Heading/Breadcrumbs -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Recommend
                    <small>추천</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="../module/main.jsp">Home</a>
                    </li>
                    <li class="active">Recommend</li>
                </ol>
            </div>
        </div>
	</div>	
	
	<p>
	<p>
	
	<c:if test="${not empty jrb }">
	<table border="1" width="70%" align="center">
		<tr>
			<th>닉네임</th>
			<td>${jrb.m_nick}</td>
		</tr>
		<tr>
			<th>추천수</th>
			<td><b class="red">${jrb.recocount}</b></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${jrb.brd_readcount}</td>
		</tr>
		<tr>
			<th>IP</th>
			<td>${jrb.brd_ip}</td>
		</tr>

		<c:if test="${null ne jrb.brd_update_date}">
		<tr>
			<th>작성일</th>
			<td>${jrb.brd_reg_date}</td>
		</tr>
		<tr>
			<th>최근수정일</th>
			<td>${jrb.brd_update_date}</td>
		</tr>
		</c:if>
		<c:if test="${null eq jrb.brd_update_date}">
		<tr>
			<th>작성일</th>
			<td>${jrb.brd_reg_date}</td>
		</tr>
		</c:if>
		<tr>
			<th width="10%">제목</th>
			<td><font class="category">[${jrb.rc_value}]</font> ${jrb.brd_subject}</td>
		</tr>
		<tr>
			<td colspan="2" align="center"><pre>${jrb.brd_content}</pre></td>
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
	
	<div style="border: 1px solid; padding: 10px 10px 10px 10px; margin:0 auto; width: 60%">
			<b style="font-size: 16px;">#댓글 </b>
			<hr>
			<c:if test="${not empty rpList}">
				<c:forEach var="jrr" items="${rpList}">
					<a class="re_nick">${jrr.m_nick}</a>
					<span class="re_date">${jrr.re_reg_Date}</span>
					<c:if test="${not empty m_no}">
						<c:if test="${m_no == jrr.m_no}">
							<a class="re_a"> 답글 </a>
							<span class="re_j">|</span>
							<a class="re_a"> 수정 </a>
							<span class="re_j">|</span>
							<a class="re_a" onclick="deleteRpChk(${jrr.re_no},${brd_no},${pageNum})"> 삭제 </a>
						</c:if>
					</c:if>
					<p>
					<p>
					${jrr.re_content}
					<hr>
				</c:forEach>
			</c:if>
		
		<form action="insertReply.do" name="frm" onsubmit="return isSubmit(${sessionScope.m_no})">
			<input type="hidden" name="m_no" value="${sessionScope.m_no }">
			<input type="hidden" name="brd_no" class= "${brd_no}" value="${brd_no}">
			<input type="hidden" name="pageNum" value="${pageNum}">
			<textarea style="resize: none; width: 80%; vertical-align: top;" rows="4" cols="50" maxlength="1000" id="re_content"
				name="re_content" required="required"></textarea>
			<input style="height: 65px; width: 100px; text-align: center;" type="submit" value="등록">
		</form>
	</div>
	
</body>
</html>