<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="card_box">
			<div id="card_wrap">
				<c:choose>
					<c:when test="${empty trdto}">
						<div>내용을 불러오는 데 실패하였습니다. 다시 시도해 주세요.</div>
					</c:when>
					<c:otherwise>
						<div id="card_left">
							<div id="profile">
								<img src="/resources/img/sub/userThum.jpg"/>
							</div>
							<div class="card_line">
								<div class="left_left">
									<span>아이디</span>
									<span class="span_con">${trdto.id}</span>
								</div>
								<div class="left_right">
									<span>이름</span>
									<span class="span_con">${trdto.name}</span>
								</div>
							</div>
							<div class="card_line">
								<div class="left_left">
									<span>나이</span>
									<span class="span_con">${trdto.age}</span>
								</div>
								<div class="left_right">
									<span>성별</span>
									<span class="span_con">${trdto.gender}</span>
								</div>
							</div>
							<div class="card_line">
								<div class="left_left">
									<span>국적</span>
									<span class="span_con">${trdto.country}</span>
								</div>
								<div class="left_right">
									<span>신고수</span>
									<span class="span_con">${trdto.report_count}</span>
								</div>
							</div>
							<hr>
							<div class="card_line">
								<span>이메일</span>
								<span class="span_con">${trdto.email}</span>
							</div>
							<div class="card_line">
								<span>전화번호</span>
								<span class="span_con">${trdto.phone_country}${trdto.phone}</span>
							</div>
							<div class="card_line">
								<span>주소</span>
								<span class="span_con">${trdto.address}</span>
							</div>
							<div class="card_line">
								<span>계좌번호</span>
								<span class="span_con">${trdto.bank_name} ${trdto.account}</span>
							</div>
						</div>
						<div id="card_right">
							<div class="card_line">
								<div class="left_left">
									<span>가입 유형</span>
									<span class="span_con">
										<c:if test="${trdto.mem_type == 'basic'}">일반</c:if>
										<c:if test="${trdto.mem_type == 'kakao'}">카카오</c:if>
									</span>
								</div>
								<div class="left_right">
									<span>등급</span>
									<span class="span_con">
										<c:if test="${trdto.grade == 'default'}">일반</c:if>
										<c:if test="${trdto.grade == 'partner'}">파트너</c:if>
										<c:if test="${trdto.grade == 'tutor'}">튜터</c:if>
									</span>
								</div>
							</div>
							<div class="card_line">
								<span>가입일</span>
								<span class="span_con">${fn:substring(trdto.signup_date, 0, 10)}</span>
							</div>
							<hr>
							<div class="card_line">
								<span>구사 언어</span>
								<span class="span_con">${trdto.lang_can}</span>
							</div>
							<div class="card_line">
								<span>학습 언어</span>
								<span class="span_con">${trdto.lang_learn}</span>
							</div>
							<hr>
							<div class="card_line">
								<span>관심사</span>
								<span class="span_con">${trdto.hobby}</span>
							</div>
							<hr>
							<div class="card_line">
								<span>소개</span>
							</div>
							<div class="introduce">
								${trdto.introduce}
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
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
						var seq = ${trdto.id};
						location.href = "/admins/deleteBySeq?pageName=tutorList&id=" + id;
					}
				})
				
				$('#goToList').on('click', function(){
					location.href = "/admins/tutorList";
				})
			</script>
		</div>
	</div>
</body>
</html>