<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/resources/admin/style.css"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="/resources/js/slick.min.js"></script>
<script src="/resources/js/common.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
</head>
	<body>
		<c:if test="${!empty sessionScope.adminLog}">
			<header>
			<div id="header_opt">
				<ul class="clearfix">
					<li>
						<a href="/admin/logout">로그아웃</a><br>
					</li>
					<li>
						<a href="/admin">관리자 메인</a><br>
					</li>
					<li>
						<a href="/">핑퐁 메인</a>
					</li>
				</ul>
			</div>
			<section id="ahdBot">
				<div class="inner1200 clearfix">
					<nav>
						<div class="menu_wrap">
							<ul class="clearfix gnb">
								<li>
									<a href="/admins/memberList">회원 관리</a>
									<ul class="gnb_sub">
										<li><a href="/admins/memberList">회원</a></li>
										<li><a href="/admins/blacklistList">블랙리스트</a></li>
									</ul>
								</li>
								<li>
									<a href="/admins/partnerList">파트너 관리</a>
								</li>												
								<li>
									<a href="/admins/groupList">그룹 관리</a>
								</li>												
								<li>
									<a href="/admins/tutorList">튜터 관리</a>
									<ul class="gnb_sub">
										<li><a href="/admins/tutorList">튜터</a></li>
										<li><a href="/admins/tutorAppList">튜터 신청</a></li>
										<li><a href="/admins/lessonList">강의</a></li>
										<li><a href="/admins/lessonAppList">강의 개설 신청</a></li>
										<li><a href="/admins/lessonDelList">강의 삭제 신청</a></li>
										<li><a href="/admins/tuteeList">튜티</a></li>
										<li><a href="/admins/refundList">강의 환불 신청</a></li>
									</ul>
								</li>												
								<li>
									<a href="/admins/discussionList">게시판 관리</a>
									<ul class="gnb_sub">
										<li><a href="/admins/discussionList">토론</a></li>
										<li><a href="/admins/correctList">첨삭</a></li>
										<li><a href="/admins/newsList">소식통</a></li>
									</ul>
								</li>
								<li>
									<a href="/admins/reportList">신고 관리</a>
								</li>
							</ul>
						</div>
					</nav>
				</div>
			</section>
			
		</header>
	</c:if>