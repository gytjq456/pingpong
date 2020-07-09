<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<h3>회원</h3>
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<th>유형</th>
					<th>아이디(이름)</th>
					<th>성별</th>
					<th>등급</th>
					<th>가입일</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty mlist}">
						<tr>
							<td colspan="6">등록된 회원이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="mlist" items="${mlist}">
							<tr>
								<td><input type="checkbox" value="${mlist.id}" class="deleteCheck"></td>
								<td>${mlist.mem_type}</td>
								<td><a href="/admins/memberView?id=${mlist.id}">${mlist.id}(${mlist.name})</a></td>
								<td>${mlist.gender}</td>
								<td>
									<c:if test="${mlist.grade == 'default'}">일반</c:if>
									<c:if test="${mlist.grade == 'partner'}">파트너</c:if>
									<c:if test="${mlist.grade == 'tutor'}">튜터</c:if>
								</td>
								<td>${mlist.signup_date}</td>
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
					
					location.href = '/admins/deleteAll?pageName=memberList&values=' + delList;
				}
			})
		</script>
	</div>
</body>
</html>