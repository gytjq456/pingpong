<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=521d781cfe9fe7597693f2dc29a10601&libraries=services"></script>

<style>
	#title{width:80%;}
/*     .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;} */
    .price_wrap {}
    .price_wrap input { width:200px !important; margin-right:10px;}
    #map { margin-top:20px;}
    
</style>
<script>
	$(function() {
		$("#back").on("click", function(){
			var result = confirm("강의 목록으로 돌아가시겠습니까?");
			if(result){
				location.href="/tutor/lessonList?orderBy=seq&keywordSelect=name";
			}else{
				return false;
			}
		})
		
		$("input, textarea").blur(function(){
			var thisVal = $(this).val();
			$(this).val(textChk(thisVal));
		})
		
		function textChk(thisVal){
			var replaceId  = /(script)/gi;
			var textVal = thisVal;
		    if (textVal.length > 0) {
		        if (textVal.match(replaceId)) {
		        	textVal = thisVal.replace(replaceId, "");
		        }
		    }
		    return textVal;
		}
	
		//오늘날짜 전에 클릭 안되게 걸어주기 
		$('#apply_start').datepicker({
			dateFormat : 'yy-mm-dd',
			minDate : 0,
			maxDate : '+1m',
			onClose : function(selectedDate){
				$('#apply_end').datepicker("option", "minDate", selectedDate);
			},
			onSelect: function(dateText, inst){
				var stDate = dateText.split("-");
				var dt = new Date(stDate[0], stDate[1], stDate[2]);
				var year = dt.getFullYear(); //년도구하기
				var month = dt.getMonth() +1;	//한달뒤의 달 구하기
				var month = month +"";	//문자형태
				if(month.length=="1") var month="0"+month;	//두자리 정수형태
				var day = dt.getDate();
				var day = day+"";
				if(day.length=="1") var day="0"+day;
				
				var nextMonth = year +"-" + month+"-"+ day;
				$("#apply_end").datepicker("option", "maxDate", nextMonth);
			}
		}).datepicker('setDate', new Date());

		$('#apply_end').datepicker({
			dateFormat : 'yy-mm-dd',
			minDate : 0,
			maxDate : '+1m',
			onClose : function(selectedDate) {
				$('#apply_start').datepicker("option", "maxDate", selectedDate);
				$('#start_date').datepicker("option", "minDate", selectedDate);
			}
		});

		$('#start_date').datepicker({
			dateFormat : 'yy-mm-dd',
			minDate : 0,
			maxDate : '+1m +7d',
			onClose : function(selectedDate) {
				$('#end_date').datepicker("option", "minDate", selectedDate);
			},
			onSelect: function(dateText, inst){
				var stDate = dateText.split("-");
				var dt = new Date(stDate[0], stDate[1], stDate[2]);
				var year = dt.getFullYear();
				var month = dt.getMonth() +1;
				var month = month +"";
				if(month.length=="1") var month="0"+month;   
				var day = dt.getDate();
				var day = day+"";
				if(day.length=="1") var day="0"+day;
				
				var nextMonth = year +"-" + month+"-"+ day;
				$("#end_date").datepicker("option", "maxDate", nextMonth);
			}
		});
		
		$('#end_date').datepicker({
			dateFormat : 'yy-mm-dd',
			minDate : 7,
			maxDate : '+1m +7d',
			onClose : function(selectedDate) {
				$('#start_date').datepicker("option", "maxDate", selectedDate);
			}
		});
		
		
/* 
 		
		$('#start_date').on('change', function() {
			var endDate = $('#end_date').val();
			if (endDate != '') {
				$('#end_date').val('');
			}
		})  */

		$("#price").focusout(function() {
			var priceVal = $(this).val();
			if (priceVal>300000) {
				alert("최대 30만원입니다.");
				$(this).val('');
			}
		})

		var start_hourVal = $("#start_hour").val();
		var end_hourVal = $("#end_hour").val();

		$("#max_num").focusout(function() {
			var maxVal = $(this).val();
			if(maxVal<5){
				alert("최소 5명입니다.");
				$(this).val('');
			}else if(maxVal>30){
				alert("최대 30명입니다.");
				$(this).val('');
			}
		})
		
		$("#start_hour").on("change", function(){
			var start_hourVal = $("#start_hour").val();
			console.log(start_hourVal);
			$("#end_hour").on("change", function(){
				//$("select option[value<="+start_hourVal+"]").prop('disabled',true);
				if($("#end_hour").val()<=start_hourVal){
					alert("시작시간보다 늦은시간으로 설정해주세요.");
					$("#end_hour").val('');
				}
			})
		})
/* 		
		$("#end_hour").on("change", function(){
			var end_hourVal = $("#end_hour").val();
			console.log(end_hourVal);
			$("#start_hour").on("change", function(){
				//$("select option[value<="+start_hourVal+"]").prop('disabled',true);
				if($("#start_hour").val()>=end_hourVal){
					alert("끝나는 시간보다 빠른 시간으로 설정해주세요.");
					$("#start_hour").val('');
				}
			})
		}) */

		$("#frm").on("submit", function() {
			var titleVal = $("#title").val();
			var summernoteVal = $("#summernote").val();
			var priceVal = $("#price").val()
			var apply_startVal = $("#apply_start").val();
			var apply_endVal = $("#apply_end").val();
			var start_dateVal = $("#start_date").val();
			var end_dateVal = $("#end_date").val();
			var max_numVal = $("#max_num").val();
			var sidoVal = $("#sido1").val();
			var gugunVal = $("#gugun1").val();

			if (titleVal.length == 0) {
				alert("제목을 입력해주세요");
				return false;
			} else if (priceVal == 0) {
				alert("가격을 입력해주세요");
				return false;
			} else if (apply_startVal.length == 0) {
				alert("모집시작 기간을 선택해주세요");
				return false;
			} else if (apply_endVal.length == 0) {
				alert("모집마감 기간을 선택해주세요");
				return false;
			} else if (start_dateVal.length == 0) {
				alert("수업시작 기간을 선택해주세요");
				return false;
			} else if (end_dateVal.length == 0) {
				alert("수업마감 기간을 선택해주세요");
				return false;
			} else if (max_numVal.length == 0) {
				alert("인원을 입력해주세요");
				return false;
			} else if (sidoVal == '시, 도 선택') {
				alert("시,도 를 선택해주세요.");
				return false;
			} else if (gugunVal == '구, 군 선택') {
				alert("구,군 을 선택해주세요.");
				return false;
			} else if (summernoteVal.length == 0) {
				alert("내용을 입력해주세요");
				return false;
			}
		})

		$('#summernote').summernote({
			height: 300,
			lang: "ko-KR",
			callbacks:{
				onImageUpload : function(files){
					uploadSummernoteImageFile(files[0],this);
				}
			}
		}); 

	});

	function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "/summerNote/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success : function(data) {
	        	//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote('insertImage', data.url);
			}
		});
	}		
