<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=521d781cfe9fe7597693f2dc29a10601&libraries=services"></script>

<!--  제목, 내용, 최대 인원 증원 가능, 만남 장소, 모집기간은 더 늘릴수만 있다 -->

<script>
	$(function() {
		//오늘날짜 전에 클릭 안되게 걸어주기 
	    $('#apply_end').datepicker({ dateFormat: 'yy-mm-dd' });

		        
		$('#summernote').summernote({
			height : 300,
			lang : 'ko-KR',
			callbacks : {
				onImageUpload : function(files) {
					uploadSummernoteImageFile(files[0], this);
				}
			}
		});z

	});
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="lessonApp_update" class="inner1200">
			<div class="tit_s1">
				<h2>Lesson</h2>
				<p>강의를 수정하고 수정버튼을 누르세요. 최대한 수정하지 않는 방향으로 해주세요</p>
			</div>

			<form action="lessonAppUpdateProc" method="post">
				<div class="title_wrap">
					<div class="tit_s3">
						<h4>제목</h4>
					</div>
					<div class="right">
						<input type="text" id="title" name="title"
							placeholder="${ldto.title }">
					</div>

				</div>


				<div class="price_wrap">
					<div class="tit_s3">
						<h4>가격</h4>
					</div>
					<div class="right">
						<input type="text" id="price" name="price" value="${ldto.price }" style="background-color: lightgray" readonly>
						원 /시간
					</div>
				</div>


				<div class="language_wrap">
					<div class="tit_s3">
						<h4>언어</h4>
					</div>
					<div class="right">
						<input type="text" name="language" value="${ldto.language }"style="background-color: lightgray" readonly>
					</div>
				</div>



				<div class="apply_date">
					<div class="tit_s3">
						<h4>모집 기간</h4>
					</div>
					<input type="text" id="apply_start" name="apply_start" size="12" value="${ldto.apply_start }" style="background-color: lightgray" readonly>
						~ 
					<input type="text" id="apply_end" name="apply_end" size="12" value="${ldto.apply_end }"> 
						<label for="apply_end" class="calendar_icon">
							<i class="fa fa-calendar" aria-hidden="true"></i>
						</label>
				</div>

				<div class="lesson_date">
					<div class="tit_s3">
						<h4>수업 기간</h4>
					</div>
					<input type="text" id="start_date" name="start_date" size="12" value="${ldto.start_date }" style="background-color: lightgray" readonly>
					 ~ 
					<input type="text" id="end_date" name="end_date" size="12" value="${ldto.end_date }" style="background-color: lightgray" readonly> 
					
				</div>

				<div class="lesson_time">
					<div class="tit_s3">
						<h4>수업 시간</h4>
					</div>
					<input type=text id="start_hour" name="start_hour" value="${ldto.start_hour }" size=1 style="background-color: lightgray" readonly>:
					<input type=text id="start_minute" name="start_minute" value="${ldto.start_minute }" size=1 style="background-color: lightgray" readonly>~
					<input type=text id="end_hour" name="end_hour" value="${ldto.end_hour }" size=1 style="background-color: lightgray" readonly>:
					<input type=text id="end_minute" name="end_minute" value="${ldto.end_minute }" size=1 style="background-color: lightgray" readonly>
					
				</div>

				<div class="max_num_wrap">
					<div class="tit_s3">
						<h4>최대 인원</h4>
					</div>
					<!-- 조건 걸기 -->
					<input type="text" id="max_num" name="max_num" value="${ldto.max_num }">
				</div>

				<div class="map">
					<div class="tit_s3">
						<h4>장소</h4>
					</div>
					<input type="text" id="location" name="location" value="${ldto.location }" readonly
					style="background-color: lightgray">
					<div id="map" style="width:500px;height:400px;"></div>
						
				</div>

				<div class="contents">
					<div class="tit_s3">
						<h4>커리큘럼</h4>
					</div>
					<textarea id="summernote" name="curriculum">${ldto.curriculum }</textarea>
				</div>
				<div>
					<button>수정 하기</button>
				</div>
			</form>
		</article>
	</section>
	<script>
		var locationVal= $("#location").val();
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			level : 3
		//지도의 레벨(확대, 축소 정도)
		};
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(locationVal, function(result, status) {
			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {

				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

				// 결과값으로 받은 위치를 마커로 표시합니다
				var marker = new kakao.maps.Marker({
					map : map,
					position : coords
				});

				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);
			}
		});

	</script>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />