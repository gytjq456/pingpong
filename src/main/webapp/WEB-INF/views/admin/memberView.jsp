<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="card_box">
			<div id="card_wrap">
				<c:choose>
					<c:when test="${empty mdto}">
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
									<span class="span_con">${mdto.id}</span>
								</div>
								<div class="left_right">
									<span>이름</span>
									<span class="span_con">${mdto.name}</span>
								</div>
							</div>
							<div class="card_line">
								<div class="left_left">
									<span>나이</span>
									<span class="span_con">${mdto.age}</span>
								</div>
								<div class="left_right">
									<span>성별</span>
									<span class="span_con">${mdto.gender}</span>
								</div>
							</div>
							<div class="card_line">
								<div class="left_left">
									<span>국적</span>
									<span class="span_con">${mdto.country}</span>
								</div>
								<div class="left_right">
									<span>신고수</span>
									<span class="span_con">${mdto.report_count}</span>
								</div>
							</div>
							<hr>
							<div class="card_line">
								<span>이메일</span>
								<span class="span_con">${mdto.email}</span>
							</div>
							<div class="card_line">
								<span>전화번호</span>
								<span class="span_con">${mdto.phone_country}${mdto.phone}</span>
							</div>
							<div class="card_line">
								<span>주소</span>
								<span class="span_con">${mdto.address}</span>
							</div>
							<div class="card_line">
								<span>계좌번호</span>
								<span class="span_con">${mdto.bank_name} ${mdto.account}</span>
							</div>
						</div>
						<div id="card_right">
							<div class="card_line">
								<div class="left_left">
									<span>가입 유형</span>
									<span class="span_con">
										<c:if test="${mdto.mem_type == 'basic'}">일반</c:if>
										<c:if test="${mdto.mem_type == 'kakao'}">카카오</c:if>
									</span>
								</div>
								<div class="left_right">
									<span>등급</span>
									<span class="span_con">
										<c:if test="${mdto.grade == 'default'}">일반</c:if>
										<c:if test="${mdto.grade == 'partner'}">파트너</c:if>
										<c:if test="${mdto.grade == 'tutor'}">튜터</c:if>
									</span>
								</div>
							</div>
							<div class="card_line">
								<span>가입일</span>
								<span class="span_con">${fn:substring(mdto.signup_date, 0, 10)}</span>
							</div>
							<hr>
							<div class="card_line">
								<span>구사 언어</span>
								<span class="span_con">${mdto.lang_can}</span>
							</div>
							<div class="card_line">
								<span>학습 언어</span>
								<span class="span_con">${mdto.lang_learn}</span>
							</div>
							<hr>
							<div class="card_line">
								<span>관심사</span>
								<span class="span_con">${mdto.hobby}</span>
							</div>
							<hr>
							<div class="card_line">
								<span>소개</span>
							</div>
							<div class="introduce">
								${mdto.introduce}
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
						var seq = ${mdto.id};
						location.href = "/admins/deleteBySeq?pageName=memberList&id=" + id;
					}
				})
				
				$('#goToList').on('click', function(){
					location.href = "/admins/memberList";
				})
			</script>
		</div>
	</div>
</body>
</html>