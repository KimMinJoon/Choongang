<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/modern-business.css" rel="stylesheet">
<link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>
<body>

   <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
               <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                       <span class="sr-only">Toggle navigation</span>
                       <span class="icon-bar"></span>
                       <span class="icon-bar"></span>
                       <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="../module/main.jsp">Language Exchange</a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                   <li>
                  <a href="../module/main.jsp?pgm=/noticeBoard/exchangeLanguage.jsp">Introduce</a>
               </li>
                  <li>
                      <a href="${pageContext.request.contextPath}/noticeBoard/list.do">Notice</a>
                  </li>
                  <li>
                      <a href="${pageContext.request.contextPath}/meetBoard/meetlist.do">Meet</a>
                  </li>
                  <li>
                      <a href="${pageContext.request.contextPath}/recommendBoard/list.do">Recommend</a>
                  </li>
                  <li>
                      <a href="${pageContext.request.contextPath}/oneLineBoard/list.do">OneLine</a>
                  </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Member<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                           <c:set var="m_no" value="${sessionScope.m_no}"></c:set>
                     <c:if test="${empty m_no}">
                            <li>
                                <a href="${pageContext.request.contextPath}/member/login.do">Login</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/member/join.do">Join</a>
                            </li>
                            </c:if>
                            <c:if test="${not empty m_no}">
                            <li>
                                <a href="../module/main.jsp?pgm=/member/mypagetemp.jsp">Mypage</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/member/logout.do">Logout</a>
                            </li>
                            </c:if>
                        </ul>
                    </li>
                 </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
    
    <script src="../js/jquery.js"></script>
   <script src="../js/bootstrap.min.js"></script>
   <script>
   $('.carousel').carousel({
       interval: 5000 //changes the speed
   })
   </script>

</body>
</html>