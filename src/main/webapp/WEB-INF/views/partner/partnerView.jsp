<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<style>
	#jjim { right: -72%; }
	#jjim i { color: #fbaab0; }
</style>
<script>
	$(function(){
		//리뷰 
		var reviewtForm = $("#reviewtForm");
		var starPoint = $(".starPoint");
		var point_box = $(".point_box")
		var point_input = $("#point");
		starPoint.find("button").click(function(){
			var idx = $(this).index()+1;
			var point = point_box.find(".point").text();
			point_box.find(".point").text(idx)
			point_input.val(idx);
			for(var i=0; i<idx; i++){
				starPoint.find("button:eq("+i+")").addClass("on");
			}
			if(idx < point){
				starPoint.find("button").removeClass("on");
				for(var i=0; i<idx; i++){
					starPoint.find("button:eq("+i+")").addClass("on");
				}
			}
		})
		
		// 리뷰 글자수 체크
		reviewtForm.find("#textCont").keyup(function(){
			var word = $(this).val();
			var wordSize = word.length;
			console.log(wordSize)
			if(wordSize <= 1000){
				$(".wordsize .current").text(wordSize);
			}else{
				word = word.substr(0,1000);
				$(".wordsize .current").text(word.length);
				$(this).val(word);
				alert("리뷰는  1000자 이하로 등록해 주세요")
			}
		})
		
		// 리뷰 데이터 전송
		var textCont = $("#textCont");
		$("#reviewtForm").submit(function(){
			var form = $("#reviewtForm")[0];
			var formData = new FormData(form);
			
			if(point_input.val() == 0){
				alert("평점을 입력해주세요.");
				return false;
			}
			
			if(textCont.val() == "" || textCont.val().replace(/\s|　/gi, "").length == 0){
				alert("리뷰 내용을 작성해주세요.")
				textCont.focus();
				return false;
			}
			
			$.ajax({
				url:"/group/reviewWrite",
				type:"post",
				dataType:"json",
				data:formData,
		    	contentType : false,
		        processData : false 	            
			}).done(function(resp){
				location.href="/partner/partnerView?seq=${pdto.seq}"
			});
			return false;
		})
		
		// 리뷰 게시글 글자수 ... 처리
		var reviewList = $(".review_list");
		var oriTxt = [];
		reviewList.find("article").each(function(){
			var reviewTxt = $(this).find(".txtBox a").text();
			oriTxt.push(reviewTxt);
			var reviewSize = reviewTxt.length;
			if(reviewSize > 140){
				var txtSubStr = reviewTxt.substr(0,140);
				$(this).find(".txtBox a").text(txtSubStr+"...");
			}
			
			var point = $(this).find(".starPoint").data("star");
			for(var i=0; i<point; i++){
				$(this).find(".starPoint em:eq("+i+")").addClass("on");
			}
			console.log(point);
		})
		
		reviewList.find(".txtBox a").click(function(e){
			e.preventDefault();
			var idx = $(this).closest("article").index();
			var txtSize = oriTxt[idx-1].length;
			if($(this).text().length == 143){
				$(this).text(oriTxt[idx-1]);
			}else{
				if(txtSize > 140){
					var txtSubStr = oriTxt[idx-1].substr(0,140);
					$(this).text(txtSubStr+"...");
				}
			}
		})
		
		
	})
	
</script>

<body>
	<br><br><br><br><br><br><br><br><br><br><br>
	<c:choose>
		<c:when test="${empty pdto }">
			해당 뷰페이지에 파트너 정보를 찾을 수 없습니다.
		</c:when>
		<c:otherwise>
			<div class="box">
				<%-- <img src ="/upload/member/${plist.id}/${plist.sysname}"> --%>
				<span class="jjim"><i class="fa fa-heart-o" aria-hidden="true"></i>찜하기</span><br>
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
				<c:if test="${sessionScope.loginInfo.id == pdto.id}">
					<button class="delete">파트너 삭제</button>
				</c:if>
			</div>
		</c:otherwise>
	</c:choose>
	<script>
		$(".email")
	</script>
	<script>
		$(".back").on("click",function(){
			location.href="/partner/partnerList";
		})
		
		//이메일 팝업창 생성
		$(".button_aa .email").on("click",function(e){
			var seq = $(this).closest('.button_aa').siblings('.box').find('.seq').html();
			
		})
		
		$(".button_aa .delete").on("click",function(){
			confirm("정말 파트너 취소 하시겠습니까?");
			location.href="/partner/deletePartner";
		})
		
		//찜하기
		var checkJjim = ${checkJjim};
		console.log(checkJjim);
		if(checkJjim){
			$('.jjim').css('color','#fbaab0');
			$('.jjim i').removeClass('fa-heart-o');
			$('.jjim i').addClass('fa-heart');
		}
		
		$('.jjim').on('click', function(){
			var seq = $('.seq').html();
			
			if ($(this).css('color') != 'rgb(251, 170, 176)') {
				$.ajax({
					url: '/partner/jjim',
					data: {'parent_seq': seq},
					type: 'POST'
				}).done(function(resp){
					console.log(resp);
					location.href = '/partner/partnerView?seq=' + seq;
				})
			} else {
				$.ajax({
					url: '/partner/delJjim',
					data: {'parent_seq': seq},
					type: 'POST'
				}).done(function(resp){
					location.href = '/partner/partnerView?seq=' + seq;
				})
			}
		})
	</script>
	
	<!-- 리뷰 -->
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
									<input type="hidden" name="parent_seq" value="${pdto.seq}">
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
	</article>
<jsp:include page="/WEB-INF/views/email/write.jsp"/>
<jsp:include page="/WEB-INF/views/footer.jsp"/>	