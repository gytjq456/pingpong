<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<style>
	* { box-sizing: border-box; }
	#seq { display: none; }
	.group_info { display: inline-block; }
	#writer_info { width: 30%; position: relateive; }
	#group_base { width: 65%; position: absolute; top: 0; right: 2%; }
	#writer_profile { width: 300px; height: 300px; border-radius: 50%; text-align: center; line-height: 300px; position: relative; top: 50%; left: 50%; transform: translate(-50%, 0); overflow: hidden; }
	#writer_name_id { position: relative; left: 50%; transform: translate(-50%, 0); display: inline-block; margin-top: 20px; }
	.base_info { position: relative; width: 95%; }
	#group_title { font-size: 40px; font-weight: bold; margin: 10px; }
	#group_base_info { padding: 15px; border-bottom: 1px solid #ddd; }
	#group_base_info span { position: relative; }
	#group_base_info span i { margin-right: 5px; }
	#point_avg { left: 10px; }
	#like { right: -74%; }
	#jjim { right: -75%; }
	#report { right: -76%; }
	#point i { color: #fcba03; }
	#like i { color: #3162a4; }
	#jjim i { color: #fbaab0; }
	#report i { color: #fc0303; }
	.info_with_icon { width: 24.7%; display: inline-block; position: relative; text-align: center; padding-bottom: 20px; padding-top: 40px; }
	.info_with_icon i { font-size: 50px; margin-bottom: 15px; }
	#group_tab_menu { width: 100%; }
	#group_contents_wrapper { position: relative; }
	#group_contents { width: 69%; vertical-align: top; }
	#group_optional { width: 30%; border-left: 1px solid #ddd; padding: 0 30px; }
	#group_view_card { position: relative; }
	#group_optional .optional_menu { font-size: 22px; }
	#group_optional .member_profile { display: inline-block; width: 50px; height: 50px; border-radius: 50%; border: 1px solid #ddd; line-height: 50px; text-align: center; margin-right: 5px; }
	#group_optional .optional_sub { font-weight: bold; }
	#group_optional span { margin-right: 5px; }
	#group_optional #like_count { border-right: 1px solid #ddd; padding-right: 10px; }
	#group_optional .optional_box { margin-bottom: 20px; }
	#related_group_title { font-size: 22px; }
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
		
		var checkLike = ${checkLike};
		if (checkLike) {
			$('#like').css('color', 'red');
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
	})
