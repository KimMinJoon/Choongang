<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/modern-business.css" rel="stylesheet">
<link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<script type="text/javascript">
</script>
</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header"> Welcome to Meet the New </h1>
			</div>
		<c:forEach var="brd" items="${list2 }">
			<c:if test="${not empty list2 }">
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4> <i class="fa fa-fw fa-user"></i><a href="../meetBoard/view.do?brd_no=${brd.brd_no}">
						<c:if test="${fn:length(brd.brd_subject) > 35}">
							<c:out value="${fn:substring(brd.brd_subject, 0, 35)}" /> ...
						</c:if>
						<c:if test="${fn:length(brd.brd_subject) <= 35}">
							${brd.brd_subject}
						</c:if>
						</a> </h4>
						<div class="text-right">
							<h5>${brd.m_nick}&nbsp;&nbsp;&nbsp;&nbsp;</h5>
						</div>
					</div>
					<div class="panel-body">
					<c:if test="${fn:length(brd.brd_content) > 80}">
						<c:out value="${fn:substring(brd.brd_content, 0, 80)}" /> ...
					</c:if>
					<c:if test="${fn:length(brd.brd_content) <= 80}">
						<p>${brd.brd_content}</p>
					</c:if>
					</div>
				</div>
			</div>
			</c:if>
		</c:forEach>
		</div>
		<!-- /.row -->
	</div>
        
</body>
</html>