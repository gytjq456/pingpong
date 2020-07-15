<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=521d781cfe9fe7597693f2dc29a10601&libraries=services"></script>

 <style>

	.refund_guid { line-height:1.6; }
	.refund_guid li { margin-bottom:6px; position:relative; padding-left:12px;}
	.refund_guid li:last-child { margin:0; }
	.refund_guid li:before { content:""; width:4px; height:4px; border-radius:50%; background:#333; display:block; position:absolute; left:0; top:10px; }
	.customoverlay {position:relative;bottom: 60px; left: 5px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
	.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
	.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #f1989f;background: #f1989f url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
	.customoverlay .mapTitle {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
	.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
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
				$("#jjim i").css('color','rgb(51, 51, 51)')
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
				$("#jjim i").css('color','rgb(240, 7, 7)')
				location.href="/tutor/lessonView?seq="+seq;
				return false;
			}).fail(function(error1, error2) {
				console.log(error1);
				console.log(error2);
			})
		}
	})
	
	var checkJjim = ${checkJjim};
	if (checkJjim) {
		//$('#jjim').css('color', '#fbaab0');
		$('#jjim i').removeClass('fa-heart-o');
		$('#jjim i').addClass('fa-heart');
	}
	
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
		
		//지도
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var location_lat = ${ldto.location_lat};
		var location_lng = ${ldto.location_lng};
		var mapTitleVal = '${ ldto.title}';
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(location_lat, location_lng), //지도의 중심좌표.
			level : 3
		//지도의 레벨(확대, 축소 정도)
		};
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(location_lat, location_lng); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		var content = '<div class="customoverlay">' +
		    '  <a href="https://map.kakao.com/link/map/'+mapTitleVal+','+location_lat+','+location_lng+'" target="_blank">' +
		    '    <span class="mapTitle">'+mapTitleVal+'</span>' +
		    '  </a>' +
		    '</div>';

		// 커스텀 오버레이가 표시될 위치입니다 
		var position = new kakao.maps.LatLng(location_lat, location_lng);  

		// 커스텀 오버레이를 생성합니다
		var customOverlay = new kakao.maps.CustomOverlay({
		    map: map,
		    position: position,
		    content: content,
		    yAnchor: 1 
		});
		
		
		var headHeight = $("header").height();
		$(".tab_s2 ul li").click(function(){
			var idx = $(this).index()+1;
			var topPos = $("#tab_"+idx).offset().top;
			if($(".tab_s2").hasClass("fixed")){
				$("html,body").stop().animate({
					scrollTop:topPos - headHeight - 80
				})
			}else{
				$("html,body").stop().animate({
					scrollTop:topPos - headHeight - 160
				})
			}
		})
		
		var menuObj = $("#group_tab_menu");
		var menuTopPos = menuObj.offset().top;
		$(window).scroll(function(){
			var scrollTop = $(this).scrollTop();
			if(menuTopPos <= scrollTop + headHeight){
				menuObj.addClass("fixed");
			}else{
				menuObj.removeClass("fixed");
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
					location.href="/tutor/lessonView?seq=${ldto.seq}"
				});
			}
		})
})

</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<!-- lessonView -->
		<article id="group_view" class="inner1200">
