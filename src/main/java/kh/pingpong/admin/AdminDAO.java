package kh.pingpong.admin;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.dto.CorrectDTO;
import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.DiscussionDTO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;
import kh.pingpong.dto.ReportListDTO;
import kh.pingpong.dto.TuteeDTO;
import kh.pingpong.dto.TutorAppDTO;

@Repository
public class AdminDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 회원 목록
	public List<MemberDTO> memberList() {
		return mybatis.selectList("Admin.memberList");
	}
	
	// 회원 뷰
	public MemberDTO memberView(String id) {
		return mybatis.selectOne("Admin.memberView", id);
	}
	
	// 파트너 목록
	public List<PartnerDTO> partnerList() {
		return mybatis.selectList("Admin.partnerList");
	}
	
	// 파트너 뷰
	public PartnerDTO partnerView(int seq) {
		return mybatis.selectOne("Admin.partnerView", seq);
	}
	
	// 그룹 목록
	public List<GroupDTO> groupList() {
		return mybatis.selectList("Admin.groupList");
	}
	
	// 그룹 뷰
	public GroupDTO groupView(int seq) {
		return mybatis.selectOne("Admin.groupView", seq);
	}
	
	// 튜터 목록
	public List<MemberDTO> tutorList() {
		return mybatis.selectList("Admin.tutorList");
	}
	
	// 튜터 뷰
	public MemberDTO tutorView(String id) {
		return mybatis.selectOne("Admin.tutorView", id);
	}
	
	// 튜터 신청 목록
	public List<TutorAppDTO> tutorAppList() {
		return mybatis.selectList("Admin.tutorAppList");
	}
	
	// 튜터 신청 뷰
	public TutorAppDTO tutorAppView(int seq) {
		return mybatis.selectOne("Admin.tutorAppView", seq);
	}
	
	// 강의 목록
	public List<LessonDTO> lessonList() {
		return mybatis.selectList("Admin.lessonList");
	}
	
	// 강의 뷰
	public LessonDTO lessonView(int seq) {
		return mybatis.selectOne("Admin.lessonView", seq);
	}
	
	// 강의 신청 목록
	public List<LessonDTO> lessonAppList() {
		return mybatis.selectList("Admin.lessonAppList");
	}
	
	// 강의 신청 뷰
	public LessonDTO lessonAppView(int seq) {
		return mybatis.selectOne("Admin.lessonAppView", seq);
	}
	
	// 강의 삭제 목록
	public List<DeleteApplyDTO> lessonDelList() {
		return mybatis.selectList("Admin.lessonDelList");
	}
	
	// 강의 삭제 뷰
	public DeleteApplyDTO lessonDelView(int seq) {
		return mybatis.selectOne("Admin.lessonDelView", seq);
	}
	
	// 튜티 목록
	public List<TuteeDTO> tuteeList() {
		return mybatis.selectList("Admin.tuteeList");
	}
	
	// 튜티 뷰
	public TuteeDTO tuteeView(int seq) {
		return mybatis.selectOne("Admin.tuteeView", seq);
	}
	
	// 토론 게시글 목록
	public List<DiscussionDTO> discussionList() {
		return mybatis.selectList("Admin.discussionList");
	}
	
	// 토론 게시글 뷰
	public DiscussionDTO discussionView(int seq) {
		return mybatis.selectOne("Admin.discussionView", seq);
	}
	
	// 첨삭 게시글 목록
	public List<CorrectDTO> correctList() {
		return mybatis.selectList("Admin.correctList");
	}
	
	// 첨삭 게시글 뷰
	public CorrectDTO correctView(int seq) {
		return mybatis.selectOne("Admin.correctView", seq);
	}
	
	// 신고 목록
	public List<ReportListDTO> reportList() {
		return mybatis.selectList("Admin.reportList");
	}
	
	// 신고 뷰
	public ReportListDTO reportView(int seq) {
		return mybatis.selectOne("Admin.reportView", seq);
	}
}
