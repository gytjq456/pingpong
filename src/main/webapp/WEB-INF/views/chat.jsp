<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<section id="chatWrap">
		<section id="chatList">
			<div class="tit">채팅</div>
			<div class="list">
				<ul>
				
				</ul>
			</div>
		</section>	
		<div id="chatRoom">
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
		</div>
	</section>
	
	<script>
		$(function(){
			$.ajax({
				url:"/partner/chatPartner",
				data:"post",
				dataType:"json"
			}).done(function(resp){
				console.log(resp)
				for(var i=0; i<resp.length; i++){
					var userTag = "";
					userTag = "<li>"
					userTag += "<div class='userInfo_s1'>"
					userTag += "<div class='thumb'><img src='/resources/img/sub/userThum.jpg'></div>"
					userTag += "<div class='info'>"
					userTag += "<p class='userId'>"+resp[i].name+"</p>"
					userTag += "</div>"
					userTag += "<button data-uid="+resp[i].id+" data-name="+resp[i].name+" class='chatting'>채팅</button>"
					userTag += "</div>"						
					
					var chatList = $("#chatList");
					chatList.find(".list ul").append(userTag);
					
					
				};
			})
			// 채팅 
			var ws;
			var chatRoom;
			$(document).on("click",".chatting",function(){
				var uid = $(this).data("uid");
				var uname = $(this).data("name");
				if("${sessionScope.loginInfo}" == ""){
					alert("로그인후 이용이 가능합니다.")
					location.href="/member/login";
					return false;
				}else{
					ws = new WebSocket("ws://localhost/chat");
					//ws = new WebSocket("ws://192.168.60.58/chat");
					$.ajax({
						url:"/chatting/create",
						type:"post",
						//dataType:"json",
						data:{
							userId:uid,
							userName:uname
						}
					}).done(function(resp){
						chatRoom = resp;
						console.log(resp);
						if(resp == ""){
							alert("채팅방 생성");
						}else{
							alert("채팅방 존재")
						}
						$("#chatRoom").addClass("on");
					}).fail(function(){
						alert("error")
					})
					
					ws.onmessage = function(e){
						var msg = JSON.parse(event.data);
						console.log("msg :" + msg)
						console.log("msg :" + msg.chatRoom)
						var time = new Date(msg.date);
						var timeStr = time.toLocaleTimeString();
						
						var userTag = "";
						userTag = userTag + "<div class='userInfo_s1 other'>"
						userTag += "<div class='thumb'><img src='/resources/img/sub/userThum.jpg'></div>"
						userTag += "<div class='info'>"
						userTag += "<p class='userId'>"+msg.id+"</p>"
						userTag += "</div>"
						//userTag += "<div class='chatTxt'><p>"+msg.text+"</p><span class='writeDate'>"+msg.date+"</span></div>"
						userTag += "<div class='chatTxt'><p>"+msg.text+"</p><span class='writeDate'>"+msg.date+"</span></div>"
						userTag += "</div>"				
						$(".chatBox").append(userTag);
						updateScroll();
					}	
					
				}
				
			});
			
			
			//var ws = new WebSocket("ws://192.168.60.58/chat");
			$(".txtInput").keydown(function(e){
				if(e.keyCode == 13){
					$("#transfer").click();
					return false;
				}
			})
			$("#transfer").click(function(){
				
				
				var txtInput = $(".txtInput")
				var toTime = new Date();
				var theYear = toTime.getFullYear();
				var theMonth = toTime.getMonth();
				var theDate = toTime.getDate();
				var theHours = toTime.getHours();
				var theMinutes = toTime.getMinutes();
				var theSeconds = toTime.getSeconds();
				var timeResult = "";
				if(theMinutes < 10){
					theMinutes = "0"+theMinutes
				}
				
				if(theHours > 12){
					timeResult = "오후" + theHours+":"+theMinutes
				}else{
					timeResult = "오전" + theHours+":"+theMinutes
				}

				var chatTxt = $(".txtInput").text();
				var userTag = "";
				userTag = userTag + "<div class='userInfo_s1 my'>"
				userTag += "<div class='info'>"
				userTag += "<p class='userId'>${sessionScope.loginInfo.name}</p>"
				userTag += "</div>"
				userTag += "<div class='thumb'><img src='/resources/img/sub/userThum.jpg'></div>"
				userTag += "<div class='chatTxt'><span class='writeDate'>"+timeResult+"</span><p>"+chatTxt+"</p></div>"
				userTag += "</div>"
				
				
				var msg = {
					chatRoom : chatRoom,
					type: "message",
					text: chatTxt,
					id:   "${sessionScope.loginInfo.name}",
					date: timeResult
				};
				
				$(".chatBox").append(userTag);
				updateScroll();
				txtInput.html("");
				txtInput.focus();
				
				ws.send(JSON.stringify(msg));
				
				return false;
			})
		})
		
		function updateScroll(){
			var element = document.getElementById("chatBox");
			element.scrollTop = element.scrollHeight;
		}
	</script>