<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.insert{
	width: 950px;
	margin : 0px auto;
}
.wrap {
	background : #A5C8DE;
	width: 920px;
	position: relative;
	display: inline-block;
}

.wrap textarea {
	width: 80%;
	resize: none;
	min-height: 4.5em;
	line-height: 1.6em;
	max-height: 9em;
	vertical-align: top;
}
textarea{
	vertical-align: top;
}

.wrap span {
	position: absolute;
	bottom: 5px;
	right: 5px;
}

.replyForm{
	position: relative;;
}

.Rows{
	width: 950px;
	margin : 0 auto;
}
.Row{
	width: 920px;
	background : #A5C8DE;
	border: 1px solid black;
	position: relative;
	height: 120px;
}
.updateForm{
	background : #A5C8DE;
	border: 1px solid black;
	height: 120px;
	width: 920px;
}
.replyUpdate{
	height: 120px;
}
.replyRow{
	height: 120px;
}
.RowNum{
	font-size: 10px;
	font-weight: bold;
	margin: 10px;	
}
.RowNick{
	font-size : 15px;
	font-weight: bold;
	font-style: italic;
	color: green;
	margin : 5px;
}
.RowDate{
	font-size : 10px;
	color: blue;
}
pre{
	width : 900px;
	margin : 10px;
}
pre > a{
	color: #FFA7A7;
}

#update{
	position : relative;
}

