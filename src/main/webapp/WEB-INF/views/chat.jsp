<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
	<section id="chatWrap">
		<section id="chatList">
			<div class="tit">채팅</div>
			<c:choose>
				<c:when test="${sessionScope.loginInfo.grade eq 'partner'}">
				<div class="list">
					<ul>
					
					</ul>
				</div>
				</c:when>
				<c:otherwise>
				<div class="noList">
					<p>서비스 정책에 따라 채팅기능은 일반 회원은 사용이 불가능 합니다. 파트너 등록을 하시면 서비스 이용이 가능합니다.</p>
					<div><a href="">파트너 등록</a></div>
				</div>
				</c:otherwise>
			</c:choose>
		</section>	
		<div id="chatRoom">
			<div class="top"><button id="close"><i class="fa fa-angle-left" aria-hidden="true"></i></button></div>
			<div class="title clearfix">
				<i class="fa fa-users" aria-hidden="true"></i>
				<p></p>
				<span></span>
			</div>
			<div class="chatBox" id="chatBox">
				<div class="sysdate"></div>
				<div class="txtRow"></div>
			</div>
			<div class="txtInputBox">
				<div class="txtInput" contenteditable="true">
					
				</div>
				<button type="button" id="transfer">전송</button>
			</div>
		</div>
		<div id="chatClose"><button type="button"><i class="fa fa-times" aria-hidden="true"></i></button></div>
	</section>