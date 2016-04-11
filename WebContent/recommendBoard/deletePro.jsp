<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../session/sessionChk.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

		
	<c:if test="${result > 0 }">
		<script language=javascript>
			self.window.alert("삭제 성공");
			opener.parent.location.href = "list.do?pageNum=${pageNum}";
			window.close();
		</script>
	</c:if>
	<c:if test="${result <= 0 }">
		<script type="text/javascript">
			alert("삭제 실패");
			history.go(-1);
		</script>
	</c:if>

</body>
</html>