<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/header.jsp" />

<style>
.wrapper{
	border: 1px solid black;
}
</style>


<div id="subWrap" class="hdMargin">
   <section id="subContents">
      <article id="tutorList" class="inner1200">
      
      <div class="list_main">
      	<div class="row">
			<h2>튜터 목록</h2>
		</div>
		<div class="row">
			<div class="col-lg-3">프로필</div>
			<div class="col-lg-2">이름</div>
			<div class="col-lg-1">나이</div>
			<div class="col-lg-1">성별</div>
			<div class="col-lg-1">국가</div>
			<div class="col-lg-2">주소</div>
			<div class="col-lg-2">구사가능언어</div>
		</div>
		<c:choose>
			<c:when test="${empty tutorlist}">
				<div class="row">
					<div class='col-12'>튜터가 없습니다.</div>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach var="i" items="${tutorlist}">
					<div class="row wrapper">
						<div class="col-lg-3"><img src ="/upload/member/${i.id}/${i.sysname}"></div>
						<div class="col-lg-2">${i.name}</div>
						<div class="title col-lg-1">${i.age}
							<!-- <span class="badge badge-danger">New</span> -->
						</div>
						<div class="col-lg-1">${i.gender}</div>
						<div class="col-lg-1">${i.country}</div>
						<div class="col-lg-2">${i.address}</div>
						<div class="col-lg-2">${i.lang_can}</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
      
      </div>
      
      </article>
   </section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />