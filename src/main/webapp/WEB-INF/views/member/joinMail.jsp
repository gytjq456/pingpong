<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
	
	$(function(){
		
		var emailRegex = /^[a-z A-Z 0-9]+@[a-z]+\.[a-z]{2,6}$/g;
		var userMailSend = $("#userMailSend");
		var sendEmailCode = "";
		var code = $("#code").val();
		var tid;
		var time = 10;
		
		//체크박스
		var ckbox1 = $("input:checkbox[name=ckbox1]");
		var ckIsNull = ckbox1.is(":checked") == true;
		var count = $('input:checkbox[name=ckbox1]:checked').length;
		
		function setTimer(){
			tid = setInterval(function(){
				time--;
				timer(time)
			},1000);
		}
		
		function timer(seconds) {
            var hour, min, sec
            hour = parseInt(seconds/3600);
            min = parseInt((seconds%3600)/60);
            sec = seconds%60;

            if (hour.toString().length==1) {
               hour = "0" + hour;   
            }
            if(min.toString().length==1){
               min = "0" + min;
            }
            if(sec.toString().length==1){
               sec = "0" + sec;
            }
            var m = min + ":" + sec; 
            $("#timer").html(m);
            if(min == 0 && sec == 0){
               clearInterval(tid);
               authKey = "";
            }
         }
		
		//인증번호 발송
		$("#sendEmail").on("click",function(){
			var result_email = emailRegex.test(userMailSend.val());

			if(userMailSend.val() == "" || result_email == false){
				alert("이메일을 입력해주세요.");
				userMailSend.focus();
				return false;
			}else{
				$.ajax({
					url :"/member/joinSendMail",
					type : "post",
					data : {
						"userMailSend" : userMailSend.val()
					}
				}).done(function(resp){					
					alert(resp + "인증번호가 발송되었습니다.");
					sendEmailCode = resp;
					console.log(sendEmailCode + "코드");
					clearInterval(tid);
					time = 10;
					setTimer();
					
				}).fail(function(error1, error2){
					alert("인증번호 발송이 실패하였습니다.");
				});
			}			
		});	
		
		//인증번호 비교
		$("#code").keyup(function(){			
			code = $("#code").val();
			
			if(sendEmailCode == code){
				$("#codeCk").text("인증번호가 일치합니다.");
				clearInterval(tid);
			}else{
				$("#codeCk").text("인증번호가 불일치합니다.");
				clearInterval(tid);
				setTimer();
			}
		});
		
		//다음버튼을 눌렀을 때 
		$("#join").on("click", function(){
			if(userMailSend.val() == "" || code == ""){
				alert("이메일과 인증번호가 입력 되어 있어야 합니다.");
				return false;
			}else{
				if(sendEmailCode == code){
					location.href= "/member/join?mail="+ userMailSend.val();
				}else{
					alert("인증번호가 불일치합니다.");
					$("#codeCk").focus();
					return false;
				}
			}
			return false;
		});
	});
</script>

<div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
	<section id="subContents">
		<div id="loginMail">
			<h1 class="h1">이메일 인증</h1>
			<div id="joinSendMail">
				<div>
					<input type="text" id="userMailSend" name="userMailSend" placeholder="이메일을 입력해주세요"><br>
					<button type="button" id="sendEmail" name="sendEmail">인증번호받기</button>
					<dl>
						<dt>인증번호</dt>
						<dd>
							<input type="text" id="code" name="code" placeholder="인증번호 입력해주세요">
							<span id="timer"></span>
							<span id="codeCk"></span>
						</dd>
					</dl>
				</div>
				<br>
				<div class="joinbox">
					<h3>이용약관</h3>
					<div class="text01">
						<div style="border:1px solid #ddd;">
							하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하
						</div>
						<input type="checkbox" name="ckbox1" value="ckbox1" id="ckbox1"/>
						<label for="ckbox1" >이용약관 동의</label>
					</div>					
				</div>
				<br>
				<div class="joinbox">
					<h3>개인정보 수집 및 이용동의</h3>
					<div class="text01">
						<div style="border:1px solid #ddd;">
							하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하
						</div>
						<input type="checkbox" name="ckbox2" value="ckbox2" id="ckbox2"/>
						<label for="ckbox2">개인정보 수집 및 이용에 동의합니다.</label>
					</div>					
				</div>
				<br>
				<button type="button" id="join" name="join">다음</button>
			</div>
		</div>
	</section>
</div>


<jsp:include page="/WEB-INF/views/footer.jsp" />