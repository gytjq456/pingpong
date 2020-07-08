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
		<c:when test="${empty rflist}">
			환불 신청이 없습니다.
		</c:when>
		<c:otherwise>
			<input type="checkbox" id="selectAll"><br>
			<c:forEach var="rflist" items="${rflist}">
				<input type="checkbox" value="${rflist.seq}" class="deleteCheck">
				${rflist.seq} : 
				<a href="/admin/refundView?seq=${rflist.seq}">${rflist.id}</a>
				 : ${rflist.name} : ${rflist.email} : ${rflist.phone} : 
				${rflist.bank_name} : ${rflist.account} : ${rflist.profile}
				 : ${rflist.parent_seq} : ${rflist.cancle}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<button id="deleteAll">승인</button>
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
			
			location.href = '/admin/deleteAll?pageName=refundList&values=' + delList;
		})
	</script>
</body>
</html>