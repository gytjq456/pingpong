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
		<c:when test="${empty ladto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			글번호: ${ladto.seq}<br>
			강사: ${ladto.name}(${ladto.id})<br>
			이메일: ${ladto.email}<br>
			전화번호: (${ladto.phone_country})${ladto.phone}<br>
			유형: ${ladto.category}<br>
			제목: ${ladto.title}<br>
			가격: ${ladto.price}<br>
			언어: ${ladto.language}<br>
			모집 기간: ${ladto.apply_start} ~ ${ladto.apply_end}<br>
			진행 기간: ${ladto.start_date} ~ ${ladto.end_date}<br>
			진행 시간: ${ladto.start_hour}:${ladto.start_minute} ~ ${ladto.end_hour}:${ladto.end_minute}<br>
			인원: ${ladto.cur_num}/${ladto.max_num}<br>
			장소: ${ladto.location}<br>
			내용: ${ladto.curriculum}<br>
			추천수: ${ladto.like_count}<br>
			조회수: ${ladto.view_count}<br>
			리뷰수: ${ladto.review_count}<br>
			평점: ${ladto.review_point}<br>
			모집중: ${ladto.applying}<br>
			진행중: ${ladto.proceeding}<br>
		</c:otherwise>
	</c:choose>
	<a href="/admin/lessonPass?seq=${ladto.seq}">승인</a>
	<a href="/admin/deleteBySeq?pageName=lessonAppList&seq=${ladto.seq}">삭제</a>
	<a href="/admin/lessonAppList">목록으로</a>
</body>
</html>