<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>
	<style>
		footer { margin-top:0; }
	</style>
	<div id="main" class="hdMargin">
        <script src="/resources/js/main.js"></script>
        
        <section id="mainVisual">
            <div class="visu">
                <article class="item item1">

                </article>
                <article class="item item2">

                </article>
                <article class="item item3">

                </article>
            </div>
            <div class="txt_box">
                <h2>텍스트 텍스트 텍스트 텍스트 텍스트 </h2>
            </div>
        </section>
	</div>
	
	<div id="mainCont">
		
		<section id="toDayClass">
			<div class="tit_main left">
			<h3>To Day Class</h3>
				<p>현재 모집중인 그룹 모임과 전문가와 함께하는 수업입니다.</p>
			</div>		
			<div class="inner1200 clearfix">
				<article class="classList">
					<div class="classWrap">
						<section class="groupClass">
							<div class="category">GROUP</div>
							<div class="list">
								<ul>
									
								</ul>
							</div>
						</section>
						<section class="tutorClass">
							<div class="category">TUTOR CLASS</div>
							<div class="list">
								<ul>
									
								</ul>
							</div>
						</section>
					</div>
				</article>
				<article class="scheduleWrap">
					<jsp:include page="schedule.jsp"/>
					<div class="tip">
						<p>진행중인 일정을 확인 할 수 있습니다.</p>
						<p>진행 기간 기준으로 노출이 됩니다.</p>
					</div>
				</article>
			</div>
		</section>
	
	
		<section id="personList">
			<div class="inner1200">
				<div class="tit_main">
					<h3>Partner & Tutor</h3>
					<p>PINGPONG과 함께 하는 Partner와 Tutor를 소개합니다</p>
				</div>
				<div id="tab_s3">
					<ul>
						<li class="on" data-type="partner"><button>Partner</button></li>
						<li data-type="tutor"><button>Tutor</button></li>
					</ul>
				</div>
				<div class="listWrap">
					<section id="partnerList">
						<div class="list">
						</div>
					</section>
				</div>
			</div>
		</section>
		
		<section id="mapWrap">
			<div class="mapSelect">
				<input type="hidden" name="placeAddr" id="placeAddr">
				<select name="sido1" id="sido1"></select>
				<select name="gugun1" id="gugun1"></select>		
			</div>
			<div id="map"></div>
		</section>
	</div>
	
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cb57281667e3a6a69eb9d73a89f1f42f"></script>
	<script>
		new sojaeji('sido1', 'gugun1');
		$("#sido1 option:eq(1)").attr("selected", "selected");
		
	    new sojaeji('sido1', 'gugun1');
	    $("#gugun1 option:eq(1)").attr("selected", "selected");
        
	    
		var sido = $("#sido1");
		var gugun = $("#gugun1");
		var placeArrd = $("#placeAddr");
		var addr = sido.val()+" "+gugun.val();

		var latArr = [];
		var lanArr = [];
		gugun.on("change",function(){ 
			latArr = [];
			lanArr = [];
			addr = sido.val()+" "+$(this).val();
			placeArrd.val(addr);
			mapSchFn(addr,"chance")
		})
		mapSchFn(addr,"init");
		
		function mapSchFn(addr,typeFn){
			$.ajax({
				url:"/mapSch",
				type:"post",
				dataType:"json",
				data:{
					addr:addr	
				}
			}).done(function(resp){
				/* console.log(resp) */
					//&& !resp.gList.length || !resp.lessonList.length
				if(typeFn == "init" && !resp.gList.length && !resp.lessonList.length){
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = { 
				        center: new kakao.maps.LatLng(37.51734273063705, 127.04739551373974), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };
					// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
					var map = new kakao.maps.Map(mapContainer, mapOption)
				}else{
					if(resp.gList.length || resp.lessonList.length){
						for(var i=0; i<resp.gList.length; i++){
							latArr.push(resp.gList[i].location_lat);
							lanArr.push(resp.gList[i].location_lng);
						}
						for(var i=0; i<resp.lessonList.length; i++){
							latArr.push(resp.lessonList[i].location_lat);
							lanArr.push(resp.lessonList[i].location_lng);
						}
						
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
					    mapOption = { 
					        center: new kakao.maps.LatLng(latArr[0], lanArr[0]), // 지도의 중심좌표
					        level: 3 // 지도의 확대 레벨
					    };
						
						$("#map").html("");
						var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
						
						/* console.log(latArr)
						console.log(lanArr) */
						
						// 커스텀 오버레이가 표시될 위치입니다 
						//var position = new kakao.maps.LatLng(37.49887, 127.026581);
						// 마커를 표시할 위치와 title 객체 배열입니다 
						/* console.log("len = " + resp.gList.length)
						console.log("len = " + resp.lessonList.length) */
						var positions = [];
						for (var i = 0; i < resp.gList.length; i++) {
							positions.push({
								content: '<div class="infoView">'+
			 					'<div class="profile"><img src="/upload/member/'+resp.gList[i].id+'/'+resp.gList[i].profile+'"/></div>' + 
			 					'<div class="info">'+
								'<div class="group_cate cate">그룹</div>' + 
								'<div class="writer">'+resp.gList[i].writer_name+'</div>' + 
								'<div class="hoppy">'+resp.gList[i].hobby_type+'</div>'+
								'</div>'+
								'</div>',
								latlng: new kakao.maps.LatLng(latArr[i], lanArr[i])
							});
						}
						for (var i = 0; i < resp.lessonList.length; i++) {
							console.log(i)
							positions.push({
								content: '<div class="infoView">'+
			 					'<div class="profile"><img src="/upload/member/'+resp.lessonList[i].id+'/'+resp.lessonList[i].profile+'"/></div>' + 
			 					'<div class="info">'+
								'<div class="lesson_cate cate">강의</div>' + 
								'<div class="writer">'+resp.lessonList[i].name+'</div>' + 
								'<div class="hoppy">'+resp.lessonList[i].title+'</div>'+
								'</div>'+
								'</div>',
								latlng: new kakao.maps.LatLng(latArr[i+1], lanArr[i+1])
							});
						}
						
						// 마커 이미지의 이미지 주소입니다
						for (var i = 0; i < positions.length; i ++) {
						    
						    // 마커를 생성합니다
						    var marker = new kakao.maps.Marker({
						        map: map, // 마커를 표시할 지도
						        position: positions[i].latlng // 마커의 위치
						    });
						    
						    // 마커에 표시할 인포윈도우를 생성합니다 
						    var infowindow = new kakao.maps.InfoWindow({
						        content: positions[i].content // 인포윈도우에 표시할 내용
						    });
							
						    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
						    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
						    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
						    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
						    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
						}
			
						// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
						function makeOverListener(map, marker, infowindow) {
						    return function() {
						        infowindow.open(map, marker);
						    };
						}
						
						// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
						function makeOutListener(infowindow) {
						    return function() {
						        infowindow.close();
						    };
						}
					}else{
						alert("검색된 결과가 없습니다.");
						
					}
				}
				
			})
		}
		
	</script>
	
	
<jsp:include page="footer.jsp"/>