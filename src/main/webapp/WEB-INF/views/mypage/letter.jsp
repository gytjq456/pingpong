<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<style>
	#letter_list_wrap table .letter_con { display: none; }
	#letter_list_wrap table .letter_con td { text-align: left; }
	.letter_btns { overflow: hidden; }
	.letter_btns > button { width: 100px; height: 30px; border: 1px solid #ddd; background-color: #fff; color: #aaa; border-radius: 6px; margin-top: 15px; float: right; }
	.letter_btns > button:hover { background-color: #4c98ff; color: #fff; border: none; }
</style>
<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="jjimManage" class="inner1200">
			<div class="tit_s1">
				<h2>쪽지함</h2>
			</div>
			<div class="listWrap" id="letter_list_wrap">
				<section class="session card_body">	
					<h4>받은 쪽지함</h4>
					<c:choose>
						<c:when test="${empty rlist}">
							<p>받은 쪽지가 없습니다.</p>
						</c:when>
						<c:otherwise>
							<table>
								<thead>
									<tr>
										<th><input type="checkbox" class="select_all"></th>
										<th>번호</th>
										<th>보낸 사람</th>
										<th>미리 보기</th>
										<th>수신 날짜</th>
										<th>읽음</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="rlist" items="${rlist}">
										<tr>
											<td><input type="checkbox" class="select_one"></td>
											<td class="seq_rec seq">${rlist.seq}</td>
											<td>${rlist.from_id}</td>
											<td class="show_con">${rlist.from_name} 님이 쪽지를 보냈습니다.</td>
											<td>${fn:substring(rlist.write_date, 0, 10)}</td>
											<td class="read">
												<c:if test="${rlist.read == 'Y'}">읽음</c:if>
												<c:if test="${rlist.read == 'N'}">읽지 않음</c:if>
											</td>
										</tr>
										<tr class="letter_con">
											<td colspan="6">
												<div>${rlist.contents}</div>
												<div class="letter_btns">
													<button class="del_rec_let">삭제</button>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:otherwise>
					</c:choose>
				</section>
				<section class="session card_body">	
					<h4>보낸 쪽지함</h4>
					<c:choose>
						<c:when test="${empty slist}">
							<p>보낸 쪽지가 없습니다.</p>
						</c:when>
						<c:otherwise>
							<table>
								<thead>
									<tr>
										<th><input type="checkbox" class="select_all"></th>
										<th>번호</th>
										<th>받는 사람</th>
										<th>미리 보기</th>
										<th>발신 날짜</th>
										<th>읽음</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="slist" items="${slist}">
										<tr>
											<td><input type="checkbox" class="select_one"></td>
											<td class="seq">${slist.seq}</td>
											<td>${slist.to_id}</td>
											<td class="show_con">${slist.to_name} 님에게 보낸 쪽지입니다.</td>
											<td>${fn:substring(slist.write_date, 0, 10)}</td>
											<td>
												<c:if test="${slist.read == 'Y'}">읽음</c:if>
												<c:if test="${slist.read == 'N'}">읽지 않음</c:if>
											</td>
										</tr>
										<tr class="letter_con">
											<td colspan="6">
												<div>${slist.contents}</div>
												<div class="letter_btns">
													<button class="del_send_let">삭제</button>
												</div>
											</td>
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
<script>
	$(function(){
		$('.show_con').on('click', function(){
			var contents = $(this).parent().next();
			
			if (contents.css('display') == 'none') {
				var contentsCount = $('.letter_con').length;
				var read = $(this).siblings('.read');
				var readVal = read.html();
				
				if (readVal != null && readVal.indexOf('읽지 않음') > -1) {
					var seq = $(this).siblings('.seq_rec').html();
					$.ajax({
						url: "/letter/updateRead",
						data: {
							seq: seq
						},
						type: "POST"
					}).done(function(resp){
						if (resp) {
							read.html('읽음');
						} else {
							alert('알 수 없는 에러가 발생하였습니다. 새로 고침을 해 주세요.');
						}
					})
				}
				
				for (var i = 0; i < contentsCount; i++) {
					$($('.letter_con')[i]).hide();
				}
				
				contents.show();
			} else {
				contents.hide();
			}
		})
		
		$('.del_rec_let').on('click', function(){
			var seq = $(this).closest('.letter_con').prev().find('.seq').html();
			var conf = confirm('정말 삭제하시겠습니까?');
			
			if (conf) {
				location.href = "/letter/deleteReceiveLetter?seq=" + seq;
			}
		})
		
		$('.del_send_let').on('click', function(){
			var seq = $(this).closest('.letter_con').prev().find('.seq').html();
			var conf = confirm('정말 삭제하시겠습니까?');
			
			if (conf) {
				location.href = "/letter/deleteSendLetter?seq=" + seq;
			}
		})
	})
</script>
<jsp:include page="/WEB-INF/views/footer.jsp"/>