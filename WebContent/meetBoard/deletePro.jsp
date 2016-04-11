<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../session/sessionChk.jsp"  %>
<!DOCTYPE html >
<html>
<head>
<c:if test="${result > 0}">
<script type="text/javascript">
	alert("삭제성공");
	location.href="../meetBoard/meetlist.do?pageNum=${pageNum}";
</script>
</c:if>
<c:if test="${result <= 0}">
<script type="text/javascript">
	alert("삭제실패...");
	history.go(-1);
</script>
</c:if>
</body>
</html>