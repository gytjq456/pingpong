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
		<c:when test="${empty sessionScope.adminLog}">
			<div>
				<form action="/admin/login" method="post">
					<input type="text" name="id" id="id"><br>
					<input type="password" name="pw" id="pw"><br>
					<button>로그인</button>
				</form>
			</div>
		</c:when>
		<c:otherwise>
			<a href="/admin/memberList">회원</a>
			<a href="/admin/partnerList">파트너</a>
			<a href="/admin/groupList">그룹</a>
			<a href="/admin/tutorList">튜터</a>
			<a href="/admin/tutorAppList">튜터 신청</a>
			<a href="/admin/lessonList">강의</a>
			<a href="/admin/lessonAppList">강의 신청</a>
			<a href="/admin/lessonDelList">강의 삭제</a>
			<a href="/admin/tuteeList">튜티</a>
			<a href="/admin/discussionList">토론 게시판</a>
			<a href="/admin/correctList">첨삭 게시판</a>
			<a href="/admin/reportList">신고</a>
			<a href="/admin/logout">로그아웃</a>
		</c:otherwise>
	</c:choose>
</body>
</html>