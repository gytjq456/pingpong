<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
	<div id="socketAlert" class="alert alert-success" role="alert" style="display:none;"></div>
	<script>
		var socket = null; //전역변수 선언
		$(document).ready(function(){
			connectWS();
		});
		
		function connectWS(){
			var ws = new WebSocket("ws://localhost/websocket/echo");
			socket = ws;
			ws.open = function(message){
				console.log(message);
			};
			ws.onmessage = function(event){
				$("#socketAlert").text(event.data);
				$("#socketAlert").css("display","block");
			};
			ws.onclose = function(event){
				console.log("Server disconnect");
			};
			ws.onerror = function(event){
				console.log("Server Error");
			};
		}
	</script>
	
	<input type="button" id="btnSend" value="Send">
	<input type="text" id="msg" value="test" class="form-control"/>
	
	<script>
		$(document).ready(function(){
			$("#btnSend").on("click",function(evt){
				evt.preventDefault();
				if(socket.redayState != 1) return;
				let msg = $("#msg").val();
				socket.send(msg); // 소켓에 입력된 메시지를 보낸다.
			});
		});
	</script>
	<!-- <section id="notifyWrap">
		<section id="notifyList">
			<div class="notify">알림창</div>
				<div class="review">리뷰</div><hr>
				<div class="groupApply">그룹신청</div><hr>
				<div class="groupOK">그룹승인</div><hr>
				<div class="tutorOK">튜터승인</div><hr>
				<div class="lessonOpen">강의개설</div><hr>
				<div class="correction">첨삭</div><hr>
				<div class="letter">쪽지</div>
		</section>
	</section> -->
	