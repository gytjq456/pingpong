<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty ldlist}">
				등록된 강의 취소 신청이 없습니다.
			</c:when>
			<c:otherwise>
				<input type="checkbox" id="selectAll"><br>
				<c:forEach var="ldlist" items="${ldlist}">
					<input type="checkbox" value="${ldlist.seq}" class="deleteCheck">
					${ldlist.seq} : 
					<a href="/admins/lessonDelView?seq=${ldlist.seq}">${ldlist.id}</a>
					 : ${ldlist.category} : 
					${ldlist.contents} : ${ldlist.parent_seq}<br>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<button id="acceptAll">승인</button>
		<button id="deleteAll">삭제</button>
		<div class="navi">${navi}</div>
		<script>
			$('#selectAll').on('change', function(){
				if ($('#selectAll').is(':checked')) {
					$('.deleteCheck').attr('checked', 'true');
				} else {
					$('.deleteCheck').removeAttr('checked');
				}
			})
			
			$('#acceptAll').on('click', function(){
				var conf = confirm('선택한 항목들을 모두 승인하시겠습니까?');
				
				if (conf) {
					var accCount = $('.deleteCheck:checked').length;
					var accList = [];
					
					for (var i = 0; i < accCount; i++){
						accList[i] = $($('.deleteCheck:checked')[i]).val();
					}
					
					location.href = '/admins/acceptDeleteLessons?values=' + accList;
				}
			})
		
			$('#deleteAll').on('click', function(){
				var conf = confirm('선택한 항목들을 정말 삭제하시겠습니까?');
				
				if (conf) {
					var delCount = $('.deleteCheck:checked').length;
					var delList = [];
					
					for (var i = 0; i < delCount; i++) {
						delList[i] = $($('.deleteCheck:checked')[i]).val();
					}
					
					location.href = '/admins/deleteAll?pageName=lessonDelList&values=' + delList;
				}
			})
		</script>
	</div>
</body>
</html>