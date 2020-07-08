<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
	<section id="chatWrap">
		<section id="chatList">
			<div class="tit">채팅</div>
			<c:choose>
				<c:when test="${sessionScope.loginInfo.grade eq 'partner'}">
				<div class="list">
					<ul>
					
					</ul>
				</div>
				</c:when>
				<c:otherwise>
				<div class="noList">
					<p>서비스 정책에 따라 채팅기능은 일반 회원은 사용이 불가능 합니다. 파트너 등록을 하시면 서비스 이용이 가능합니다.</p>
					<div><a href="">파트너 등록</a></div>
				</div>
				</c:otherwise> 
			</c:choose>
		</section>	
		<div id="chatRoom">
			<div class="top"><button id="close"><i class="fa fa-angle-left" aria-hidden="true"></i></button></div>
			<div class="title clearfix">
				<i class="fa fa-users" aria-hidden="true"></i>
				<p></p>
				<span></span>
			</div>
			<div class="chatBox" id="chatBox">
				<div class="sysdate"></div>
				<div class="txtRow"></div>
			</div>
			<div class="txtInputBox">
				<div class="txtInput" contenteditable="true">
					
				</div>
				<button type="button" id="transfer">전송</button>
			</div>
		</div>
		<div id="chatClose"><button type="button"><i class="fa fa-times" aria-hidden="true"></i></button></div>
	</section>
	
	<script>
		$(function(){
			var timeResult = "";
			$.ajax({
				url:"/member/personList",
				type:"post",
				dataType:"json",
				data:{
					type:"partner"
				},
			}).done(function(resp){
				console.log(resp)
				for(var i=0; i<resp.length; i++){
					if("${sessionScope.loginInfo.name}"!= resp[i].name){
						var chatList = $("#chatList");
						var userTag = $("<li>");
						var userInfo_s1 = $("<div class='userInfo_s1'>");
						var info = $("<div class='info'>"); 
						userInfo_s1.append("<div class='thumb'><img src='/resources/img/sub/userThum.jpg'>")
						userInfo_s1.append("<div class='info'><p class='userId'>"+resp[i].name+"</p>")
						userInfo_s1.append("<button data-uid="+resp[i].id+" data-name="+resp[i].name+" class='chatting'>채팅</button>")
						userTag.append(userInfo_s1);
						chatList.find(".list ul").append(userTag);
					}
				};
			})
			// 채팅 
			var chatRoom;
			var txtInput = $(".txtInput")
			var toTime = new Date();
			var today = toTime.getDay();
			var theYear = toTime.getFullYear();
			var theMonth = toTime.getMonth()+1;
			var theDate = toTime.getDate();
			var theHours = toTime.getHours();
			var theMinutes = toTime.getMinutes();
			var theSeconds = toTime.getSeconds();
			var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
			var todayLabel = week[today];	
			if(theMonth < 10){
				theMonth = '0' + theMonth
			}
			if(theDate < 10){
				theDate = '0' + theDate
			}			
			var uid = "";
			
			
			if("${sessionScope.loginInfo.id}" != ""){
				//var ws  =new WebSocket("ws://localhost/chat");
				var ws  =new WebSocket("ws://192.168.60.58/chat");
				ws.onopen = function(){
					var msg = {
						type:"login",
						userid:"${sessionScope.loginInfo.id}",
						userName:"${sessionScope.loginInfo.name}",
						targetId:uid
					}
					ws.send(JSON.stringify(msg));
				}
				
				$(document).on("click",".chatting",function(){
					$(this).closest(".addMsg").removeClass("addMsg");
					if(!$(this).closest("li").hasClass("on")){
						alert("로그아웃된 파트너 입니다.")
						return false;
					}					
					uid = $(this).data("uid");
					var uname = $(this).data("name");
					$.ajax({
						url:"/chatting/create",
						type:"post",
						dataType:"json",
						data:{
							chatMemberId:uid,
							users:uname
						}
					}).done(function(resp){
						// 채팅방 열림
						$("#chatRoom").addClass("on");
						var chatWrap = $("#chatWrap");
						chatWrap.find(".title p").text("${sessionScope.loginInfo.name},"+uname);
						var member = chatWrap.find(".title p").text().split(",");
						chatWrap.find(".title span").text(member.length);
						txtInput.focus();
						console.log(typeof resp)
						if(typeof resp == 'string'){
							chatRoom = resp
							$(".chatBox .sysdate").html(theYear+"년 "+theMonth+"월 "+theDate+"일 "+todayLabel);
						}else{
							console.log(resp);
							var record = resp;
							chatRoom = record[0].roomId;
							$(".chatBox .sysdate").html(record[0].realWriteDate);
							$(".chatBox .txtRow").html("");
							var userTag;
							//console.log(record.length)
							 for(var i=0; i<record.length; i++){
								if(record[i].sendUser == "${sessionScope.loginInfo.name}"){
									var userInfo_s1 = $("<div class='userInfo_s1 my'>");
									var info = $("<div class='info'>"); 
									userInfo_s1.append("<div class='info'><p class='userId'>"+record[i].sendUser+"</p>")
									userInfo_s1.append("<div class='thumb'><img src='/resources/img/sub/userThum.jpg'>")
									userInfo_s1.append("<div class='chatTxt'><span class='writeDate'>"+record[i].writeDate+"</span><p>"+record[i].chatRecord+"</p>")
									//userTag.append(userInfo_s1);
									$(".chatBox .txtRow").append(userInfo_s1);	
								}else{
									var userInfo_s1 = $("<div class='userInfo_s1 other'>");
									userInfo_s1.append("<div class='thumb'><img src='/resources/img/sub/userThum.jpg'>")
									userInfo_s1.append("<div class='info'><p class='userId'>"+record[i].sendUser+"</p>")
									userInfo_s1.append("<div class='chatTxt'><p>"+record[i].chatRecord+"</p><span class='writeDate'>"+record[i].writeDate+"</span>")
									//userTag.append(userInfo_s1);
									$(".chatBox .txtRow").append(userInfo_s1);								
								}
							}
							updateScroll();
						}
						var msg = {
							chatRoom : chatRoom,
							type:"register",
							userid:"${sessionScope.loginInfo.id}",
							userName:"${sessionScope.loginInfo.name}",
							targetId:uid
						}
						ws.send(JSON.stringify(msg));
					}).fail(function(){
						alert("error")
					})
				})
				
				ws.onmessage = function(e){
					console.log("tttt ===" + e.data);
					var msg = JSON.parse(e.data);
					var time = new Date(msg.date);
					var timeStr = time.toLocaleTimeString();
					
					
					for(var i=0; i<msg.length; i++){
						if(msg[i].type == "login"){
							var chatList = $("#chatList .list ul li");
							chatList.each(function(){
								var idx = $(this).index();
								if(chatList.eq(idx).find("button").data("uid") == msg[i].userid){
									$(this).addClass("on");
								}
							})
						}
					}
					if(msg.type == "logout"){
						var chatList = $("#chatList .list ul li");
						chatList.each(function(){
							if(msg.userid == $(this).find("button").data("uid")){
								$(this).removeClass("on");
							}
						})
						ws.onclose = function(){
							var msg = {
								type:"logout==",
								userid:"${sessionScope.loginInfo.id}",
								userName:"${sessionScope.loginInfo.name}",
								targetId:uid
							}
							ws.send(JSON.stringify(msg));
						}
					}
					if(msg.type == "message"){
						var userInfo_s1 = $("<div class='userInfo_s1 other'>");
						userInfo_s1.append("<div class='thumb'><img src='/resources/img/sub/userThum.jpg'>")
						userInfo_s1.append("<div class='info'><p class='userId'>2222"+msg.userName+"</p>")
						userInfo_s1.append("<div class='chatTxt'><p>"+msg.text+"</p><span class='writeDate'>"+msg.date+"</span></div>")
						$(".chatBox .txtRow").append(userInfo_s1);
						var rightPos = $("#chatWrap #chatRoom").css("right").replace(/[^-\d\.]/g, '');
						if(rightPos < 0){
							$("#chatList .list ul li").each(function(){
								var uid = $(this).find("button").data("uid")
								if(uid == msg.userid){
									$(this).addClass("addMsg");
								}
							})
						}
						updateScroll();
					}
					
				}
				$("#chatWrap #close").click(function(){
					$("#chatRoom").removeClass("on");
					$("#chatBox .txtRow").html("");
				})
				txtInput.keyup(function(e){
					if(e.keyCode == 13){
						$("#transfer").click();
						return false;
					}
				})
				$("#transfer").click(function(){
					
					if(theMinutes < 10){
						theMinutes = "0"+theMinutes
					}
					
					if(theHours > 12){
						timeResult = "오후 " + theHours+":"+theMinutes
					}else{
						timeResult = "오전 " + theHours+":"+theMinutes
					}
	
					var chatTxt = txtInput.text();
					var userInfo_s1 = $("<div class='userInfo_s1 my'>");
					userInfo_s1.append("<div class='info'><p class='userId'>${sessionScope.loginInfo.name}</p>")
					userInfo_s1.append("<div class='thumb'><img src='/resources/img/sub/userThum.jpg'>")
					userInfo_s1.append("<div class='chatTxt'><span class='writeDate'>"+timeResult+"</span><p>"+chatTxt+"</p>")
					
					var msg = {
						chatRoom : chatRoom,
						type: "message",
						text: chatTxt,
						userid:"${sessionScope.loginInfo.id}",
						userName:"${sessionScope.loginInfo.name}",
						date: timeResult,
						targetId:uid
					};
					
					$(".chatBox .txtRow").append(userInfo_s1);
					updateScroll();
					txtInput.html("");
					txtInput.focus();
					
					ws.send(JSON.stringify(msg));	
				})
			
			
			}
			
		})
		
	
		
		function updateScroll(){
			var element = document.getElementById("chatBox");
			element.scrollTop = element.scrollHeight;
		}
	</script>