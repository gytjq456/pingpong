<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/header.jsp" />

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
				<h2>나의 강의목록</h2>
			</div>
			<div class="listWrap">
				<section class="session card_body">		
					<h4>강의 신청 리스트</h4>
					<c:choose>
						<c:when test="${empty telist}">
							등록된 강의기록이 없습니다.
						</c:when>
						<c:otherwise>
							<table>
								<colgroup>
									<col width="50px"/>
									<col width="360px"/>
									<col width=""/>
									<col width=""/>
									<col width=""/>
									<col width=""/>
									<col width="100px"/>
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>튜터</th>
										<th>언어</th>
										<!-- <th>커리큘럼</th> -->
										<th>강의 기간</th>
										<!-- <th>인원</th> -->
										<th>장소</th>
										<!-- <th>추천</th>
										<th>리뷰</th>
										<th>평점</th> -->
										<th>비고</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="telist" items="${telist}">
									<tr id="${telist.seq}">
										<td><input type="hidden"  class="seq" value="${telist.seq}"></td>
										<td><input type="hidden" class="start_date" value="${telist.start_date}"/></td>
										<td><input type="hidden" class="price" value="${telist.price }"/></td>
										<td>${telist.seq}</td>
										<td><a href="#;">${telist.title}</a></td>
										<td><a href="#;">${telist.name}</a></td>
										<td>${telist.language}</td>
										<%-- <td>${telist.curriculum}</td> --%>
										<td>${telist.start_date}~${telist.end_date}</td>
										<%-- <td>${telist.cur_num}/${telist.max_num}</td> --%>
										<td>${telist.location}</td>
										<%-- <td>${telist.like_count}</td>
										<td>${telist.review_count}</td>
										<td>${telist.review_point}</td> --%>
										<td><input type="button" class="refund" value="강의 환불"></td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</c:otherwise>
					</c:choose>
				</section>
			</div>
			
		</article>
	</section>
</div>



<jsp:include page="/WEB-INF/views/footer.jsp" />