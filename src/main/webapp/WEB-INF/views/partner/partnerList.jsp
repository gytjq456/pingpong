	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<style>
	#tabContWrap { display:block;}
	.defaultSch input { width:100%; }
	.checkBox_s1 select { padding:5px; border:1px solid #ddd; box-sizing:border-box; border-radius:6px; font-size:14px;}
	
		#layerPop_s3 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none; background:rgba(0,0,0,0.5);  }
		#layerPop_s3 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff; padding:30px 20px; box-sizing:border-box;}
		#layerPop_s3 .tit_s3 { text-align:center; font-weight:700; font-size:20px; border-bottom:1px solid #ddd; padding-bottom:12px; margin-bottom:12px;}
		#layerPop_s3 .tit {  font-weight:700; }
		#layerPop_s3 .info {}
		#layerPop_s3 input[type="password"],
		#layerPop_s3 input[type="text"] { border:1px solid #ddd; border-radius:6px; width:100%; padding:5px 10px; font-size:12px; width:100%;}
		#layerPop_s3 .info > dl { overflow:hidden; margin-bottom:14px;}
		#layerPop_s3 .info > dl:last-child { margin:0; }
		#layerPop_s3 .info > dl dt { margin-bottom:10px; } 
		#layerPop_s3 .info > dl dd {}
		#layerPop_s3 .info > dl { float:left; width:48%; margin-right:4%; } 
		#layerPop_s3 .info > dl:nth-child(2n) { margin-right:0; } 
		#layerPop_s3 .txtBox { margin-top:10px; }
	
</style>
<script>
	$(function() {
		/* $(".box").on("click", function() {
			var seq = $(this).find(".seq").html();
			location.href = "/partner/partnerView?seq=" + seq;
		}) */
		
		$('#partnerBtn').on('click', function(){				
			var checkboxCount = $("input:checkbox[name='contactList']").length;
			console.log('checkboxCount: ' + checkboxCount)
			var selectedContact = [];
			
			for (var i = 0; i < checkboxCount; i++) {
				var inputChecked = $("input:checkbox[name='contactList']:eq(" + i + ")").is(":checked");
				if (inputChecked) {
					selectedContact.push($("input:checkbox[name='contactList']:eq(" + i + ")").val());
					console.log('selectedContact: ' + selectedContact)
				}
			}
			
			$("#contact").val(selectedContact);
			
			$('#partnerRegister').submit();
		
		})
		
		var grade = '${sessionScope.loginInfo.grade}';
		
		
		//이메일 팝업창 생성
		$(".button_aa .email_a").on("click",function(e){
			alert("이메일 페이지로 이동하실께요.");
			var seq = $(this).closest('.button_aa').siblings('.box').find('.seq').html();
			window.open("http://localhost:8888/partner/selectPartnerEmail?seq="+seq,"width=800,height=400");
		})
				
		//시군 
		   new sojaeji('sido1', 'gugun1');
				 var addrTxt = "";
		   
		   $('#sido1').change(function(){
		         var sido = $("#sido1").val();
		         addrTxt = sido;
		         $('#address').val(sido);
		    });  
		   $('#gugun1').change(function(){
		         var gugun = $("#gugun1").val();
		         console.log(gugun);
		         console.log(addrTxt + ' ' + gugun)
		         $('#address').val(addrTxt + ' ' + gugun);
		    });  

		new sojaeji('sido1', 'gugun1');
		   
		$('#gugun1').change(function(){
			var sido = $('#sido1 option:selected').val();
			var gugun = $('#gugun1 option:selected').val();
			console.log(sido);
			console.log(gugun);
			console.log($('#address').val(sido + ' ' + gugun));
		});
		
		
		//최신순, 평점순
		/* var align = '${align}';
		if(align != null){
			$("#align").val(align);
			console.log(align);
		}else{
			$('#align').val('seq');
		} */
		
		$('#align').on('change', function(){
			var orderByVal = $('#align').val();
			location.href='/partner/partnerList?align='+orderByVal;
		})
		
		// 로그인 후 이용가능
		$(".box").on("click",function(){
			if(${sessionScope.loginInfo.id == ""}){
				alert("로그인 후 이용해주세요.");
				location.href="http://localhost/member/login";
			}	
		})
		
		$(".partnerBox article").each(function(){
			var text = $(this).find(".introduce p").text();
			var seq = $(this).data("seq");
			//$(this).children("article").wrap('<a href="/discussion/view?seq='+seq+'">')
		
			var tagLt = text.replace(/<a/gim,"$lta;");
			var tagGt = tagLt.replace(/a>/gim,"a$gt;");
			console.log(tagGt)
			if(text.length >= 100) { 
				tagGt = tagGt.substring(0,60)+"...";;
				$(this).find(".introduce p").text(tagGt);
			}else{
				$(this).find(".introduce p").text(tagGt);
			}
		})		
	})
</script>
<body>
	<div id="subWrap" class="hdMargin">
		<section id=""></section>
		<section id="subContents">
			<article id="group_list" class="inner1200">
				<div class="tit_s1">
					<h2>Partner </h2>
					<p>다양한 사람들을 원하시나요?<br>관심사가 비슷한 사람들과 함께 소통해 보세요.</p>
				</div>
				
				
				
				
				
				
				
				
				<div class="partner_search_box">
					<div id="tabContWrap" class="search_wrap">
						<article id="tab_1" class="kewordSch">
							<div class="search_as_keyword">
								<form action="/partner/partnerSearch" method="post" id="test">
									<div class="search_as_keyword">
										<section class="defaultSch">
											<div class="tit">검색어</div>
											<div class="schCon ">
												<input type="text" name="name" id="keyword_input" placeholder="파트너의 이름을 입력하세요.">
											</div>
										</section>
										<section>
											<div class="tit">유형</div>
											<div class="schCon">
												<ul class="checkBox_s1">
													<li class="">
														<select name="age" id="age" onchange="setSelectBox(this)">
															<option value="" disabled selected >나이대</option>
															<option value="1">10대</option>	
															<option value="2">20대</option>	
															<option value="3">30대</option>	
															<option value="4">40대</option>	
															<option value="5">50대</option>
														</select>
													</li>
													<li class="">
														<select name="gender" id="gender">
															<option value="" disabled selected >성별</option>
															<!-- <option value="전체">전체</option> -->
															<option value="남자">남자</option>	
															<option value="여자">여자</option>
														</select>
													</li>
													<li>
														<input type="hidden" id="address" name="address">
														<select name="sido1" id="sido1"></select>
													</li>
													<li>
														<select name="gugun1" id="gugun1"></select>
													</li>
													<li>
														<select name="lang_can" id="lang_can">
															<option value="" disabled selected >구사언어</option>
															<c:forEach var="ldto" items="${ldto}">
																<option value="${ldto.language}">${ldto.language}</option>
															</c:forEach>
														</select>
													</li>
													<li>
														<select name="lang_learn" id="lang_learn">
															<option value="" disabled selected >학습언어</option>
															<c:forEach var="ldto" items="${ldto}">
																<option value="${ldto.language}">${ldto.language}</option>
															</c:forEach>	
														</select>
													</li>
													<li>
														<select name="hobby" id="hobby">
															<option value="" disabled selected >취미</option>
															<c:forEach var="hdto" items="${hdto}">
																<option value="${hdto.hobby}">${hdto.hobby}</option>
															</c:forEach>
														</select>
													</li>
												</ul>
											</div>
										</section>
										<div class="btnS1 center">
											<div><input type="submit" value="검색" id=searchAsKeyword></div>
										</div>
									</div>
								</form>
							</div>
						</article>
					</div>
				</div>
				<div class="search_btn_style">
					<div class="btnS1 right posStatic">
						<select name="align" id="align">
							<option value="recent" <c:if test="${align == 'recent'}">selected</c:if>>최신 순</option>
							<option value="point" <c:if test="${align == 'point'}">selected</c:if>>인기 순</option>
						</select>
					</div>
				</div>

				<div class="partnerBox clearfix">
					<c:choose>
						<c:when test="${empty alist}">
							등록된 파트너가 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="plist" items="${alist}">
								<article class="card_body">
									<a href="/partner/partnerView?seq=${plist.seq}">
										<div class="box plist">
											<%-- <span class="seq">${plist.seq}</span> --%> 
											<div class="userInfo clearfix">
												<div class="img"><img src ="/upload/member/${plist.id}/${plist.sysname}"></div>
												<!-- <div class="img"><img src ="/resources/img/sub/userThum.jpg"></div> -->
												<div class="info">
													<ul>
														<li>
															<span>이름</span>
															<p>${plist.name}(${plist.id}, ${plist.age}세, ${plist.gender}) </p>
														</li>
														<li>
															<span>이메일</span>
															<p>${plist.email}</p>
														</li>
														<li>
															<span>구사 언어</span>
															<p>${plist.lang_can}</p>
														</li>
														<li>
															<span>배울 언어</span>
															<p>${plist.lang_learn}</p>
														</li>
														<li>
															<span>취미</span>
															<p>${plist.hobby}</p>
														</li>
														<li class="introduce">
															<span>자기소개</span>
															<p>${plist.introduce}${plist.introduce}</p>
														</li>
													</ul>
												</div>
											</div>
										</div>
										<div class="btn_li">
											<p><button class="letter">쪽지</button></p>
											<p><button class="chatting" data-uid="${plist.id}" data-name="${plist.name}">채팅</button></p>
											<p><button class="email_a">이메일</button></p>
										</div>
									</a>
								</article>				
							</c:forEach>
						</c:otherwise>
					</c:choose>	
				</div>
			</article>
		</section>
	</div>
	 

	
	
	
	<article id="layerPop_s3">
		<div class="pop_body">
			<div class="tit_s3">
				<h4>이메일 보내기</h4>
				<p>이메일은 실제로 사용하시는 정보를 입력하셔야 합니다.</p>
			</div>
			<form id="emailForm"> 
				<input type="hidden" name="seq" value="${pdto.seq}">
				
				<div class="info clearfix">
					<dl>
						<dt class="tit">받는이 :</dt>
						<dd><input type="text" name="name" value="${pdto.name}"></dd>
					</dl>
					<dl class="">
						<dt class="tit">발신자 이메일</dt>
						<dd><p><input type="text" name="memail" value="${loginInfo.email}"></p></dd>
					</dl>
					<dl class="">
						<dt class="tit">이메일 비밀번호</dt>
						<dd><p><input type="password" name="emailPassword" ></p></dd>
					</dl>
					<dl class="">
						<dt class="tit">수신자 이메일</dt>
						<dd><p><input type="text" name="email" value="${pdto.email}"></p></dd>
					</dl>
					<dl class="">
						<dt class="tit">제목</dt>
						<dd><p><input type="text" name="subject"></p></dd>
					</dl>
				</div>
				<div data-seq="" class="txtBox">
					<article>
						<div class="tit">내용</div>
						<div class="txtBox">
							<textarea rows="5" cols="80" name="contents"></textarea>
						</div>
						<div class="btns_s3">
							<p><input type="submit" value="전송" id="send"></p>
							<p><input type="button" id="backReport" value="닫기"></p>
						</div>
					</article>
				</div>
			</form>
		</div>
		<script>
	 		$(function(){
	 			var layerPop_s3 = $("#layerPop_s3");
				 $("#emailForm").on("submit",function(){
					 var formData = new FormData($("#emailForm")[0]);
					$.ajax({
						url:"/partner/send",
						data:formData,
						type:"post",
						dataType:"json",
						cache:false,
						contentType:false,
						processData:false
					}).done(function(resp){
						alert("test :" + resp)
					})
					return false;
				})
				
				$("#backReport").click(function(){
					layerPop_s3.stop().fadeOut();
				})
				$(".email_a").click(function(){
					layerPop_s3.stop().fadeIn();
				})
	 		})
		</script>  
	</article>
	
	
	<div class="navi">${navi}</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>