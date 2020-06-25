<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="/resources/js/common.js"></script>
</head>
<body>
	<header>
		<section id="hdTop">
			<div class="inner1200">
				<div class="util">
					<ul>
						<li class="alram"><a href="#;"><img src="/resources/img/common/alram.png"><span class="length"></span></a></li>
						<li><a href="#;">Login</a></li>
						<li><a href="#;">Logout</a></li>
						<li><a href="#;">Join</a></li>
						<li>
							<a href="#;">MyPage</a>
							<ul class="depth2">
								<li><a href="#;">나의 정보수정</a></li>
								<li><a href="#;">나의 튜터 목록</a></li>
								<li><a href="#;">모임기록</a></li>
								<li><a href="#;">찜목록</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</section>
		<section id="hdBot">
			<div class="inner1200 clearfix">
				<h1 class="logo"><a href="#;"><img src="/resources/img/common/logo.png"/></a></h1>
				<nav>
					<div >
						<ul class="clearfix gnb">
							<li>
								<a href="#;">Partner</a>
								<ul class="depth2">
									<li><a href="#;">파트너 목록</a></li>
									<li><a href="#;">파트너 등록</a></li>
								</ul>
							</li>
							<li>
								<a href="#;">Group</a>
								<ul class="depth2">
									<li><a href="#;">그룹 찾기</a></li>
									<li><a href="#;">그룹 등록</a></li>
								</ul>
							</li>
							<li>
								<a href="#;">Tutor</a>
								<ul class="depth2">
									<li><a href="#;">튜터 찾기</a></li>
									<li><a href="#;">튜터 신청</a></li>
								</ul>
							</li>												
							<li>
								<a href="/discussion/list">Board</a>
								<ul class="depth2">
									<li><a href="/discussion/list">토론</a></li>
									<li><a href="#;">질문</a></li>
									<li><a href="#;">소식</a></li>
								</ul>
							</li>												
							<li>
								<a href="#;">Guide</a>
							</li>												
							<li>
								<a href="#;">Developer</a>
							</li>												
						</ul>
					</div>
				</nav>
			</div>
		</section>
	</header>
