<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script>
	$(function(){
		var layerPop_s4 = $("#layerPop_s4");
		$("#popClose").on("click", function(){
			layerPop_s4.stop().fadeOut();
			$("input[type='checkbox']").prop("checked", false);
		})
		
		$(document).on("click",".resiterPop", function(){
			if("${sessionScope.loginInfo}" == "" ){
				alert("로그인후 이용이 가능합니다.")
				location.href="/member/login";
			}else{
				if("${sessionScope.loginInfo.grade}" == "partner"){
					alert("이미 등록된  파트너 입니다.")
				}else if("${sessionScope.loginInfo.grade}" == "tutor"){
					alert("튜터는 파트너 신청이 불가능합니다.")
				}else{
					layerPop_s4.stop().fadeIn();
				}
			}
		})
		
		$('#partnerBtn').on('click', function(){				
			var checkboxCount = $("input:checkbox[name='contactList']").length;
			console.log('checkboxCount: ' + checkboxCount)
			var selectedContact = [];
			var agreeChk =$("input:checkbox[name='agree']").prop("checked");
			if(!agreeChk){
				alert("프로필 동의를 해주세요.")
				return false;
			}
			for (var i = 0; i < checkboxCount; i++) {
				var inputChecked = $("input:checkbox[name='contactList']:eq(" + i + ")").prop("checked");
				//var inputChecked = $("input:checkbox[name='contactList']:eq(" + i + ")").is(":checked");
				if (inputChecked) {
					selectedContact.push($("input:checkbox[name='contactList']:eq(" + i + ")").val());
					console.log('selectedContact: ' + selectedContact)
				}
			}
			
			if(!selectedContact.length){
				alert("연락 수단을 선택해 주세요.")
				return false;
			}
			;
			if(!$("#chatting").prop("checked")){
				alert("채팅 항목은 필수입니다.");
				return false;
			}
			
			$("#contact").val(selectedContact);
			$('#partnerRegister').submit();
		})
	})
</script>
<c:if test="${sessionScope.loginInfo.grade != 'partner'}">
<article id="layerPop_s4">
	<div class="pop_body">
		<div class="tit_s3">
			<h3>파트너 등록</h3>
			<p>자신의 프로필을 공유하여 다른 사람들과 소통해보세요.</p>
		</div>
		<form action="/partner/insertPartner" id="partnerRegister" method="post">
			<input type="hidden" name="contact" id="contact">
			<section>
				<article>
					<div>
						<ul class="checkBox_s1">
							<li>
								<input type="checkbox" name="agree" id="agree">
								<label for="agree" class="checkLabel"><span></span>프로필 공유 동의(필수)</label>
							</li>
						</ul>
						<div class="checkAgree">* 프로필 공유에 동의하지 않으면 신청서 제출이 불가능합니다.</div>
					</div>
					<div class="btnSelect">
						<div class="tit">연락 수단 선택</div>
						<ul class="checkBox_s1">
							<li>
								<input type="checkbox" name="contactList" value="쪽지" id="letter" >
								<label for="letter" ><span></span>쪽지</label>
							</li>
							<li>
								<input type="checkbox" name="contactList" value="이메일" id="email" >
								<label for="email" ><span></span>이메일</label>
							</li>
							<li>
								<input type="checkbox" name="contactList" value="채팅" id="chatting" >
								<label for="chatting" ><span></span>채팅(필수)</label>
							</li>
						</ul>
					</div>
					<div class="btns_s3">
						<p><button type="button" id="partnerBtn">등록</button></p>
						<p><input type="button" id="popClose" value="닫기"></p>
					</div>
				</article>
			</section>
		</form>
	</div>
</article>
</c:if>


