<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/header.jsp" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=521d781cfe9fe7597693f2dc29a10601&libraries=services"></script>
<style>
/* .profile{width:50px; height:100px;}
.wrapper{border: 1px solid black; float: left; width: 25%;}
.listWrapper{overflow:hidden;} 
.bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;} */
</style>
<script>

	$(function() {
		
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
		
		$('#start_date').datepicker({ dateFormat: 'yy-mm-dd'});
		$('#end_date').datepicker({ dateFormat: 'yy-mm-dd'});

		$("#listClick>section").each(function() {
			var text = $(this).find(".title").text();
			var seq = $(this).data("seq");
			console.log(seq);
			$(this).children("article").wrap(
					'<a href="/tutor/lessonView?seq=' + seq + '">')
		})
		
		//orderBy 페이지 전환되도 안바뀌게
 		var orderBy = '${orderBy}';
		console.log(orderBy);
		if (orderBy != null) {
			$('#orderBy').val(orderBy);
		} else {
			$('#orderBy').val(seq);
		}
		
		//keywordSelect 페이지 전환되도 안바뀌게
		var keywordSelect = '${keywordSelect}';
		console.log(keywordSelect);
		if(keywordSelect!=null){
			$('#keywordSelect').val(keywordSelect);
		}else{
			$('#keywordSelect').val(name);
		}
		
		var keyword = '${keyword}';
		console.log(keyword);
		if(keyword!=null){
			$('#keyword').val(keyword);
		}
		
/* 		var topSearch = '${topSearch}';
		console.log(topSearch);
		if(topSearch!=null){
			$('.topSearch').val(topSearch);
		} */

		$("#orderBy").on("change",function(){
			var orderbyVal = $("#orderBy").val();
			var selectVal = $("#keywordSelect").val();
			location.href="/tutor/lessonList?orderBy="+orderbyVal+"&keywordSelect="+selectVal;
		})
		
		/* 검색안돼~~~~ 다시해~~~ */
		$(".ing").on("click", function(){
			console.log($(this).attr('id'));
			var orderbyVal = $("#orderBy").val();
			var period = $(this).attr('id');
			var selectVal = $("#keywordSelect").val();
			var keywordVal = $("#keyword").val();
			var topSearchVal = $(".topSearch").text();
			
			if(period == 'all'){
				location.href="/tutor/lessonList?orderBy="+orderbyVal+"&keywordSelect="+selectVal;
				return false;
			}
			location.href="/tutor/lessonListPeriod?orderBy="+orderbyVal+"&period="+period+"&keywordSelect="
					+selectVal+"&keyword="+keywordVal;

		})

		 //키워드로 검색
		$("#searchkeyword").on("click", function(){
			var topSearchVal = $(this).text();
			//여기서
			var selectVal = $("#keywordSelect").val();
			//검색바 내용
			var keywordVal = $("#keyword").val();
			//조회순 최신순 ...
			var orderbyVal = $("#orderBy").val();
			
			location.href="/tutor/searchKeword?keywordSelect="+selectVal+"&keyword="+keywordVal+"&orderBy="+orderbyVal;
		})
		
		//달력으로 검색
		$("#searchcalendar").on("click", function(){
			var orderByVal = $('#orderBy').val();
			var start_dateVal = $("#start_date").val();
			var end_dateVal = $("#end_date").val();
			location.href="/tutor/searchDate?start_date="+start_dateVal+"&end_date="+end_dateVal+"&orderBy="+orderByVal;
		})
		
		//지도로 검색
		$("#searchMap").on("click", function(){
			var locationVal = $("#location").val();
			var orderByVal = $('#orderBy').val();
			
			location.href="/tutor/searchMap?location="+locationVal+"&orderBy="+orderByVal;
		}) 

	
	})
</script>


