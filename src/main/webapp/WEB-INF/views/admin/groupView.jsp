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
		<c:when test="${empty gdto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			글번호: ${gdto.seq}<br>
			제목: ${gdto.title}<br>
			작성자: ${gdto.writer_name}(${gdto.writer_id})<br>
			유형: ${gdto.hobby_type}<br>
			모집 기간: ${gdto.apply_start} ~ ${gdto.apply_end}<br>
			진행 기간: ${gdto.start_date} ~ ${gdto.end_date}<br>
			기간 유형: ${gdto.period}<br>
			인원: ${gdto.cur_num}/${gdto.max_num}<br>
			장소: ${gdto.location}<br>
			내용: ${gdto.contents}<br>
			작성일: ${gdto.date}<br>
			조회수: ${gdto.view_count}<br>
			추천수: ${gdto.like_count}<br>
			신청수: ${gdto.app_count}<br>
			리뷰수: ${gdto.review_count}<br>
			평점: ${gdto.review_point}<br>
			모집중: ${gdto.applying}<br>
			진행중: ${gdto.proceeding}<br>
		</c:otherwise>
	</c:choose>
	<a href="/admin/deleteBySeq?pageName=groupList&seq=${gdto.seq}">삭제</a>
	<a href="/admin/groupList">목록으로</a>
</body>
</html>