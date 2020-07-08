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
		<header>
		<section id="ahdBot">
			<div class="inner1200 clearfix">
				<nav>
					<div>
						<ul class="clearfix gnb">
							<li>
								<a href="#;">회원 관리</a>
								<ul>
									<li><a href="/admin/memberList">회원</a></li>
									<li><a href="/admin/blacklistList">블랙리스트</a></li>
								</ul>
							</li>
							<li>
								<a href="/admin/partnerList">파트너 관리</a>
							</li>												
							<li>
								<a href="/admin/groupList">그룹 관리</a>
							</li>												
							<li>
								<a href="#;">튜터 관리</a>
								<ul>
									<li><a href="/admin/tutorList">튜터</a></li>
									<li><a href="/admin/tutorAppList">튜터 신청</a></li>
									<li><a href="/admin/lessonList">강의</a></li>
									<li><a href="/admin/lessonAppList">강의 신청</a></li>
									<li><a href="/admin/lessonDelList">강의 삭제</a></li>
									<li><a href="/admin/tuteeList">튜티</a></li>
									<li><a href="/admin/refundList">환불 신청</a></li>
								</ul>
							</li>												
							<li>
								<a href="#;">게시판 관리</a>
								<ul>
									<li><a href="/admin/discussionList">토론</a></li>
									<li><a href="/admin/correctList">첨삭</a></li>
									<li><a href="#;">소식통</a></li>
								</ul>
							</li>
							<li>
								<a href="/admin/reportList">신고 관리</a>
							</li>
						</ul>
					</div>
				</nav>
			</div>
		</section>
	</header>