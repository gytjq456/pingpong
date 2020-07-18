<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="table_wrap">
			<h3 class="tit">첨삭 게시판</h3>
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll"></th>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>유형</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty clist}">
							<tr>
								<td colspan="6">등록된 첨삭 게시글이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="clist" items="${clist}">
								<tr>
									<td><input type="checkbox" value="${clist.seq}" class="deleteCheck"></td>
									<td>${clist.seq}</td>
									<td><a href="/admins/correctView?seq=${clist.seq}">${clist.title}</a></td>
									<td>${clist.writer}</td>
									<td>${clist.type}</td>
									<td>${fn:substring(clist.write_date, 0, 10)}</td>
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
							
							location.href = '/admins/deleteAll?pageName=correctList&values=' + delList;
						}
					}
				})
			</script>
		</div>
	</div>
</body>
</html>