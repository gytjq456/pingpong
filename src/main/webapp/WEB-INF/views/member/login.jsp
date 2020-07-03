<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>
		<script>		
			$(function(){
				//로그인
				$("#isIdPwSame").on('click',function(){
					var id = $("#id").val();
					var pw = $("#pw").val();
					
					if(id == ""){
						alert("id를 입력해주세요.");
						$("#id").focus();
						return false;
					}else if(pw == ""){
						alert("pw를 입력해주세요.");
						$("#pw").focus();
						return false;
					}
					
					$.ajax({
						type : "post",
						url : "/member/isIdPwSame",
						data : {
							id : $('#id').val(),
							pw : $('#pw').val()
						}
						}).done(function(resp){
							if(resp){
								alert("로그인이 되었습니다.");
								location.href="/";
							}else{
								alert("로그인에 실패하였습니다.");
							}
						}).fail(function(error1, error2){
							alert("관리자에게 문의주세요.")
					});
				});
				
				//id찾기
				$("#idFind").on('click',function(){
					location.href="/member/idFind";
				});
				
				//pw찾기
				$("#pwFind").on('click',function(){
					location.href="/member/pwFind";
				});
				
				//회원가입
				$("#signup").click(function(){
					location.href="/member/joinMail";
				});
			});
			
			
		</script>
		
		<div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
		<section id="subContents">
			<div id="login">
			    <h1 class="h1">login</h1>
	            <input type="text" name="id" id ="id" placeholder="Id"><br>
	            <input type="password" name="pw" id ="pw" placeholder="Password"><br>
	                    
	            <input type="checkbox" name="rememberId" id="rememberId" name="rememberId">
	            <label for="rememberId">아이디 저장하기</label> 
	                   
	            <input type="button" value="Login" id="isIdPwSame">           
	            <input type="button" value="Google" id="google_btn">
	            <input type="button" value="Kakao" id="kakao_btn">

	            <div id="other_text">
	            <a href="#" class="side" id="idFind">id찾기</a>
	            <a href="#" class="side" id="pwFind">비밀번호 찾기</a>
	            <a href="#" class="side" id="signup">회원가입</a></div>
	        </div>
	        </section>
	      </div>
	        
 <jsp:include page="/WEB-INF/views/footer.jsp"/>