<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
	$(function() {
		$("#list_view > section").each(
				function() {
					var text = $(this).find(".contents").text();
					var seq = $(this).data("seq");
					$(this).children("article").wrap(
							'<a href="/correct/view?seq=' + seq + '">')
					var tagLt = text.replace(/<a/gim, "$lta;");
					var tagGt = tagLt.replace(/a>/gim, "a$gt;");
					console.log(tagGt)
					if (text.length >= 300) {
						tagGt = tagGt.substring(0, 299) + "...";
						;
						$(this).find(".contents").text(tagGt);
					} else {
						$(this).find(".contents").text(tagGt);
					}
				})
	})
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="discussion_list" class="inner1200">
		
		<a href="/correct/correct_write">질문등록하기</a>

				<div id="list_view">
					<c:forEach var="i" items="${list}">
						<section>
						<td><a href="/correct/correct_view?seq=${i.seq}">
							<tr>
								<td>${i.seq}</td>
								<td>${i.writer}</td>
								<td>${i.language}</td>
								<td>${i.title}</td>
								<td>${i.type}</td>
								<td class="contents">${i.contents}</td>
								<td>${i.write_date}</td>
								<td>조회수 :${i.view_count}</td>
								<td>좋아요 :${i.like_count}</td>
								<td>싫어요 :${i.hate_count}</td>
								<td>답글 수 :${i.reply_count}</td>
							</tr>
								</a></td>
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