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
	
	@RequestMapping("cancleTest")
	public String cancelTest(TuteeDTO ttdto, String start_date,Model model) throws Exception{
		MemberDTO mdto = new MemberDTO();
		ttdto.setId(mdto.getId());
//		String[] array = start_date.split("-");
//		for(int i=0; i<array.length; i++) {
//			System.out.println(array[i]);
//		}
//
//		SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
//
//		Date to = form.parse(start_date);
//		System.out.println(to);
		
		model.addAttribute("start_date",start_date);
		model.addAttribute("ttdto",ttdto);
		return "/tutor/payRefund_test";
	}
	
	
	@RequestMapping("refundPrice")
	@ResponseBody
	public String refundPrice(String start_date) throws Exception{
		System.out.println(start_date);
		
		SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
		Date date =null;
		
		date = form.parse(start_date);
		
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(date);
		cal1.add(Calendar.DATE, 10);
		
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(date);
		cal2.add(Calendar.DATE, 15);
		
		//start_date
		System.out.println(date);
		//date 형식으로
		//cal1 = start_date+10
		//cal2 = start_date+15
		System.out.println(cal1.getTime());
		System.out.println(cal2.getTime());
		
		//string 형식으로 
		String strDate1 = form.format(cal1.getTime());
		String strDate2 = form.format(cal2.getTime());
		
		System.out.println(strDate1);
		System.out.println(strDate2);
		
		return start_date;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value="cancle", produces="application/json; charset=utf8")
	@ResponseBody
	public String cancle(String merchant_uid) {

		return new Gson().toJson(merchant_uid);
	}


}