<!-- 			<div class="tit_s1">
				<h2>강의 View</h2>
			</div> -->
					
			<div class="group_title_wrapper card_body">
				<div id="writer_info" class="group_info_top">
					<div id="writer_profile"><img src="/upload/member/${ldto.id}/${ldto.sysname}"></div>
					<div id="writer_name_id">${ldto.name}(${ldto.id})</div>
				</div>
				
				
				<div id="group_base" class="group_info_top">
					<span id="seq">${ldto.seq}</span>
					<div id="group_base_info" class="base_info">
						<div id="group_title">${ldto.title}</div>
						<div id="mini_option_wrap">
							<span id="point_avg"><i class="fa fa-star" aria-hidden="true"></i>${ldto.review_point}</span>
							<div id="three_options">
								<span id="like"><i id="like" class="fa fa-thumbs-up" style="color:"></i>추천</span>
								<span id="jjim"><i id="" class="fa fa-heart-o"></i>찜하기</span>
								<a id="report" data-seq="${seq}" data-thisseq="" data-id="${ldto.id}" data-url="/tutor/report" data-proc="/tutor/reportProc"><i class="fa fa-exclamation" aria-hidden="true"></i> 신고</a>
							</div>
						</div>
					</div>
					<div id="group_detail" class="base_info clearfix">
						<div class="info_with_icon">
							<i class="fa fa-map-marker" aria-hidden="true"></i><br>
							${ldto.location}
						</div>
						<div class="info_with_icon">
							<i class="fa fa-calendar" aria-hidden="true"></i><br>
							<span>${ldto.start_date} </span> <span>~</span> <span>${ldto.end_date}</span>
						</div>
						<div class="info_with_icon">
							<i class="fa fa-clock-o" aria-hidden="true"></i><br>
							<span>${ldto.start_hour }:${ldto.start_minute }</span> <span>~</span> <span>${ldto.end_hour }:${ldto.end_minute }</span>
						</div>
						<div class="info_with_icon">
							<i class="fa fa-users" aria-hidden="true"></i><br>
							${ldto.max_num }
						</div>
						<div class="info_with_icon">
								<i class="fa fa-gamepad" aria-hidden="true"></i>
							<br>
							<span>${ldto.language}</span>
						</div>
						<div class="info_with_icon">
								<i class="fa fa-gamepad" aria-hidden="true"></i>
							<br>
							<span>${ldto.price } 원 /총 금액</span>
						</div>
					</div>
				</div>	
			</div>
			<div id="group_tab_menu" class="tab_s2">
				<ul class="clearfix">
					<li class="on"><a href="#;">커리큘럼</a></li>
					<li><a href="#;">강의문의</a></li>
					<li><a href="#;">환불안내</a></li>
					<li><a href="#;">리뷰</a></li>
					<li id="pay"><a href="#;">결제하기</a></li>
				</ul>
			</div>			

			
			<!-- ----//////////////// -->
			
			
			
			
			<div id="tabContWrap_s2">
				<article id="tab_1" class="curriTab">
					<div id="group_contents_wrapper" class="card_body clearfix">
						<div id="group_contents" class="group_info">
							<p>${ldto.curriculum }</p>
						</div>
						<div id="group_optional" class="group_info">
							<div class="optional_box">
								<div class="optional_menu">가격</div>
								<div class="optional_body">${ldto.price}원</div>
							</div>
							<div class="optional_box"> 
								<div class="optional_menu">참여자 인원( ${ldto.cur_num} / ${ldto.max_num} )</div>
								<div class="group_members optional_body">
									
								</div>
							</div>
							<div class="optional_box">
								<div class="optional_menu">위치</div>
								<div class="optional_body">${ldto.location}</div>
								<div id="map"></div>
							</div>
							<div class="optional_box countList_s2">
								<span class="optional_sub"><i class="fa fa-eye"></i>7</span>
								<span class="optional_sub"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i> 1</span>
								<span class="optional_sub"><i class="fa fa-file-text-o" aria-hidden="true"></i> 0</span>
							</div>
							<div class="btnS1" id="view_btns">
								<c:choose>
									<c:when test="${loginInfo.grade == 'tutor' && loginInfo.id== ldto.id }">
										<button type="button" id="popOnBtn">강의 삭제</button>
											<%-- <a href="/tutor/lessonUpdate?seq=${ldto.seq }" class="on">강의 수정</a> --%>
									</c:when>
								</c:choose>
														
								<button type="button" id="backList" value="">목록</button>	
							</div>
						</div>
					</div>				
				</article>
				<article id="tab_2" class="lessonQuTab card_body">
					<div class="tit_s2">
						<h3>강의 문의</h3>
					</div>
					<div class="lesson_guid refund_guid">
						<ul>
							<li>강의 문의는 전화 또는 채팅, 메일을 통해서 문의해 주세요.</li>
							<li>전화번호 ${ldto.phone_country}${ldto.phone }</li>
							<li>메일 ${ldto.email }</li>
						</ul>
					</div>
				</article>
				<article id="tab_3" class="refundTab card_body">
					<div class="tit_s2">
						<h3>환불 안내</h3>
					</div>
					<div class="refund_guid">
						<ul>
							<li>고객센터 직접 문의 (1:1상담, 게시판, 이메일, 전화: 1588-1580)</li>
							<li>마이페이지 > 강의 목록에서 환불신청</li>
							<li>결제 취소 및 환불은 환불신청 접수 후 7일 이내에 처리해 드립니다.</li>
							<li>환불시 구매자와 환불자가 다를 경우 19세 미만의 고객은 보호자의 동의가 필요합니다.</li>
							<li>수업 시작 날짜전 환불 요정 - 전액 환불</li>
							<li>수업 시작 날짜로부터 1일~10일 경과 - 전체금액 중 2/3 환불</li>
							<li>수업 시작 날짜로부터 10일~15일 경과 - 전체금액 중 1/2 환불</li>
							<li>수업 시작 날짜로부터 15일 이후 경과 - 환불 금액 없음</li>
						</ul>
					</div>				
				</article>
				<article id="tab_4" class="reviewTab">
				
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
											<p class="userId">${loginInfo.id }</p>
										</div>
									</div>
									<c:choose>
										<c:when test=""></c:when>
									</c:choose>
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
							<h3>리뷰 </h3>
						</div>				
						<c:forEach var="i" items="${reviewList}">
							<article class="clearfix">
								<div class="userInfo_s1">
									<!-- <div class="thumb"><img src="/resources/img/sub/userThum.jpg"/></div> -->
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
				<!-- <article id="tab_5" class="payTab">결제하기</article> -->

			</div>
			
<!-- 				<ul>
					<li><a>커리큘럼</a></li>
					<li><a>강의문의</a></li>
					<li><a>환불안내</a></li>
					<li><a>리뷰</a></li>
					<li><a>결제하기</a></li>
				</ul> -->			
<!-- 			<div class="view_main">
				<div class="curriculum"></div>
				<div class="curri_right">
					<div class="mprice_"> </div>
					<div class="mlocation_"></div>
					<div id="map" style="width:450px;height:350px;"></div>
					<div class="mmax_num"></div>
					<div class="mcur_num">현재인원 &nbsp  </div>
				</div>
			</div> -->
		</article>
	</section>
</div>


<jsp:include page="/WEB-INF/views/tutor/cancle.jsp" />
<%-- <jsp:include page="/WEB-INF/views/tutor/lessonReport.jsp" /> --%>

<!-- 공통 신고하기  -->
<jsp:include page="/WEB-INF/views/reportPage.jsp" />

<jsp:include page="/WEB-INF/views/footer.jsp" />