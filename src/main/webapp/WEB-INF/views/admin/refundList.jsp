<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty rflist}">
				환불 신청이 없습니다.
			</c:when>
			<c:otherwise>
				<input type="checkbox" id="selectAll"><br>
				<c:forEach var="rflist" items="${rflist}">
					<input type="checkbox" value="${rflist.seq}" class="deleteCheck">
					${rflist.seq} : 
					<a href="/admins/refundView?seq=${rflist.seq}">${rflist.id}</a>
					 : ${rflist.name} : ${rflist.email} : ${rflist.phone} : 
					${rflist.bank_name} : ${rflist.account} : ${rflist.profile}
					 : ${rflist.parent_seq} : ${rflist.cancle}<br>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<button id="deleteAll">승인</button>
		<div class="navi">${navi}</div>
		<script>
			$('#selectAll').on('change', function(){
				if ($('#selectAll').is(':checked')) {
					$('.deleteCheck').attr('checked', 'true');
				} else {
					$('.deleteCheck').removeAttr('checked');
				}
			})
		
			$('#deleteAll').on('click', function(){
				var conf = confirm('선택한 항목들을 모두 승인하시겠습니까?');
				
				if (conf) {
					var delCount = $('.deleteCheck:checked').length;
					var delList = [];
					
					for (var i = 0; i < delCount; i++) {
						delList[i] = $($('.deleteCheck:checked')[i]).val();
					}
					
					location.href = '/admins/deleteAll?pageName=refundList&values=' + delList;
				}
			})
		</script>
	</div>
</body>
</html>