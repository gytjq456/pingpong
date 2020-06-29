<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>
	
	<style>
		
	</style>

	<div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
		<section id="subContents">
			<div id="loginMail">
			    <h1 class="h1">이메일 인증</h1>
	            <form action="loginMail" method="post" id="loginMail">
	            	<div>
	            		<input type="text" id="email" name="email">
	            		<button type="button" id="sendEmail" name="sendEmail">
	            			인증코드
	            		</button>
	            	</div>
	            </form>
	        </div>
	    </section>
	</div>
	            

<jsp:include page="/WEB-INF/views/footer.jsp"/>