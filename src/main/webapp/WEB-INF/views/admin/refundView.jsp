<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="view_wrap">
			<c:choose>
				<c:when test="${empty rfdto}">
					<div>내용을 불러오는 데 실패하였습니다. 다시 시도해 주세요.</div>
				</c:when>
				<c:otherwise>
					<div class="view_line">
						<div class="first_line">
							강의 환불 신청서
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="second_line_left">
								<span>글번호</span>
								<span class="span_con">${rfdto.seq}</span>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="third_line_left">
								<ul>
									<li>
										<span>신청자</span>
										<span class="span_con">${rfdto.id}(${rfdto.name})</span>
									</li>
									<li>
										<span>전화번호</span>
										<span class="span_con">${rfdto.phone_country}${rfdto.phone}</span>
									</li>
									<li>
										<span>이메일</span>
										<span class="span_con">${rfdto.email}</span>
									</li>
									<li>
										<span>강의 코드</span>
										<span class="span_con">${rfdto.parent_seq}</span>
									</li>
								</ul>
							</div>
							<div class="third_line_right">
								<ul>
									<li>
										<span>계좌 은행</span>
										<span class="span_con">${rfdto.bank_name}</span>
									</li>
									<li>
										<span>계좌번호</span>
										<span class="span_con">${rfdto.account}</span>
									</li>
									<li>
										<span>환불 금액</span>
										<span class="span_con">${rfdto.refundPrice}</span>
									</li>
									<li>
										<span>처리 현황</span>
										<span class="span_con">
											<c:if test="${rfdto.cancle == 'Y'}">대기</c:if>
										</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="btn_wrap">
				<div class="btns">
					<button id="accept">승인</button>
					<button id="goToList">목록으로</button>
				</div>
			</div>
			<script>
				$('#accept').on('click', function(){
					var conf = confirm('정말 승인하시겠습니까?');
					
					if (conf) {
						var seq = ${rfdto.seq};
						location.href = "/admins/deleteBySeq?pageName=refundList&seq=" + seq;
					}
				})
				
				$('#goToList').on('click', function(){
					location.href = "/admins/refundList";
				})
			</script>
		</div>
	</div>
</body>
</html>