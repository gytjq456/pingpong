<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="table_wrap">
			<h3>튜티</h3>
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll"></th>
						<th>번호</th>
						<th>아이디(이름)</th>
						<th>전화번호</th>
						<th>강의 코드</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty ttlist}">
							<tr>
								<td colspan="5">튜티가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="ttlist" items="${ttlist}">
								<tr>
									<td><input type="checkbox" value="${ttlist.seq}" class="deleteCheck"></td>
									<td>${ttlist.seq}</td>
									<td><a href="/admins/tuteeView?seq=${ttlist.seq}">${ttlist.id}(${ttlist.name})</a></td>
									<td>${ttlist.phone_country}${ttlist.phone}</td>
									<td>${ttlist.parent_seq}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div class="btn_wrap">
				<div class="btns">
					<button id="deleteAll">삭제</button>
				</div>
			</div>
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
					var delCount = $('.deleteCheck:checked').length;
					
					if (delCount == 0) {
						alert('선택된 항목이 없습니다.');
					} else {
						var conf = confirm('선택한 항목들을 정말 삭제하시겠습니까?');
						
						if (conf) {
							var delList = [];
							
							for (var i = 0; i < delCount; i++) {
								delList[i] = $($('.deleteCheck:checked')[i]).val();
							}
							
							location.href = '/admins/deleteAll?pageName=tuteeList&values=' + delList;
						}
					}
				})
			</script>
		</div>
	</div>
</body>
</html>