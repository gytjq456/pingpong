<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<h3>튜티 환불 신청</h3>
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<th>번호</th>
					<th>아이디(이름)</th>
					<th>계좌 은행</th>
					<th>금액</th>
					<th>강의 코드</th>
					<th>처리 현황</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty rflist}">
						<tr>
							<td colspan="7">환불 신청이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="rflist" items="${rflist}">
							<tr>
								<td><input type="checkbox" value="${rflist.seq}" class="deleteCheck"></td>
								<td>${rflist.seq}</td>
								<td><a href="/admins/refundView?seq=${rflist.seq}">${rflist.id}(${rflist.name})</a></td>
								<td>${rflist.bank_name}</td>
								<td>${rflist.price}</td>
								<td>${rflist.parent_seq}</td>
								<td>
									<c:if test="${rflist.cancle == 'Y'}">대기</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
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