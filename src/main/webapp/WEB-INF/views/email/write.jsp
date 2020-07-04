<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<title>Insert title here</title>
</head>
<body>
	<h2>이메일 보내기</h2>
	<form method="post" action="/partner/send"> 
	<!-- post방식으로 자료를 컨트롤러로 보냄 -->
		<input type="hidden" name="seq" value="${pdto.seq}">
		받는 사람  : <input name="senderName" value=${pdto.name}><br>
		발신자 이메일 : <input name="memail" value="${loginInfo.email}"><br>
		이메일 비밀번호 : <input type="password" name="emailPassword"><br>
		수신자 이메일 : <input name="pemail" value=${pdto.email}><br>
		제목 : <input name="subject"><br>
		내용 : <textarea rows="5" cols="80" name="message"></textarea><br>
		<input type="submit" value="전송" id="send">
	</form>
	<script>
		$("#send").on("click",function(){
			alert('이메일 전송이 완료되었습니다.');
			window.close();
		})
	</script>
</body>

</html>