<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<style>
	.review{border-bottom: 1px solid gray;}
	.tab{border-bottom: 1px solid gray;}
	.view_main{border-bottom: 1px solid gray; width:100%; height: 600px;}
	.curriculum{float: left; width: 70%; height:100%;}
	.priceLocation{float: left; width: 30%; height:100%;}
	.lesson_guid{border-bottom: 1px solid gray;}
	.refund_guid{border-bottom: 1px solid gray;}
	.view_top{border-bottom: 1px solid gray; width:100%; height: 200px;}
	.view_top_left{float: left; width: 20%; height: 100%;}
	.view_top_right{float: left; width: 80%; height:100%;}
</style>

<script>
$(function(){
	$("#backList").on("click", function(){
		location.href="/tutor/lessonList?orderBy=seq";
	})
	
	var checkLikeVal = ${checkLike};
	var checkJjimVal = ${checkJjim};
	
	if(checkLikeVal==true){
		$("#like").css('color','rgb(58, 89, 201)');
	}
	if(checkJjimVal==true){
		$("#jjim").css('color','rgb(240,7,7)')
	}
	
	//같은사람이 결제하기 또 눌렀는지 확인
	$("#pay").on("click", function(){
		var max_numVal = ${ldto.max_num};
		var cur_numVal = ${ldto.cur_num};
		if(max_numVal == cur_numVal){
			alert("수강인원이 다찼습니다.");
			return false;
		}
		
		var seq = ${seq};
		$.ajax({
			url:"/payments/payTrue",
			data:{
				parent_seq : seq
			},
			type: "POST"
		}).done(function(resp){
			console.log(resp);
			if(resp>0){
				alert("이미 결제한 강의 입니다.");
				location.href="/tutor/lessonView?seq="+seq;
				return false;
			}else{
				location.href="/payments/payMain?parent_seq=${ldto.seq }&title=${ldto.title}&price=${ldto.price}";
			}
		}).fail(function(error1, error2) {
			console.log(error1);
			console.log(error2);
		})
	})
	
	
	
	$("#like").on("click", function(){
		console.log($(this).css('color'));
		var seq = ${seq};
		
 		if($(this).css('color')=='rgb(58, 89, 201)'){
			alert("이미 추천한 강의입니다.");
			return false;
		}
		 
		$.ajax({
			url: "/tutor/likeTrue",
			data: {
				parent_seq : seq
			},
			type: 'POST'
		}).done(function(resp){
			console.log(resp);
	
			alert('추천하셨습니다.');
			
			$("#like").css('color','rgb(58, 89, 201)');
			location.href = '/tutor/lessonView?seq=' + seq;
		}).fail(function(error1, error2) {
			console.log(error1);
			console.log(error2);
		})
	})
	
	$("#jjim").on("click", function(){
		console.log($(this).css('color'));
		var seq = ${seq};
		
		if($(this).css('color')=='rgb(240, 7, 7)'){
			$.ajax({
				url:"/tutor/deleteJjim",
				data:{
					parent_seq: seq
				},
				type:'POST'
			}).done(function(resp){
				console.log(resp);
				alert("찜을 취소합니다.");
				$("#jjim").css('color','rgb(51, 51, 51)')
				location.href="/tutor/lessonView?seq="+seq;
				return false;
			}).fail(function(error1, error2) {
				console.log(error1);
				console.log(error2);
			})
		}else{
			$.ajax({
				url: "/tutor/insertJjim",
				data:{
					parent_seq: seq
				},
				type: 'POST'
			}).done(function(resp){
				console.log(resp);
				alert("찜에 등록되었습니다.");
				$("#jjim").css('color','rgb(240, 7, 7)')
				location.href="/tutor/lessonView?seq="+seq;
				return false;
			}).fail(function(error1, error2) {
				console.log(error1);
				console.log(error2);
			})
		}
	})
	
	// 리뷰 
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
			console.log(resp)
			var categoryVal= $("#category").val();
			location.href="/tutor/reviewUpdate?parent_seq=${ldto.seq}&category="+categoryVal;
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

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="lessonView" class="inner1200">

			<div class="tit_s1">
				<h2>강의 View</h2>
			</div>

			<div class="btnS1 right">
				<c:choose>
					<c:when test="${loginInfo.grade == 'tutor' && loginInfo.id== ldto.id }">
						<p>
							<a href="/tutor/lessonUpdate?seq=${ldto.seq }" class="on">강의 수정</a>
							<button type="button" id="popOnBtn" class="on">강의 삭제</button>
						</p>
					</c:when>
				</c:choose>
			</div>
			<div class="view_top">
				<div class="view_top_left">
					<div class="profile">
						<img src="/upload/member/${ldto.id}/${ldto.sysname}">
					</div>
				</div>
				
				<div class="view_top_right">
					<div class="title">
						${ ldto.title}
					</div>
					<div class="option_btn">
						★${ ldto.review_point}
						<i id="like" class="fa fa-thumbs-up" style="color:"></i>
						<i id="jjim" class="fa fa-heart" style="font-size:16px; color:rgb(51, 51, 51)"></i>
						<a id="report">신고</a>
					</div>
					
					<div class="info">
						위치 : ${ldto.location }
						수업기간 : ${ldto.start_date } ~ ${ldto.end_date }
						수업시간 : ${ldto.start_hour }:${ldto.start_minute } ~ ${ldto.end_hour }:${ldto.end_minute }
						최대인원 : ${ldto.max_num }
						수업언어 : ${ldto.language }
						가격 : ${ldto.price } 원 /총 금액
					</div>
	
				</div>
			</div>
			
			<div class="tab_s1">
				<ul class="clearfix">
					<li class="on"><a href="#;">커리큘럼</a></li>
					<li><a href="#;">강의문의</a></li>
					<li><a href="#;">환불안내</a></li>
					<li><a href="#;">리뷰</a></li>
					<li id="pay"><a>결제하기</a></li>
				</ul>
			</div>
			
			
			<div id="tabContWrap">
				<article id="tab_1" class="curriTab">커리큘럼</article>
				<article id="tab_2" class="lessonQuTab">강의문의</article>
				<article id="tab_3" class="refundTab">환불안내</article>
				<article id="tab_4" class="reviewTab">리뷰</article>
				<article id="tab_5" class="payTab">결제하기</article>
<!-- 				<ul>
					<li><a>커리큘럼</a></li>
					<li><a>강의문의</a></li>
					<li><a>환불안내</a></li>
					<li><a>리뷰</a></li>
					<li><a>결제하기</a></li>
				</ul> -->
			</div>
			
			<div class="view_main">
				<div class="curriculum">${ldto.curriculum }</div>
				<div class="priceLocation">가격 ${ldto.price}원/시간 <br>위치 ${ldto.location} <br>
				최대인원 &nbsp ${ldto.max_num } <br>현재인원 &nbsp ${ldto.cur_num } </div>
			</div>
			
			<div class="tit_s3">
				<h4>강의 문의</h4>
			</div>
			<div class="lesson_guid">
				<ul>
					<li>강의 문의는 전화 또는 채팅, 메일을 통해서 문의해 주세요.</li>
					<li>전화번호 ${ldto.phone_country}${ldto.phone }</li>
					<li>메일 ${ldto.email }</li>
				</ul>
			</div>
			
			
			<div class="tit_s3">
				<h4>환불 안내</h4>
			</div>
			<div class="refund_guid">
				<ul>
					<li>· 고객센터 직접 문의 (1:1상담, 게시판, 이메일, 전화: 1588-1580)</li>
					<li>· 마이페이지>강의 목록에서 환불신청</li>
					<li>* 결제 취소 및 환불은 환불신청 접수 후 7일 이내에 처리해 드립니다.</li>
					<li>* 환불시 구매자와 환불자가 다를 경우 19세 미만의 고객은 보호자의 동의가 필요합니다.</li>
					<li>* 수업 시작 날짜전 환불 요정 - 전액 환불</li>
					<li>* 수업 시작 날짜로부터 1일~10일 경과 - 전체금액 중 2/3 환불</li>
					<li>* 수업 시작 날짜로부터 10일~15일 경과 - 전체금액 중 1/2 환불</li>
					<li>* 수업 시작 날짜로부터 15일 이후 경과 - 환불 금액 없음</li>
				</ul>
			</div>
			
			<article id="tab_3" class="mapSch">
						<!-- 리뷰  -->
						<div id="review_wrap" class="card_body">
							<div class="review_box">
								<div class="tit_s2">
									<h3>리뷰 작성</h3>
								</div>
								<form id="reviewtForm">
									<input type="hidden" name="writer" value="${loginInfo.id }">
									<input type="hidden" name="point" value="0" id="point">
									<input type="hidden" id ="category" name="category" value="강의">
									<input type="hidden" name="parent_seq" value="${ldto.seq}">
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
												<p class="userId">${loginInfo.id }</p>
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
			
			<input type="button" id="backList" value="목록으로">	
		
		</article>
	</section>
</div>


<jsp:include page="/WEB-INF/views/tutor/cancle.jsp" />
<jsp:include page="/WEB-INF/views/tutor/lessonReport.jsp" />
<jsp:include page="/WEB-INF/views/footer.jsp" />