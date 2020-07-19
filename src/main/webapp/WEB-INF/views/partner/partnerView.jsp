<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<style>
	.pushBtn { position:absolute; right:0; top:0;}
	.pushBtn > p { display:inline-block; margin-right:6px; font-size:14px !important; }
	.pushBtn > p i {  font-size:14px;}
	.pushBtn > p:last-child { margin:0; }
	.fa-star { color:#fcba03;}
	.fa-heart-o { color:#fbaab0;}
	.seq { display:none; }
	#jjim { cursor:pointer; }
	.button_li { text-align:center;}
	.button_li button { display:inline-block; border:1px solid #ddd; background:none; height:42px; line-height:42px; padding:0 12px; border-radius:6px; margin-right:6px; transition:all 0.5s;}	
	.button_li button:last-child { margin:0; }
	.button_li button:hover { background:#fbaab0; color:#fff;}
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
		

		$(".reviewDelete").click(function(){
			var result = confirm("리뷰를 삭제하시겠습니까?");
			if(result){
				var seq = $(this).data("seq");
				$.ajax({
					url:"/group/reviewDelete",
					type:"post",
					dataType:"json",
					data:{
						seq:seq
					},
				}).done(function(resp){
					location.href="/partner/partnerView?seq=${pdto.seq}"
				});
			}

		})
		
		$("input,textarea").blur(function(){
			var thisVal = $(this).val();
			$(this).val(textChk(thisVal,$(this)));
		})
	 	$(".note-editable").blur(function(){
			var thisVal = $(this).html();
			$(this).text(textChk(thisVal,$(this)));
		});
	})
	
	
	function textChk(thisVal, obj){
		var replaceId  = /(script)/gi;
		var textVal = thisVal;
	    if (textVal.length > 0) {
	        if (textVal.match(replaceId)) {
	        	console.log(obj)
	        	if(obj.val().length){
		        	obj.val("");
		        	textVal = obj.val();
	        	}else{
		        	obj.html("");
		        	textVal = obj.val();
	        	}
	        }
	    }
	    return textVal;
	}
	
</script>


	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="mypage" class="inner1200 clearfix">
			<c:choose>
					<c:when test="${empty pdto }">
						해당 뷰페이지에 파트너 정보를 찾을 수 없습니다.
					</c:when>
					<c:otherwise>
						<div id="session" class="card_body">
							<span class="seq">${pdto.seq}</span>
							<form action="/member/memberSelect" method="post">
								<input type="hidden" value="${pdto.id}" id="partner_name">	
								<div class="userInfo clearfix">
									<div class="thum">
										<div class="img"><img src ="/upload/member/${pdto.id}/${pdto.sysname}"></div>
									</div>
									<div class="infoBox">
										<div class="name">
											<span class="grade">파트너</span>
											${pdto.name} <span>(${pdto.age}, ${pdto.id}, ${pdto.gender})</span>
											
											<div class="pushBtn">
												<p class="jjim"><i class="fa fa-heart-o" aria-hidden="true"></i> 찜하기</p>
												<p><i class="fa fa-file-text-o" aria-hidden="true"></i> ${pdto.review_count}</p>
												<p><i class="fa fa-star" aria-hidden="true"></i> ${pdto.review_point}</p>
											</div>
										</div>
										<div class="infoTxt">
											<ul>
												<li>
													<span>이메일</span>
													<p>${pdto.email}</p>
												</li>
												<li>
													<span>전화번호</span>
													<p>${pdto.phone_country}${pdto.phone}</p>
												</li>
												<li>
													<span>국적</span>
													<p>${pdto.country}</p>
												</li>
												<li>
													<span>지역</span>
													<p>${pdto.address}</p>
												</li>
												<!-- <li>
													<span>은행</span>
													<p>SC제일은행 ( 1111 )</p>
												</li> -->
											</ul>
										</div>
									</div>
								</div>
								<div class="sideInfo">
									<ul>
										<li>
											<span>구사 가능언어</span>
											<p>${pdto.lang_can}</p>
										</li>
										<li>
											<span>배우고 싶은 언어</span>
											<p>${pdto.lang_learn}</p>
										</li>
										<li>
											<span>취미</span>
											<p>${pdto.hobby}</p>
										</li>
										<li class="introduce">
											<span>자기소개</span>
											<p>${pdto.introduce}</p>
										</li>
									</ul>
								</div>
							</form>

							<div class="button_li">
								<c:if test = "${fn : contains(pdto.contact, '쪽지')}">
									<button id="sendLet">쪽지</button>
								</c:if>
								<!-- <button class="chat">채팅</button> -->
								<c:if test = "${fn : contains(pdto.contact, '이메일')}">
									<button class="email_a">이메일</button>
								</c:if>
								<button class="report" data-id="${pdto.id}" data-thisseq="" data-seq="${pdto.seq}" data-proc="/partner/reportProc" data-url="/partner/report">신고하기</button>
								<button class="back">목록으로</button>
								<c:if test="${sessionScope.loginInfo.id == pdto.id}">
									<button class="delete">파트너 삭제</button>
								</c:if>
							</div>
						</div>			
					</c:otherwise>
				</c:choose>
				<script>
					$(".back").on("click",function(){
						location.href="/partner/partnerList?cpage=1&align=recent";
					})
					
					/* 이메일 팝업창 생성
					$(".button_aa .email").on("click",function(e){
						var seq = $(this).closest('.button_aa').siblings('.box').find('.seq').html();
					}) */
					
					var id =$("#partner_name").val();
					$(".button_li .delete").on("click",function(){
						var con = confirm("정말 파트너 취소 하시겠습니까?");
						console.log(con);
						if(con){
							location.href="/partner/deletePartner?id="+id;
						}					
					});
					
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
								<input type="hidden" name="writer" value="${loginInfo.id}">
								<input type="hidden" name="point" value="0" id="point">
								<input type="hidden" name="category" value="파트너">
								<input type="hidden" name="parent_seq" value="${pdto.seq}">
								<input type="hidden" name="thumNail" value="${loginInfo.sysname}">
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
										<div class="thumb"><img src="/upload/member/${loginInfo.id}/${loginInfo.sysname}"/></div>
										<div class="info">
											<p class="userId">${loginInfo.name}</p>
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
							<h3>리뷰 목록</h3>
						</div>				
						<c:forEach var="i" items="${reviewList}">
							<article class="clearfix">
								<div class="userInfo_s1">
									<div class="thumb"><img src="/upload/member/${i.writer}/${i.thumNail}"/></div>
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
									<c:if test="${loginInfo.id == i.writer }">
										<div class="btnS1 right">
											<div><input type="button" class="reviewDelete" value="삭제"  data-seq="${i.seq}"></div>
										</div>		
									</c:if>
								</div>
							</article>
						</c:forEach>
					</div>
				</article>
			</article>
		</section>
	</div>
<jsp:include page="/WEB-INF/views/reportPage.jsp" />
<jsp:include page="/WEB-INF/views/partner/sendLetter.jsp" />
<jsp:include page="/WEB-INF/views/email/write.jsp"/>	
<jsp:include page="/WEB-INF/views/footer.jsp"/>	