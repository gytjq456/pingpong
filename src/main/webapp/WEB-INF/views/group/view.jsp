<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<style>
	* { box-sizing: border-box; }
	#seq { display: none; }
	.group_info { display: inline-block; }
	.group_info_top { float: left; }
	.group_title_wrapper { overflow: hidden; }
	/* #writer_info { width: 30%; position: relateive   ; } */
	/* #group_base { width: 62%; margin-left: 3%; } */
	#writer_profile { width: 240px; height: 240px; border-radius: 50%; text-align: center; line-height: 300px; position: relative; top: 50%; left: 50%; transform: translate(-50%, 0); overflow: hidden; }
	#writer_name_id { position: relative; left: 50%; transform: translate(-50%, 0); display: inline-block; margin-top: 20px; }
	.base_info { position: relative; }
	#group_title { font-size: 40px; font-weight: bold; word-break: break-all; margin-bottom: 15px; }
	#group_base_info { padding: 15px 0; border-bottom: 1px solid #ddd; }
	#group_base_info span { position: relative; }
	#group_base_info span i { margin-right: 5px; }
	#point_avg i { color: #fcba03; }
	#like i { color: #3162a4; }
	#jjim i { color: #fbaab0; }
	#report i { color: #fc0303; }
	.info_with_icon { width: 24.6%; display: inline-block; position: relative; text-align: center; padding-bottom: 20px; padding-top: 40px; vertical-align: top; }
	.info_with_icon i { font-size: 50px; margin-bottom: 15px; }
	#group_tab_menu { width: 100%; }
	#group_contents_wrapper { position: relative; }
	#group_contents { width: 69%; vertical-align: top; }
	#group_optional { width: 30%; border-left: 1px solid #ddd; padding: 0 30px; }
	#group_view_card { position: relative; }
	#group_optional .optional_menu { font-size: 22px; margin-bottom: 5px; }
	#group_optional .member_profile { display: inline-block; width: 50px; height: 50px; border-radius: 50%; border: 1px solid #ddd; line-height: 50px; text-align: center; margin-right: 5px; }
	#group_optional .optional_sub { font-weight: bold; }
	#group_optional span { margin-right: 5px; }
	#group_optional #like_count { border-right: 1px solid #ddd; padding-right: 10px; }
	#group_optional .optional_box { margin-bottom: 20px; }
	#related_group_title { font-size: 22px; }
	#view_btns #update, #view_btns #delete { width: 49%; display: inline-block; }
	#view_btns button { width: 100%; margin-top: 5px; }
	#view_btns #update { margin-right: 2px; }
	#writer_profile img { vertical-align: top; }
	#map { width: 100%; height: 200px; margin-top: 10px; }
	#mini_option_wrap { position: relative; }
	#three_options { position: absolute; right: 0; top: 0; }
	#three_options span { margin-left: 8px; }
