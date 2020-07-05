<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${empty tadto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			글번호: ${tadto.seq}<br>
			아이디: ${tadto.id}<br>
			제목: ${tadto.title}<br>
			자격증: ${tadto.license}<br>
			경력: ${tadto.career}<br>
			경험: ${tadto.exp}<br>
			소개: ${tadto.introduce}<br>
			추천인: ${tadto.recomm}<br>
			패스: ${tadto.pass}
		</c:otherwise>
	</c:choose>
</body>
</html>