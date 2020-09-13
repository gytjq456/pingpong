# PINGPONG(핑퐁)
* Language Exchange(언어 교환) 사이트
* 서로 모국어 및 자신이 할 수 있는 언어를 다른 사람들과 교환하여 언어를 학습할 수 있는 사이트

## 개발 환경
* 서버: EC2(Amazone), Apache Tomcat v8.5
* JAVA EE IDE(통합 개발 환경): Eclipse, Spring
* Database: ORACLE SQL Developer, MyBatis
* 사용 언어: JAVA, HTML, CSS, Javascript, JSP, SQL, EL/JSTL
* 라이브러리: JQuery, AJAX, Bootstrap, Web Socket, sojaeji.js, chart.js, datepicker-ko.js
* API: KAKAO Login, KAKAO MAP, KAKAO Address, PAPAGO, Summernote API, I'mport

## 담당 역할
* 마이 페이지
  * 그룹 신청 승인, 거절, 삭제
    * [GroupController](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/controller/GroupController.java, "GroupController") (라인 443~490)
    * [GroupService](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/service/GroupService.java, "GroupService") (라인 274~330)
    * [GroupDAO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dao/GroupDAO.java, "GroupDAO") (라인 264~302)
    * [GroupApplyDTO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dto/GroupApplyDTO.java, "GroupApplyDTO")
    * [GroupMemberDTO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dto/GroupMemberDTO.java, "GroupMemberDTO")
    * [GroupDTO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dto/GroupDTO.java, "GroupDTO")
  * 받은 쪽지함, 보낸 쪽지함(쪽지 출력, 답장, 삭제)
    * [LetterController](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/controller/LetterController.java, "LetterController")
    * [LetterService](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/service/LetterService.java, "LetterService")
    * [LetterDAO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dao/LetterDAO.java, "LetterDAO")
    * [LetterDTO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dto/LetterDTO.java, "LetterDTO")
* 그룹(리뷰 제외)
  * 게시글 등록, 수정, 삭제, 출력
  * 게시글 검색, 출력 형태 지정(모집 형태 검색 버튼, 최신순/조회순/추천순/인기순/평점순)
  * 키워드 상세 검색
  * Datepicker를 이용한 날짜 지정, 날짜 검색
  * KAKAO MAP API, sojaeji.js를 이용한 위치 지정, 위치 검색
  * 관련 게시글 추천
  * Summernote API를 이용한 게시글 등록
    * [GroupController](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/controller/GroupController.java, "GroupControllerAgain")
    * [GroupService](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/service/GroupService.java, "GroupServiceAgain")
    * [GroupDAO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dao/GroupDAO.java, "GroupDAOAgain")
    * [GroupMemberDTO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dto/GroupMemberDTO.java, "GroupMemberDTOAgain")
    * [GroupApplyDTO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dto/GroupApplyDTO.java, "GroupApplyDTOAgain")
    * [GroupDTO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dto/GroupDTO.java, "GroupDTOAgain")
  * Scheduler를 이용한 진행도 관리
    * [GroupScheduler](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/scheduler/GroupScheduler.java, "GroupScheduler")
  * AOP로 이용 제한(로그인 안 한 경우 로그인 페이지 이동)
    * [LogAdvisor](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/aspect/LogAdvisor.java, "LogAdvisor")
* 관리자
  * chart.js를 이용한 일일 방문자 수/언어 선호도/지역 선호도 출력
  * 전체 게시판 게시글 출력, 삭제
  * 신청서 승인(튜터 신청, 신고)
  * 블랙리스트 등록, 해제, 로그인 제한
    * [Admin](https://github.com/eunhabb/pingpong/tree/master/src/main/java/kh/pingpong/admin, "admin")
  * Scheduler를 이용한 블랙리스트 관리
    * [Scheduler](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/scheduler/GroupScheduler.java, "Scheduler")
* 신고/추천/찜
  * 게시글 신고(그룹)
    * [Controller](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/controller/GroupController.java, "reportController") (라인 290~306)
    * [Service](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/service/GroupService.java, "reportService") (라인 142~148)
    * [DAO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dao/GroupDAO.java, "reportDAO") (라인 197~203)
    * [DTO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dto/ReportListDTO.java, "reportDTO")
  * 게시글 추천(그룹)
    * [Controller](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/controller/GroupController.java, "likeController") (라인 254~264)
    * [Service](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/service/GroupService.java, "likeService") (라인 104~112)
    * [DAO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dao/GroupDAO.java, "likeDAO") (라인 179~195)
    * [DTO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dto/LikeListDTO.java, "likeDTO")
  * 찜하기(그룹)
    * [Controller](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/controller/GroupController.java, "jjimController") (라인 266~288)
    * [Service](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/service/GroupService.java, "jjimService") (라인 130~140)
    * [DAO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dao/GroupDAO.java, "jjimDAO") (라인 234~253)
    * [DTO](https://github.com/eunhabb/pingpong/blob/master/src/main/java/kh/pingpong/dto/JjimDTO.java, "jjimDTO")
