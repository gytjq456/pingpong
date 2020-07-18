<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	#apply_start_cal, #apply_end_cal, #start_date_cal, #end_date_cal{display: none;}
	.sun{color: #ef3333;}
	.sat{color: #2107e0;}
	.active{background-color: dodgerblue; color: #fff;}
	.group_sub{width: 10%; vertical-align: center;}
	.vertical_top{vertical-align: top; margin-top: 3px;}
	#hobby_type{display: none;}
	#map{margin-top: 10px;}
	#updateProc .wordsize { float: right; transform: translate(-15px, -70px); color: #999; }
	#find_group_write #title { padding-right: 76px; }
</style>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script>
	$(function(){
		var apply_start = '${gdto.apply_start}';
		var apply_end = '${gdto.apply_end}';
		var start_date = '${gdto.start_date}';
		var end_date = '${gdto.end_date}';
		
		$("input,textarea").blur(function(){
			var thisVal = $(this).val();
			$(this).val(textChk(thisVal,$(this)));
		})
	 	$(".note-editable").blur(function(){
			var thisVal = $(this).html();
			$(this).text(textChk(thisVal,$(this)));
		});
		
		function textChk(thisVal, obj){
			var replaceId  = /(script)/gi;
			var textVal = thisVal;
		    if (textVal.length > 0) {
		        if (textVal.match(replaceId)) {
		        	console.log(obj)
		        	if(obj.val().length){
			        	obj.val("");
			        	textVal = obj.val();
		        	}else{
			        	obj.html("");
			        	textVal = obj.val();
		        	}
		        }
		    }
		    return textVal;
		}
		
		$('#apply_start').datepicker({
			dateFormat: 'yy-mm-dd',
			minDate: new Date(apply_start),
			maxDate: new Date(apply_start)
		}).datepicker('setDate', new Date(apply_start));
		
		$('#apply_end').datepicker({
			dateFormat: 'yy-mm-dd',
			minDate: new Date($('#apply_start').val())
		}).datepicker('setDate', new Date(apply_end));
		
		$('#start_date').datepicker({
			dateFormat: 'yy-mm-dd',
			minDate: 0,
			onClose: function(){
				$('#end_date').datepicker({
					dateFormat: 'yy-mm-dd',
					minDate: new Date($('#start_date').val())
				});
			}
		}).datepicker('setDate', new Date(start_date));
		
		$('#end_date').val(end_date);
		
		$('#start_date').on('change', function(){
			var endDate = $('#end_date').val();
			if (endDate != '') {
				$('#end_date').val('');
			}
		});
		
		$('#end_date').on('change', function(){
			var applyEnd = new Date($('#apply_end').val());
			var endDate = new Date($('#end_date').val());
			
			if (endDate < applyEnd) {
				alert('모집 마감 날짜보다 이전 날짜로 설정하실 수 없습니다.');
				$('#end_date').val('');
			}
		})
		
		var selectedHobbyList = '${gdto.hobby_type}';
		var selectedHobbyArr = selectedHobbyList.split(',');
		var hobbyCount = $("input:checkbox[name='hobby']").length;
		var hobbyArrValue = [];
		
		for (var i = 0; i < hobbyCount; i++) {
			hobbyArrValue.push($("input:checkbox[name='hobby']:eq(" + i + ")").val());
		}
		
		var hobbyArr = $("input:checkbox[name='hobby']");
		
		for (var i = 0; i < hobbyCount; i++) {
			for (var j = 0; j < selectedHobbyList.length; j++) {
				if (hobbyArrValue[i] == selectedHobbyArr[j]) {
					$(hobbyArr[i]).attr('checked', 'true');
				}
			}
		}
		
		$('#max_num').on('keyup', function(){
			var num = $(this).val();
			var regex = /^[0-9]*$/;
			if (!regex.test(num)) {
				alert('숫자만 입력 가능합니다.');
				$(this).val('');
			}
		})
		
		$('#max_num').focusout(function(){
			var tryModify = $('#max_num').val();
			var curNum = ${gdto.cur_num};
			if (tryModify < curNum || tryModify == 1) {
				alert('2명 이하 또는 현재 인원보다 적은 인원으로 설정하실 수 없습니다.');
				$('#max_num').val('${gdto.max_num}');
			}
		})
		
		var setWord = '${gdto.title}';
		var setWordSize = setWord.length;
		$('#updateProc .wordsize .current').text(setWordSize);
		
		$("#title").keyup(function(){
			var word = $(this).val();
			var wordSize = word.length;
			if(wordSize <= 100){
				$("#updateProc .wordsize .current").text(wordSize);
			}else{
				word = word.substr(0,100);
				$("#updateProc .wordsize .current").text(word.length);
				$(this).val(word);
				alert("제목은  100자 이하로 등록해 주세요.");
			}
		})
		
		$('#contents').summernote({
			height: 600,
			callbacks: {
				onImageUpload: function(files) {
					uploadSummernoteImageFile(files[0], this);
				}
			}
		})
		
		$('#back').on('click', function(){
			location.href = "/group/main?orderBy=seq&ing=all";
		})
		
		function uploadSummernoteImageFile(file, editor) {
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data: data,
				type: "POST",
				url: "/group/imgUpload",
				contentType: false,
				processData: false,
				success: function(data) {
					$(editor).summernote('insertImage', data.url);
				}
			})
		}
	})
</script>
	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="group_write" class="inner1200">
				<div class="tit_s1">
					<h2>Group</h2>
					<p>그룹 수정하기</p>
				</div>
				<div class="card_body" id="find_group_write">
					<form action="/group/updateProc?seq=${gdto.seq}" id="updateProc" name="updateProc" method="post">
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>제목</h4>
							</div>
							<div class="group_sub_input"><input type="text" name="title" id="title" value="${gdto.title}"></div>
							<div class="wordsize"><span class="current">0</span>/100</div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>유형</h4>
							</div>
							<div class="group_sub_input">
								<ul class="checkBox_s1">
										<c:forEach var="hbdto" items="${hblist}">
									<li>
											<input type="checkbox" name="hobby" class="hobby_list" id="${hbdto.seq}" value="${hbdto.hobby}">
											<label for="${hbdto.seq}"><span></span>${hbdto.hobby}</label>
									</li>
										</c:forEach>
								</ul>
								<input type="text" name="hobby_type" id="hobby_type" value="${gdto.hobby_type}">
							</div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>모집 기간</h4>
								<span class="notice">*모집 기간 시작 날짜는 오늘 날짜 이외의 날짜로 설정이 불가능합니다.</span>
							</div>
							<div class="group_sub_input calendar_wrapper">
								<span id="apply_start_cal_btn" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
								<input type="text" name="apply_start" id="apply_start" class="cal_input" value="${gdto.apply_start}" readonly>
								<span class="between_calendar">~</span>
								<span id="apply_end_cal_btn" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
								<input type="text" name="apply_end" id="apply_end" class="cal_input" value="${gdto.apply_end}" readonly><br>
							</div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>진행 기간</h4>
								<span class="notice">*시작 날짜를 설정해야만 종료 날짜를 설정하실 수 있습니다.</span>
							</div>
							<div class="group_sub_input">
								<span id="start_date_cal_btn" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
								<input type="text" name="start_date" id="start_date" class="cal_input" value="${gdto.start_date}" readonly>
								<span class="between_calendar">~</span>
								<span id="end_date_cal_btn" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
								<input type="text" name="end_date" id="end_date" class="cal_input" value="${gdto.end_date}" readonly><br>
							</div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>최대 인원</h4>
								<span class="notice">*최소 2명부터 최대 100명까지 설정 가능합니다.</span>
							</div>
							<div class="group_sub_input">
								<input type="text" name="max_num" id="max_num" value="${gdto.max_num}" placeholder="00"> 명
							</div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>장소</h4>
								<span class="notice">*정확한 장소를 클릭하여 마커 표시를 해 주세요. 마커로 표시된 장소로 저장되어 보여집니다.</span>
							</div>
							<div class="group_sub_input">
								<input type="text" name="location" id="location" value="${gdto.location}" placeholder="**시 **구">
								<input type="text" name="location_lat" id="location_lat" value="${gdto.location_lat}">
								<input type="text" name="location_lng" id="location_lng" value="${gdto.location_lng}">
								<select name="sido1" id="sido1"></select>
								<select name="gugun1" id="gugun1"></select>
								<div id="map" style="width: 100%; height: 350px;"></div>
							</div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>내용</h4>
								<span class="notice">*그룹을 소개할 내용을 작성하는 곳입니다. 정확한 모임 날짜, 시간, 장소, 참여 가능 기준 등을 기재하시면 도움이 됩니다.</span>
							</div>
							<div class="group_sub_input">
								<textarea name="contents" id="contents">${gdto.contents}</textarea>
							</div>
						</div>
						<div class="btnS1 center">
							<div>
								<input type="button" id="update" onclick="javascript:updateProc_func()" value="수정">
							</div>
							<div><button type="button" id="back">목록</button></div>
						</div>
					</form>
				</div>
			</article>
		</section>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=033532d2fa35e423d2d5e723c0bfd1fe&libraries=services"></script>
	<script>
		function updateProc_func(){
			var hobbyCheckLength = $("input:checkbox[name='hobby']").length;
			var hobbyList = [];
			
			for (var i = 0; i < hobbyCheckLength; i++) {
				if ($("input:checkbox[name='hobby']:eq(" + i + ")").prop('checked') == true) {
					hobbyList.push($("input:checkbox[name='hobby']:eq(" + i + ")").val());
				}
			}
			console.log(hobbyList);
			$('#hobby_type').val(hobbyList);
			
			
			var noteObj = $(".note-editable");
			var replaceId  = /(script)/gi;
			if(noteObj.text().match(replaceId)){
				alert("부적절한 내용이 들어가있습니다.")
				noteObj.focus();
				noteObj.html("")
				return false;
			}
			
			
			$('#updateProc').submit();
		}
		
		new sojaeji('sido1', 'gugun1');
		var inputLocation = $('#location').val();
		var inputSplit = inputLocation.split(' ');
		if (inputSplit.length > 2) {
			inputSplit[1] = inputSplit[1] + ' ' + inputSplit[2];
		}
        $('#sido1').val(inputSplit[0]);
	    new sojaeji('sido1', 'gugun1');
        $('#gugun1').val(inputSplit[1]);
		var marker;
		var circle;
		var location_lat = '${gdto.location_lat}';
		var location_lng = '${gdto.location_lng}';
		// 지도
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(location_lat, location_lng), // 지도의 중심좌표
	        level: 2 // 지도의 확대 레벨
	    };  
		
		if ($('#map').html() == '') {
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		}
		
		$('#gugun1').change(function(){
			var sido = $('#sido1 option:selected').val();
			var gugun = $('#gugun1 option:selected').val();
			
			$('#location').val(sido + ' ' + gugun);
			
			kakaoMapLocation($('#location').val());
		})
		
		var inputLocation = $('#location').val();
		
		if (inputLocation == '') {
			inputLocation = '서울시 중구';
		}
		kakaoMapLocation(inputLocation);
		
		function kakaoMapLocation(inputLocation){
			var geocoder = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체를 생성합니다.
			
			// 지도에 클릭 이벤트를 등록합니다
			// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
			    
			    // 클릭한 위도, 경도 정보를 가져옵니다 
			    var latlng = mouseEvent.latLng; 
			    
			    geocoder.addressSearch(inputLocation, function(result, status) {
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
				    	
				        var coords = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng());
						
				        // 결과값으로 받은 위치를 마커로 표시합니다
				        if (marker == null) {
					        marker = new kakao.maps.Marker({
					            map: map,
					            position: coords
					        });
				        }
				        
				        marker.setPosition(coords);
		
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						// 지도에 표시할 원을 생성합니다
						if (circle == null) {
							circle = new kakao.maps.Circle({
							    center : new kakao.maps.LatLng(latlng.getLat(), latlng.getLng()),  // 원의 중심좌표 입니다 
							    radius: 50, // 미터 단위의 원의 반지름입니다 
							    strokeWeight: 1, // 선의 두께입니다 
							    strokeColor: '#75B8FA', // 선의 색깔입니다
							    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
							    strokeStyle: 'solid', // 선의 스타일 입니다
							    fillColor: '#CFE7FF', // 채우기 색깔입니다
							    fillOpacity: 0.7  // 채우기 불투명도 입니다   
							}); 
						}
				        
				        map.setCenter(coords);
				        circle.setPosition(coords);
					
						// 지도에 원을 표시합니다 
						circle.setMap(map); 
				    }
				});
			    
			    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
			    message += '경도는 ' + latlng.getLng() + ' 입니다';
			    console.log(message)
			    var locationLat = latlng.getLat();
				var locationLng = latlng.getLng();
			    $('#location_lat').val(locationLat);
			    $('#location_lng').val(locationLng);
			    
			    coords = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng());
			    
			 	// 지도 마커 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
			    kakao.maps.event.addListener(map, 'idle', function() {
			        searchAddrFromCoords(marker.getPosition(), displayCenterInfo);
			    }); 
			    
			    function searchAddrFromCoords(coords, callback) {
				    // 좌표로 행정동 주소 정보를 요청합니다
				    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
				}
			    
			 	// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
			    function displayCenterInfo(result, status) {
			        if (status === kakao.maps.services.Status.OK) {
			            for(var i = 0; i < result.length; i++) {
			                // 행정동의 region_type 값은 'H' 이므로
			                if (result[i].region_type === 'H') {
			                    var detailClickedLocation = result[i].address_name;
			                    var detailSplit = detailClickedLocation.split(' ');
			                    var detailThird = detailSplit[2];
			                    var detailThirdLast = detailThird.charAt(detailThird.length - 1);
			                    if (detailThirdLast == '구') {
			                    	detailSplit[1] = detailSplit[1] + ' ' + detailSplit[2];
			                    }
		                    	inputLocation = detailSplit[0] + ' ' + detailSplit[1];
			                    console.log(inputLocation);
			                    $('#location').val(inputLocation);
			                    $('#sido1').val(detailSplit[0]);
							    new sojaeji('sido1', 'gugun1');
			                    $('#gugun1').val(detailSplit[1]);
			                    break;
			                }
			            }
			        }    
			    }
			});
			geocoder.addressSearch(inputLocation, function(result, status) {
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			    	
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			        var locationLat = result[0].y;
					var locationLng = result[0].x;
					$('#location_lat').val(locationLat);
				    $('#location_lng').val(locationLng);
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        if (marker == null) {
				        marker = new kakao.maps.Marker({
				            map: map,
				            position: coords
				        });
			        }
			        
			        marker.setPosition(coords);
	
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					// 지도에 표시할 원을 생성합니다
					if (circle == null) {
						circle = new kakao.maps.Circle({
						    center : new kakao.maps.LatLng(result[0].y, result[0].x),  // 원의 중심좌표 입니다 
						    radius: 50, // 미터 단위의 원의 반지름입니다 
						    strokeWeight: 1, // 선의 두께입니다 
						    strokeColor: '#75B8FA', // 선의 색깔입니다
						    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						    strokeStyle: 'solid', // 선의 스타일 입니다
						    fillColor: '#CFE7FF', // 채우기 색깔입니다
						    fillOpacity: 0.7  // 채우기 불투명도 입니다   
						});
					}
			        
			        map.setCenter(coords);
			        circle.setPosition(coords);
				
					// 지도에 원을 표시합니다 
					circle.setMap(map); 
			    }
			});
		}
	</script>
<jsp:include page="/WEB-INF/views/footer.jsp"/>