<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>
		<script>
			$("#isIdPwSames").submit(function(){
				location.href="/member/isIdPwSame";
			});
			
			$(function(){
				$("#signup").click(function(){
					location.href="/member/signup";
				});
			});
		</script>
		
		<div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
		<section id="subContents">
			<div id="login">
			    <h1 class="h1">login</h1>
	            <form action="isIdPwSame" method="post" id="isIdPwSame">
	                <input type="text" name="id" id ="id" placeholder="Id"><br>
	                <input type="password" name="pw" id ="pw" placeholder="Password"><br>
	                    
	                <input type="checkbox" name="rememberId" id="rememberId" name="rememberId">
					<label for="rememberId">아이디 저장하기</label> 
	                   
	                <input type="submit" value="Login" id="login_btn">           
	                <input type="button" value="Google" id="google_btn">
	                <input type="button" value="Kakao" id="kakao_btn">
	            </form>
	            <div id="other_text">
	            <a href="#" class="side" id="idFind">id찾기</a>
	            <a href="#" class="side" id="pwFind">비밀번호 찾기</a>
	            <a href="#" class="side" id="signup">회원가입</a></div>
	        </div>
	        </section>
	      </div>
	        
 <jsp:include page="/WEB-INF/views/footer.jsp"/>