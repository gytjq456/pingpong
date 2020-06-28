<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	$(function(){
		var seq = $('#seq').html();

		$('#delete').on('click', function(){
			var result = confirm('정말 삭제하시겠습니까?');
			if (result) {
				location.href = "/group/delete?seq=" + seq;
			}
		})
		
		$('#update').on('click', function(){
			location.href = "/group/update?seq=" + seq;
		})
		
		var checkLike = ${checkLike};
		
		if (checkLike) {
			$('#like').css('color', 'red');
		}
	})
</script>
</head>
<body>
	<span id="like">따봉</span>
	글번호: <span id="seq">${gdto.seq}</span><br>
	제목: ${gdto.title}<br>
	작성자: ${gdto.writer}<br>
	유형: ${gdto.hobby_type}<br>
	모집 기간: ${gdto.apply_start} ~ ${gdto.apply_end}<br>
	진행 기간: ${gdto.start_date} ~ ${gdto.end_date}<br>
	최대 인원: ${gdto.max_num}<br>
	현재 인원: ${gdto.cur_num}<br>
	장소: ${gdto.location}<br>
	내용: ${gdto.contents}<br>
	작성일: ${gdto.write_date}<br>
	조회수: ${gdto.view_count}<br>
	추천수: <span id="like_count">${gdto.like_count}</span><br>
	신청수: ${gdto.app_count}<br>
	리뷰수: ${gdto.review_count}<br>
	리뷰 포인트: ${gdto.review_point}<br>
	<button type="button" id="update">수정</button>
	<button type="button" id="delete">삭제</button>
	<button type="button" id="applyForm" onclick="javascript:applyPopup()">신청</button>
	<button type="button" id="deleteForm" onclick="javascript:deletePopup()">탈퇴</button>
	<button type="button" id="toList" onclick="javascript:toList()">목록</button>
	<script>
		function applyPopup() {
			var seq = $('#seq').html();
			var url = '/group/applyForm/parent_seq/' + seq;
			var name = 'GroupApply';
			var option = 'width = 500, height = 500, top = 100, left = 200, location = no';
			window.open(url, name, option);
		}
		
		function deletePopup() {
			var seq = $('#seq').html();
			var url = '/group/outForm/parent_seq/' + seq;
			var name = 'GroupOut';
			var option = 'width = 500, height = 500, top = 100, left = 200, location = no';
			window.open(url, name, option);
		}
		
		function toList() {
			location.href = '/group/main';
		}
		
		$('#like').on('click', function(){
			console.log($(this).css('color'));
			if ($(this).css('color') == 'rgb(255, 0, 0)') {
				alert('이미 추천하셨습니다.');
				
				return false;
			}
			
			var seq = $('#seq').html();
			
			$.ajax({
				url: '/group/like',
				data: {'parent_seq': seq},
				type: 'POST'
			}).done(function(resp){
				alert('추천하셨습니다.');
				location.href = '/group/view?seq=' + seq;
			})
		})
	</script>
</body>
</html>