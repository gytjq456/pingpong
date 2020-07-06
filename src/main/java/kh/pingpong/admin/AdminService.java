package kh.pingpong.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

@Service
public class AdminService {
	@Autowired
	private AdminDAO adao;
	
	// 회원 목록
	public List<MemberDTO> memberList() {
		return adao.memberList();
	}
	
	// 회원 뷰
	public MemberDTO memberView(String id) {
		return adao.memberView(id);
	}
	
	// 파트너 목록
	public List<PartnerDTO> partnerList() {
		return adao.partnerList();
	}
	
	// 파트너 뷰
	public PartnerDTO partnerView(int seq) {
		return adao.partnerView(seq);
	}
	
	// 그룹 목록
	public List<GroupDTO> groupList() {
		return adao.groupList();
	}
	
	// 그룹 뷰
	public GroupDTO groupView(int seq) {
		return adao.groupView(seq);
	}
	
	// 튜터 목록
	public List<MemberDTO> tutorList() {
		return adao.tutorList();
	}
	
	// 튜터 뷰
	public MemberDTO tutorView(String id) {
		return adao.tutorView(id);
	}
	
	// 튜터 신청 목록
	public List<TutorAppDTO> tutorAppList() {
		return adao.tutorAppList();
	}
	
	// 튜터 신청 뷰
	public TutorAppDTO tutorAppView(int seq) {
		return adao.tutorAppView(seq);
	}
	
	// 강의 목록
	public List<LessonDTO> lessonList() {
		return adao.lessonList();
	}
	
	// 강의 뷰
	public LessonDTO lessonView(int seq) {
		return adao.lessonView(seq);
	}
	
	// 강의 신청 목록
	public List<LessonDTO> lessonAppList() {
		return adao.lessonAppList();
	}
	
	// 강의 신청 뷰
	public LessonDTO lessonAppView(int seq) {
		return adao.lessonAppView(seq);
	}
	
	// 강의 삭제 목록
	public List<DeleteApplyDTO> lessonDelList() {
		return adao.lessonDelList();
	}
	
	// 강의 삭제 뷰
	public DeleteApplyDTO lessonDelView(int seq) {
		return adao.lessonDelView(seq);
	}
	
	// 튜티 목록
	public List<TuteeDTO> tuteeList() {
		return adao.tuteeList();
	}
	
	// 튜티 뷰
	public TuteeDTO tuteeView(int seq) {
		return adao.tuteeView(seq);
	}
	
	// 토론 게시글 목록
	public List<DiscussionDTO> discussionList() {
		return adao.discussionList();
	}
	
	// 토론 게시글 뷰
	public DiscussionDTO discussionView(int seq) {
		return adao.discussionView(seq);
	}
	
	// 첨삭 게시글 목록
	public List<CorrectDTO> correctList() {
		return adao.correctList();
	}
	
	// 첨삭 게시글 뷰
	public CorrectDTO correctView(int seq) {
		return adao.correctView(seq);
	}
	
	// 신고 목록
	public List<ReportListDTO> reportList() {
		return adao.reportList();
	}
	
	// 신고 뷰
	public ReportListDTO reportView(int seq) {
		return adao.reportView(seq);
	}
}
