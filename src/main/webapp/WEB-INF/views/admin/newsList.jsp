<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty nlist}">
				등록된 토론 게시글이 없습니다.
			</c:when>
			<c:otherwise>
				<input type="checkbox" id="selectAll"><br>
				<c:forEach var="nlist" items="${nlist}">
					<input type="checkbox" value="${nlist.seq}" class="deleteCheck">
					${nlist.seq} : 
					<a href="/admins/newsView?seq=${nlist.seq}">${nlist.writer}</a>
					 : ${nlist.title} : ${nlist.category} : 
					${nlist.location} : ${nlist.write_date}<br>
				</c:forEach>
			</c:otherwise>
		</c:choose>
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
		
			$('#deleteAll').on('click', function(){
				var conf = confirm('선택한 항목들을 정말 삭제하시겠습니까?');
				
				if (conf) {
					var delCount = $('.deleteCheck:checked').length;
					var delList = [];
					
					for (var i = 0; i < delCount; i++) {
						delList[i] = $($('.deleteCheck:checked')[i]).val();
					}
					
					location.href = '/admins/deleteAll?pageName=newsList&values=' + delList;
				}
			})
		</script>
	</div>
</body>
</html>