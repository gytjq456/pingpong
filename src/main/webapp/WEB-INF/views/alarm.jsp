<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<style>
	#alarmWrap {width:10%; height:300px;}
</style>
<body>
	<section id="alarmWrap">
		<section id="alarmWindow">
			<div class="alarmTitle">알림</div>
				<div class="alarmList">
					<div class="review">
						리뷰<br>
						<c:out value="${alarmCount}"/>
					</div>
					<div class="groupApply">그룹신청</div>
					<div class="groupOK">그룹승인</div>
					<div class="tutorOK">튜터승인</div>
					<div class="lessonOpen">강의개설</div>
					<div class="correction">첨삭</div>
					<div class="letter">쪽지</div>
				</div>
		</section>
	</section>
	<script>
		
	</script>
</body>	