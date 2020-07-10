<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<h3>강의</h3>
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<th>번호</th>
					<th>강의명</th>
					<th>가격</th>
					<th>강사명</th>
					<th>유형</th>
					<th>모집중</th>
					<th>진행중</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty llist}">
						<tr>
							<td colspan="8">등록된 강의가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="llist" items="${llist}">
							<tr>
								<td><input type="checkbox" value="${llist.seq}" class="deleteCheck"></td>
								<td>${llist.seq}</td>
								<td><a href="/admins/lessonView?seq=${llist.seq}">${llist.title}</a></td>
								<td>${llist.price}</td>
								<td>${llist.id}(${llist.name})</td>
								<td>${llist.category}</td>
								<td>
									<c:if test="${llist.applying == 'Y'}">O</c:if>
									<c:if test="${llist.applying == 'N'}">X</c:if>
								</td>
								<td>
									<c:if test="${llist.proceeding == 'Y'}">O</c:if>
									<c:if test="${llist.proceeding == 'N'}">X</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
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
					
					location.href = '/admins/deleteAll?pageName=lessonList&values=' + delList;
				}
			})
		</script>
	</div>
</body>
</html>