</style>
<script>
	$(function(){
		var seq = $('#seq').html();

		$('#delete').on('click', function(){
			var result = confirm('정말 삭제하시겠습니까?');
			if (result) {
				location.href = "/group/delete?seq=" + seq;
			}
		})
		
		$('#update').on('click', function(){
			location.href = "/group/update?seq=" + seq;
		})
		
		$('#applyCancel').on('click', function(){
			var conf = confirm('가입 신청을 취소하시겠습니까?');
			if (conf) {
				location.href = '/group/deleteApplyForm?seq=' + seq;
			}
		})
		
		var checkLike = ${checkLike};
		if (checkLike) {
			$('#like').css('color', '#3162a4');
			$('#like i').removeClass('fa-thumbs-o-up');
			$('#like i').addClass('fa-thumbs-up');
		}
		
		var checkJjim = ${checkJjim};
		if (checkJjim) {
			$('#jjim').css('color', '#fbaab0');
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
				location.href="/group/view?seq=${gdto.seq}"
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
		
		var headHeight = $("header").height();
		$(".tab_s2 ul li").click(function(){
			var idx = $(this).index()+1;
			var topPos = $("#tab_"+idx).offset().top;
			$("html,body").stop().animate({
				scrollTop:topPos - headHeight - 80
			})
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
		
		
	})
</script>
	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="group_view" class="inner1200 clearfix">
				<div class="group_title_wrapper card_body">
					<div id="writer_info" class="group_info_top">
						<div id="writer_profile"><img src="/resources/img/sub/userThum.jpg"/></div>
						<div id="writer_name_id">${gdto.writer_name}(${gdto.writer_id})</div>
					</div>
					<div id="group_base" class="group_info_top">
						<span id="seq">${gdto.seq}</span>
						<div id="group_base_info" class="base_info">
							<div id="group_title">${gdto.title}</div>
							<div id="mini_option_wrap">
								<span id="point_avg"><i class="fa fa-star" aria-hidden="true"></i>${gdto.review_point}</span>
								<div id="three_options">
									<span id="like"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i>추천</span>
									<span id="jjim"><i class="fa fa-heart-o" aria-hidden="true"></i>찜하기</span>
									<span id="report"><i class="fa fa-exclamation" aria-hidden="true"></i>신고</span>
								</div>
							</div>
						</div>
						<div id="group_detail" class="base_info clearfix">
							<div class="info_with_icon">
								<i class="fa fa-map-marker" aria-hidden="true"></i><br>
								${gdto.location}
							</div>
							<div class="info_with_icon">
								<i class="fa fa-calendar" aria-hidden="true"></i><br>
								<span>${gdto.start_date}</span> <span>~</span> <span>${gdto.end_date}</span>
							</div>
							<div class="info_with_icon">
								<i class="fa fa-users" aria-hidden="true"></i><br>
								${gdto.max_num}명
							</div>
							<div class="info_with_icon">
								<c:if test="${fn:startsWith(gdto.hobby_type, '영화')}">
									<i class="fa fa-video-camera" aria-hidden="true"></i>
								</c:if>
								<c:if test="${fn:startsWith(gdto.hobby_type, '공연')}">
									<i class="fa fa-ticket" aria-hidden="true"></i>
								</c:if>
								<c:if test="${fn:startsWith(gdto.hobby_type, '음악')}">
									<i class="fa fa-music" aria-hidden="true"></i>
								</c:if>
								<c:if test="${fn:startsWith(gdto.hobby_type, '독서')}">
									<i class="fa fa-book" aria-hidden="true"></i>
								</c:if>
								<c:if test="${fn:startsWith(gdto.hobby_type, '스포츠')}">
									<i class="fa fa-futbol-o" aria-hidden="true"></i>
								</c:if>
								<c:if test="${fn:startsWith(gdto.hobby_type, '게임')}">
									<i class="fa fa-gamepad" aria-hidden="true"></i>
								</c:if>
								<c:if test="${fn:startsWith(gdto.hobby_type, '여행')}">
									<i class="fa fa-plane" aria-hidden="true"></i>
								</c:if>
								<c:if test="${fn:startsWith(gdto.hobby_type, '요리')}">
									<i class="fa fa-cutlery" aria-hidden="true"></i>
								</c:if>
								<c:if test="${fn:startsWith(gdto.hobby_type, '기타')}">
									<i class="fa fa-handshake-o" aria-hidden="true"></i>
								</c:if>
								<br>
								<span>${gdto.hobby_type}</span>
							</div>
						</div>
					</div>
				</div>
				<div id="group_tab_menu" class="tab_s2">
					<ul class="clearfix">
						<li class="on"><a href="#;">상세 정보</a></li>
						<li><a href="#;">관련 모임</a></li>
						<li><a href="#;">리뷰(${gdto.review_count})</a></li>
						<li>
							<c:if test="${checkApply == true}">
								<button id="applyCancel">신청 취소</button>
							</c:if>
							<c:if test="${checkApply == false && (sessionScope.loginInfo.id != gdto.writer_id) && checkMember == false}">
								<button type="button" id="applyForm">신청하기</button>
							</c:if>
							<c:if test="${checkMember == true}">
								<button id="deleteForm">탈퇴하기</button>
							</c:if>
							<c:if test="${sessionScope.loginInfo.id == gdto.writer_id}">
								<button id="groupApplyManage">신청 현황</button>
							</c:if>
						</li>
					</ul>
				</div>
				<div id="tabContWrap_s2">
					<article id="tab_1" class="kewordSch">
						<div id="group_contents_wrapper" class="card_body clearfix">
							<div id="group_contents" class="group_info">
								${gdto.contents}
							</div>
							<div id="group_optional" class="group_info">
								<div class="optional_box">
									<div class="optional_menu">모집 기간</div>
									<div class="optional_body">${gdto.apply_start} ~ ${gdto.apply_end}</div>
								</div>
								<div class="optional_box">
									<div class="optional_menu">참여자 인원(${gdto.cur_num})</div>
									<div class="group_members optional_body">
										<c:choose>
											<c:when test="${empty memberList}">
												아직 참여 중인 인원이 없습니다.
											</c:when>
											<c:otherwise>
												<c:forEach var="member" items="${memberList}">
													<div class="member_profile"><img src="/resources/img/sub/userThum.jpg"/></div>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<div class="optional_box">
									<div class="optional_menu">위치</div>
									<div class="optional_body">${gdto.location}</div>
									<div id="map"></div>
								</div>

								<div class="optional_box countList_s2" >
									<span class="optional_sub"><i class="fa fa-eye"></i>${gdto.view_count}</span>
									<span class="optional_sub"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i> ${gdto.like_count}</span>
									<span class="optional_sub"><i class="fa fa-file-text-o" aria-hidden="true"></i> ${gdto.app_count}</span>
									<%-- <span class="optional_sub">작성일</span><span>${gdto.date}</span><br> --%>
								</div>
								<div class="btnS1" id="view_btns">
									<c:if test="${sessionScope.loginInfo.id == gdto.writer_id}">
										<button type="button" id="update">수정</button>
										<button type="button" id="delete">삭제</button>
									</c:if>
									<button type="button" id="toList" onclick="javascript:toList()">목록</button>
								</div>
							</div>
						</div>
					</article>
					<article id="tab_2" class="calendarSch card_body">
						<div id="related_group_title">관련 모임</div>
						<div id="related_groups">
							<c:choose>
								<c:when test="${empty relatedGroup}">
									관련 모임이 없습니다.
								</c:when>
								<c:otherwise>
									<c:forEach var="related" items="${relatedGroup}">
										<div class="back_and_wrap item">
											<a href="/group/beforeView?seq=${related.seq}" class="group_list_a">
												<div class="each_profile"><img src="/resources/img/sub/userThum.jpg"/></div>
												<c:if test="${fn:startsWith(related.hobby_type, '영화')}">
													<div class="group_background background_pink"></div>
												</c:if>
												<c:if test="${fn:startsWith(related.hobby_type, '공연')}">
													<div class="group_background background_purple"></div>
												</c:if>
												<c:if test="${fn:startsWith(related.hobby_type, '음악')}">
													<div class="group_background background_blue"></div>
												</c:if>
												<c:if test="${fn:startsWith(related.hobby_type, '독서')}">
													<div class="group_background background_brown"></div>
												</c:if>
												<c:if test="${fn:startsWith(related.hobby_type, '스포츠')}">
													<div class="group_background background_red"></div>
												</c:if>
												<c:if test="${fn:startsWith(related.hobby_type, '게임')}">
													<div class="group_background background_yellow"></div>
												</c:if>
												<c:if test="${fn:startsWith(related.hobby_type, '여행')}">
													<div class="group_background background_green"></div>
												</c:if>
												<c:if test="${fn:startsWith(related.hobby_type, '요리')}">
													<div class="group_background background_orange"></div>
												</c:if>
												<c:if test="${fn:startsWith(related.hobby_type, '기타')}">
													<div class="group_background background_gray"></div>
												</c:if>
												<div class="group_each_wrapper">
													<div class="each_writer"><span class="each_name">${related.writer_name}</span>(${related.writer_id})</div>
													<div class="each_title">${related.title}</div>
													<div class="each_body">
														<div><span class="sub_title">장소</span> <p>${related.location}</p></div>
														<div><span class="sub_title">유형</span> <p>${related.hobby_type}</p></div>
														<div><span class="sub_title">모집</span>
															<c:if test="${related.applying == 'N'}">
															 - 
															</c:if>
															<c:if test="${related.applying == 'Y'}">
															 <p>${related.apply_start} ~ ${related.apply_end}</p>
															</c:if>
														</div>
														<div><span class="sub_title">진행</span> <p>${related.start_date} ~ ${related.end_date}</p></div>
														<div><span class="sub_title">평점</span> <p><i class="fa fa-star" aria-hidden="true"></i> ${related.review_point}</p></div>
													</div>
													<div class="countList_s2">
														<span class="sub_title"><i class="fa fa-eye"></i>${related.view_count}</span>   
														<span class="sub_title"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i>${related.like_count}</span>   
														<span class="sub_title"><i class="fa fa-commenting-o" aria-hidden="true"></i>${related.review_count}</span> 
														<span class="sub_title"><i class="fa fa-file-text-o" aria-hidden="true"></i>${related.app_count}</span> 
													</div>
													<div class="status clearfix">
														<c:if test="${related.applying == 'Y'}">
															<div class="group_applying">모집중</div>  
														</c:if>
														<c:if test="${related.proceeding == 'Y'}">
															<div class="group_proceeding">진행중</div>
														</c:if>
														<c:if test="${related.proceeding == 'B'}">
															<div class="group_ready">준비중</div>
														</c:if>
														<c:if test="${related.proceeding == 'N' && related.applying == 'N'}">
															<div class="group_done">마감</div>
														</c:if>
													</div>
												</div>
											</a>
										</div>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
					</article>
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
									<input type="hidden" name="category" value="그룹">
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
					</article>
				</div>			
			</article>
		</section>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=033532d2fa35e423d2d5e723c0bfd1fe&libraries=services"></script>
	<script>
		function toList() {
			location.href = '/group/main?orderBy=seq';
		}
		
		$('#like').on('click', function(){
			if ($(this).css('color') == 'rgb(49, 98, 164)') {
				alert('이미 추천하셨습니다.');
				
				return false;
			}
			
			var seq = $('#seq').html();
			
			$.ajax({
				url: '/group/like',
				data: {'parent_seq': seq},
				type: 'POST'
			}).done(function(resp){
				alert('추천하셨습니다.');
				location.href = '/group/view?seq=' + seq;
			})
		})
		
		$('#jjim').on('click', function(){
			var seq = $('#seq').html();
			
			if ($(this).css('color') != 'rgb(251, 170, 176)') {
				$.ajax({
					url: '/group/jjim',
					data: {'parent_seq': seq},
					type: 'POST'
				}).done(function(resp){
					location.href = '/group/view?seq=' + seq;
				})
			} else {
				$.ajax({
					url: '/group/delJjim',
					data: {'parent_seq': seq},
					type: 'POST'
				}).done(function(resp){
					location.href = '/group/view?seq=' + seq;
				})
			}
		})
		
		var inputLocation = '${gdto.location}';
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		geocoder.addressSearch(inputLocation, function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });

				// 지도에 표시할 원을 생성합니다
				var circle = new kakao.maps.Circle({
				    center : new kakao.maps.LatLng(result[0].y, result[0].x),  // 원의 중심좌표 입니다 
				    radius: 50, // 미터 단위의 원의 반지름입니다 
				    strokeWeight: 1, // 선의 두께입니다 
				    strokeColor: '#75B8FA', // 선의 색깔입니다
				    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				    fillColor: '#CFE7FF', // 채우기 색깔입니다
				    fillOpacity: 0.7  // 채우기 불투명도 입니다   
				}); 
				
				// 지도에 원을 표시합니다 
				circle.setMap(map); 
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});    
		
	</script>
<%-- <jsp:include page="/WEB-INF/views/group/report.jsp" /> --%>
<!-- 공통 신고하기  -->
<jsp:include page="/WEB-INF/views/reportPage.jsp" />

<jsp:include page="/WEB-INF/views/group/apply.jsp" />
<jsp:include page="/WEB-INF/views/group/out.jsp" />
<jsp:include page="/WEB-INF/views/footer.jsp"/>