<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>

<script src="/resources/js/myinfoModify.js"></script>

<Style>
	#joinForm input,
	#joinForm select, 
	#joinForm button { max-width:140px; }
	#joinForm input[type="submit"] { 
	    height: 32px;
	    line-height: 32px;
	    border: 1px solid #ddd;
	    box-sizing: border-box;
	    border-radius: 6px;
	    width: 100%;
	    margin: 0;
	    padding: 0 10px;
	}
	#joinForm input[type="submit"],
	#joinForm button { position:absolute; right:0; top:0; font-size:12px;}
	.se_singup { position:relative;}
	.se_con p { margin-bottom:10px;}
	.se_con { margin-top:20px;}
	
	
	.phoneInput select {}
	#joinForm .phoneInput input[type="text"] { 
		width:calc(100% - 143px);
		width:-webkit-calc(100% - 143px);
		width:-moz-calc(100% - 143px);
	}
</Style>

    <div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
		<section id="subContents">
			<div id="joinForm">
				<div class="tit_s1">
					<h2>MEMBER</h2>
					<p>다양한 사람들을 원하시나요?<br>관심사가 비슷한 사람들과 함께 소통해 보세요.</p>
				</div>
				<input type="hidden" id="id" name="id" value="${sessionScope.loginInfo.id}">
				<input type="hidden" id="name" name="name" value="${sessionScope.loginInfo.name}">
				<input type="hidden" id="email" name="email" value="${sessionScope.loginInfo.email}">
				
				<div class="formBox card_body">
					<div class="se_singup">
						<div class="title">아이디</div>
						<div class="se_con">
							<p>${sessionScope.loginInfo.id}</p>
						</div>
					</div>
					
					<c:if test="${mdto.mem_type != 'kakao'}">
						<div class="se_singup" id="kakaoNot">
							<div class="title">
								비밀번호 							
							</div>												
							<div class="se_con">
								<div>
									<button type="button" id="modyPwBtn">비밀번호 수정</button>								
								</div>
							</div>						
						</div>
					</c:if>
		
					<div class="se_singup">
						<div class="title">이름</div>
						<div class="se_con">
							<p>${sessionScope.loginInfo.name}</p>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">나이</div>
						<div class="se_con">
							<p>
								${sessionScope.loginInfo.age}				
								${sessionScope.loginInfo.gender}
							</p>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">e-mail</div>
						<div class="se_con">
							<p>${sessionScope.loginInfo.email}</p>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">전화번호</div>
						<div class="se_con phoneInput">
							<p>
								${sessionScope.loginInfo.phone_country}
								${sessionScope.loginInfo.phone}
							</p>
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<select id="phone_country" name="phone_country" class="w20">
										<!-- <option value="null" id="phone_countryNull">선택 안함</option> -->
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="070">070</option>
									</select>
									<input type="text" id="phone" name="phone" class="w80" placeholder="'-'는 제외하고 작성">
									<button type="button" id="phone_Result">수정완료</button>
								</div>
							</div>							
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">주소</div>
						<div class="se_con">
							<p>${sessionScope.loginInfo.address}</p>
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<div id="hidden_address">
										<select name="sido1" id="sido1"></select>
										<select name="gugun1" id="gugun1"></select>
										<input type="hidden" name="address" id="address">
									</div>
									<button type="button" id="address_Result">수정완료</button>
								</div>
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">은행</div>
						<div class="se_con phoneInput">
							<p>
								${sessionScope.loginInfo.bank_name}
								${sessionScope.loginInfo.account}
							</p>
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<select id="bank_name" name="bank_name">
										<option value="null">선택 안함</option>
										<c:forEach var="i" items="${bankList}">	
											<option value="${i.bank_name}">${i.bank_name}</option>
										</c:forEach>
									</select>
									<input type="text" id="account" name="account" class="w80">
									<button type="button" id="bank_Result">수정완료</button>
								</div>
							</div>
						</div>
					</div>
					
					<div class="se_singup">
						<div class="title">프로필 사진</div>
						<div class="se_con">
							<p><img src="/upload/member/${sessionScope.loginInfo.id}/${sessionScope.loginInfo.sysname}"></p>
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<form id="profile_form" enctype="multipart/form-data">
										<input type="file" id="profile" name="profile">
										<input type="submit" id="profile_Result" value="수정완료">
									</form>
								</div>								
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">나라</div>
						<div class="se_con">
							<p>${sessionScope.loginInfo.country}</p>
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<select id="country" name="country" class="w100">
										<option value="null">선택 안함</option>
										<c:forEach var="i" items="${countryList}">						
											<option value="${i.name}">${i.name}</option>
										</c:forEach>
									</select>
									<button type="button" id="country_Result">수정완료</button>
								</div>
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">구사 가능 언어 (최대 3개)</div>
						<div class="se_con">
							<p>${sessionScope.loginInfo.lang_can}</p>
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<ul class="checkBox_s1">
									<c:forEach var="i" items="${lanList}" varStatus="status">
										<li>
											<input type="checkbox" name="lang_can" value="${i.language}" id="test${status.index}" name="lang_can"/>
											<label for="test${status.index}" ><span></span>${i.language}</label>
										</li>
									</c:forEach>
									</ul>
									<button type="button" id="lang_can_Result">수정완료</button>
								</div>
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">배우고 싶은 언어 (최대 3개)</div>
						<div class="se_con">
							<p>${sessionScope.loginInfo.lang_learn}</p>
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<ul class="checkBox_s1">
									<c:forEach var="i" items="${lanList}" varStatus="status">	
										<li>
											<input type="checkbox" name="lang_learn" value="${i.language}" id="test2${status.index}" />
											<label for="test2${status.index}" ><span></span>${i.language}</label>
										</li>
									</c:forEach>
									</ul>
									<button type="button" id="lang_learn_Result">수정완료</button>
								</div>
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">취미 (최대 3개)</div>
						<div class="se_con">
							<p>${sessionScope.loginInfo.hobby}</p>
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<ul class="checkBox_s1">
									<c:forEach var="i" items="${hobbyList}" varStatus="status">		
										<li>
											<input type="checkbox" name="hobby" value="${i.hobby}" id="test3${status.index}" name="hobby">
											<label for="test3${status.index}"><span></span>${i.hobby}</label>
										</li>
									</c:forEach>
									</ul>
									<button type="button" id="hobby_Result">수정완료</button>
								</div>
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">자기소개</div>
						<div class="se_con">
							<p>${sessionScope.loginInfo.introduce}</p>
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">							
									<textarea id="introduce" name="introduce" class="w100" placeholder="50글자 이상 작성해주세요"></textarea>
									<span id="counter">(0 / 최대 500자)</span>
									<button type="button" id="introduce_Result">수정완료</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		</section>
	</div>
			
<jsp:include page="/WEB-INF/views/footer.jsp"/>