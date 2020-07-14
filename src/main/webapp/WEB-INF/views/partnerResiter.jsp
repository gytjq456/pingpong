<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:if test="${sessionScope.loginInfo.grade == 'default'}">
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
								<label for="agree" class="checkLabel"><span></span>프로필 공유 동의</label>
							</li>
						</ul>
						<div class="checkAgree">* 프로필 공유에 동의하지 않으면 신청서 제출이 불가능합니다.</div>
					</div>
					<div class="btnSelect">
						<div class="tit">연락 수단 선택</div>
						<ul class="checkBox_s1">
							<li>
								<input type="checkbox" name="contactList" id="letter" >
								<label for="letter" ><span></span>쪽지</label>
							</li>
							<li>
								<input type="checkbox" name="contactList" id="email" >
								<label for="email" ><span></span>이메일</label>
							</li>
							<li>
								<input type="checkbox" name="contactList" id="chatting" readonly checked>
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
<script>
	$(function(){
		var layerPop_s4 = $("#layerPop_s4");
		$("#popClose").on("click", function(){
			layerPop_s4.stop().fadeOut();
		})
		
		$(".resiterPop").click(function(){
			layerPop_s4.stop().fadeIn();
		})
	})
</script>
</c:if>


