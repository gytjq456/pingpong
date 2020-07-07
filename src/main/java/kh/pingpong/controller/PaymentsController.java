package kh.pingpong.controller;

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
	public String cancelTest() throws Exception{
		return "/tutor/payRefund";
	}
	
	@RequestMapping(value="cancle", produces="application/json; charset=utf8")
	@ResponseBody
	public String cancle(String merchant_uid) {

		return new Gson().toJson(merchant_uid);
	}


}
