<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="group_list" class="inner1200">
				<div class="tit_s1">
					<h2>Group</h2>
					<p>다양한 사람들을 원하시나요?<br>관심사가 비슷한 사람들과 함께 소통해 보세요.</p>
				</div>
				<div class="group_search_box">
					<div class="tab_s1">
						<ul class="clearfix">
							<li class="on"><a href="#;">키워드 검색</a></li>
							<li><a href="#;">달력 검색</a></li>
							<li><a href="#;">지도 검색</a></li>
						</ul>
					</div>
					<div id="tabContWrap">
						<article id="tab_1" class="kewordSch">
							<div class="search_as_keyword">
								<select id="keyword_type">
									<option value="writer_name">작성자</option>
									<option value="title">글제목</option>
									<option value="contents">글내용</option>
								</select>
								<input type="text" name="keyword" id="keyword_input" placeholder="검색어를 입력하세요.">
								<div>
									<span>유형</span>
									<c:forEach var="hbdto" items="${hblist}">
										<input type="checkbox" name="hobby" class="hobby_list" id="${hbdto.seq}" value="${hbdto.hobby}"><label for="${hbdto.seq}">${hbdto.hobby}</label>
									</c:forEach>
									<input type="text" id="selected_hobby" name="hobby_type">
								</div>
								<div>
									<span>기간</span>
									<input type="radio" name="period" class="period" id="short_period" value="단기">
									<label for="short_period">단기(1년 미만)</label>
									<input type="radio" name="period" class="period" id="long_period" value="장기">
									<label for="long_period">장기(1년 이상)</label>
								</div>
								<button type="button" id="searchAsKeyword">이 조건으로 검색</button>
							</div>
						</article>
						<article id="tab_2" class="calendarSch">
							<div class="search_as_calendar">
								<span>기간 선택</span>
								<label for="date_start" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></label>
								<input type="text" name="date_start" id="date_start" class="cal_input" readonly>
								<span class="between_calendar">~</span>
								<label for="date_end" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></label>
								<input type="text" name="date_end" id="date_end" class="cal_input" readonly><br>
								<button type="button" id="search_cal_btn">조회</button>
							</div>
						</article>
						<article id="tab_3" class="mapSch">
							<div class="search_as_map">
								<span>위치 선택</span>
								<input type="text" name="location" id="location">
								<select name="sido1" id="sido1"></select>
								<select name="gugun1" id="gugun1"></select>
								<!-- <div id="map" style="width: 100%; height: 350px;"></div> -->
								<button type="button" id="search_map_btn">조회</button>
							</div>
						</article>
					</div>
				</div>
				<div class="btnS1 left">
					<div><button type="button" id="all" class="ing">전체</button></div>
					<div><button type="button" id="applying" class="ing">모집중</button></div>
					<div><button type="button" id="proceeding" class="ing">진행중</button></div>
					<div><button type="button" id="done" class="ing">마감</button></div>
				</div>
				<div>
					<select id="orderBy">
						<option value="seq">최신순</option>
						<option value="view_count">조회순</option>
						<option value="like_count">추천순</option>
						<option value="app_count">인기순</option>
						<option value="review_point">평점순</option>
					</select>
				</div>
				<div id="listStyle1" class="card_body">
					<c:choose>
						<c:when test="${empty glist}">
							등록된 게시글이 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="glist" items="${glist}">
								<a href="/group/beforeView?seq=${glist.seq}">
									<div class="group_each_wrapper">
										<div><span class="sub_title">작성자</span> ${glist.writer_name}(${glist.writer_id})</div>
										<div><span class="sub_title">제목</span> ${glist.title}</div>
										<div><span class="sub_title">유형</span> ${glist.hobby_type}</div>
										<div><span class="sub_title">모집 기간</span> ${glist.apply_start} ~ ${glist.apply_end}</div>
										<div><span class="sub_title">진행 기간</span> ${glist.start_date} ~ ${glist.end_date}</div>
										<div><span class="sub_title">평점</span> ★ ${glist.review_point}</div>
										<div>
											<span class="sub_title">조회</span> ${glist.view_count}  
											<span class="sub_title">추천</span> ${glist.like_count}  
											<span class="sub_title">리뷰</span> ${glist.review_count}
										</div>
										<c:if test="${glist.applying == 'Y'}">
											<span>모집중</span>  
										</c:if>
										<c:if test="${glist.proceeding == 'Y'}">
											<span>진행중</span>
										</c:if>
										<c:if test="${glist.proceeding == 'N' && glist.applying == 'N'}">
											<span>마감</span>
										</c:if>
									</div>
								</a>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					<div class="navi">${navi}</div>
					<a href="/group/write">그룹 등록하기</a>
				</div>
			</article>
		</section>
	</div>
	<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=033532d2fa35e423d2d5e723c0bfd1fe&libraries=services"></script> -->
	<script>
		$('#date_start').datepicker({ dateFormat: 'yy-mm-dd' });
		$('#date_end').datepicker({ dateFormat: 'yy-mm-dd' });
		
		var orderBy = '${orderBy}';
		if (orderBy != null) {
			$('#orderBy').val(orderBy);
		} else {
			$('#orderBy').val('seq');
		}
		
		$('#orderBy').on('change', function() {
			var orderByVal = $('#orderBy').val();
			
			location.href = '/group/main?orderBy=' + orderByVal;
		})
		
		$('.ing').on('click', function(){
			var orderByVal = $('#orderBy').val();
			var ing = $(this).attr('id');
			
			if (ing == 'all') {
				location.href = '/group/main?orderBy=' + orderByVal;
				
				return false;
			}
			
			location.href = '/group/mainOption?orderBy=' + orderByVal + '&ing=' + ing;
		})
		
		$('#searchAsKeyword').on('click', function(){
			var orderByVal = $('#orderBy').val();
			var selectedHobbyLength = $('.hobby_list:checked').length;
			var selectedHobby = [];
			var keywordType = null;
			var keywordInput = null;
			var periodLength = $('.period:checked').length;
			var period = null;
			
			if (periodLength > 0) {
				period = $('.period:checked').val();
			}
			
			if (selectedHobbyLength > 0) {
				for (var i = 0; i < selectedHobbyLength; i++) {
					selectedHobby[i] = $($('.hobby_list:checked')[i]).val();
				}
				$('#selected_hobby').val(selectedHobby);
			}
			
			var hobbyType = $('#selected_hobby').val();
			
			if ($('#keyword_input').val() != '') {
				var keywordType = $('#keyword_type').val();
				var keywordInput = $('#keyword_input').val();
			} else {
				if ((hobbyType == '') && (period == null)) {
					alert('검색 조건을 선택해 주세요.');
					return false;
				}
			}
			
			location.href = '/group/search?searchType=' + keywordType + '&searchThing=' + keywordInput + '&orderBy=' + orderByVal + '&hobbyType=' + hobbyType + '&period=' + period;
		})
		
		$('#search_cal_btn').on('click', function(){
			var orderByVal = $('#orderBy').val();
			var dateStart = $('#date_start').val();
			var dateEnd = $('#date_end').val();
			
			location.href = '/group/searchDate?dateStart=' + dateStart + '&dateEnd=' + dateEnd + '&orderBy=' + orderByVal;
		})
		
		$('#search_map_btn').on('click', function(){
			var orderByVal = $('#orderBy').val();
			var locationVal = $('#location').val();
			console.log(orderBy + ' ' + location)
			location.href = '/group/searchLocation?location=' + locationVal + '&orderBy=' + orderByVal;
		})
		
		new sojaeji('sido1', 'gugun1');
		
		$('#gugun1').change(function(){
			var sido = $('#sido1 option:selected').val();
			var gugun = $('#gugun1 option:selected').val();
			
			$('#location').val(sido + ' ' + gugun);
			
			//kakaoMapLocation($('#location').val());
		})
		
		/* var inputLocation = $('#location').val();
		
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
		} */
	</script>
<jsp:include page="/WEB-INF/views/footer.jsp"/>