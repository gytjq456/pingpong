<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
	
	<script>
	
	</script>

	<div>
		<section id="subContents">
			<div id="session">	
				<form action="/mypage/partnerRecord" method="post">	
					${mdto.id}<br>
					${mdto.name}<br>
					${mdto.age}<br>
					${mdto.sysname}<br>
				</form>
			</div>
		</section>
	</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>