#counter {
	background: rgba(255, 0, 0, 0.5);
	border-radius: 0.5em;
	padding: 0 .5em 0 .5em;
	font-size: 0.75em;
}
.b {
	color: #004080;
	font-weight: 900;
}
a:link {color:black; text-decoration:none}
a:visited {color:black; text-decoration:none}
a:active {color:black; text-decoration:none}
a:hover {color:#8f8f8f;}
</style>
<c:set var="bno" value="${param.brd_no}"/>
<c:if test="${empty bno}">
	<c:set var="bno" value="0"/>
</c:if>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('textarea').css('resize','none');
		$(".updateForm").hide();
		$(".replyForm").hide();
		
		if(${bno} != 0){
			$(".${param.brd_no}").parent().parent().show();
		}
		$(".btnUpdate").click(function(){
			$(this).parent().nextAll(".Row").show();
			$(this).parent().nextAll(".updateForm").hide("slow");
			$(this).parent().prevAll(".Row").show();
			$(this).parent().prevAll(".updateForm").hide("slow");
			$(this).parent().hide("slow");
			var text = $(this).parent().next().find(".originText").text();
			$(this).parent().next().find(".updateContent").val(text);
			$(this).parent().next().show("slow");
		});
		
		$('.btnReply').click(function(){
			$(this).parent().next().next().show("slow");
		});
		
		$(".updateCancel").click(function(){
			$(this).parent().parent().hide("slow"); 
			$(this).parent().parent().prev().show("slow");	
		});
		
		$(".btnReply").click(function(){
			$(this).parent().next().next().show("slow");
		});
		
		$(".countClick").click(function(){
			$(this).parent().parent().next().next().show("slow");
		});
		
		$(".replyCancel").click(function(){
			$(this).parent().parent().hide("slow"); 
			$(this).parent().parent().prev().prev().show("slow");	
		});
		
		$(".btnRepUpdate").click(function(){
			$(this).parent().nextAll(".replyRow").show();
			$(this).parent().nextAll(".replyUpdate").hide();
			$(this).parent().prevAll(".replyRow").show();
			$(this).parent().prevAll(".replyUpdate").hide();
			$(this).parent().hide("slow");
			var text = $(this).parent().next().find(".originRepText").text();
			$(this).parent().next().find(".updateReContent").val(text);
			$(this).parent().next().show("slow");
		});
		
		$(".repUpdateCancel").click(function(){
			$(this).parent().parent().hide("slow"); 
			$(this).parent().parent().prev().show("slow");
		});
	});
	
	function deleteChk(brd_no,pageNum){
		var searchType = document.getElementById("searchType");
		var searchTxt = document.getElementById("searchTxt");
		if(confirm("정말 삭제하시겠습니까?")){
			location.href="${pageContext.request.contextPath}/oneLineBoard/delete.do?brd_no="+brd_no+"&pageNum="+pageNum+"&searchType=" + searchType.value + "&searchTxt=" + searchTxt.value;	
		}else{
			return;
		}
	}
	
	function deleteRepChk(reply_no, brd_no, pageNum){
		var searchType = document.getElementById("searchType");
		var searchTxt = document.getElementById("searchTxt");
		if(confirm("정말 삭제하시겠습니까?")){
			location.href="${pageContext.request.contextPath}/oneLineBoard/deleteReply.do?reply_no="+reply_no+"&brd_no="+brd_no+"&pageNum="+pageNum+"&searchType=" + searchType.value + "&searchTxt=" + searchTxt.value;	
		}else{
			return;
		}
	}
	
	function sessionChk(number){
		if(number == null || number == "" || number == "null"){
 			if (confirm("이 서비스는 로그인이 필요한 서비스 입니다. 로그인 하시겠습니까?")) {
 				location.href = "${pageContext.request.contextPath}/member/login.do";
 			} else {
 				return;
 			}
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
	
	function textCheck() {
		var counter = document.getElementById("counter");
		var content = document.getElementById("content");
		counter.innerHTML = 
			content.value.length + "/" + content.maxLength;
		if(content.value.length >= content.maxLength){
			alert("최대 " + content.maxLength + "글자 까지 작성할수 있습니다.");
		}
	}
	
	function locate(pageNum){
		var searchType = document.getElementById("searchType");
		var searchTxt = document.getElementById("searchTxt");
		location.href="../oneLineBoard/list.do?pageNum=" + pageNum + "&searchType=" + searchType.value + "&searchTxt=" + searchTxt.value;
	}
</script>
</head>
<body>

	
	<!-- Page Content -->
    <div class="container">

        <!-- Page Heading/Breadcrumbs -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">OneLine
                    <small>한줄</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="../module/main.jsp">Home</a>
                    </li>
                    <li class="active">OneLine</li>
                </ol>
            </div>
        </div>
	</div>
	
	<p>
	<p>
	
	<div style="border: 1px solid; padding: 10px 10px 10px 10px;" class="insert">
		<div style="border: 1px solid; padding: 10px 10px 10px 10px;" class="wrap">
			<form action="${pageContext.request.contextPath}/oneLineBoard/write.do" name="wrtierFrm" onsubmit="return isSubmit(${sessionScope.m_no})">
				<input type="hidden" name="m_no" value="${sessionScope.m_no}">
				<textarea Rows="3" cols="50" maxlength="150" id="content"
					name="brd_content" required="required" onkeyup="textCheck()" onfocus="sessionChk(${sessionScope.m_no})"></textarea>
				<span id="counter">0/150</span> <input
					style="height: 50px; width: 120px;" type="submit" value="등록">
			</form>
		</div>
	</div>
	<p>
	<div style="border: 1px solid; padding: 10px 10px 10px 10px;" class="Rows">
		<c:set var="tot" value="${total}" />
		<c:if test="${list != null}">
			<c:if test="${not empty list}">
				<c:forEach var="jolb" items="${list}">
					<div class="Row">
						<p><span class="RowNum">${tot}</span><span class="RowNick">${jolb.m_nick}</span><span class="RowDate">${jolb.brd_reg_date}</span>
						<pre class="RowContent" style="white-space: pre-line;word-break:break-all;">${jolb.brd_content}<a class="countClick">[${jolb.rep_count}]</a></pre>
						<c:if test="${sessionScope.m_no != null}">
							<c:if test="${jolb.m_no == sessionScope.m_no}">
								<input type="button" class="btnUpdate" value="수정">
								<input type="button" value="삭제" onclick="deleteChk(${jolb.brd_no},${pageNum})">
							</c:if>
							<input type="button" class="btnReply" value="답글">
						</c:if>
						</p>
					</div>
					<div class="updateForm">
						<form action="${pageContext.request.contextPath}/oneLineBoard/update.do" name="updateFrm" method="post" onsubmit="return isSubmit(${sessionScope.m_no})">
							<input type="button" class="updateCancel" value="취소"><br>
 							<input type="hidden" name="m_no" value="${sessionScope.m_no}">
							<input type="hidden" name="pageNum" value="${pageNum}">
							<input type="hidden" name="brd_no" value="${jolb.brd_no}">
							<input type="hidden" name="searchType" value="${searchType}">
							<input type="hidden" name="searchTxt" value="${searchTxt}">
							<p class="originText" style="display: none;">${jolb.brd_content}</p>
							<textarea Rows="3" cols="100" maxlength="150" class="updateContent"
									name="brd_content" required="required" >${jolb.brd_content}</textarea>
							<input style="height: 50px; width: 120px;" type="submit" value="등록">
						</form>
					</div>
					<div class="replyForm">
						<form action="${pageContext.request.contextPath}/oneLineBoard/insertReply.do" name="replyFrm" onsubmit="return isSubmit(${sessionScope.m_no })" method="post">
							<input type="hidden" name="m_no" value="${sessionScope.m_no }">
							<input type="hidden" name="brd_no" class= "${jolb.brd_no}" value="${jolb.brd_no}">
							<input type="hidden" name="pageNum" value="${pageNum}">
							<input type="button" class="replyCancel" value="취소"></p>
							<textarea Rows="3" cols="100" maxlength="150" class="replyContent"
								name="content" required="required"></textarea>
					 		<input style="height: 50px; width: 120px;" type="submit" value="등록">
						</form>
						 <c:if test="${not empty reList}"> 
							<c:forEach var="jolr" items="${reList}">
								<c:if test="${jolr.brd_no == jolb.brd_no}">
									<div class="replyRow">
										<span class="RowNick">${jolr.m_nick}</span><span class="RowDate">${jolr.reg_Date}</span><pre>${jolr.content}</pre>
										<c:if test="${not empty m_no}">
											<c:if test="${m_no == jolr.m_no}">
												<input type="button" value="수정" class="btnRepUpdate">
												<input type="button" value="삭제" onclick="deleteRepChk(${jolr.reply_no},${jolr.brd_no},${pageNum})">
											</c:if>
										</c:if>
									</div>
									<div class="replyUpdate" style="display: none;">
										<form action="${pageContext.request.contextPath}/oneLineBoard/UpdateReply.do" method="post" >
											<input type="hidden" name="reply_no" value="${jolr.reply_no}">
											<input type="hidden" name="brd_no" value="${jolr.brd_no}">
											<input type="hidden" name="pageNum" value="${pageNum}">
											<input type="hidden" name="searchType" value="${searchType}">
											<input type="hidden" name="searchTxt" value="${searchTxt}">
											<input type="button" class="repUpdateCancel" value="취소">
											<p class="originRepText" style="display: none;">${jolr.content}</p>
											<textarea Rows="3" cols="100" maxlength="150" class="updateReContent"
													name="content" required="required">${jolr.content}</textarea>
											<input type="submit" value="등록">											
										</form>
									</div>
								</c:if>
							</c:forEach>
						 </c:if> 	
				</div>
				<c:set var="tot" value="${tot - 1 }"/>
			</c:forEach>
		</c:if>
	</c:if>
	<c:if test="${empty list }">
		<p>게시글이 없습니다.</p>
	</c:if>
	
	<br>
	
		<div align="center" id="pagingandsearch">
			<c:if test="${startPage != 1}">
				<a href="javascript:locate(1)">&lt;&lt;맨 앞으로</a>
			</c:if>
			<c:if test="${startPage > pagePerBlock}">
				<a href="javascript:locate(${startPage-pagePerBlock})">&lt;이전</a>
			</c:if>
 			<c:forEach var="i" begin="${startPage}" end="${endPage}">
 				<c:if test="${i != nowPage}">
 					<a href="javascript:locate(${i})">[${i}]</a>
 				</c:if>
 				<c:if test="${i == nowPage}">
 					<b class="b">[${i}]</b>
 				</c:if>
			</c:forEach>
			<c:if test="${totalPage > endPage}">
				<a href="javascript:locate(${startPage+pagePerBlock})">다음&gt;</a>
			</c:if>
			<c:if test="${endPage != totalPage}">
				<a href="javascript:locate(${totalPage})">맨 뒤로&gt;&gt;</a>
			</c:if>
			
			<p>
			<p>
			
			<select id="searchType">
				<c:set var="brd_content" value="brd_contents"/>
				<c:if test="${searchType eq brd_content}">
					<option value="brd_content" selected="selected">내용</option>
				</c:if>
				<c:if test="${searchType ne brd_content}">
					<option value="brd_content">내용</option>
				</c:if>
				<c:set var="m_nick" value="m_nick"/>
				<c:if test="${searchType eq m_nick}">
					<option value="m_nick" selected="selected">글쓴이</option>
				</c:if>
				<c:if test="${searchType ne m_nick}">
					<option value="m_nick">글쓴이</option>
				</c:if>
			</select>
			<input type="text" id="searchTxt" value="${searchTxt}">
			<input type="submit" value="검색" onclick="locate(1)">
		</div>
	</div>
	
</body>
</html>