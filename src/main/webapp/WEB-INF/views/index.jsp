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
				<select name="sido1" id="sido1"></select>
				<select name="gugun1" id="gugun1"></select>		
			</div>
			<div id="map"></div>
		</section>
	</div>
	
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cb57281667e3a6a69eb9d73a89f1f42f"></script>
	<script>
		new sojaeji('sido1', 'gugun1');
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 커스텀 오버레이에 표시할 내용입니다     
		// HTML 문자열 또는 Dom Element 입니다 
		var content = '<div class="overlaybox">' +
		    '    <div class="boxtitle">금주 영화순위</div>' +
		    '    <div class="first">' +
		    '        <div class="triangle text">1</div>' +
		    '        <div class="movietitle text">드래곤 길들이기2</div>' +
		    '    </div>' +
		    '    <ul>' +
		    '        <li class="up">' +
		    '            <span class="number">2</span>' +
		    '            <span class="title">명량</span>' +
		    '            <span class="arrow up"></span>' +
		    '            <span class="count">2</span>' +
		    '        </li>' +
		    '        <li>' +
		    '            <span class="number">3</span>' +
		    '            <span class="title">해적(바다로 간 산적)</span>' +
		    '            <span class="arrow up"></span>' +
		    '            <span class="count">6</span>' +
		    '        </li>' +
		    '        <li>' +
		    '            <span class="number">4</span>' +
		    '            <span class="title">해무</span>' +
		    '            <span class="arrow up"></span>' +
		    '            <span class="count">3</span>' +
		    '        </li>' +
		    '        <li>' +
		    '            <span class="number">5</span>' +
		    '            <span class="title">안녕, 헤이즐</span>' +
		    '            <span class="arrow down"></span>' +
		    '            <span class="count">1</span>' +
		    '        </li>' +
		    '    </ul>' +
		    '</div>';
		
		// 커스텀 오버레이가 표시될 위치입니다 
		//var position = new kakao.maps.LatLng(37.49887, 127.026581);
		// 마커를 표시할 위치와 title 객체 배열입니다 
		var positions = [
		    {
		        title: '카카오', 
		        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
		    },
		    {
		        title: '생태연못', 
		        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
		    },
		    {
		        title: '텃밭', 
		        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
		    },
		    {
		        title: '근린공원',
		        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
		    }
		];
		
		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		
		for (var i = 0; i < positions.length; i ++) {
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		}
		// 커스텀 오버레이를 지도에 표시합니다
		
	</script>
	
	
<jsp:include page="footer.jsp"/>