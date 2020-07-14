	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<script>
	$(function() {
		$(".box").on("click", function() {
			var seq = $(this).find(".seq").html();
			location.href = "/partner/partnerView?seq=" + seq;
		})
		
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
		
		//var grade = '${sessionScope.loginInfo.grade}';
		
		
		//이메일 모달창 생성
		$(".button_aa .email_a").on("click",function(e){
			var seq = $(this).closest('.button_aa').siblings('.box').find('.seq').html();
			//window.open("http://localhost:8888/partner/selectPartnerEmail?seq="+seq,"width=800,height=400");
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
		$('#align').on('change',function(){
			var orderByVal = $('#align').val();
			location.href='/partner/partnerList?align='+orderByVal;
		})
		
		// 로그인 후 이용가능
		$(".box").on("click",function(){
			if(${sessionScope.loginInfo.id == null}){
				alert("로그인 후 이용해주세요.");
				location.href="http://localhost/member/login";
			}	
		})
	});
</script>
<body>
	<div id="subWrap" class="hdMargin" style="padding-top: 155.924px;">
		<section id=""></section>
		<section id="subContents">
			<article id="group_list" class="inner1200">
				<div class="tit_s1">
					<h2>Partner</h2>
					<p>다양한 사람들을 원하시나요?<br>관심사가 비슷한 사람들과 함께 소통해 보세요.</p>
				</div>
				<div class="partner_register_box">
					<div id="tab_2" class="profileShareAgree">			
							<c:if test="${sessionScope.loginInfo.grade == 'default'}">
								<form action="/partner/insertPartner" id="partnerRegister" method="post">
									<h2>파트너를 등록해주세요</h2>
									<div>자신의 프로필을 공유하여 다른 사람들과 소통해보세요.</div>
									프로필 공유 동의 <input type="checkbox" name="agree" id="agree">(필수)<br> 
									<span><input type="checkbox" name="contactList" id="letter" >쪽지</span> 
									<span><input type="checkbox" name="contactList" id="email">이메일</span> 
									<span><input type="checkbox" name="contactList" id="chatting" >채팅(필수)</span><br>
									<input type="hidden" name="contact" id="contact">
									1:1 기본적으로 제공되는 서비스입니다.
									<button type="button" id="partnerBtn">등록</button>
								</form>
							</c:if>
					</div>
				</div>
				<div class="partner_search_box">
					<div id="tabContWrap" class="search_wrap">
						<article id="tab_1" class="kewordSch">
							<div class="search_as_keyword">
							<form action="/partner/partnerSearch" method="post" id="test">
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
									<div class="btnS1 center">
										<div><input type="submit" value="검색" id=searchAsKeyword></div>
									</div>
								</section>
							</div>
							</form>
						</article>
					</div>
				</div>
				<div class="search_btn_style">
					<div class="btnS1 right">
						<select name="align" id="align">
							<option value="recent" <c:if test="${align == 'recent'}">selected</c:if>>최신 순</option>
							<option value="point" <c:if test="${align == 'point'}">selected</c:if>>인기 순</option>
						</select>
					</div>
				</div>

	<div class="partnerBox">
		<c:choose>
			<c:when test="${empty alist}">
				등록된 파트너가 없습니다.
			</c:when>
			<c:otherwise>
				<c:forEach var="plist" items="${alist}">
					<div class="list_${plist.seq}">
						<div class="box">
							<span class="seq">${plist.seq}</span> 
							<img src ="/upload/member/${plist.id}/${plist.sysname}">
							<span class="name">${plist.name}</span> <br> 
							<span class="age">${plist.age}</span><br> 
							<span class="id">아이디 : ${plist.id}</span><br> 
							<span class="gender">성별 :${plist.gender}</span><br> 
							<span class="email">${plist.email}</span><br> 
							<span class="lang_can">구사 가능한 언어 :${plist.lang_can}</span><br> 
							<span class="lang_learn">배우고 싶은 언어 : ${plist.lang_learn}</span><br>
							<span class="hobby">취미 : ${plist.hobby}</span><br> 
							<span class="introduce">자기 소개 : ${plist.introduce}</span>
						</div>
						<div class="button_aa">
							<button class="letter">쪽지</button>
							<button class="chatting" data-uid="${plist.id}" data-name="${plist.name}">채팅</button>
							<button class="email_a"><a href="#writeEmail" class='btn' data-seq="${plist.seq}">이메일</a></button>
						</div>
					</div><hr>						
				</c:forEach>
			</c:otherwise>
		</c:choose>	
	</div>
	
	<div class="navi">${navi}</div>
 	
	<div class=modal>
		<div id="writeEmail" >
		  	<div id="" class="emailPop">
				<h2>이메일 보내기</h2>
				<form id="emailForm"> 
				<!-- post방식으로 자료를 컨트롤러로 보냄 -->
					받는 사람  : <input name="name" id="receiverName"><br>
					발신자 이메일 : <input name="memail" value="${loginInfo.email}"><br>
					이메일 비밀번호 : <input type="password" name="emailPassword"><br>
					수신자 이메일 : <input name="email" id="sendrMail"><br>
					제목 : <input name="subject"><br>
					내용 : <textarea rows="5" cols="80" name="contents"></textarea><br>
					<input type="submit" value="전송" id="send">
				</form>
			</div>
		</div>
	</div>
	<script>
	$(function(){
		
		var writeEmail = $("#writeEmail");
	    $('a[href="#writeEmail"]').click(function(e) {
	    	e.preventDefault();
	     	 $("#writeEmail").stop().fadeIn();
	     	 var seq = $(this).data("seq");
	     	 var name = $(".list_"+seq).find(".name").text();
	     	 var email = $(".list_"+seq).find(".email").text();
	     	 writeEmail.find("#receiverName").val(name);
	     	  writeEmail.find("#sendrMail").val(email);
	    });
    
		 $("#emailForm").submit(function(){
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
				alert("이메일이 전송되었습니다.");
				$("#writeEmail").stop().fadeOut();
			})
			return false;
		})
		
		$('a[href="#writeEmail"]').click(function(event) {
		      event.preventDefault();
		 
		      $(this).modal({
		        fadeDuration: 300
		      });
		    });
		
	})
	</script>
 	
 	
<jsp:include page="/WEB-INF/views/footer.jsp"/>