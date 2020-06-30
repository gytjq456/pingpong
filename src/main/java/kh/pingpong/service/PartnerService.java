package kh.pingpong.service;

import java.util.List;
import java.util.Map;

import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import kh.pingpong.config.Configuration;
import kh.pingpong.dao.PartnerDAO;
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;

@Service
public class PartnerService {
	@Autowired
	private PartnerDAO pdao;
	
	@Autowired
	JavaMailSender mailSender;

	public List<PartnerDTO> search(int cpage, Map<String, Object> search, PartnerDTO pdto) throws Exception{
		return pdao.search(cpage, search, pdto);
	}
	
	public List<HobbyDTO> selectHobby() throws Exception{
		return pdao.selectHobby();
	}
	
	public List<LanguageDTO> selectLanguage() throws Exception{
		return pdao.selectLanguage();
	}
	
	public PartnerDTO selectBySeq(int seq) throws Exception{
		return pdao.selectBySeq(seq);
	}
	
	public List<PartnerDTO> partnerList(int cpage) throws Exception{
		return pdao.selectByPageNo(cpage);
	}
	
	//페이지 네비게이션
	public String getPageNavi(int currentPage) throws Exception{

		int recordTotalCount =pdao.getArticleCount(); 
		int pageTotalCount = 0; 
		System.out.println(pdao.getArticleCount());
	
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

		StringBuilder sb = new StringBuilder(); // jsp濡� �꽆寃⑥＜湲� �쐞�빐 �꽔�� 寃�

		if(needPrev) {
			sb.append("<a href ='partnerList?cpage="+(startNavi-1)+"'>"+" <<  " + "</a>");
		}
		for(int i = startNavi; i<=endNavi; i++) {
			sb.append("<a href ='partnerList?cpage="+i+"'> "+ i +"</a>");
		}
		if(needNext) {
			sb.append("<a href ='partnerList?cpage="+(endNavi+1)+"'>"+" >>" + "</a>");
		}				
		return sb.toString();
	}
	
	public MemberDTO selectMember(String id) throws Exception{
		return pdao.selectMember(id);
	}
	public int partnerInsert(Map<String, Object> insertP) throws Exception{
		return pdao.insertPartner(insertP);
	}
	
	public void SendMail(PartnerDTO pdto, MemberDTO mdto) {
		try {
			//이메일 객체
			MimeMessage msg = mailSender.createMimeMessage();
			
			//받는 사람을 설정(수신자 받는 사람의 이메일 주소 객체를 생성해서 이메일 주소를 담음)
			msg.addRecipient(RecipientType.TO, new InternetAddress(pdto.getEmail()));
			
			 /*
             * createMimeMessage() : MimeMessage객체를 생성(메시지 구성후 메일 발송)
             * addRecipient() : 메시지의 발신자를 설정 
             * InternetAddress() : 이메일 주소
             * getReceiveMail() : 수신자 이메일 주소
             */
 
            // 보내는 사람(이메일 + 주소)
            // (발신자, 보내는 사람의 이메일 주소와 이름을 담음)
            // 이메일 발신자
			msg.addFrom(new InternetAddress[] { new InternetAddress(mdto.getEmail(), mdto.getName()) });
			
			//이메일 제목(인코딩해야 한글이 깨지지 않음)
			msg.setSubject("이메일 제목","utf-8");
			msg.setText("이메일 내용","utf-8");
			
          //html로 보낼 경우        
          //MimeMessage message = mailSender.createMimeMessage();
          //MimeMessageHelper helper = new MimeMessageHelper(message, true);
          //helper.setTo("test@host.com");
          //helper.setText("<html><body><img src='cid:identifier1234'></body></html>", true);

          // 이메일 보내기
			mailSender.send(msg);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
