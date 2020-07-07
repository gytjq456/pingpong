<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<div id="" class="emailPop">
		<h2>이메일 보내기</h2>
		<form id="emailForm"> 
		<!-- post방식으로 자료를 컨트롤러로 보냄 -->
			<input type="hidden" name="seq" value="${pdto.seq}">
			받는 사람  : <input name="name" value="${pdto.name}"><br>
			발신자 이메일 : <input name="memail" value="${loginInfo.email}"><br>
			이메일 비밀번호 : <input type="password" name="emailPassword"><br>
			수신자 이메일 : <input name="email" value="${pdto.email}"><br>
			제목 : <input name="subject"><br>
			내용 : <textarea rows="5" cols="80" name="contents"></textarea><br>
			<input type="submit" value="전송" id="send">
		</form>
	</div>
 	<script>
 		$(function(){
			 $("#emailForm").on("submit",function(){
				 alert("이메일")
				 var formData = new FormData($("#emailForm")[0]);
				$.ajax({
					url:"/partner/send",
					data:formData,
					type:"post",
					dataType:"json",
					cache:false,
					contentType:false,
					processData:false
				}).done(function(resp){
					alert("test :" + resp)
				})
				return false;
			})
 		})
	</script>
