<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty rdto}">
				ㅠㅠ
			</c:when>
			<c:otherwise>
				글번호: ${rdto.seq}<br>
				아이디: ${rdto.id}<br>
				사유: ${rdto.reason}<br>
				신고자: ${rdto.reporter}<br>
				신고일: ${rdto.sDate}<br>
				부모: ${rdto.parent_seq}<br>
				유형: ${rdto.category}<br>
				패스: ${rdto.pass}<br>
			</c:otherwise>
		</c:choose>
		<button id="accept">승인</button>
		<button id="delete">삭제</button>
		<a href="/admins/reportList">목록으로</a>
		<script>
			$('#accept').on('click', function(){
				var conf = confirm('정말 승인하시겠습니까?');
				
				if (conf) {
					var seq = ${rdto.seq};
					var id = '${rdto.id}';
					var category = '${rdto.category}';
					var parent_seq = ${rdto.parent_seq};
					location.href = "/admins/reportUpdate?seq=" + seq + "&id=" + id + "&category=" + category + "&parent_seq=" + parent_seq;
				}
			})
			
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${rdto.seq};
					location.href = "/admins/deleteBySeq?pageName=reportList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>