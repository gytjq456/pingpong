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
				<p></p>
				<span></span>
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
			var timeResult = "";
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
			var chatRoom;
			$(document).on("click",".chatting",function(){
				var uid = $(this).data("uid");
				var uname = $(this).data("name");
				if(uid == "${sessionScope.loginInfo.id}"){
					alert("나와의 채팅은 불가능 합니다.");
					return false;
				}
				
				if("${sessionScope.loginInfo}" == ""){
					alert("로그인후 이용이 가능합니다.")
					location.href="/member/login";
					return false;
				}else{
					$.ajax({
						url:"/chatting/create",
						type:"post",
						//dataType:"json",
						data:{
							chatMemberId:uid,
							users:uname
						}
					}).done(function(resp){
						console.log(resp)
						console.log(resp.length)
						if(resp.length == 10){
							chatRoom = resp;
						}else{
							var data = JSON.parse(resp);
							console.log(data)
							chatRoom = data[0].roomId;
							for(var i=0; i<data.length; i++){
								var userTag = "";
								if(data[i].sendUser == "${sessionScope.loginInfo.name}"){
									var userTag = "";
									userTag = userTag + "<div class='userInfo_s1 my'>"
									userTag += "<div class='info'>"
									userTag += "<p class='userId'>"+data[i].sendUser+"</p>"
									userTag += "</div>"
									userTag += "<div class='thumb'><img src='/resources/img/sub/userThum.jpg'></div>"
									userTag += "<div class='chatTxt'><span class='writeDate'>"+data[i].writeDate+"</span><p>"+data[i].chatRecord+"</p></div>"
									userTag += "</div>"	
									$(".chatBox").append(userTag);	
								}else{
									userTag = userTag + "<div class='userInfo_s1 other'>"
									userTag += "<div class='thumb'><img src='/resources/img/sub/userThum.jpg'></div>"
									userTag += "<div class='info'>"
									userTag += "<p class='userId'>"+data[i].sendUser+"</p>"
									userTag += "</div>"
									//userTag += "<div class='chatTxt'><p>"+msg.text+"</p><span class='writeDate'>"+msg.date+"</span></div>"
									userTag += "<div class='chatTxt'><p>"+data[i].chatRecord+"</p><span class='writeDate'>"+data[i].writeDate+"</span></div>"
									userTag += "</div>"				
									$(".chatBox").append(userTag);								
								}
							}
							updateScroll();
						}
						$("#chatRoom").addClass("on");
						var chatWrap = $("#chatWrap");
						chatWrap.find(".title p").prepend("${sessionScope.loginInfo.id},"+uid);
						var member = chatWrap.find(".title p").text().split(",");
						chatWrap.find(".title span").text(member.length);
						
						
					}).fail(function(){
						alert("error")
					})
					
					var ws = new WebSocket("ws://localhost/chat");
					ws.onmessage = function(e){
						var msg = JSON.parse(event.data);
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
				
				$(".txtInput").keyup(function(e){
					if(e.keyCode == 13){
						$("#transfer").click();
						return false;
					}
				})
				$("#transfer").click(function(){
					var txtInput = $(".txtInput")
					
					var toTime = new Date();
					var today = toTime.getDay();
					var theYear = toTime.getFullYear();
					var theMonth = toTime.getMonth();
					var theDate = toTime.getDate();
					var theHours = toTime.getHours();
					var theMinutes = toTime.getMinutes();
					var theSeconds = toTime.getSeconds();
					var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
					var todayLabel = week[today];
					
					if(theMinutes < 10){
						theMinutes = "0"+theMinutes
					}
					
					if(theHours > 12){
						timeResult = "("+todayLabel+")오후" + theHours+":"+theMinutes
					}else{
						timeResult = "("+todayLabel+")오전" + theHours+":"+theMinutes
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
				})
			});
			
				
			
		})
		
	
		
		function updateScroll(){
			var element = document.getElementById("chatBox");
			element.scrollTop = element.scrollHeight;
		}
	</script>