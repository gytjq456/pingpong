<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<style>
	#apply_start_cal, #apply_end_cal, #start_date_cal, #end_date_cal{display: none;}
	.sun{color: #ef3333;}
	.sat{color: #2107e0;}
	.active{background-color: dodgerblue; color: #fff;}
	.group_sub{width: 10%; vertical-align: center;}
	.vertical_top{vertical-align: top; margin-top: 3px;}
	#hobby_type{display: none;}
	#map{margin-top: 10px;}
</style>
<script>
	$(function(){
		$('#apply_start').datepicker({ dateFormat: 'yy-mm-dd' });
		$('#apply_end').datepicker({ dateFormat: 'yy-mm-dd' });
		$('#start_date').datepicker({ dateFormat: 'yy-mm-dd' });
		$('#end_date').datepicker({ dateFormat: 'yy-mm-dd' });

		$('#max_num').on('keyup', function(){
			var num = $(this).val();
			var regex = /^[0-9]*$/;
			if (!regex.test(num)) {
				alert('숫자만 입력 가능합니다.');
				$(this).val('');
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
					<p>새 그룹 등록하기</p>
				</div>
				<div class="card_body" id="find_group_write">
					<form action="/group/writeProc" id="writeProc" name="writeProc" method="post">
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>제목</h4>
							</div>
							<div class="group_sub_input"><input type="text" name="title" id="title"></div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>유형</h4>
							</div>
							<div class="group_sub_input">
								<c:forEach var="hbdto" items="${hblist}">
									<input type="checkbox" name="hobby" class="hobby_list" id="${hbdto.seq}" value="${hbdto.hobby}"><label for="${hbdto.seq}">${hbdto.hobby}</label>
								</c:forEach>
								<input type="text" name="hobby_type" id="hobby_type">
							</div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>모집 기간</h4>
							</div>
							<div class="group_sub_input calendar_wrapper">
								<label for="apply_start" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></label>
								<input type="text" name="apply_start" id="apply_start" class="cal_input" readonly>
								<span class="between_calendar">~</span>
								<label for="apply_end" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></label>
								<input type="text" name="apply_end" id="apply_end" class="cal_input" readonly><br>
							</div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>진행 기간</h4>
							</div>
							<div class="group_sub_input">
								<label for="start_date" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></label>
								<input type="text" name="start_date" id="start_date" class="cal_input" readonly>
								<span class="between_calendar">~</span>
								<label for="end_date" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></label>
								<input type="text" name="end_date" id="end_date" class="cal_input" readonly><br>
							</div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>최대 인원</h4>
							</div>
							<div class="group_sub_input">
								<input type="text" name="max_num" id="max_num" placeholder="00"><span class="max_num_myung">명</span>
							</div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>장소</h4>
							</div>
							<div class="group_sub_input">
								<input type="text" name="location" id="location" placeholder="**시 **구">
								<select name="sido1" id="sido1"></select>
								<select name="gugun1" id="gugun1"></select>
								<div id="map" style="width: 100%; height: 350px;"></div>
							</div>
						</div>
						<div class="group_write_sub">
							<div class="tit_s3">
								<h4>내용</h4>
							</div>
							<div class="group_sub_input">
								<textarea name="contents" id="contents"></textarea>
							</div>
						</div>
						<div class="btnS1 center">
							<div>
								<input type="button" id="write" onclick="javascript:writeProc_func()" value="등록">
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
		function writeProc_func(){
			var hobbyCheckLength = $("input:checkbox[name='hobby']").length;
			var hobbyList = [];
			
			for (var i = 0; i < hobbyCheckLength; i++) {
				if ($("input:checkbox[name='hobby']:eq(" + i + ")").prop('checked') == true) {
					hobbyList.push($("input:checkbox[name='hobby']:eq(" + i + ")").val());
				}
			}
			console.log(hobbyList);
			$('#hobby_type').val(hobbyList);
			
			$('#writeProc').submit();
		}
		
		new sojaeji('sido1', 'gugun1');
		
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
			// 지도
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 2 // 지도의 확대 레벨
		    };  
		
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체를 생성합니다.
			
			// 지도에 클릭 이벤트를 등록합니다
			// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
			    
			    // 클릭한 위도, 경도 정보를 가져옵니다 
			    var latlng = mouseEvent.latLng; 
			    
				// 지도를 클릭한 위치에 표출할 마커입니다
				var marker = new kakao.maps.Marker({ 
				    // 지도 중심좌표에 마커를 생성합니다 
				    position: map.getCenter() 
				}); 
			    
			    // 마커 위치를 클릭한 위치로 옮깁니다
			    marker.setPosition(latlng);
			    
			    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
			    message += '경도는 ' + latlng.getLng() + ' 입니다';
			    
			    coords = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng());
			    
			 	// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
			    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			 
			 	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
			    kakao.maps.event.addListener(map, 'idle', function() {
			        searchAddrFromCoords(map.getCenter(), displayCenterInfo);
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
			                    inputLocation = detailSplit[0] + ' ' + detailSplit[1];
			                    console.log(inputLocation);
			                    $('#location').val(inputLocation);
			                    $('#sido1').val(detailSplit[0]);
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
	
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });
	
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					// 지도에 표시할 원을 생성합니다
					var circle = new kakao.maps.Circle({
					    center : new kakao.maps.LatLng(result[0].y, result[0].x),  // 원의 중심좌표 입니다 
					    radius: 50, // 미터 단위의 원의 반지름입니다 
					    strokeWeight: 1, // 선의 두께입니다 
					    strokeColor: '#75B8FA', // 선의 색깔입니다
					    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
					    strokeStyle: 'solid', // 선의 스타일 입니다
					    fillColor: '#CFE7FF', // 채우기 색깔입니다
					    fillOpacity: 0.7  // 채우기 불투명도 입니다   
					}); 
			        
			        map.setCenter(coords);
				
					// 지도에 원을 표시합니다 
					circle.setMap(map); 
			    }
			});
		}
	</script>
<jsp:include page="/WEB-INF/views/footer.jsp"/>