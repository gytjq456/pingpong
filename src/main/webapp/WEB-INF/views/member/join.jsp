<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>

<script src="/resources/js/join.js"></script>

    <div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
		<section id="subContents">
			<div id="join">
			    <h1>MEMBER</h1>
				<form action="joinProc" method="post" id="joinProc" enctype="multipart/form-data">
					<input type="hidden" name="mem_type" value="basic">
					<input type="hidden" name="category" value="member">
					<input type="hidden" name="grade" value="defalut">
					
					<div class="se_singup">
						<div class="title">아이디</div>
						<div class="se_con">
							<input type="text" name="id" id="id" class="w80">
							<button type="button" class="w20 idck" id="duplcheckId">중복확인</button>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">비밀번호</div>
						<div class="se_con">
							<input type="password" id="pw" name="pw" class="w100">
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">비밀번호확인</div>
						<div class="se_con">
							<input type="password" name="pw_ck" id="pw_ck" class="w100">
						</div>
						<div id="pwConfrom"></div>
					</div>
		
					<div class="se_singup">
						<div class="title">이름</div>
						<div class="se_con">
							<input type="text" id="name" name="name" class="w100">
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">나이</div>
						<div class="se_con">
							<input type="text" id="age" name="age" class="w70">				
							
							<label><input type="radio" name="gender" value="남자" id="m"> 남자</label>
							<label><input type="radio" name="gender" value="여자" id="g"> 여자</label>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">e-mail</div>
						<div class="se_con">
							${mail}
							<input type="hidden" id="email" name="email" class="w100" value="${mail}">
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">전화번호</div>
						<div class="se_con">
							<select id="phone_country" name="phone_country" class="w20">
								<option value="null" id="phone_countryNull">선택 안함</option>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="070">070</option>
							</select>
							<input type="text" id="phone" name="phone" class="w80" placeholder="'-'는 제외하고 작성">
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">주소</div>
						<div class="se_con">
							<select name="sido1" id="sido1"></select>
							<select name="gugun1" id="gugun1"></select>
							<input type="hidden" name="address" id="address">
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">은행</div>
						<div class="se_con">
							<select id="bank_name" name="bank_name">
								<option value="null">선택 안함</option>
								<c:forEach var="i" items="${bankList}">	
									<option value="${i.bank_name}">${i.bank_name}</option>
								</c:forEach>
							</select>
							<input type="text" id="account" name="account" class="w80">
						</div>
					</div>
					
					<div class="se_singup">
						<div class="title">프로필 사진</div>
						<div class="se_con">
							<input type="file" id="profile" name="profile">
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">나라</div>
						<div class="se_con">
							<select id="country" name="country" class="w100">
								<option value="null">선택 안함</option>
								<c:forEach var="i" items="${countryList}">						
									<option value="${i.name}">${i.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">구사 가능 언어 (최대 3개)</div>
						<div class="se_con">
							<c:forEach var="i" items="${lanList}" varStatus="status">	
								<input type="checkbox" name="lang_can" value="${i.language}" id="test${status.index}" name="lang_can"/>
								<label for="test${status.index}" >${i.language}</label>
							</c:forEach>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">배우고 싶은 언어 (최대 3개)</div>
						<div class="se_con">
							<c:forEach var="i" items="${lanList}" varStatus="status">	
								<span class="o_box">					
									<input type="checkbox" name="lang_learn" value="${i.language}" id="test2${status.index}" />
									<label for="test2${status.index}" >${i.language}</label>
								</span>	
							</c:forEach>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">취미 (최대 3개)</div>
						<div class="se_con">
							<c:forEach var="i" items="${hobbyList}" varStatus="status">		
								<input type="checkbox" name="hobby" value="${i.hobby}" id="test3${status.index}" name="hobby">
								<label for="test3${status.index}">${i.hobby}</label>
							</c:forEach>
						</div>
					</div>
		
					<div class="se_singup">
						<div class="title">자기소개</div>
						<div class="se_con">
							<textarea id="introduce" name="introduce" class="w100"> </textarea>
							<span id="counter">(0 / 최대 500자)</span>

						</div>
					</div>
		
					<div class="si_btn">
						<a href="javascript:history.back();">뒤로가기</a>
					</div>
				</form>
			</div>
		</section>
	</div>
			
<jsp:include page="/WEB-INF/views/footer.jsp"/>