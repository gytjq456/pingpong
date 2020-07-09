<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>
	
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
						<p>모집이 끝나지 않은 모임을 확인 할 수 있습니다.</p>
						<p>모집 기간 기준으로 노출이 됩니다.</p>
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
	</div>
	
	
<jsp:include page="footer.jsp"/>