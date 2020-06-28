<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>

	<div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
		<section id="subContents">
			<div id="session">	
				<form action="/member/memberSelect" method="post">	
					${mdto.id}<br>
					${mdto.name}<br>
					${mdto.age}<br>
					${mdto.sysname}<br>
					<img src ="/upload/member/${mdto.id}/${mdto.sysname}">
				</form>
			</div>
		</section>
	</div>
		
<jsp:include page="/WEB-INF/views/footer.jsp"/>