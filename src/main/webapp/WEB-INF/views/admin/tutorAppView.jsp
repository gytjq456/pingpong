<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty tadto}">
				ㅠㅠ
			</c:when>
			<c:otherwise>
				글번호: ${tadto.seq}<br>
				아이디: ${tadto.id}<br>
				제목: ${tadto.title}<br>
				자격증:
				<c:forEach items="${files}" var="i">
					<a href="/file/downloadFileLicense?seq=${tadto.seq}&license=${i.sysname}" class="downloadF">
						${i.oriname}</a>
				</c:forEach>
				<br>
				경력: ${tadto.career}<br>
				경험: ${tadto.exp}<br>
				소개: ${tadto.introduce}<br>
				추천인: ${tadto.recomm}<br>
				패스: ${tadto.pass}<br>
			</c:otherwise>
		</c:choose>
		<button id="accept">승인</button>
		<button id="delete">삭제</button>
		<a href="/admins/tutorAppList">목록으로</a>
		<script>
			$('#accept').on('click', function(){
				var conf = confirm('정말 승인하시겠습니까?');
				
				if (conf) {
					var seq = ${tadto.seq};
					var id = '${tadto.id}';
					location.href = "/admins/tutorAppUpdate?seq=" + seq + "&id=" + id;
				}
			})
			
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${tadto.seq};
					location.href = "/admins/deleteBySeq?pageName=tutorAppList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>