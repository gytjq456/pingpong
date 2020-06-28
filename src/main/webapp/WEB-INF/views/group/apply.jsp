<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
	#contents{width: 450px; height: 350px;}
</style>
<script>
	$(function(){
		var parent_seq = ${parent_seq}
		$('#parent_seq').val(parent_seq);
		
		$('#contents').focusin(function(){
			var agree = $('#agree').is(':checked');
			if (!agree) {
				alert('프로필 공유에 동의해 주세요.');
				$('#agree').focus();
			}
		})
	})
</script>
</head>
<body>
	<h3>그룹 참가 신청서</h3>
	<input type="checkbox" id="agree" required><label for="agree">프로필 공유 동의</label><br>
	* 프로필 공유에 동의하지 않으면 신청서 제출이 불가능합니다.<br>
	가입 이유/포부<br>
	<input type="text" name="parent_seq" id="parent_seq">
	<textarea name="contents" id="contents"></textarea>
	<button type="button" id="apply">제출</button>
	<button type="button" id="back">닫기</button>
	<script>
		$('#apply').on('click', function(){
			var parent_seq = $('#parent_seq').val();
			console.log(parent_seq)
			var contents = $('#contents').val();
			$.ajax({
				url: "/group/apply",
				data: {'parent_seq': parent_seq, 'contents': contents},
				type: "POST"
			}).done(function(resp){
				if (resp) {
					alert('성공적으로 신청되었습니다.');
					self.opener = self;
					self.close();
				} else {
					alert('신청에 실패하였습니다. 잠시 후 다시 시도해 주세요.');
				}
			})
		})
		
		$('#back').on('click', function(){
			self.opener = self;
			self.close();
		})
	</script>
</body>
</html>