<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/header.jsp" />
<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="my_group_manage" class="inner1200">
			<div class="tit_s1">
				<h2>그룹 관리</h2>
			</div>
			<h4>주선자</h4>
			<div>
				<div>
					<div class="title_wrap">
						<div class="my_seq">글번호</div>
						<div class="my_title">제목</div>
						<div class="my_num">인원</div>
						<div class="my_loc">장소</div>
						<div class="my_date">등록일</div>
						<div class="my_app">신청서</div>
					</div>
				</div>
				<div>
					<c:choose>
						<c:when test="${empty gl_list}">
							<div>
								<div>주선자로서의 기록이 존재하지 않습니다.</div>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="gl_list" items="${gl_list}">
								<div class="option_wrap">
									<div class="my_seq">${gl_list.seq}</div>
									<div class="my_title">${gl_list.title}</div>
									<div class="my_num">${gl_list.cur_num}/${gl_list.max_num}</div>
									<div class="my_loc">${gl_list.location}</div>
									<div class="my_date">${fn:substring(gl_list.write_date, 0, 10)}</div>
									<div class="my_app"><button class="all_app">${gl_list.app_count}</button></div>
								</div>
								<div class="this_app_list_${gl_list.seq}"></div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</article>
		<article id="group_manage" class="inner1200">
			<h4>그룹원</h4>
			<div>
				<div>
					<div class="title_wrap">
						<div class="mem_seq">글번호</div>
						<div class="mem_title">제목</div>
						<div class="mem_num">인원</div>
						<div class="mem_loc">장소</div>
						<div class="mem_leader">주선자</div>
						<div class="mem_app">신청서</div>
					</div>
				</div>
				<c:choose>
					<c:when test="${empty gm_list}">
						<div>
							<div>그룹 멤버로서 기록이 존재하지 않습니다.</div>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="gm_list" items="${gm_list}">
							<div class="option_wrap">
								<div class="mem_seq">${gm_list.seq}</div>
								<div class="mem_title">${gm_list.title}</div>
								<div class="mem_num">${gm_list.cur_num}/${gm_list.max_num}</div>
								<div class="mem_loc">${gm_list.location}</div>
								<div class="mem_leader">${gm_list.writer_name}(${gm_list.writer_name})</div>
								<div class="mem_app"><a href="group/myAppView?seq=${gm_list.seq}">신청서</a></div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</article>
	</section>
</div>
<script>
	$('.all_app').on('click', function(){
		alert('아아앙')
		var seq = $(this).parent().siblings('.my_seq').html();
		console.log(seq);
		console.log($('.this_app_list_' + seq))
		var div = $('.this_app_list_' + seq);
		$.ajax({
			url: "/group/allAppList",
			data: {
				seq: seq
			},
			type: "POST"
		}).done(function(resp){
			for (var i = 0; i < resp.length; i++) {
				div.append("<div>" + resp[i].seq + "</div><div>" + resp[i].id + "</div><div>" + resp[i].name + "</div>");
			}
		}).fail(function(resp){
			alert('ㅇㅇ')
		})
	})
</script>
<jsp:include page="/WEB-INF/views/footer.jsp" />