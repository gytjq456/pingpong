<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="card_box">
			<div id="card_wrap">
				<c:choose>
					<c:when test="${empty pdto}">
						<div>내용을 불러오는 데 실패하였습니다. 다시 시도해 주세요.</div>
					</c:when>
					<c:otherwise>
						<div id="card_left">
							<div id="profile">
								<img src="/upload/member/${pdto.id}/${pdto.sysname}"/>
							</div>
							<div class="card_line">
								<div class="left_left">
									<span>아이디</span>
									<span class="span_con">${pdto.id}</span>
								</div>
								<div class="left_right">
									<span>이름</span>
									<span class="span_con">${pdto.name}</span>
								</div>
							</div>
							<div class="card_line">
								<div class="left_left">
									<span>나이</span>
									<span class="span_con">${pdto.age}</span>
								</div>
								<div class="left_right">
									<span>성별</span>
									<span class="span_con">${pdto.gender}</span>
								</div>
							</div>
							<div class="card_line">
								<div class="left_left">
									<span>국적</span>
									<span class="span_con">${pdto.country}</span>
								</div>
								<div class="left_right">
									<span>파트너 등록 번호</span>
									<span class="span_con">${pdto.seq}</span>
								</div>
							</div>
							<hr>
							<div class="card_line">
								<span>이메일</span>
								<span class="span_con">${pdto.email}</span>
							</div>
							<div class="card_line">
								<span>전화번호</span>
								<span class="span_con">${pdto.phone_country}${pdto.phone}</span>
							</div>
							<div class="card_line">
								<span>주소</span>
								<span class="span_con">${pdto.address}</span>
							</div>
						</div>
						<div id="card_right">
							<div class="card_line">
								<div class="left_left">
									<span>리뷰수</span>
									<span class="span_con">${pdto.review_count}</span>
								</div>
								<div class="left_right">
									<span>평점</span>
									<span class="span_con">${pdto.review_point}</span>
								</div>
							</div>
							<div class="card_line">
								<span>등록일</span>
								<span class="span_con">${fn:substring(pdto.partner_date, 0, 10)}</span>
							</div>
							<hr>
							<div class="card_line">
								<span>구사 언어</span>
								<span class="span_con">${pdto.lang_can}</span>
							</div>
							<div class="card_line">
								<span>학습 언어</span>
								<span class="span_con">${pdto.lang_learn}</span>
							</div>
							<hr>
							<div class="card_line">
								<span>관심사</span>
								<span class="span_con">${pdto.hobby}</span>
							</div>
							<div class="card_line">
								<span>연락 수단</span>
								<span class="span_con">${pdto.contact}</span>
							</div>
							<hr>
							<div class="card_line">
								<span>소개</span>
							</div>
							<div class="introduce">
								${pdto.introduce}
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
						var seq = ${pdto.seq};
						location.href = "/admins/deleteBySeq?pageName=partnerList&seq=" + seq;
					}
				})
				
				$('#goToList').on('click', function(){
					location.href = "/admins/partnerList";
				})
			</script>
		</div>
	</div>
</body>
</html>