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
							<li id="map_on"><a href="#;">지도 검색</a></li>
						</ul>
					</div>
					<div id="tabContWrap" class="search_wrap">
						<article id="tab_1" class="kewordSch">
							<div class="search_as_keyword">
								<section class="defaultSch">
									<div class="tit">검색어</div>
									<div class="schCon ">
										<select id="keyword_type">
											<option value="writer_name">작성자</option>
											<option value="title">글제목</option>
											<option value="contents">글내용</option>
										</select>
										<input type="text" name="keyword" id="keyword_input" placeholder="검색어를 입력하세요.">
									</div>
								</section>
								<section>
									<div class="tit">유형</div>
									<div class="schCon">
										<ul class="checkBox_s1">
										<c:forEach var="hbdto" items="${hblist}">
											<li class="<c:if test="${hbdto.hobby == '기타'}">etcSch</c:if>">
												<input type="checkbox" name="hobby" class="hobby_list" id="${hbdto.seq}" value="${hbdto.hobby}">
												<label for="${hbdto.seq}"><span></span>${hbdto.hobby}</label>
												<c:if test="${hbdto.hobby == '기타'}">
													<input type="hidden" id="selected_hobby" name="hobby_type">
												</c:if>
										</c:forEach>
										</ul>
									</div>
								</section>
								<section>
									<div class="tit">기간</div>
									<div class="schCon">
										<ul class="radio_s1">
											<li>
												<input type="radio" name="period" class="period" id="short_period" value="단기">
												<label for="short_period"><span></span>단기(1년 미만)</label>
											</li>
											<li>
												<input type="radio" name="period" class="period" id="long_period" value="장기">
												<label for="long_period"><span></span>장기(1년 이상)</label>
											</li>
										</ul>
									</div>
								</section>
								<div class="btnS1 center">
									<div><button type="button" id="searchAsKeyword">검색</button></div>
								</div>
							</div>
						</article>
						<article id="tab_2" class="calendarSch">
							<div class="search_as_calendar">
								<div class="scheduleSchBox">
									<div><span>기간 선택</span></div>
									<div class="schBar">
										<p>
											<label for="date_start" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></label>
											<input type="text" name="date_start" id="date_start" class="cal_input" readonly>
										</p>
										<p>
											<span class="between_calendar">~</span>
										</p>
										<p>
											<label for="date_end" class="calendar_icon"><i class="fa fa-calendar" aria-hidden="true"></i></label>
											<input type="text" name="date_end" id="date_end" class="cal_input" readonly>
										</p>
									</div>
								</div>
								
								
								<div class="btnS1 center">
									<div><button type="button" id="search_cal_btn">검색</button></div>
								</div>
							</div>
						</article>
						<article id="tab_3" class="mapSch">
							<div class="search_as_map">
							
							
								<section id="mapWrap">
									<div class="mapSelect">
										<input type="hidden" name="location" id="location">
										<select name="sido1" id="sido1"></select>
										<select name="gugun1" id="gugun1"></select>		
									</div>
									<div id="map" style="width: 100%; height: 350px;"></div>
								</section>							
								<!-- <div id="location_text"></div> -->
								
								
								
								
								
								
								
								<div class="btnS1 center">
									<div><button type="button" id="search_map_btn">검색</button></div>
								
								</div>
							</div>
						</article>
					</div>
				</div>
				<div class="search_btn_style">
					<div class="btnS1 left">
						<div><button type="button" id="all" class="ing">전체</button></div>
						<div><button type="button" id="applying" class="ing">모집중</button></div>
						<div><button type="button" id="proceeding" class="ing">진행중</button></div>
						<div><button type="button" id="done" class="ing">마감</button></div>
					</div>
					<div class="btnS1 right">
						<div>
							<select id="orderBy">
								<option value="seq">최신순</option>
								<option value="view_count">조회순</option>
								<option value="like_count">추천순</option>
								<option value="app_count">인기순</option>
								<option value="review_point">평점순</option>
							</select>
						</div>
					</div>
				</div>
				<div id="listStyle1" class="card_body group_list_wrapper">
					<c:choose>
						<c:when test="${empty glist}">
							등록된 게시글이 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="glist" items="${glist}">
								<div class="back_and_wrap item">
									<a href="/group/beforeView?seq=${glist.seq}" class="group_list_a">
										<div class="each_profile"><img src="/resources/img/sub/userThum.jpg"/></div>
										<c:if test="${fn:startsWith(glist.hobby_type, '영화')}">
											<div class="group_background background_pink"></div>
										</c:if>
										<c:if test="${fn:startsWith(glist.hobby_type, '공연')}">
											<div class="group_background background_purple"></div>
										</c:if>
										<c:if test="${fn:startsWith(glist.hobby_type, '음악')}">
											<div class="group_background background_blue"></div>
										</c:if>
										<c:if test="${fn:startsWith(glist.hobby_type, '독서')}">
											<div class="group_background background_brown"></div>
										</c:if>
										<c:if test="${fn:startsWith(glist.hobby_type, '스포츠')}">
											<div class="group_background background_red"></div>
										</c:if>
										<c:if test="${fn:startsWith(glist.hobby_type, '게임')}">
											<div class="group_background background_yellow"></div>
										</c:if>
										<c:if test="${fn:startsWith(glist.hobby_type, '여행')}">
											<div class="group_background background_green"></div>
										</c:if>
										<c:if test="${fn:startsWith(glist.hobby_type, '요리')}">
											<div class="group_background background_orange"></div>
										</c:if>
										<c:if test="${fn:startsWith(glist.hobby_type, '기타')}">
											<div class="group_background background_gray"></div>
										</c:if>
										<div class="group_each_wrapper">
											<div class="each_writer"><span class="each_name">${glist.writer_name}</span>(${glist.writer_id})</div>
											<div class="each_title">${glist.title}</div>
											<div class="each_body">
												<div><span class="sub_title">장소</span> <p>${glist.location}</p></div>
												<div><span class="sub_title">유형</span> <p>${glist.hobby_type}</p></div>
												<div><span class="sub_title">모집</span>
													<c:if test="${glist.applying == 'N'}">
													 - 
													</c:if>
													<c:if test="${glist.applying == 'Y'}">
													 <p>${glist.apply_start} ~ ${glist.apply_end}</p>
													</c:if>
												</div>
												<div><span class="sub_title">진행</span> <p>${glist.start_date} ~ ${glist.end_date}</p></div>
												<div><span class="sub_title">평점</span> <p><i class="fa fa-star" aria-hidden="true"></i> ${glist.review_point}</p></div>
											</div>
											<div class="countList_s2">
												<span class="sub_title"><i class="fa fa-eye"></i>${glist.view_count}</span>   
												<span class="sub_title"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i>${glist.like_count}</span>   
												<span class="sub_title"><i class="fa fa-commenting-o" aria-hidden="true"></i>${glist.review_count}</span> 
												<span class="sub_title"><i class="fa fa-file-text-o" aria-hidden="true"></i>${glist.app_count}</span> 
											</div>
											<div class="status">
												<c:if test="${glist.applying == 'Y'}">
													<div class="group_applying">모집중</div>  
												</c:if>
												<c:if test="${glist.proceeding == 'Y'}">
													<div class="group_proceeding">진행중</div>
												</c:if>
												<c:if test="${glist.proceeding == 'B'}">
													<div class="group_ready">준비중</div>
												</c:if>
												<c:if test="${glist.proceeding == 'N' && glist.applying == 'N'}">
													<div class="group_done">마감</div>
												</c:if>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="btnS1 right ">
					<div><a href="/group/write" class="on">그룹 등록하기</a></div>
				</div>
				<div id="listNav">${navi}</div>
			</article>
		</section>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=033532d2fa35e423d2d5e723c0bfd1fe&libraries=services"></script>
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
		
		$('.hobby_list').change(function(){
			if($(this).is(':checked')) {
				var checkedCount = $('.hobby_list:checked').length;
				
				if (checkedCount > 3) {
					alert('유형은 세 개까지만 선택 가능합니다.');
					$(this).prop('checked', false);
				}
			}
		})
		
		$('#searchAsKeyword').on('click', function(){
			var orderByVal = $('#orderBy').val();
			var selectedHobbyLength = $('.hobby_list:checked').length;
			var selectedHobby = [];
			var keywordType = null;
			var keywordInput = null;
			var periodLength = $('.period:checked').length;
			var period = null;
			var hobbyType = null;
			
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
			
			location.href = '/group/search?keywordType=' + keywordType + '&keywordValue=' + keywordInput + '&orderBy=' + orderByVal + '&hobbyType=' + hobbyType + '&period=' + period;
		})
		
		$('#search_cal_btn').on('click', function(){
			var orderByVal = $('#orderBy').val();
			var dateStart = $('#date_start').val();
			var dateEnd = $('#date_end').val();
			
			location.href = '/group/searchDate?start_date=' + dateStart + '&end_date=' + dateEnd + '&orderBy=' + orderByVal;
		})
		
		$('#search_map_btn').on('click', function(){
			var orderByVal = $('#orderBy').val();
			var locationVal = $('#location').val();
			console.log(orderBy + ' ' + location)
			location.href = '/group/searchLocation?location=' + locationVal + '&orderBy=' + orderByVal;
		})
		
		new sojaeji('sido1', 'gugun1');
		// 지도
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.563814978331, 126.997555182057), // 지도의 중심좌표
	        level: 2 // 지도의 확대 레벨
	    };
		
		$('#map_on').on('click', function(){
			setTimeout(function(){
				var marker;
				var circle;
				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				$('#gugun1').change(function(){
					var sido = $('#sido1 option:selected').val();
					var gugun = $('#gugun1 option:selected').val();
					
					$('#location').val(sido + ' ' + gugun);
					$('#location_text').html(sido + ' ' + gugun);
					
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
					                    $('#location_text').html(inputLocation);
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
			}, 100)
		})
	</script>
<jsp:include page="/WEB-INF/views/footer.jsp"/>