<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<footer>
		<section id="ftTop" class="inner1200">
			<div class="txt">
				<p>상호 : (주)핑퐁<span class="br_480">|</span> 주소 : 서울특별시 강남구 역삼동 123 - 45<span class="br_767">|</span>사업자등록번호 : 000-00-00000</p>
				<p>대표자명 : 이효섭<span class="br_480">|</span>임원 : 김혜선 이재경 채나은 정은하 박선호</p>
				<p>Copyright ⓒ2020 pingpong inc, ltd. All rights reserved</p>
			</div>
			<div class="sns">
				<ul>
					<li><a href="#;" onclick="alert('준비중 입니다.');return false;" title="페이스북 바로가기"><img src="/resources/img/common/faceBook_icon.png"/></a></li>
					<li><a href="#;" onclick="alert('준비중 입니다.');return false;" title="인스타그램 바로가기"><img src="/resources/img/common/instagram_icon.png"/></a></li>
					<li><a href="#;" onclick="alert('준비중 입니다.');return false;" title="유튜브 바로가기"><img src="/resources/img/common/youtube_icon.png"/></a></li>
				</ul>
			</div>
		</section>
	</footer>

	<div id="chatOpenBtn"><button>채팅</button></div>
	<jsp:include page="chat.jsp"/>	
	<jsp:include page="partnerResiter.jsp"/>	
	
	
</body>
</html>