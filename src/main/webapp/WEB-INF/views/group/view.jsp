<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
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
				<span id="like">따봉</span>
				글번호: <span id="seq">${gdto.seq}</span><br>
				제목: ${gdto.title}<br>
				작성자: ${gdto.writer}<br>
				유형: ${gdto.hobby_type}<br>
				모집 기간: ${gdto.apply_start} ~ ${gdto.apply_end}<br>
				진행 기간: ${gdto.start_date} ~ ${gdto.end_date}<br>
				최대 인원: ${gdto.max_num}<br>
				현재 인원: ${gdto.cur_num}<br>
				장소: ${gdto.location}<br>
				내용: ${gdto.contents}<br>
				작성일: ${gdto.write_date}<br>
				조회수: ${gdto.view_count}<br>
				추천수: <span id="like_count">${gdto.like_count}</span><br>
				신청수: ${gdto.app_count}<br>
				리뷰수: ${gdto.review_count}<br>
				리뷰 포인트: ${gdto.review_point}<br>
				<c:choose>
					<c:when test="${sessionScope.loginInfo.id == gdto.writer}">
						<button type="button" id="update">수정</button>
						<button type="button" id="delete">삭제</button>
					</c:when>
					<c:otherwise>
						<button type="button" id="applyForm" onclick="javascript:applyPopup()">신청</button>
						<button type="button" id="deleteForm" onclick="javascript:deletePopup()">탈퇴</button>
					</c:otherwise>
				</c:choose>
				<button type="button" id="toList" onclick="javascript:toList()">목록</button>
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
		</section>
	</div>



<jsp:include page="/WEB-INF/views/footer.jsp"/>