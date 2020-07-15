package kh.pingpong.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
import kh.pingpong.dao.PartnerDAO;
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.JjimDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;
import kh.pingpong.dto.ReportListDTO;
import kh.pingpong.dto.ReviewDTO;

@Service
public class PartnerService {
	@Autowired
	private PartnerDAO pdao;
	
	//파트너 게시글에서 파트너 찾기
	public List<PartnerDTO> search(int cpage, Map<String, Object> search, PartnerDTO pdto) throws Exception{
		return pdao.search(cpage, search, pdto);
	}
	
	//취미 선택 
	public List<HobbyDTO> selectHobby() throws Exception{
		return pdao.selectHobby();
	}
	
	//언어 선택
	public List<LanguageDTO> selectLanguage() throws Exception{
		return pdao.selectLanguage();
	}
	
	//seq로 파트너 상세 뷰페이지 불러오기
	public PartnerDTO selectBySeq(int seq) throws Exception{
		return pdao.selectBySeq(seq);
	}
	
	//파트너 게시글 페이징
	public List<PartnerDTO> partnerList(int cpage) throws Exception{
		return pdao.selectByPageNo(cpage);
	}
	public List<PartnerDTO> partnerListAll() throws Exception{
		return pdao.partnerListAll();
	}
	
	//파트너 신고
	public int selectReport(ReportListDTO rldto) {
		return pdao.selectReport(rldto);
	}
	
	public int insertReport(ReportListDTO rldto) {
		return pdao.insertReport(rldto);
	}
	
	//페이지 네비게이션
	public String getPageNavi(int currentPage, String align,Map<String, Object> search) throws Exception{
		int recordTotalCount = pdao.getArticleCount(); 
		int pageTotalCount = 0; 
		//System.out.println(pdao.getArticleCount());
	
		if(recordTotalCount % Configuration.RECORD_COUNT_PER_PAGE > 0) {
			pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE + 1;
			
		}else {
			pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE;
		}

		if(currentPage < 1) {
			currentPage = 1;
		}else if (currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}

		// navi 1~10				
		int startNavi = (currentPage-1)/Configuration.NAVI_COUNT_PER_PAGE*Configuration.NAVI_COUNT_PER_PAGE+1; //�궡媛� 4�럹�씠吏��뿉 �엳�뼱 洹몃윴�뜲 �럹�씠吏� 踰덊샇媛� 1~10�닽�옄媛� �굹���빞�릺. currentPage-1�븯�뒗 �씠�쑀�뒗 �빐�떦 �럹�씠吏�媛�20�씪�븣
		int endNavi = startNavi+ Configuration.NAVI_COUNT_PER_PAGE-1; // end�꽕鍮꾩� start�꽕鍮꾨뒗 

		//endNavi
		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		boolean needPrev = true;
		boolean needNext = true;
		if(startNavi ==1) {needPrev = false;}
		if(endNavi == pageTotalCount) {needNext = false;}		

		StringBuilder sb = new StringBuilder();
		String alignType = align; 
		//String selectOption = (String)search.get(key)
		sb.append("<ul>");
		if(alignType != null) {
			if(needPrev) {
				sb.append("<li><a href ='partnerList?cpage="+(startNavi-1)+"'>"+" <<  " + "</a></li>");
			}
			for(int i = startNavi; i<=endNavi; i++) {
				if(currentPage == i) {
					sb.append("<li class='on'><a href ='partnerList?cpage="+i+"&align="+alignType+"'> "+ i +"</a></li>");
				}else {
					sb.append("<li><a href ='partnerList?cpage="+i+"&align="+alignType+"'> "+ i +"</a></li>");
				}
			}
			if(needNext) {
				sb.append("<li><a href ='partnerList?cpage="+(endNavi+1)+"'>"+" >>" + "</a></li>");
			}			
		}else {
			//if()
		}
		sb.append("</ul>");
		return sb.toString();
	}
	
	//회원 선택
	public MemberDTO selectMember(String id) throws Exception{
		return pdao.selectMember(id);
	}
	
	//파트너 등록, 파트너 등록 후 멤버 등급 변경
	@Transactional("txManager")
	public int partnerInsert(Map<String, Object> insertP,MemberDTO mdto) throws Exception{
		pdao.updateMemberGrade(mdto);
		return pdao.insertPartner(insertP);
	}
		
//	public int updateMemberGrade(MemberDTO mdto) throws Exception{
//		return pdao.updateMemberGrade(mdto);
//	}
	
	//파트너 삭제
	@Transactional("txManager")
	public int deletePartner(MemberDTO mdto) throws Exception{
		pdao.updateMemberGradeD(mdto);
		return pdao.deletePartner(mdto);
	}
	
//	//이메일 전송
//	public void SendMail(PartnerDTO pdto, MemberDTO mdto) {
//		try {
//			//이메일 객체
//			MimeMessage msg = mailSender.createMimeMessage();
//			
//			//받는 사람을 설정(수신자 받는 사람의 이메일 주소 객체를 생성해서 이메일 주소를 담음)
//			msg.addRecipient(RecipientType.TO, new InternetAddress(pdto.getEmail()));
// 
//            // 보내는 사람(이메일 + 주소)
//            // (발신자, 보내는 사람의 이메일 주소와 이름을 담음)
//            // 이메일 발신자
//			msg.addFrom(new InternetAddress[] { new InternetAddress(mdto.getEmail(), mdto.getName()) });
//			
//			//이메일 제목(인코딩해야 한글이 깨지지 않음)
//			msg.setSubject("이메일 제목","utf-8");
//			msg.setText("이메일 내용","utf-8");
//			System.out.println("MSG : " + msg);
//            // 이메일 보내기
//			mailSender.send(msg);
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//	}
	
	//리뷰 리스트 출력
	public List<ReviewDTO> reviewList(int seq) throws Exception{
		return pdao.reviewList(seq);
	}
	//리뷰 글쓰기
	public int reviewWrite(ReviewDTO redto) throws Exception{
		return pdao.reviewWrite(redto);
	}
	
	//찜하기
	public int insertJjim(JjimDTO jdto) {
		return pdao.insertJjim(jdto);
	}
	public int deleteJjim(JjimDTO jdto) {
		return pdao.deleteJjim(jdto);
	}
	public boolean selectJjim(JjimDTO jdto) {
		return pdao.selectJjim(jdto);
	}
	
	//검색 최신순 / 평점순
	public List<PartnerDTO> searchAlign(int cpage,String align) throws Exception{
		return pdao.searchAlign(cpage,align);
	}
}
