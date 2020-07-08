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
		<c:when test="${empty talist}">
			등록된 튜터 신청이 없습니다.
		</c:when>
		<c:otherwise>
			<input type="checkbox" id="selectAll"><br>
			<c:forEach var="talist" items="${talist}">
				<input type="checkbox" value="${talist.seq}" class="deleteCheck">
				${talist.seq} : ${talist.id} : 
				<a href="/admin/tutorAppView?seq=${talist.seq}">${talist.title}</a>
				 : ${talist.license} : 
				${talist.recomm} : ${talist.pass}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<button id="acceptAll">승인</button>
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
		
		$('#acceptAll').on('click', function(){
			var accCount = $('.deleteCheck:checked').length;
			var accList = [];
			
			for (var i = 0; i < accCount; i++){
				accList[i] = $($('.deleteCheck:checked')[i]).val();
			}
			
			location.href = '/admin/acceptAll?pageName=tutorAppList&values=' + accList;
		})
	
		$('#deleteAll').on('click', function(){
			var delCount = $('.deleteCheck:checked').length;
			var delList = [];
			
			for (var i = 0; i < delCount; i++) {
				delList[i] = $($('.deleteCheck:checked')[i]).val();
			}
			
			location.href = '/admin/deleteAll?pageName=tutorAppList&values=' + delList;
		})
	</script>
</body>
</html>