</script>


<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<!--lessonApp_view  -->
		<article id="discussion_write" class="inner1200">
			<div class="tit_s1">
				<h2>Lesson</h2>
				<p>새 강의 등록하기</p>
			</div>

			<div class="card_body" id="find_group_write">
				<form action="lessonAppProc" id="frm" method="post">
					<section class="title_wrap">
						<div class="tit_s3">
							<h4>제목</h4>
						</div>
						<div class="">
							<input type="text" id="title" name="title" placeholder="강의 성격이 드러날 키워드를 포함하여 간결한 제목으로 설정해 주세요.">
						</div>
					</section>
					<section class="price_wrap">
						<div class="tit_s3">
							<h4>가격</h4>
							<span class="notice">*한달기준 최대 30만원 입니다. 일기준 최대 만원으로 잡아 날짜에 맞춰 금액을 정해주세요.</span>
						</div>
						<div class="right">
							<input type="text" id="price" name="price" placeholder="총 가격">원 
						</div>
					</section>
					<section>
						<div class="language_wrap">
							<div class="tit_s3">
								<h4>언어</h4>
							</div>
							<div class="right">
								<select id="language" name="language">
									<c:forEach var="i" items="${lanList}">
										<option value="${i.language}">${i.language}</option>
									</c:forEach>
								</select>
							</div>
						</div>					
					</section>
					<section>
						<div class="apply_date">
							<div class="tit_s3">
								<h4>모집 기간</h4>
							</div>
							<label for="apply_start" class="calendar_icon">
								<i class="fa fa-calendar" aria-hidden="true"></i>
							</label>
							<input type="text" id="apply_start" name="apply_start" size="12" readonly> 
							~ 
							<label for="apply_end" class="calendar_icon">
								<i class="fa fa-calendar" aria-hidden="true"></i>
							</label>
							<input type="text" id="apply_end" name="apply_end" size="12" readonly> 
						</div>					
					</section>
					<section>
						<div class="lesson_date">
							<div class="tit_s3">
								<h4>수업 기간</h4>
								<span class="notice">*수업기간은 최대 한달만 가능합니다.</span>
							</div>
							<label for="start_date" class="calendar_icon">
								<i class="fa fa-calendar" aria-hidden="true"></i>
							</label>
							<input type="text" id="start_date" name="start_date" size="12" readonly>
							 ~ 
							<label for="end_date" class="calendar_icon">
								<i class="fa fa-calendar" aria-hidden="true"></i>
							</label>
							<input type="text" id="end_date" name="end_date" size="12" readonly> 
						</div>					
					</section>
					<section>
						<div class="lesson_time">
							<div class="tit_s3">
								<h4>수업 시간</h4>
							</div>
							<!-- <input type="time" id="start_hour" name="start_hour"> : 
							<input type="time" id="end_hour" name="end_hour"> -->
							<select id="start_hour" name="start_hour">
								<option value="07">07</option>
								<option value="08">08</option>
								<option value="09">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
							</select> : <select id="start_minute" name="start_minute">
								<option>00</option>
								<option>15</option>
								<option>30</option>
								<option>45</option>
							</select> ~ <select id="end_hour" name="end_hour">
								<option value="08">08</option>
								<option value="09">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
							</select> : <select id="end_minute" name="end_minute">
								<option>00</option>
								<option>15</option>
								<option>30</option>
								<option>45</option>
							</select>
						</div>					
					</section>
					<section>
						<div class="max_num_wrap">
							<div class="tit_s3">
								<h4>최대 인원</h4>
							</div>
							<!-- 조건 걸기 -->
							<input type="text" id="max_num" name="max_num"
								placeholder="최소5명 최대30명">
						</div>					
					</section>
					<section>
						<div class="mapWrap">
							<div class="tit_s3">
								<h4>장소</h4>
							</div>
							<select name="sido1" id="sido1"></select> 
							<select name="gugun1" id="gugun1"></select>
							<input type="hidden" id="location" name="location">
							<input type="hidden" id="location_lat" name="location_lat">
							<input type="hidden" id="location_lng" name="location_lng">
							
							<div id="map"></div>
								
						</div>					
					</section>
					<section>
						<div class="contents">
							<div class="tit_s3">
								<h4>커리큘럼</h4>
							</div>
							<textarea id="summernote" name="curriculum"></textarea>
						</div>					
					</section>
					<div class="btnS1 center">
						<div>
							<button id="submit">신청하기</button>
						</div>
						<div><button type="button" id="back">목록</button></div>
					</div>
				</form>
			</div>
		</article>
	</section>
	<script>
		new sojaeji('sido1', 'gugun1');
		
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(37.56801425339971, 126.9832107418218), //지도의 중심좌표.
			level : 3
		//지도의 레벨(확대, 축소 정도)
		};
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		var sidogugun;
		$("#gugun1").change(function() {
			var sido = $('#sido1 option:selected').val();
			var gugun = $('#gugun1 option:selected').val();
			sidogugun = sido + ' ' + gugun;
			/* $(this).after('<input type="hidden" name="location" value="'+sidogugun+'">'); */
			$('#location').val(sidogugun);

			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(sidogugun, function(result, status) {
				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {

					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

					// 결과값으로 받은 위치를 마커로 표시합니다
					/*  var marker = new kakao.maps.Marker({
						map : map,
						position : coords
					});  */

					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					map.setCenter(coords);
				
				}
				
			});
		})

		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}),  infowindow = new kakao.maps.InfoWindow({zindex:1}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);

		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다';
		    
		    $("#location_lat").val(latlng.getLat());
		    $("#location_lng").val(latlng.getLng());
		    
		    //지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록
		    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {
		            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
		            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
		            
		            var content = '<div class="bAddr">' +
		                            '<span class="title">법정동 주소정보</span>' + 
		                            detailAddr + 
		                        '</div>';

		            // 마커를 클릭한 위치에 표시합니다 
		            marker.setPosition(mouseEvent.latLng);
		            marker.setMap(map);

		            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
		            infowindow.setContent(content);
		            infowindow.open(map, marker);
		            
		    		
		    		// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		    		searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		        }   
		    });
		    
		});
		
		// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'idle', function() {
		    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});

		function searchAddrFromCoords(coords, callback) {
		    // 좌표로 행정동 주소 정보를 요청합니다
		    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);  
		}

		function searchDetailAddrFromCoords(coords, callback) {
		    // 좌표로 법정동 상세 주소 정보를 요청합니다
		    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}

		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		        for(var i = 0; i < result.length; i++) {
		            // 행정동의 region_type 값은 'H' 이므로
		            if (result[i].region_type === 'H') {
		            	console.log(result[i]);
			            console.log(result[i].region_1depth_name);
			            console.log(result[i].region_2depth_name);
			            
			            var sido1Val = result[i].region_1depth_name;
			            var gugun1Val = result[i].region_2depth_name;
			            var dong1Val = result[i].region_3depth_name;
			            
			            $("#sido1").val(sido1Val);
			            new sojaeji('sido1', 'gugun1');
			      		if(gugun1Val!=""){
			      			$("#gugun1").val(gugun1Val); 
			      		}else{
			      			$("#gugun1").val(dong1Val);
			      		}
			      		
			            
						
						sidogugun = sido1Val + ' ' + gugun1Val;
						$('#location').val(sidogugun);
		                break;
		            }
		        }
		    }    
		}

	</script>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />