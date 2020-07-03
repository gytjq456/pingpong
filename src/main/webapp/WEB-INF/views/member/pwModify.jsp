<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
	$(function(){
		//비밀번호 일치
		$("#pw_ck").on("keyup",function(){
			var pwResult1 = $("#pw").val();
			var pwResult2 = $("#pw_ck").val();
			if(pwResult1 == pwResult2){
				$("#pwConfrom").text("비밀번호가 일치합니다.");				
			}else{
				$("#pwConfrom").text("비밀번호 일치 하지 않습니다.");
				return false
			}
		});
		
		$("#pwModify").submit(function(){
			var f_id = $("#id");
			var f_name = $("#name");
			var f_email = $("#email");
			var f_pw = $("#pw");
			var f_pw_ck = $("#pw_ck");
			
			//비밀번호		
			var regexPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/g;
			var result_pw = regexPw.test(f_pw.val());
			if(!result_pw){
				alert("비밀번호 : 최소 8글자, 숫자, 특수문자를 넣어주세요.");
				f_pw.focus();
				return false;
			}
			
			//비밀번호 값 안넣었을 때
			if(f_pw.val() == ""){
				alert("비밀번호를 입력해주세요");
				f_pw.focus();
				return false;
			}else if(f_pw_ck.val() == ""){
				alert("비밀번호 확인을 입력해주세요");
				f_pw_ck.focus();
				return false;
			}else if(!(f_pw.val() == f_pw_ck.val())){
				alert("비밀번호가 일치 하지 않습니다.");
				f_pw_ck.focus();
				return false;
			};	
						
			$.ajax({
				url : "/member/pwModifyProc",
				type : "post",
				data : {
					id : f_id.val(),
					name : f_name.val(),
					email : f_email.val(),
					pw : f_pw.val()
				}
			}).done(function(resp){
				alert("비밀번호 수정이 성공하였습니다. 로그인을 진행해주세요.");
				location.href="/member/login";
				
			}).fail(function(error1, error2){
				alert(" :: 실패");
				console.log(error1);
				console.log(error2);
				return false;
			});
			
			return false;
		});
	});
</script>

<div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
		<section id="subContents">
			<div id="join">
				<form id="pwModify">
					<input type="hidden" name="id" id="id" value="${mdto.id}">
					<input type="hidden" name="name" id="name" value="${mdto.name}">
					<input type="hidden" name="email" id="email" value="${mdto.email}">
					<div><input type="password" id="pw" name="pw" placeholder="수정할 비밀번호를 입력해주세요"></div>
					<div><input type="password" id="pw_ck" name="pw_ck" placeholder="수정할 비밀번호를 재입력해주세요"></div>				
					<div id="pwConfrom">ㅇㅇ</div>
					<div><input type="submit" id="submitBtn"></div>
				</form>
			</div>
		</section>
</div>

<!--  
<jsp:include page="/WEB-INF/views/footer.jsp" />-->