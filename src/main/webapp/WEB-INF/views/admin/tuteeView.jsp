<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="view_wrap">
			<c:choose>
				<c:when test="${empty ttdto}">
					<div>내용을 불러오는 데 실패하였습니다. 다시 시도해 주세요.</div>
				</c:when>
				<c:otherwise>
					<div class="view_line">
						<div class="first_line">
							튜티 정보
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="third_line_left">
								<ul>
									<li>
										<span>학생 번호</span>
										<span class="span_con">${ttdto.seq}</span>
									</li>
									<li>
										<span>아이디</span>
										<span class="span_con">${ttdto.id}(${ttdto.name})</span>
									</li>
									<li>
										<span>이메일</span>
										<span class="span_con">${ttdto.email}</span>
									</li>
								</ul>
							</div>
							<div class="third_line_right">
								<ul>
									<li>
										<span>강의 코드</span>
										<span class="span_con">${ttdto.parent_seq}</span>
									</li>
									<li>
										<span>전화번호</span>
										<span class="span_con">${ttdto.phone}</span>
									</li>
									<li>
										<span>계좌번호</span>
										<span class="span_con">${ttdto.bank_name} ${ttdto.account}</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="btn_wrap">
				<div class="btns">
					<button id="delete">삭제</button>
					<button id="goToList">목록으로</button>
				</div>
			</div>
			<script>
				$('#delete').on('click', function(){
					var conf = confirm('정말 삭제하시겠습니까?');
					
					if (conf) {
						var seq = ${ttdto.seq};
						location.href = "/admins/deleteBySeq?pageName=tuteeList&seq=" + seq;
					}
				})
				
				$('#goToList').on('click', function(){
					location.href = "/admins/tuteeList";
				})
			</script>
		</div>
	</div>
</body>
</html>