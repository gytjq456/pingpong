# pingpong
Language Exchange 언어 교환 사이트 구현
- 서로 모국어 및 자신이 할 수 있는 언어를 다른 사람들과 교환을 하여 언어를 학습 할 수 있는 사이트


```

서버 : EC2 ( Amazone ) , Apache Tomcat v8.5

Java EE IDE(통합개발환경) : Eclipse, Spring

Database : ORACLE SQL Developer, mybatis

사용언어 : JAVA, HTML, CSS, Javascript, JSP, SQL, EL/JSTL

라이브러리 : jQuery, AJAX, Bootstrap, Web Socket, sojaeji.js, chart.js, datepicker-ko.js

API : Kakao Login, kakao MAP, kakao Address, PAPAGO, summer note API, i'mport, 

```


# work

MainPage
- 이용 가이드, 파트너 목록 바로 가기 버튼 생성 (메인 슬라이드)
- 캘린더를 이용한 검색 
- KaKao MAP API, sojaeji.js를 이용한 위치 검색 
- Partner & Tutor 목록 출력

Chatting
- WebSocket을 이용한 일대일 채팅

Discussion board
- 게시글, 댓글 등록, 수정, 삭제, 출력 
- summernote API를 이용한 게시글 등록
- PAPAGO API를 이용한 번역
- 게시글 출력 형태 지정(최신순, 인기순) 
- 키워드 상세 검색(토론 게시판)
- AOP로 이용 제한(로그인 안 한 경우 로그인 페이지 이동) 

Review 
- 글 등록, 삭제, 출력 
- 별점을 이용한 평점 등록 
- 그룹/튜터의 경우 해당 그룹원, 튜티만 작성 가능하도록 함 

# code
MainPage
- https://github.com/gytjq456/pingpong/blob/master/src/main/webapp/WEB-INF/views/index.jsp
- https://github.com/gytjq456/pingpong/blob/master/src/main/webapp/WEB-INF/views/schedule.jsp
- https://github.com/gytjq456/pingpong/blob/master/src/main/webapp/resources/js/main.js

Chatting
- https://github.com/gytjq456/pingpong/blob/master/src/main/webapp/WEB-INF/views/chat.jsp
- https://github.com/gytjq456/pingpong/tree/master/src/main/java/kh/pingpong/chat

토론 게시판 
- https://github.com/gytjq456/pingpong/tree/master/src/main/webapp/WEB-INF/views/board/discussion
- https://github.com/gytjq456/pingpong/blob/master/src/main/java/kh/pingpong/controller/DiscussionController.java
- https://github.com/gytjq456/pingpong/blob/master/src/main/java/kh/pingpong/service/DiscussionService.java
- https://github.com/gytjq456/pingpong/blob/master/src/main/java/kh/pingpong/dao/DiscussionDAO.java
- https://github.com/gytjq456/pingpong/blob/master/src/main/resources/mappers/discussion-mapper.xml

Review ( Ctrl + F -> review 검색 / 검색 결과만 작업)
- https://github.com/gytjq456/pingpong/blob/master/src/main/java/kh/pingpong/controller/GroupController.java 
- https://github.com/gytjq456/pingpong/blob/master/src/main/java/kh/pingpong/service/GroupService.java
- https://github.com/gytjq456/pingpong/blob/master/src/main/java/kh/pingpong/dao/GroupDAO.java
- https://github.com/gytjq456/pingpong/blob/master/src/main/resources/mappers/group-mapper.xml

