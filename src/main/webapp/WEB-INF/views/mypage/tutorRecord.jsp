<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/header.jsp" />

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<script>
		$(function(){
			$(".refund").on("click", function(){
				var seq = $(this).parent().siblings().find('.seq').val();
				var start_date = $(this).parent().siblings().find('.start_date').val();
				var price = $(this).parent().siblings().find('.price').val();
				
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

<article id="management">
	<h2>나의 강의목록</h2>
	<section class="tuteeRecord">
		<div class="subContents">
			<div class="session">
				<h4>강의목록</h4>
				<c:choose>
					<c:when test="${empty telist}">
							등록된 강의기록이 없습니다.
						</c:when>
					<c:otherwise>
						<table>
							<c:forEach var="telist" items="${telist}">
								<tr id="${telist.seq}">
									<td>강의번호:${telist.seq}</td>
									<td><a href="#;">${telist.title}</a></td>
									<td><a href="#;">튜터명:${telist.name}</a></td>
									<td>언어:${telist.language}</td>
									<td>커리큘럼:${telist.curriculum}</td>
									<td>강의 기간:${telist.start_date}~${telist.end_date}</td>
									<td>최대인원(현재인원/최대인원):${telist.cur_num}/${telist.max_num}</td>
									<td>만남장소:${telist.location}</td>
									<td>추천수:${telist.like_count}</td>
									<td>리뷰수:${telist.review_count}</td>
									<td>평점:${telist.review_point}</td>
									
									<td><input type="hidden"  class="seq" value="${telist.seq}"></td>
									<td><input type="hidden" class="start_date" value="${telist.start_date}"></td>
									<td><input type="hidden" class="price" value="${telist.price }"></td>
									
									<td><input type="button" class="refund" value="강의 환불"></td>
								</tr>
							</c:forEach>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
</article>
<script>

	</script>


<jsp:include page="/WEB-INF/views/footer.jsp" />