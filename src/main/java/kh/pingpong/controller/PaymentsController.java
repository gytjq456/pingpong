package kh.pingpong.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.TuteeDTO;
import kh.pingpong.service.TutorService;

@Controller
@RequestMapping("/payments/")
public class PaymentsController {

	@Autowired
	private HttpSession session;

	@Autowired
	private TutorService tservice;

	//결제한사람이 또 결제하는지
	@RequestMapping("payTrue")
	@ResponseBody
	public int payTrue(TuteeDTO ttdto) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		System.out.println(ttdto.getParent_seq() + id);
		ttdto.setId(id);
		int result = tservice.payTrue(ttdto);
		System.out.println(result);
		return result;
	}

	//튜티 결제
	@RequestMapping("payMain")
	public String payMain(Model model, TuteeDTO ttdto) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		ttdto.setId(mdto.getId());
		ttdto.setName(mdto.getName());
		ttdto.setEmail(mdto.getEmail());
		ttdto.setPhone_country(mdto.getPhone_country());
		ttdto.setPhone(mdto.getPhone());
		ttdto.setBank_name(mdto.getBank_name());
		ttdto.setAccount(mdto.getAccount());
		ttdto.setSysname(mdto.getSysname());
		ttdto.setAddress(mdto.getAddress());
		ttdto.setSysname(mdto.getSysname());

		model.addAttribute("ttdto", ttdto);
		return "/tutor/payMain";
	}

	@RequestMapping(value="complete", produces="application/json; charset=utf8")
	@ResponseBody
	public String complete(String imp_uid) {

		return new Gson().toJson(imp_uid);
	}

	@RequestMapping("paySuccess")
	public String paySuccess(TuteeDTO ttdto, Model model) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		ttdto.setId(mdto.getId());
		ttdto.setName(mdto.getName());
		ttdto.setEmail(mdto.getEmail());
		ttdto.setPhone_country(mdto.getPhone_country());
		ttdto.setPhone(mdto.getPhone());
		ttdto.setBank_name(mdto.getBank_name());
		ttdto.setAccount(mdto.getAccount());
		ttdto.setSysname(mdto.getSysname());
		ttdto.setAddress(mdto.getAddress());
		ttdto.setSysname(mdto.getSysname());


		int parent_seq = ttdto.getParent_seq();
		tservice.tuteeInsert(ttdto);
		tservice.tuteeCurnumCount(ttdto);
		return "redirect: /tutor/lessonView?seq="+parent_seq;
	}
	
	@RequestMapping("cancle")
	public String cancel(TuteeDTO ttdto, String start_date,Model model) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		ttdto.setId(mdto.getId());
		
		model.addAttribute("start_date",start_date);
		model.addAttribute("ttdto",ttdto);
		return "/tutor/payRefund";
	}
	
	
	@RequestMapping("refundPrice")
	@ResponseBody
	public int refundPrice(String start_date, int price) throws Exception{
		SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
		//start_date
		Date sdate =null;
		//현재날짜
		Date todayDate = new Date();
		
		String today = form.format(todayDate);
		
		//start_date 날짜 형식으로 바꾸기 
		sdate = form.parse(start_date);

		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(sdate);
		cal1.add(Calendar.DATE, 10);
		
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(sdate);
		cal2.add(Calendar.DATE, 15);
		
		//날짜 비교
		int compareAll = todayDate.compareTo(sdate);	//오늘날짜 start_date 비교
		int compareTen = todayDate.compareTo(cal1.getTime());	//오늘날짜 start_date+10 비교
		int compareFifteen = todayDate.compareTo(cal2.getTime());	//오늘날짜 start_date+15 비교
		
		//전액환불
		if(compareAll<0) {
			System.out.println("todayDate < sdate : 전액환불");
			return price;
			
		}else if(compareAll>=0 && compareTen<0) {
			System.out.println("todayDate < sdate+10 : 1일~10일 경과 -  2/3 환불");
			return (price/3)*2;
			
		}else if(compareTen >= 0 && compareFifteen < 0 ){
			System.out.println("todayDate < sdate+15 : 10일~15일 경과 -  1/2 환불");
			return price/2;
			
		}else if(compareFifteen>0) {
			System.out.println("todayDate > sdate+15 : 환불 X");
			return 0;
		}
		
		return price;

//		//현재날짜
//		System.out.println(todayDate);	//date 형식
//		System.out.println(today);	//String 형식
//		
//		//date 형식으로 start_date
//		System.out.println(sdate);
//		//date 형식으로
//		//cal1 = start_date+10
//		//cal2 = start_date+15
//		System.out.println(cal1.getTime());
//		System.out.println(cal2.getTime());
//		
//		//string 형식으로 
//		String strDate1 = form.format(cal1.getTime());
//		String strDate2 = form.format(cal2.getTime());
//		
//		System.out.println(strDate1);
//		System.out.println(strDate2); 

	}
	
	@RequestMapping("refundInsert")
	public String refundInsert(TuteeDTO ttdto, Model model) throws Exception{
		tservice.refundInsert(ttdto);
		
		ttdto.getParent_seq();
		model.addAttribute(ttdto);
		return "/tutor/lessonView?seq="+ttdto.getParent_seq();
	}
	
	
	
	
}