</script>
	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="group_view" class="inner1200 clearfix">
				<div class="group_title_wrapper card_body">
					<div id="writer_info" class="group_info">
						<div id="writer_profile"><img src="/resources/img/sub/userThum.jpg"/></div>
						<div id="writer_name_id">${gdto.writer_name}(${gdto.writer_id})</div>
					</div>
					<div id="group_base" class="group_info">
						<span id="seq">${gdto.seq}</span>
						<div id="group_base_info" class="base_info">
							<div id="group_title">${gdto.title}</div>
							<span id="point_avg"><i class="fa fa-star" aria-hidden="true"></i>${gdto.review_point}</span>
							<span id="like"><i class="fa fa-thumbs-up" aria-hidden="true"></i>추천</span>
							<span id="jjim"><i class="fa fa-heart-o" aria-hidden="true"></i>찜하기</span>
							<span id="report"><i class="fa fa-exclamation" aria-hidden="true"></i>신고</span>
						</div>
						<div id="group_detail" class="base_info">
							<div class="info_with_icon">
								<i class="fa fa-map-marker" aria-hidden="true"></i><br>
								${gdto.location}
							</div>
							<div class="info_with_icon">
								<i class="fa fa-calendar" aria-hidden="true"></i><br>
								${gdto.start_date} ~ ${gdto.end_date}
							</div>
							<div class="info_with_icon">
								<i class="fa fa-users" aria-hidden="true"></i><br>
								${gdto.max_num}
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
						<li><a href="#;">신청(${gdto.app_count})</a></li>
					</ul>
				</div>
				<div id="tabContWrap_s2">
					<article id="tab_1" class="kewordSch">
						<div id="group_contents_wrapper" class="card_body">
							<div id="group_contents" class="group_info">
								${gdto.contents}
							</div>
							<div id="group_optional" class="group_info">
								<div class="optional_box">
									<div class="optional_menu">모집 기간</div>
									<div>${gdto.apply_start} ~ ${gdto.apply_end}</div>
								</div>
								<div class="optional_box">
									<div class="optional_menu">참여자 인원(${gdto.cur_num})</div>
									<div class="group_members">
										<div class="member_profile">플</div>
										<div class="member_profile">플</div>
										<div class="member_profile">플</div>
									</div>
								</div>
								<div class="optional_box">
									<span class="optional_sub">추천</span>
									<span id="like_count">${gdto.like_count}</span>
									<span class="optional_sub">조회</span><span>${gdto.view_count}</span><br>
									<span class="optional_sub">작성일</span><span>${gdto.write_date}</span><br>
								</div>
								<c:choose>
									<c:when test="${sessionScope.loginInfo.id == gdto.writer_id}">
										<button type="button" id="update">수정</button>
										<button type="button" id="delete">삭제</button>
									</c:when>
									<c:otherwise>
										<button type="button" id="applyForm" onclick="javascript:applyPopup()">신청</button>
										<button type="button" id="deleteForm" onclick="javascript:deletePopup()">탈퇴</button>
									</c:otherwise>
								</c:choose>
								<button type="button" id="toList" onclick="javascript:toList()">목록</button>
							</div>
						</div>
					</article>
					<article id="tab_2" class="calendarSch card_body">
						<div id="related_group_title">관련 모임</div>
						<div>
							<c:choose>
								<c:when test="${empty relatedGroup}">
									관련 모임이 없습니다.
								</c:when>
								<c:otherwise>
									<c:forEach var="related" items="${relatedGroup}">
										<a href="/group/beforeView?seq=${related.seq}">
											<div class="group_each_wrapper">
												<div><span class="sub_title">작성자</span> ${related.writer_name}(${related.writer_id})</div>
												<div><span class="sub_title">제목</span> ${related.title}</div>
												<div><span class="sub_title">유형</span> ${related.hobby_type}</div>
												<div><span class="sub_title">모집 기간</span> ${related.apply_start} ~ ${related.apply_end}</div>
												<div><span class="sub_title">진행 기간</span> ${related.start_date} ~ ${related.end_date}</div>
												<div><span class="sub_title">평점</span> ★ ${related.review_point}</div>
												<div>
													<span class="sub_title">조회</span> ${related.view_count}  
													<span class="sub_title">추천</span> ${related.like_count}  
													<span class="sub_title">리뷰</span> ${related.review_count}
												</div>
												<c:if test="${related.applying == 'Y'}">
													<span>모집중</span>  
												</c:if>
												<c:if test="${related.proceeding == 'Y'}">
													<span>진행중</span>
												</c:if>
												<c:if test="${related.proceeding == 'N' && related.applying == 'N'}">
													<span>마감</span>
												</c:if>
											</div>
										</a>
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
					</article>
				</div>			
			</article>
		</section>
	</div>
	<script>
		function applyPopup() {
			var seq = $('#seq').html();
			var url = '/group/applyForm/parent_seq/' + seq;
			var name = 'GroupApply';
			var option = 'width = 500, height = 500, top = 100, left = 200, location = no';
			window.open(url, name, option);
		}
		
		function deletePopup() {
			var seq = $('#seq').html();
			var url = '/group/outForm/parent_seq/' + seq;
			var name = 'GroupOut';
			var option = 'width = 500, height = 500, top = 100, left = 200, location = no';
			window.open(url, name, option);
		}
		
		function toList() {
			location.href = '/group/main?orderBy=seq';
		}
		
		$('#like').on('click', function(){
			console.log($(this).css('color'));
			if ($(this).css('color') == 'rgb(255, 0, 0)') {
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
	</script>


<jsp:include page="/WEB-INF/views/footer.jsp"/>