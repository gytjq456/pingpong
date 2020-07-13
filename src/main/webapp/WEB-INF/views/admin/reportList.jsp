<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="table_wrap">
			<h3>신고</h3>
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll"></th>
						<th>번호</th>
						<th>아이디</th>
						<th>신고자</th>
						<th>유형</th>
						<th>대상</th>
						<th>신고일</th>
						<th>처리 현황</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty rlist}">
							<tr>
								<td colspan="8">신고된 컨텐츠가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="rlist" items="${rlist}">
								<tr>
									<td><input type="checkbox" value="${rlist.seq}" class="deleteCheck"></td>
									<td>${rlist.seq}</td>
									<td><a href="/admins/reportView?seq=${rlist.seq}">${rlist.id}</a></td>
									<td>${rlist.reporter}</td>
									<td>${rlist.category}</td>
									<td>${rlist.parent_seq}</td>
									<td>${fn:substring(rlist.report_date, 0, 10)}</td>
									<td>
										<c:if test="${rlist.pass == 'Y'}">승인</c:if>
										<c:if test="${rlist.pass == 'N'}">대기</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div class="btn_wrap">
				<div class="btns">
					<button id="acceptAll">승인</button>
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
				
				$('#acceptAll').on('click', function(){
					var accCount = $('.deleteCheck:checked').length;
					
					if (accCount == 0) {
						alert('선택된 항목이 없습니다.');
					} else {
						var conf = confirm('선택한 항목들을 모두 승인하시겠습니까?');
						
						if (conf) {
							var accList = [];
							
							for (var i = 0; i < accCount; i++){
								accList[i] = $($('.deleteCheck:checked')[i]).val();
							}
							
							location.href = '/admins/acceptAll?pageName=reportList&values=' + accList;
						}
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
							
							location.href = '/admins/deleteAll?pageName=reportList&values=' + delList;
						}
					}
				})
			</script>
		</div>
	</div>
</body>
</html>