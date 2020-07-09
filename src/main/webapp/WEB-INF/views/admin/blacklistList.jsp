<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<h3>블랙리스트</h3>
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<th>번호</th>
					<th>아이디(이름)</th>
					<th>등록일</th>
					<th>해제일</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty bllist}">
						<tr>
							<td colspan="5">블랙리스트가 비었습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="bllist" items="${bllist}">
							<tr>
								<td><input type="checkbox" value="${bllist.seq}" class="deleteCheck"></td>
								<td>${bllist.seq}</td>
								<td><a href="/admins/blacklistView?seq=${bllist.seq}">${bllist.id}(${bllist.name})</a></td>
								<td>${bllist.start_date}</td>
								<td>${bllist.end_date}</td>
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
					
					location.href = '/admins/deleteAll?pageName=blacklistList&values=' + delList;
				}
			})
		</script>
	</div>
</body>
</html>