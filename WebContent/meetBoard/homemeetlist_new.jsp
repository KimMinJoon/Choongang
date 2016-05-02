<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				<h1 class="page-header"> Meet_New </h1>
			</div>
		<c:forEach var="brd" items="${list2 }">
			<c:if test="${not empty list2 }">
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4> <i class="fa fa-fw fa-user"></i> <a href="portfolio-item.html">${brd.brd_subject }</a> </h4>
					</div>
					<div class="panel-body">
						<p>${brd.brd_content }</p>
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