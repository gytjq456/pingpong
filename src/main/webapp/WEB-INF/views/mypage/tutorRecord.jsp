<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/header.jsp" />
<style>
	.hidden { display:none;}
	
</style>

<script>
		$(function(){
			$(".refund").on("click", function(){
				var seq = $(this).closest("tr").find('.seq').val();
				var start_date = $(this).closest("tr").find('.start_date').val();
				var price = $(this).closest("tr").find('.price').val();
				
				$.ajax({
					url:"/payments/refundTrue",
					data:{
						parent_seq : seq
					},
					type: "POST"
				}).done(function(resp){
					console.log(resp);
					if(resp>0){
						alert("이미 환불신청이 완료된 강의 입니다.");
						location.href="/mypage/tutorRecord";
						return false;
					}else{
						location.href="/payments/cancle?parent_seq="+seq+"&start_date="+start_date+"&price="+price;
					}
				}).fail(function(error1, error2) {
					console.log(error1);
					console.log(error2);
				})
				
				
				
			})
		})
	</script>
<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="jjimManage" class="inner1200">
			<div class="tit_s1">
				<h2>나의 강의 목록</h2>
			</div>
			
			
			<div class="listWrap">
				<section class="session card_body">		
					<h4>강의 리스트</h4>
					<div class="tip">
						<ul>
							<li>수업 시작 날짜전 환불 요정 - 전액 환불</li>
							<li>수업 시작 날짜로부터 1일~10일 경과 - 전체금액 중 2/3 환불</li>
							<li>수업 시작 날짜로부터 10일~15일 경과 - 전체금액 중 1/2 환불</li>
							<li>수업 시작 날짜로부터 15일 이후 경과 - 환불 금액 없음</li>		
						</ul>
					</div>		
					<c:choose>
						<c:when test="${loginInfo.grade == 'tutor'}">
							<c:choose>
								<c:when test="${empty trlist}">
									등록하신 강의가 없습니다.
								</c:when>
								<c:otherwise>
								<div class="tableWrap">
									<table>
										<thead>
											<tr>
												<th>강의 코드</th>
												<th>강의명</th>
												<th>가격</th>
												<th>수강 인원</th>
												<th>언어</th>
												<th>장소</th>
												<th>강의 기간</th>
												<th>강의 시간</th>
												<th>모집중</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="trlist" items="${trlist}">
												<tr>
													<td>${trlist.seq}</td>
													<td><a href="/tutor/lessonView?seq=${trlist.seq}">${trlist.title}</a></td>
													<td>${trlist.price}</td>
													<td>${trlist.cur_num}/${trlist.max_num}</td>
													<td>${trlist.language}</td>
													<td>${trlist.location}</td>
													<td>${trlist.start_date} ~ ${trlist.end_date}</td>
													<td>${trlist.start_hour}:${trlist.start_minute} ~ ${trlist.end_hour}:${trlist.end_minute}</td>
													<td>
														<c:if test="${trlist.applying == 'Y'}">모집중</c:if>
														<c:if test="${trlist.applying == 'N'}">마감</c:if>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="navi_line">${trnavi}</div>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${empty telist}">
									수강 중인 강의가 없습니다.
								</c:when>
								<c:otherwise>
								<div class="tableWrap">
								
									<table>
										<thead>
											<tr>
												<th>번호</th>
												<th>제목</th>
												<th>튜터</th>
												<th>언어</th>
												<th>강의 기간</th>
												<th>장소</th>
												<th>비고</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="telist" items="${telist}">
											<tr id="${telist.seq}">
												<td class="hidden"><input type="hidden"  class="seq" value="${telist.seq}"></td>
												<td class="hidden"><input type="hidden" class="start_date" value="${telist.start_date}"/></td>
												<td class="hidden"><input type="hidden" class="price" value="${telist.price }"/></td>
												<td>${telist.seq}</td>
												<td><a href="/tutor/lessonView?seq=${telist.seq}">${telist.title}</a></td>
												<td><a href="#;">${telist.name}</a></td>
												<td>${telist.language}</td>
												<td>${telist.start_date}~${telist.end_date}</td>
												<td>${telist.location}</td>

												<td><input type="button" class="refund" value="강의 환불"></td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="navi_line">${tenavi}</div>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</section>
			</div>
			
		</article>
	</section>
</div>



<jsp:include page="/WEB-INF/views/footer.jsp" />