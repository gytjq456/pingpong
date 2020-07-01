<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<footer>
		<section id="ftTop" class="inner1200">
			<div class="txt">
				<p>상호 : (주)핑퐁<span>|</span> 주소 : 서울특별시 강남구 역삼동 123 - 45<span>|</span>사업자등록번호 : 000-00-00000</p>
				<p>대표자명 : 이효섭<span>|</span>임원 : 김혜선 이재경 채나은 정은하 박선호</p>
				<p>Copyright ⓒ2020 pingpong inc, ltd. All rights reserved</p>
			</div>
			<div class="sns">
				<ul>
					<li><a href="#;" title="페이스북 바로가기"><img src="/resources/img/common/faceBook_icon.png"/></a></li>
					<li><a href="#;" title="인스타그램 바로가기"><img src="/resources/img/common/instagram_icon.png"/></a></li>
					<li><a href="#;" title="유튜브 바로가기"><img src="/resources/img/common/youtube_icon.png"/></a></li>
				</ul>
			</div>
		</section>
	</footer>
	
	
	<!-- <section id="chatWrap">
		<div class="title clearfix">
			<i class="fa fa-users" aria-hidden="true"></i>
			<p>재경, 김혜선, 채나은, 박선호, 정은하, 이효섭<span>6</span><p>
			
		</div>
		<div class="chatBox" id="chatBox">
		
		</div>
		<div class="txtInputBox">
			<div class="txtInput" contenteditable="true">
				
			</div>
			<button type="button" id="transfer">전송</button>
		</div>
	</section>
	
	<script>
		$(function(){
			var ws = new WebSocket("ws://192.168.160.171/chat");
			ws.onmessage = function(e){
				var userTag = "";
				userTag = userTag + "<div class='userInfo_s1 other'>"
				userTag += "<div class='thumb'><img src='/resources/img/sub/userThum.jpg'></div>"
				userTag += "<div class='info'>"
				userTag += "<p class='userId'>홍길동</p>"
				userTag += "</div>"
				userTag += "<div class='chatTxt'><p>"+e.data+"</p><span class='writeDate'>오후 11:34</span></div>"
				userTag += "</div>"				
				$(".chatBox").append(userTag);
				updateScroll();
			}
			
			var txtInput = $(".txtInput")
			$(".txtInput").keydown(function(e){
				if(e.keyCode == 13){
					$("#transfer").click();
					return false;
				}
			})
			
			$("#transfer").click(function(){
				var chatTxt = $(".txtInput").text();
				var userTag = "";
				userTag = userTag + "<div class='userInfo_s1 my'>"
				userTag += "<div class='info'>"
				userTag += "<p class='userId'>홍길동</p>"
				userTag += "</div>"
				userTag += "<div class='thumb'><img src='/resources/img/sub/userThum.jpg'></div>"
				userTag += "<div class='chatTxt'><span class='writeDate'>오후 11:34</span><p>"+chatTxt+"</p></div>"
				userTag += "</div>"
						
				
				$(".chatBox").append(userTag);
				updateScroll();
				txtInput.html("");
				txtInput.focus();
				
				ws.send(chatTxt);
				
				return false;
			})
		})
		
		function updateScroll(){
			var element = document.getElementById("chatBox");
			element.scrollTop = element.scrollHeight;
		}
	</script> -->
	
</body>
</html>