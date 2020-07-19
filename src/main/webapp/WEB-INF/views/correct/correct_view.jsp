<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/header.jsp" />
<style>
.top .comment_declaration {
	position: absolute;
	right: 30px;
	top: 30px;
}
</style>

<script>
	$(function() {
		$('#form').submit(function() {
			var formData = new FormData($('#form')[0]);
			console.log(formData);
			$.ajax({
				url : "/correct/commentProc",
				type : "post",
				datatype : "json",
				data : formData,
				cache : false,
				contentType : false,
				processData : false
			}).done(function(resp) {
				if (resp) {
					alert("댓글 작성이 완료 되었습니다.")
					location.href = "/correct/correct_view?seq=${dto.seq}"
				}
			})

			return false;
		})

		$("#modify").click(function() {
			location.href = "/correct/correct_modify?seq=${dto.seq}"
		})

		$(".comment_like").click(function() {
			var thisSeq = $(this).data("seq");
			$.ajax({
				url : "/correct/comment_like",
				dataType : "json",
				type : "post",
				data : {
					comm_seq : thisSeq
				}
			}).done(function(resp) {
				location.href = "/correct/correct_view?seq=${dto.seq}"
			});

		})

		$("#delete").click(function() {
			var result = confirm("게시물을 삭제 하시겠습니까?");
			var seq = $(this).data("seq");
			if (result) {
				$.ajax({
					url : "/correct/delete",
					dataType : "json",
					type : "post",
					data : {
						seq : seq
					}
				}).done(function(resp) {
					if (resp) {
						alert("게시물이 삭제되었습니다.")
						location.href = "/correct/correct_list"
					}
				})
			}
		})

		$(".comment_delete").click(function() {
			var result = confirm("댓글을 삭제 하시겠습니까?");
			var seq = $(this).data("seq");
			var parent_seq = $(this).data("parent_seq");
			if (result) {
				$.ajax({
					url : "/correct/commentDelete",
					dataType : "json",
					data : "post",
					data : {
						comm_seq : seq,
						parent_seq : parent_seq
					}
				}).done(function(resp) {
					if (resp) {
						alert("댓글이 삭제되었습니다.");
						location.href = "/correct/correct_view?seq=${dto.seq}"
					}
				})
			}
		})

		$("#historyBack").click(function() {
			location.href = "/correct/correct_list"
		})

		var langCountry = $(".langCountry")
		var langCountryVal = "ko";
		var lanArr = {
			ko : "영어, 일본어, 중국어, 베트남어, 인도네시아어, 태국어, 독일어, 러시아어, 스페인어, 이탈리아어, 프랑스어",
			en : "한국어,일본어 ,프랑스어, 중국어",
			ja : "한국어,영어,중국어",
			zhCN : "한국어,영어,일본어,중국어 번체",
			zhTW : "한국어,영어,일본어,중국어 간체"
		}
		langCountry.find("select").on("change", function() {
			langCountryVal = $(this).val();
		})
		$('#jsonConvertStringSend')
				.click(
						function() {
							var text = $(".viewPage_style1 .originTxt").text();
							var test = {
								"original_str" : text,
								"original_lang" : "${dto.language}",
								"change_lang" : langCountryVal
							};
							$
									.ajax({
										type : "POST",
										url : "/correct/papago",
										dataType : "json",
										data : test,
										success : function(data) {
											console.log(data);
											var json = data[1];
											console.log("qqq" + json);
											var obj = JSON.parse(json);
											console.log("ttt:" + obj.errorCode)
											if(obj.errorCode == "N2MT01"){
												alert("source 파라미터가 필요합니다.");
											}
											if(obj.errorCode == "N2MT04" || obj.errorCode == "N2MT02"){
												alert("지원하지 않는 언어 입니다.");
											}
											if(obj.errorCode == "N2MT03"){
												alert("target 파라미터가 필요합니다.");
											}
											if(obj.errorCode == "N2MT05"){
												alert("원본언어와 동일합니다.");
											}
											if(obj.errorCode == "N2MT06"){
												alert("source->target 번역기가 없습니다.");
											}
											if(obj.errorCode == "N2MT07"){
												alert("text 파라미터가 필요합니다.");
											}
											if(obj.errorCode == "N2MT08"){
												alert("text 파라미터가 최대 용량을 초과했습니다.");
											}
											if(obj.errorCode == "N2MT99"){
												alert("Internal server errors");
											}
											

											if (obj.errorCode == "undefined") {
												if (data[0] == "ko") {
													alert(lanArr.ko
															+ "만 번역이 가능합니다.")
												} else if (data[0] == "en") {
													alert(lanArr.en
															+ "만 번역이 가능합니다.")
												} else if (data[0] == "ja") {
													alert(lanArr.ja
															+ "만 번역이 가능합니다.")
												} else if (data[0] == "zh-CN") {
													alert(lanArr.zhCN
															+ "만 번역이 가능합니다.")
												} else if (data[0] == "zh-TW") {
													alert(lanArr.zhTW
															+ "만 번역이 가능합니다.")
												}

											} else {
												if (obj.errorCode != "010") {
													var text = obj.message.result.translatedText;
													$(".convert").text(text);
												} else {
													alert("번역 쿼리 한도 초과")
												}
											}
										},
										error : function(e) {
											console.log(e);
											alert('실패했습니다.');
										}
									});
						});
	})
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="discussion_view"
			class="viewPage_style1 inner1200 clearfix">
			<div class="body_left">
				<div class="card_body top">
					<div class="title">${dto.title}</div>
					<div class="userInfo_s1">
						<div class="thumb">
							<img src="/upload/member/${dto.id}/${dto.thumNail}" />
						</div>
						<div class="info">
							<p class="userId">${dto.writer}(${dto.id})</p>
							<p class="writeDate">${dto.dateString}</p>
							<c:choose>
								<c:when test="${loginInfo.id == dto.id}">
								</c:when>
								<c:otherwise>
									<button type="button" class="comment_declaration report"
										class="comment_report" data-thisSeq="${dto.seq}"
										data-seq="${dto.seq}" data-id="${dto.id}"
										data-url="/correct/report" data-proc="/correct/reportProc">
										<i class="fa fa-bell color_white" aria-hidden="true"></i>신고하기
									</button>
								</c:otherwise>
							</c:choose>

						</div>
					</div>
					<div class="contents ">
						<div class="originTxt">${dto.contents}</div>
						<div class="langCountry convertWrap clearfix">
							<div>
								<select>
									<c:forEach var="i" items="${langList}">
										<option value="${i.language_country}">${i.language}</option>
									</c:forEach>
								</select>
							</div>
							<div id="convertBtn">
								<button type="button" id="jsonConvertStringSend">번역하기</button>
							</div>
						</div>
						<div class="convert"></div>
					</div>

					<div class="countList">
						<ul>
							<li><i class="fa fa-eye"></i> ${dto.view_count}</li>
							<li><i class="fa fa-commenting-o" aria-hidden="true"></i>
								${dto.reply_count}</li>
						</ul>
					</div>
				</div>

				<div class="">
					<div class="comment_wrap">
						<section class="comment_write card_body">
							<div class="tit_s2">
								<h3>댓글쓰기</h3>
							</div>
							<div class="comment_box">
								<form id="form">
									<input type="hidden" name="writer" value="${loginInfo.name}">
									<input type="hidden" name="parent_seq" value="${dto.seq}">
									<input type="hidden" name="id" value="${loginInfo.id}">
									<input type="hidden" name="thumNail"
										value="${loginInfo.sysname}">
									<div class="text">
										<textarea name="contents" id="text"></textarea>
									</div>


									<div class="btnS1 right">
										<div>
											<input type="submit" value="등록">
										</div>
										<div>
											<input type="reset" value="취소">
										</div>
									</div>
								</form>
							</div>
						</section>

						<section class="comment_list card_body">
							<div class="tit_s2">
								<h3>베스트 댓글</h3>
							</div>
							<c:forEach var="u" items="${best_dto}">
								<article>
									<div class="userInfo_s1">
										<div class="thumb">
											<img src="/upload/member/${u.id}/${u.thumNail}" />
										</div>
										<div class="info">
											<p class="userId">${u.writer}(${u.id})</p>
											<p class="writeDate">${u.dateString}</p>
										</div>
									</div>
									<div class="cont">
										<div class="contents">${u.contents}</div>
										<div class="countList">
											<ul>
											
											<c:choose>
												<c:when test="${loginInfo.id == u.id}">
												
														<li>
															<button class="comment_delete normal"
																data-parent_seq="${u.parent_seq}"
																data-seq="${u.comm_seq}">댓글삭제</button>
														</li>
													
												</c:when>
												<c:otherwise>
												

														<li>
															<button class="comment_like" data-seq="${u.comm_seq}">좋아요
																:${u.like_count}</button>
															<button type="button" class="comment_declaration report"
																class="comment_report" data-thisSeq="${u.comm_seq}"
																data-seq="${dto.seq}" data-id="${u.id}"
																data-url="/correct/comment_report"
																data-proc="/correct/comment_reportProc">
																<i class="fa fa-bell color_white" aria-hidden="true"></i>신고하기
															</button>
														</li>
													
												</c:otherwise>
											</c:choose>
											</ul>
										</div>
									</div>
								</article>
							</c:forEach>
						</section>
						<section class="comment_list card_body">
							<div class="tit_s2">
								<h3>댓글(${fn:length(list_dto)})</h3>
							</div>
							<c:forEach var="i" items="${list_dto}">
								<article>
									<div class="userInfo_s1">
										<div class="thumb">
											<img src="/upload/member/${i.id}/${i.thumNail}" />
										</div>
										<div class="info">
											<p class="userId">${i.writer}(${i.id})</p>
											<p class="writeDate">${i.dateString}</p>
										</div>
									</div>
									<div class="cont">
										<div class="contents">${i.contents}</div>
										<div class="countList">
											<ul>
											
											<c:if test="${loginInfo.id == i.id}">
												
													<li>
														<button class="comment_delete normal"
															data-parent_seq="${i.parent_seq}"
															data-seq="${i.comm_seq}">댓글삭제</button>
													</li>
												
											</c:if>
											<c:if test="${loginInfo.id != i.id}">
												
													<li>
														<button class="comment_like" data-seq="${i.comm_seq}">좋아요
															${i.like_count}</button>
														<button type="button" class="comment_declaration report"
															class="comment_report" data-thisSeq="${i.comm_seq}"
															data-seq="${dto.seq}" data-id="${i.id}"
															data-url="/correct/comment_report"
															data-proc="/correct/comment_reportProc">
															<i class="fa fa-bell color_white" aria-hidden="true"></i>신고하기
														</button>
													</li>
												
											</c:if>

											</ul>
										</div>
									</div>
								</article>
							</c:forEach>
						</section>
					</div>
				</div>
			</div>
			<div class="body_right card_body">
				<div class="moreList">
					<div class="tit_s2">
						<h3>질문 더 보기</h3>
					</div>
					<div class="list">
						<ul>
							<c:forEach var="i" items="${moreList}">
								<li><a href="/correct/correct_view?seq=${i.seq}">-
										${i.title}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="btns_s2">
					<c:choose>
						<c:when test="${loginInfo.id == dto.id}">
							<button type="button" id="modify">글수정</button>
							<button type="button" id="delete" data-seq="${dto.seq}">글삭제</button>
							<button type="button" id="historyBack">뒤로가기</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="w100p" id="historyBack">뒤로가기</button>
						</c:otherwise>
					</c:choose>
				</div>
			</div>


		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/reportPage.jsp" />
<jsp:include page="/WEB-INF/views/footer.jsp" />