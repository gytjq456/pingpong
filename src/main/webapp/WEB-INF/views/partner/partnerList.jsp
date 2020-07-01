<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/header.jsp"/>
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
		
		$(".button_aa .email_a").on("click", function(e) {
			//e.stopPropagation(); // 부모의 태그를 막음
			alert("이메일 페이지로 이동하실께요.");
			var seq = $(this).closest('.button_aa').siblings('.box').find('.seq').html();
			location.href = "/partner/selectPartnerEmail?seq=" + seq;
		}) 
		
		$(".partnerSearch").on("click",function(){
			var searchCount = $(".partnerSearch [name='gender']").length;
			console.log(searchCount);
			//var search = $(".partnerSearch option:selected:eq("+i+")").text();
			//console.log(search);
		})
		
		//시군 
		new sojaeji('sido1', 'gugun1');
		   
		$('#gugun1').change(function(){
			var sido = $('#sido1 option:selected').val();
			var gugun = $('#gugun1 option:selected').val();
			console.log(sido);
			console.log(gugun);
			console.log($('#address').val(sido + ' ' + gugun));
		});
		
		
		// 채팅 
		$(".chatting").on("click",function(){
			$.ajax({
				url:"/chatting/create",
				type:"post",
				dataType:"json",
				data:{
					user:"홍길동"
				}
			}).done(function(resp){
				if(resp){
					alert("채팅방 생성")
				}else{
					alert("채팅방 존재")
				}
			})
		});
		
	})
</script>
<body>
	<h2>파트너를 등록해주세요</h2>
	<div>자신의 프로필을 공유하여 다른 사람들과 소통해보세요.</div>
	<br>
	<br>
	<br>
	<div class="profileShareAgree">
		<form action="/partner/insertPartner" id="partnerRegister" method="post">
			프로필 공유 동의 <input type="checkbox" name="agree" id="agree">(필수)<br> 
			<input type="text" name="contact" id="contact">
			1:1 기본적으로 제공되는 서비스입니다.
			<button type="button" id="partnerBtn">등록</button>
		</form>
		<span><button type="button" name="contactList" id="letter" >쪽지</button></span> 
		<span><button type="button" name="contactList" id="email" >이메일</button></span> 
		<span><button type="button" name="contactList" id="chatting" >채팅</button></span><br>
	</div>
	
	<form action="/partner/partnerSearch" method="post">
		<div class="partnerSearch">
			<!-- <select name="age" id="partnerAge" onchange="setSelectBox(this)">
				<option value="" disabled selected >나이대</option>
				<option value="NULL">전체</option>
				<option value="1">10대</option>	
				<option value="2">20대</option>	
				<option value="3">30대</option>	
				<option value="4">40대</option>	
				<option value="5">50대</option>
			</select> -->
			<select name="gender" id="gender">
				<option value="" disabled selected >성별</option>
				<!-- <option value="전체">전체</option> -->
				<option value="남">남자</option>	
				<option value="여">여자</option>
			</select>
			
			<select name="sido1" id="sido1"></select>
            <select name="gugun1" id="gugun1"></select>
                                       
			<select name="lang_can" id="lang_can">
				<option value="" disabled selected >구사언어</option>
				<c:forEach var="ldto" items="${ldto}">
					<option value="${ldto.language}">${ldto.language}</option>
				</c:forEach>
			</select>
			<select name="lang_learn" id="lang_learn">
				<option value="" disabled selected >학습언어</option>
				<c:forEach var="ldto" items="${ldto}">
					<option value="${ldto.language}">${ldto.language}</option>
				</c:forEach>	
			</select>
			<select name="hobby" id="hobby">
				<option value="" disabled selected >취미</option>
				<!-- <option value="NULL">전체</option> -->
				<c:forEach var="hdto" items="${hdto}">
					<option value="${hdto.hobby}">${hdto.hobby}</option>
				</c:forEach>
			</select>
		</div>
		<input type="submit" value="검색">
	</form>

	<div class="partnerBox">
		<c:forEach var="plist" items="${plist}">
		<div>
			<div class="box">
				<span class="seq">${plist.seq}</span> 프로필 이미지 나올곳!!!!!!!!!!(좌측상단)
				${plist.name}, ${plist.age}<br> 아이디 : ${plist.id}<br> 성별 :
				${plist.gender}<br> 이메일 : ${plist.email}<br> 구사 가능한 언어 :
				${plist.lang_can}<br> 배우고 싶은 언어 : ${plist.lang_learn}<br>
				취미 : ${plist.hobby}<br> 자기 소개 : ${plist.introduce}
			</div>
			<div class="button_aa">
				<button class="letter">쪽지</button>
				<button class="chatting" >채팅</button>
				<button class="email_a">이메일</button>
			</div>
		</div>
				<hr>		
		</c:forEach>
	</div>
	<div class="navi">${navi}</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>