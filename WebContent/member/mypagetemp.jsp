<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../session/sessionChk.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="container">
        <!-- Page Heading/Breadcrumbs -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">MYPAGE
                    <small>회원</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="../module/main.jsp">Home</a>
                    </li>
                    <li class="active">mypage</li>
                </ol>
            </div>
        </div>

		<div class="row">
			<div class="col-md-3-2">
				<jsp:include page="mypage.jsp" />
			</div>
			<div class="col-md-9">
				<c:if test="${empty param.mypgm}">
					<jsp:forward page="myinfo.temp"/>
				</c:if>
				<c:if test="${not empty param.mypgm}">
					<jsp:include page="${param.mypgm}"/>
				</c:if>
			</div>
		</div>
	</div>

	<%-- <table align="center" width="100%">
		<tr>
			<td width="20%" height="50"><jsp:include page="mypage.jsp" /></td>
			<td width="80%" class="mypagetemp">
			<c:if test="${empty param.mypgm}">
					<jsp:forward page="myinfo.temp"/>
			</c:if> 
			<c:if test="${not empty param.mypgm}">
					<jsp:include page="${param.mypgm}"/>
			</c:if></td>
		</tr>
	</table> --%>

</body>
</html>