<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<!-- lessonList -->
		<article id="group_list" class="inner1200">

			<div class="tit_s1">
				<h2>강의 목록</h2>
				<p>전문적으로 배워보고싶나요?<br>전문 튜터를 통해 강의를 들어보세요.</p>
			</div>
			
			<!-- 검색 3가지 -->
			<div class="tab_s1">
				<ul class="clearfix">
					<li class="on topSearch" value="topKeyword"><a href="#;" >키워드 검색</a></li>
					<li class="topSearch" value="topCalendar"><a href="#;" >달력 검색</a></li>
					<li class="topSearch" value="topMap"><a id="map_on" href="#;" >지도 검색</a></li>
				</ul>
			</div>

			<div id="tabContWrap" class="search_wrap">
				<article id="tab_1" class="kewordSch ">
					<div class="search_as_keyword">
						<section id="keywordSelect" class="defaultSch">
							<div class="tit">검색어</div>
							<div class="schCon ">
								<select id="keyword_type">
									<option value="name">튜터</option>
									<option value="title">글제목</option>
									<option value="curriculum">글내용</option>
								</select>

								<input type="text" id="keyword" name="keyword">
							</div>
						</section>	
						<div class="btnS1 center">
							<div><input type="button" id="searchkeyword" value="검색"></div>
						</div>				
					</div>
				</article>
				
				<article id="tab_2" class="calendarSch">
					<div class="search_as_calendar">
						<div class="scheduleSchBox">
							<div><span>수업기간</span></div>
							<div class="schBar">
								<p>
								<label for="start_date" class="calendar_icon"> 
									<i class="fa fa-calendar" aria-hidden="true"></i>
								</label>
								<input type="text" id="start_date" name="start_date" size="12">
								</p>
								<p>
									<span class="between_calendar">~</span>
								</p> 
								<p>
									<label for="end_date" class="calendar_icon"> 
										<i class="fa fa-calendar" aria-hidden="true"></i>
									</label>
									<input type="text" id="end_date" name="end_date" size="12"> 
								</p>
							</div>
						</div>
						<div class="btnS1 center">
							<div><input type="button" id="searchcalendar" value="검색하기"></div>
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
							<div id="map" style="width:500px;height:400px;"></div>
						</section>	
					</div>
					<div class="btnS1 center">
						<div><input type="button" id="searchMap" value="검색하기"></div>
					</div>
				
				</article>
			</div>

			<!-- 정렬 전체 모집중 진행중 마감 -->
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
							<option value="review_point">평점순</option>
						</select>
					</div>
				</div>
			</div>			
			
			<div class="listWrapper card_body group_list_wrapper">
				<c:choose>
					<c:when test="${empty lessonlist}">
						<div class="row">
							<div class='col-12'>강의가 없습니다.</div>
						</div>
					</c:when>
					<c:otherwise>
						<div id="listClick">
							<c:forEach var="i" items="${lessonlist}">

								<section data-seq="${i.seq}" class="back_and_wrap item">
									<article class="wrapper ">
										<div class="each_profile"><img src="/upload/member/${i.id}/${i.sysname}"></div>
										<c:if test="${fn:startsWith(i.language, '한국어')}">
											<div class="group_background background_red"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '일본어')}">
											<div class="group_background background_red"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '중국어')}">
											<div class="group_background background_red"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '힌디어')}">
											<div class="group_background background_yellow"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '태국어')}">
											<div class="group_background background_yellow"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '인도네시아')}">
											<div class="group_background background_yellow"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '베트남어')}">
											<div class="group_background background_yellow"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '러시아어')}">
											<div class="group_background background_yellow"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '포르투갈어')}">
											<div class="group_background background_purple"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '스페인어')}">
											<div class="group_background background_purple"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '영어')}">
											<div class="group_background background_blue"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '프랑스어')}">
											<div class="group_background background_green"></div>
										</c:if>
										<c:if test="${fn:startsWith(i.language, '독일어')}">
											<div class="group_background background_green"></div>
										</c:if>
										<div class="group_each_wrapper">
											<div class="each_writer"><span class="each_name name">${i.name }</span></div>
											<div class="each_title title">${i.title}</div>
											<div class="each_body">
												<div class="language">
													<span class="sub_title">언어</span>
													<p>${i.language}</p>
												</div>
												<div class="price">
													<span class="sub_title">가격</span>
													<p>${i.price} 원</p>
													<!-- <span class="badge badge-danger">New</span> -->
												</div>
												<div class="apply_date">
													<span class="sub_title">모집</span>
													<p>${i.apply_start} ~ ${i.apply_end }</p>
												</div>
												<div class="lesson_date">
													<span class="sub_title">수업</span>
													<p>${i.start_date} ~ ${i.end_date }</p>
												</div>
											</div>
											<div class="countList_s2">
												<div class="view_count sub_title"><i class="fa fa-eye"></i>${i.view_count}</div>
												<div class="like_count sub_title"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i>${i.like_count}</div>
												<div class="review_point sub_title"><i class="fa fa-star" aria-hidden="true"></i>${i.review_point}</div>
												<div class="review_count sub_title"><i class="fa fa-commenting-o" aria-hidden="true"></i>${i.review_count}</div>
											</div>
											<div class="status clearfix">
												<c:if test="${i.applying == 'Y'}">
													<div class="group_applying">모집중</div> 
												</c:if>
												<c:if test="${i.proceeding == 'Y'}">
													<div class="group_proceeding">진행중</div>
												</c:if>
												<c:if test="${i.proceeding == 'N' && i.applying == 'N'}">
													<div class="group_done">마감</div>
												</c:if>
											</div>
										</div>
									</article>
								</section>
							</c:forEach>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="btnS1 right">
				<c:choose>
					<c:when test="${loginInfo.grade == 'tutor' }">
						<div><a href="/tutor/lessonApp" class="on">강의 신청</a></div>
					</c:when>
				</c:choose>
			</div>			
			<div id="listNav">${navi}</div>
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
		
		var sidogugun;
		$("#map_on").on("click", function(){
			setTimeout(function(){
				var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
				
				$("#gugun1").change(function() {
					var sido = $('#sido1 option:selected').val();
					var gugun = $('#gugun1 option:selected').val();
					sidogugun = sido + ' ' + gugun;
					$('#location').val(sidogugun);
					
					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();
	
					// 주소로 좌표를 검색합니다
					geocoder.addressSearch(sidogugun, function(result, status) {
						// 정상적으로 검색이 완료됐으면 
						if (status === kakao.maps.services.Status.OK) {
	
							var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
							// 결과값으로 받은 위치를 마커로 표시합니다
							/* var marker = new kakao.maps.Marker({
								map : map,
								position : coords
							}); */
	
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
				            var detailAddr = !!result[0].road_address ? '<div class="st">도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
				            detailAddr += '<div class="st">지번 주소 : ' + result[0].address.address_name + '</div>';
				            
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
				            	/*  console.log(result[i]);
					            console.log(result[i].region_1depth_name);
					            console.log(result[i].region_2depth_name);  */
					            
					            var sido1Val = result[i].region_1depth_name;
					            var gugun1Val = result[i].region_2depth_name;
					            
					            $("#sido1").val(sido1Val);
					            new sojaeji('sido1', 'gugun1');
					            $("#gugun1").val(gugun1Val); 

					            sidogugun = sido1Val + ' ' + gugun1Val;
								$('#location').val(sidogugun);
				                break;
				            }
				        }
				    }    
				}

			},100)
		})
			
		
	</script>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />