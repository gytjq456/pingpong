<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>

<script src="/resources/js/myinfoModify.js"></script>

    <div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
		<section id="subContents">
			<div id="join">
			    <h1>MEMBER</h1>
				<form id="myInfoModifyProc">
					<input type="hidden" name="mem_type" value="basic">
					<input type="hidden" name="category" value="member">
					<input type="hidden" name="grade" value="defalut">
					
					<div class="se_singup">
						<div class="title">아이디</div>
						<div class="se_con">
							${sessionScope.loginInfo.id}
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">
							비밀번호 							
						</div>
												
						<div class="se_con">
							<div>
								<button type="button" class="modyBtn">링크연결 수정</button>								
							</div>
						</div>
						
					</div>
		
					<div class="se_singup">
						<div class="title">이름</div>
						<div class="se_con">
							${sessionScope.loginInfo.name}
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">나이</div>
						<div class="se_con">
							${sessionScope.loginInfo.age}				
							${sessionScope.loginInfo.gender}
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">e-mail</div>
						<div class="se_con">
							${sessionScope.loginInfo.email}
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">전화번호</div>
						<div class="se_con">
							${sessionScope.loginInfo.phone_country}
							${sessionScope.loginInfo.phone}
							<div>
								<button type="button" class="modyBtn">수정</button>
								
								<div class="show_input" id="phone_submit">
									<select id="phone_country" name="phone_country" class="w20">
										<option value="null" id="phone_countryNull">선택 안함</option>
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="070">070</option>
									</select>
									<input type="text" id="phone" name="phone" class="w80" placeholder="'-'는 제외하고 작성">
								</div>
							</div>							
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">주소</div>
						<div class="se_con">
							${sessionScope.loginInfo.address}
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<div id="hidden_address">
										<select name="sido1" id="sido1"></select>
										<select name="gugun1" id="gugun1"></select>
										<input type="hidden" name="address" id="address">
									</div>
									<button type="button" id="addressBtn">수정완료</button>
								</div>
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">은행</div>
						<div class="se_con">
							${sessionScope.loginInfo.bank_name}
							${sessionScope.loginInfo.account}
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
								</div>
							</div>
						</div>
					</div>
					
					<div class="se_singup">
						<div class="title">프로필 사진</div>
						<div class="se_con">
							<img src="/upload/member/${sessionScope.loginInfo.id}/${sessionScope.loginInfo.sysname}">
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<input type="file" id="profile" name="profile">
								</div>
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">나라</div>
						<div class="se_con">
						${sessionScope.loginInfo.country}
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<select id="country" name="country" class="w100">
										<option value="null">선택 안함</option>
										<c:forEach var="i" items="${countryList}">						
											<option value="${i.name}">${i.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">구사 가능 언어 (최대 3개)</div>
						<div class="se_con">
						${sessionScope.loginInfo.lang_can}
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<c:forEach var="i" items="${lanList}" varStatus="status">	
										<input type="checkbox" name="lang_can" value="${i.language}" id="test${status.index}" name="lang_can"/>
										<label for="test${status.index}" >${i.language}</label>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">배우고 싶은 언어 (최대 3개)</div>
						<div class="se_con">
						${sessionScope.loginInfo.lang_learn}
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<c:forEach var="i" items="${lanList}" varStatus="status">	
										<span class="o_box">					
											<input type="checkbox" name="lang_learn" value="${i.language}" id="test2${status.index}" />
											<label for="test2${status.index}" >${i.language}</label>
										</span>	
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">취미 (최대 3개)</div>
						<div class="se_con">
						${sessionScope.loginInfo.hobby}
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">
									<c:forEach var="i" items="${hobbyList}" varStatus="status">		
										<input type="checkbox" name="hobby" value="${i.hobby}" id="test3${status.index}" name="hobby">
										<label for="test3${status.index}">${i.hobby}</label>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">자기소개</div>
						<div class="se_con">
						${sessionScope.loginInfo.introduce}
							<div>
								<button type="button" class="modyBtn">수정</button>
								<div class="show_input">							
									<textarea id="introduce" name="introduce" class="w100" placeholder="50글자 이상 작성해주세요"></textarea>
									<span id="counter">(0 / 최대 500자)</span>
								</div>
							</div>
						</div>
					</div>
		
					<div class="si_btn">
						<input value="회원가입" type="submit" id="myInfoModifyBtn">
						<a href="javascript:history.back();">뒤로가기</a>
					</div>
				</form>
			</div>
		</section>
	</div>
			
<jsp:include page="/WEB-INF/views/footer.jsp"/>