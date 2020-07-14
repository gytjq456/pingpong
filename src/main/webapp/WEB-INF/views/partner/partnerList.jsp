	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<style>
	#tabContWrap { display:block !important;}
	#tabContWrap > article {display:block !important;}
	.defaultSch input { width:100%; }
	.checkBox_s1 select { padding:5px; border:1px solid #ddd; box-sizing:border-box; border-radius:6px; font-size:14px;}
	
		
	
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
										<div class="box plist">
										<a href="/partner/partnerView?seq=${plist.seq}">
											<%-- <span class="seq">${plist.seq}</span> --%> 
											<div class="userInfo clearfix">
												<div class="img"><img src ="/upload/member/${plist.id}/${plist.sysname}"></div>
												<!-- <div class="img"><img src ="/resources/img/sub/userThum.jpg"></div> -->
												<input type="hidden" value="${plist.id}" class="id">
												<input type="hidden" value="${plist.name}" class="name">
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
										</a>
										</div>
										<div class="btn_li">
											<p><button class="letter">쪽지</button></p>
											<p><button class="chatting" data-uid="${plist.id}" data-name="${plist.name}">채팅</button></p>
											<p><button class="email_a">이메일</button></p>
										</div>
								</article>				
							</c:forEach>
						</c:otherwise>
					</c:choose>	
				</div>
			</article>
		</section>
	</div>
	 

	
	
	
	
	
	
	<div class="navi">${navi}</div>
<jsp:include page="/WEB-INF/views/partner/sendLetter.jsp" />
<jsp:include page="/WEB-INF/views/email/write.jsp"/>
<jsp:include page="/WEB-INF/views/footer.jsp"/>