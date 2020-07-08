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
		<c:when test="${empty bllist}">
			블랙리스트가 비었습니다.
		</c:when>
		<c:otherwise>
			<input type="checkbox" id="selectAll"><br>
			<c:forEach var="bllist" items="${bllist}">
				<input type="checkbox" value="${bllist.seq}" class="deleteCheck">
				${bllist.seq} : 
				<a href="/admin/blacklistView?seq=${bllist.seq}">${bllist.id}(${bllist.name})</a>
				 : ${bllist.reason} : ${bllist.start_date} : ${bllist.end_date}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<button id="deleteAll">삭제</button>
	<div class="navi">${navi}</div>
	<a href="/admin">관리자 메인</a>
	<script>
		$('#selectAll').on('change', function(){
			if ($('#selectAll').is(':checked')) {
				$('.deleteCheck').attr('checked', 'true');
			} else {
				$('.deleteCheck').removeAttr('checked');
			}
		})
	
		$('#deleteAll').on('click', function(){
			var delCount = $('.deleteCheck:checked').length;
			var delList = [];
			
			for (var i = 0; i < delCount; i++) {
				delList[i] = $($('.deleteCheck:checked')[i]).val();
			}
			
			location.href = '/admin/deleteAll?pageName=blacklistList&values=' + delList;
		})
	</script>
</body>
</html>