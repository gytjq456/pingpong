<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
<style>
	#intro_menu { text-align: left; margin-left: 16px; font-weight: 500; margin-bottom: 8px; }
</style>
	<div id="main_wrap">
		<div id="view_wrap">
			<c:choose>
				<c:when test="${empty tadto}">
					<div>내용을 불러오는 데 실패하였습니다. 다시 시도해 주세요.</div>
				</c:when>
				<c:otherwise>
					<div class="view_line">
						<div class="first_line">
							${tadto.title}
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="second_line_left">
								<span>글번호</span>
								<span class="span_con">${tadto.seq}</span>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="third_line_left">
								<ul>
									<li>
										<span>작성자</span>
										<span class="span_con">${tadto.id}</span>
									</li>
									<li>
										<span>추천인</span>
										<span class="span_con">${tadto.recomm}</span>
									</li>
								</ul>
							</div>
							<div class="third_line_right">
								<ul>
									<li>
										<span>승인</span>
										<span class="span_con">
											<c:if test="${tadto.pass == 'Y'}">완료</c:if>
											<c:if test="${tadto.pass == 'N'}">대기</c:if>
										</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="third_line_left">
								<ul>
									<li>
										<span>자격증</span>
										<span class="span_con">
											<c:forEach items="${files}" var="i">
												<a href="/file/downloadFileLicense?seq=${tadto.seq}&license=${i.sysname}" class="downloadF">
													${i.oriname}</a>
											</c:forEach>
										</span>
									</li>
									<li>
										<span>경력</span>
										<span class="span_con">${tadto.career}</span>
									</li>
									<li>
										<span>경험</span>
										<span class="span_con">${tadto.exp}</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div>
							<div id="intro_menu">자기 소개</div>
							<div id="contents">${tadto.introduce}</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="btn_wrap">
				<div class="btns">
					<c:if test="${tadto.pass == 'N'}">
						<button id="accept">승인</button>
					</c:if>
					<button id="delete">삭제</button>
					<button id="goToList">목록으로</button>
				</div>
			</div>
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
				
				$('#goToList').on('click', function(){
					location.href = "/admins/tutorAppList";
				})
			</script>
		</div>
	</div>
</body>
</html>