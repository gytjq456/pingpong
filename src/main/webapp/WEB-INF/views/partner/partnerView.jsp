<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>


<body>
	<br><br><br><br><br><br><br><br><br><br><br>
	<c:choose>
		<c:when test="${empty pdto }">
			해당 뷰페이지에 파트너 정보를 찾을 수 없습니다.
		</c:when>
		<c:otherwise>
			<div class="box">
				${pdto.sysname}<br>
				<span class="seq">${pdto.seq}</span> <br>
				${pdto.id}<br>
				${pdto.name}<br>
				${pdto.age}<br>
				${pdto.gender}<br>
				${pdto.email}<br>
				${pdto.country}<br>
				${pdto.phone_country}<br>
				${pdto.phone}<br>
				${pdto.address}<br>
				${pdto.lang_can}<br>
				${pdto.lang_learn}<br>
				${pdto.hobby}<br>
				${pdto.introduce}<br>
				${pdto.partner_date}<br>
				${pdto.review_count}<br>
				${pdto.review_point}<br><br>
			</div>
			<div class="button_aa">
				<button class="letter">쪽지</button>
				<button class="chat">채팅</button>
				<button class="email">이메일</button>
				<button class="report">신고하기</button><br><br>
				<button class="back">목록으로</button>
				<button class="delete">파트너 삭제</button>
			</div>
		</c:otherwise>
	</c:choose>
	<script>
		$(".back").on("click",function(){
			location.href="/partner/partnerList";
		})
		$(".button_aa .email").on("click",function(e){
			var seq = $(this).closest('.email').siblings('.box').find('.seq').html();
			location.href="/partner/selectPartnerEmail?seq="+seq;
		})
		$(".button_aa .delete").on("click",function(){
			confirm("정말 파트너 취소 하시겠습니까?");
			location.href="/partner/deletePartner";
		})
	</script>
	
<%-- 	<!-- 리뷰 -->
	<article id="tab_3" class="mapSch">
						<!-- 리뷰  -->
						<div id="review_wrap" class="card_body">
							<div class="review_box">
								<div class="tit_s2">
									<h3>리뷰 작성</h3>
								</div>
								<form id="reviewtForm">
									<input type="hidden" name="writer" value="홍길동">
									<input type="hidden" name="point" value="0" id="point">
									<input type="hidden" name="category" value="review">
									<input type="hidden" name="parent_seq" value="${gdto.seq}">
									<div class="starPoint">
										<div>
											<button type="button"><i class="fa fa-star" aria-hidden="true"></i></button>
											<button type="button"><i class="fa fa-star" aria-hidden="true"></i></button>
											<button type="button"><i class="fa fa-star" aria-hidden="true"></i></button>
											<button type="button"><i class="fa fa-star" aria-hidden="true"></i></button>
											<button type="button"><i class="fa fa-star" aria-hidden="true"></i></button>
										</div>
										<div class="point_box">(<span class="point">0</span>점)</div>
									</div>
									<div class="textInput clearfix">
										<div class="userInfo_s1 userInfo_s2">
											<div class="thumb"><img src="/resources/img/sub/userThum.jpg"/></div>
											<div class="info">
												<p class="userId">홍길동</p>
											</div>
										</div>
										<div>
											<textarea name="contents" id="textCont"></textarea>
											<div class="wordsize"><span class="current">0</span>/1000</div>
										</div>
									</div>
									<div class="btnS1 right">
										<div><input type="submit" value="작성" class="on"></div>
										<div>
											<input type="reset" value="취소">
										</div>
									</div>										
								</form>
							</div>
						</div>	
						<div class="review_list card_body" >
							<div class="tit_s2">
								<h3>리뷰 작성</h3>
							</div>				
							<c:forEach var="i" items="${reviewList}">
								<article class="clearfix">
									<div class="userInfo_s1">
										<div class="thumb"><img src="/resources/img/sub/userThum.jpg"/></div>
										<div class="info">
											<p class="userId">${i.writer}</p>
											<p class="writeDate">${i.dateString}</p>
										</div>
									</div>
									<div class="cont">
										<div class="starPoint" data-star="${i.point}">
											<div>
												<em><i class="fa fa-star" aria-hidden="true"></i></em>
												<em><i class="fa fa-star" aria-hidden="true"></i></em>
												<em><i class="fa fa-star" aria-hidden="true"></i></em>
												<em><i class="fa fa-star" aria-hidden="true"></i></em>
												<em><i class="fa fa-star" aria-hidden="true"></i></em>
											</div>
											<div>(<span>${i.point}</span>점)</div>
										</div>
										<div class="txtBox">
											<a href="#;">${i.contents}</a>
										</div>
									</div>
								</article>
							</c:forEach>
						</div>
					</article> --%>

<jsp:include page="/WEB-INF/views/footer.jsp"/>	