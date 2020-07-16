<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
	<Script>
		$(function(){
			// 글 삭제 버튼 클릭
			$("#delete").click(function(){
				var result = confirm("해당 글을 삭제하시겠습니까?");
				if(result){
					$.ajax({
						url:"/discussion/delete",
						type:"POST",
						dateType:"json",
						data:{
							seq:"${disDto.seq}"
						}
					}).done(function(resp){
						console.log(resp)
						alert("글이 삭제 되었습니다.");
						location.href="/discussion/list";
					})		
				}
			})
			
			// 뒤로가기 버튼 클릭
			$("#historyBack").click(function(){
				location.href="/discussion/list"
			})
			
			// 글 수정 버튼 클릭
			$("#modify").click(function(){
				location.href="/discussion/modify?seq=${disDto.seq}"
			})
			
			// 댓글 쓰기
			var opinion = $("#opinion");
			var textCont = $("#textCont");
			$("#commentForm").submit(function(){
		        var form = $('#commentForm')[0];
		        var formData = new FormData(form);
		        if(opinion.val() == ""){
		        	alert("의견을 선택해주세요.");
		        	opinion.focus();
		        	return false;
		        }else if(textCont.val() == "" || textCont.val().replace(/\s|　/gi, "").length == 0){
		        	alert("댓글을 입력해주세요.")
		        	textCont.focus();
		        	textCont.val("");
		        	return false;
		        }
				$.ajax({
					url:"/discussion/commentProc",
					type:"post",
					dataType:"json",
					data:formData,
		        	contentType : false,
		            processData : false  					
				}).done(function(resp){
		        	if(resp){
		        		alert("댓글 작성이 완료 되었습니다.")
		        		location.href="/discussion/view?seq=${disDto.seq}"
		        	}
				})
				return false;
			})
			
			// 댓글 좋아요, 싫어요 증가
			var comment_likeBtn = $(".comment_likeBtn");
			var comment_hateBtn = $(".comment_hateBtn");
			var discussion_likeBtn = $(".discussion_likeBtn");
			likeHateCount(comment_likeBtn,"/discussion/commentLike","토론 댓글");
			likeHateCount(comment_hateBtn,"/discussion/commentHate","토론 댓글");
			likeHateCount(discussion_likeBtn,"/discussion/like","토론 게시글");
			console.log(likeHateCount);
			
			// 댓글 삭제
			$(".comment_delete").click(function(){
				var result = confirm("댓글을 삭제 하시겠습니까?");
				var seq = $(this).data("seq");
				var parentSeq = $(this).data("parent_seq");
				if(result){
					$.ajax({
						url:"/discussion/commentDelete",
						dataType:"json",
						data:"post",
						data:{
							seq:seq,
							parent_seq:parentSeq
						}
					}).done(function(resp){
						if(resp){
							alert("댓글이 삭제되었습니다.");
							location.href="/discussion/view?seq=${disDto.seq}"
						}
					})
				}
			})
			
			// view right_body 
			var viewPage = $("#discussion_view");
			var cardOffset = viewPage.offset().top; 
			var headerHeight = $("header").height();
			var quick_top = 100;
			var quick_menu = viewPage.find(".body_right");
			$(window).scroll(function(){
				var scrollTop = $(this).scrollTop();
				if(scrollTop >= cardOffset - headerHeight - 30){
					quick_menu.stop().animate({ 
						"top": scrollTop + "px" 
					}, 500 ); //스크롤 내려갈 때의 속도					
				}else{
					quick_menu.stop().animate({ 
						"top":0
					});
				}
			})
			
			
			// 리뷰 글자수 체크
			$("#discussion_view").find("#textCont").keyup(function(){
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
			
			
			// 파파고 번역하기
			//번역을 위해서 button 이벤트를 위해서 사용하는 것
			var langCountry = $(".langCountry")
			var langCountryVal = "ko";
			var lanArr = {
				ko : "영어, 일본어, 중국어, 베트남어, 인도네시아어, 태국어, 독일어, 러시아어, 스페인어, 이탈리아어, 프랑스어",
				en : "한국어,일본어 ,프랑스어, 중국어",
				ja : "한국어,영어,중국어",
				zhCN : "한국어,영어,일본어,중국어 번체",
				zhTW : "한국어,영어,일본어,중국어 간체"
			}
			langCountry.find("select").on("change",function(){
				langCountryVal = $(this).val();
			})
			$('#jsonConvertStringSend').click(function() {
				//번역할 object를 생성
				var text = $(".viewPage_style1 .originTxt").text();
				var test = {
					"original_str" : text,
					"original_lang" : "${disDto.language}",
					"change_lang" : langCountryVal
				};
				$.ajax({
					type : "POST",
					url : "/discussion/papago",
					dataType:"json",
					data : test, //json을 보내는 방법
					success : function(data) { //서블렛을 통한 결과 값을 받을 수 있습니다.
						console.log(data);
						//결과값을 textarea에 넣기 위해서
						
						var json = data[1];
						console.log("qqq"+json);
						var obj = JSON.parse(json);
						console.log("ttt:"+obj.errorCode)
						if(obj.errorCode == "N2MT04" || obj.errorCode == "N2MT02"){
							alert("지원하지 않는 언어 입니다.");
						}
						if(obj.errorCode == "N2MT05"){
							alert("원본언어와 동일합니다.");
						}
						
						if(obj.errorCode == "undefined"){
							if(data[0] == "ko"){
								alert(lanArr.ko+"만 번역이 가능합니다.")
							}else if(data[0] == "en"){
								alert(lanArr.en+"만 번역이 가능합니다.")
							}else if(data[0] == "ja"){
								alert(lanArr.ja+"만 번역이 가능합니다.")
							}else if(data[0] == "zh-CN"){
								alert(lanArr.zhCN+"만 번역이 가능합니다.")
							}else if(data[0] == "zh-TW"){
								alert(lanArr.zhTW+"만 번역이 가능합니다.")
							}
							
						}else{
							if(obj.errorCode != "010"){
								var text = obj.message.result.translatedText;
								$(".convert").text(text);
							}else{
								alert("번역 쿼리 한도 초과")
							}
						}
					},
					error : function(e) {
						console.log(e);
						alert('실패했습니다.');
					}
				});
			});
			
			
			
			$(".like-hate-btn").each(function(){
				var dataCheck = $(this).data("check");
				if(dataCheck){
					$(this).addClass("checkOn")
				}
			})
			$(".discussion_likeBtn").each(function(){
				var dataCheck = $(this).data("check");
				if(dataCheck){
					$(this).addClass("checkOn")
				}
			})
			
			
			// 댓글 작성중 취소후 글자수 0으로 바꾸기
			$("input[type='reset']").click(function(){
				$(".wordsize .current").text("0");
			})
			
			$("input,textarea").blur(function(){
				var thisVal = $(this).val();
				$(this).val(textChk(thisVal));
			})			
		})

		function likeHateCount(btn, url,category) {
			btn.click(function() {
				var seq = $(this).data("seq");
				$.ajax({
					url : url,
					//dataType : "json",
					data : "post",
					data : {
						category:category,
						parent_seq:seq
					}
				}).done(function(resp) {
					if(resp == "cancel"){
						if(btn.hasClass("comment_likeBtn")){
							alert("좋아요 취소")
						}else if(btn.hasClass("comment_hateBtn")){
							alert('싫어요 취소');
						}
					}else{
						var isBoolean = JSON.parse(resp);
						if (!isBoolean) {
							if(btn.hasClass("comment_likeBtn")){
								alert('이미 싫어요 된 게시글 입니다.');
							}else if(btn.hasClass("comment_hateBtn")){
								alert('이미 좋아요 된 게시글 입니다.');
							}
						}
					}
					
					location.href = "/discussion/view?seq=${disDto.seq}"
				})
			})
		}
		
		function textChk(thisVal){
			var replaceId  = /(script)/gi;
			var textVal = thisVal;
		    if (textVal.length > 0) {
		        if (textVal.match(replaceId)) {
		        	textVal = thisVal.replace(replaceId, "");
		        }
		    }
		    return textVal;
		}
		
		
	</Script>

	<div id="subWrap" class="hdMargin">
		<section id="subContents">
		
			<article id="discussion_view" class="viewPage_style1 inner1200 clearfix">
				
				<div class="body_left">
					<div class="card_body">
						<%-- <div id="">번호 : ${disDto.seq}</div> --%>
						<div class="title">${disDto.title}</div>
						<div class="userInfo_s1">
							<div class="thumb"><img src="/upload/member/${disDto.id}/${disDto.thumNail}"/></div>
							<div class="info">
								<p class="userId">${disDto.writer}</p>
								<p class="writeDate">${disDto.dateString}</p>
							</div>
						</div>
						<div class="language">${disDto.language}</div>	
						<div class="contents ">
							<div class="originTxt">${disDto.contents}</div>
							<div class="langCountry convertWrap clearfix">
								<div>
									<select>
										<c:forEach var="i" items="${langList}">
											<option value="${i.language_country}">${i.language}</option>
										</c:forEach>
									</select>
								</div>
								<div id="convertBtn"><button type="button" id="jsonConvertStringSend">번역하기</button></div>
							</div>
							<div class="convert">
							
							</div>
						</div>
						
						<div class="countList">
							<ul>
								<li><i class="fa fa-eye"></i> ${disDto.view_count}</li>			
								<li><i class="fa fa-commenting-o" aria-hidden="true"></i> ${disDto.comment_count}</li>
								<li>
									<button class="discussion_likeBtn likeBtn" data-check="${boardCheckLike}" data-seq="${disDto.seq}">
										<i class="fa fa-thumbs-up"></i> ${disDto.like_count}
									</button>
								</li>
							</ul>
						</div>
					</div>
					
					<div class="">
						<div class="comment_wrap">
							<section class="comment_write card_body">
								<div class="tit_s2">
									<h3>댓글쓰기</h3>
								</div>
								<div class="comment_box">
									<form id="commentForm">
										<input type="hidden" name="category" value="discussion">
										<input type="hidden" name="writer" value="${loginInfo.name}">
										<input type="hidden" name="id" value="${loginInfo.id}">
										<input type="hidden" name="parent_seq" value="${disDto.seq}">
										<input type="hidden" name="thumNail" value="${loginInfo.sysname}">
										<div class="opinion">
											<div>의견(찬/반)</div>
											<div>
												<select name="opinion" id="opinion">
													<option value="">선택</option>
													<option value="찬성">찬성</option>
													<option value="반대">반대</option>
												</select>
											</div>
										</div>
										<div class="textInput">
											<textarea name="contents" id="textCont"></textarea>
											<div class="wordsize"><span class="current">0</span>/1000</div>
										</div>
										<div class="btnS1 right">
											<div><input type="submit" value="작성" class="on"></div>
											<div>
												<input type="reset" value="취소">
											</div>
										</div>										
									</form>
								</div>
							</section>
							
							<section class="comment_list card_body">
								<div class="tit_s2">
									<h3>베스트 댓글(${fn:length(bestCommentList)})</h3>
								</div>
								<c:forEach var="i" items="${bestCommentList}" varStatus="status">
									<article>
										<div class="userInfo_s1">
											<div class="thumb"><img src="/upload/member/${i.id}/${i.thumNail}"/></div>
											<div class="info">
												<p class="userId">${i.writer}</p>
												<p class="writeDate">${i.dateString}</p>
											</div>
										</div>
										<div class="opinion">
											<p class="<c:if test="${i.opinion == '찬성'}">yes</c:if><c:if test="${i.opinion == '반대'}">no</c:if>">${i.opinion}</p>
										</div>
										
										<div class="cont">
											<div class="contents">${i.contents}</div>
											<div class="countList">
												<ul>
													<li>
														<button class="comment_likeBtn likeBtn like-hate-btn" data-check="${checkLike[status.index]}" data-seq="${i.seq}"><i class="fa fa-thumbs-up"></i> ${i.like_count}</button>
													</li>
													<li>
														<button class="comment_hateBtn hateBtn like-hate-btn" data-check="${checkHate[status.index]}" data-seq="${i.seq}"><i class="fa fa-thumbs-down"></i> ${i.hate_count}</button>
													</li>
													<li>
														<button class="comment_declaration report" data-thisSeq="${i.seq}" data-seq="${disDto.seq}" data-id="${i.id}" data-url="/discussion/report" data-proc="/discussion/reportProc"><i class="fa fa-bell color_white" aria-hidden="true"></i> 신고하기</button>
													</li>
													<c:if test="${loginInfo.id == i.id}">
														<li>
															<button class="comment_delete normal" data-seq="${i.seq}" data-parent_seq="${disDto.seq}">댓글삭제</button>
														</li>
													</c:if>
												</ul>
											</div>
										</div>
									</article>
								</c:forEach>					
							</section>				
							
							<section class="comment_list card_body">
								<div class="tit_s2">
									<h3>댓글(${fn:length(commentList)})</h3>
								</div>
								<c:forEach var="i" items="${commentList}" varStatus="status">
									<article>
										<div class="userInfo_s1">
											<div class="thumb"><img src="/upload/member/${i.id}/${i.thumNail}"/></div>
											<div class="info">
												<p class="userId">${i.writer}</p>
												<p class="writeDate">${i.dateString}</p>
											</div>
										</div>
										<div class="opinion">
											<p class="<c:if test="${i.opinion == '찬성'}">yes</c:if><c:if test="${i.opinion == '반대'}">no</c:if>">${i.opinion}</p>
										</div>
										
										<div class="cont">
											<div class="contents">${i.contents}</div>
											<div class="countList">
												<ul>
													<li>
														<button class="comment_likeBtn likeBtn like-hate-btn" data-check="${checkLike[status.index]}" data-seq="${i.seq}"><i class="fa fa-thumbs-up"></i> ${i.like_count}</button>
													</li>
													<li>
														<button class="comment_hateBtn hateBtn like-hate-btn" data-check="${checkHate[status.index]}" data-seq="${i.seq}"><i class="fa fa-thumbs-down"></i> ${i.hate_count}</button>
													</li>
													<li>
														<button class="comment_declaration report" data-thisSeq="${i.seq}" data-seq="${disDto.seq}" data-id="${i.id}" data-url="/discussion/report" data-proc="/discussion/reportProc"><i class="fa fa-bell color_white" aria-hidden="true"></i> 신고하기</button>
													</li>
													<c:if test="${loginInfo.id == i.id}">
														<li>
															<button class="comment_delete normal" data-seq="${i.seq}"  data-parent_seq="${disDto.seq}">댓글삭제</button>
														</li>
													</c:if>
												</ul>
											</div>
										</div>
									</article>
								</c:forEach>					
							</section>
						</div>
					</div>
				</div>
				<div class="body_right card_body">
					<div class="caution">
						<div class="tit_s2">
							<h3>토론시 주의사항</h3>
						</div>					
						<div id="txt">${disDto.caution}</div>
					</div>
					<div class="moreList">
						<div class="tit_s2">
							<h3>토론 더 보기</h3>
						</div>
						<div class="list">
							<ul>
								<c:forEach var="i" items="${moreList}"> 
									<li><a href="/discussion/view?seq=${i.seq}">- ${i.title}</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>	
					<div class="btns_s2">
						<c:choose>
							<c:when test="${loginInfo.id == disDto.id}">
								<button type="button" id="modify">글수정</button>
								<button type="button" id="delete">글삭제</button>
								<button type="button" id="historyBack">뒤로가기</button>					
							</c:when>
							<c:otherwise>
								<button type="button" class="w100p" id="historyBack">뒤로가기</button>					
							</c:otherwise>
						</c:choose>
					</div>			
				</div>
			</article>
		</section>
	</div>
<%-- <jsp:include page="/WEB-INF/views/group/report.jsp" /> --%>

<!-- 공통 신고하기  -->
<jsp:include page="/WEB-INF/views/reportPage.jsp" />
<jsp:include page="/WEB-INF/views/footer.jsp"/>