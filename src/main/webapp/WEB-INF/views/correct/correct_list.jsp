<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
$(function() {
	$(".view").click(function() {
		var seq = $(this).data("seq");
		$.ajax({
			url : "/correct/correct_list",
			dataType : "json",
			type : "post",
			data : {seq:seq}
		})
	})
})
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">	<article id="discussion_list" class="inner1200">
		
		<a href="/correct/correct_write">질문등록하기</a>

				<div id="list_view">
					<c:forEach var="i" items="${list}">
						<section>
						<article>
						<td class="view"><a href="/correct/correct_view?seq=${i.seq}"  data-seq="${i.seq}" class ="view">
							<tr>
								<td  data-seq="${i.seq}">${i.seq}</td>
								<td>작성자 : ${i.writer}</td>
								<td>구사 언어: ${i.language}</td>
								<td>제목 :${i.title}</td>
								<td>질문 유형: ${i.type}</td>
								<td class="contents"><c:choose>
        <c:when test="${fn:length(i.contents) gt 26}">
        <c:out value='${fn:substring(i.contents.replaceAll("\\\<.*?\\\>",""), 0, 200)}...'>
        </c:out></c:when>
        <c:otherwise>
        <c:out  value='내용 :${i.contents.replaceAll("\\\<.*?\\\>","")}'>
        </c:out></c:otherwise>
        
</c:choose>
</td>
								<td> ${i.write_date}</td>
								<td>조회수 :${i.view_count}</td>
								<td>좋아요 :${i.like_count}</td>
								<td>싫어요 :${i.hate_count}</td>
								<td>답글 수 :${i.reply_count}</td>
							</tr>
								</a></td>
						</article>
						</section>
					</c:forEach>
				</div>
				<div>
				${navi}
				</div>
		
		</article>
	</section>
</div>


<jsp:include page="/WEB-INF/views/footer.jsp" />