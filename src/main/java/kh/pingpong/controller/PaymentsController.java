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

@Controller
@RequestMapping("/payments/")
public class PaymentsController {
	
	@Autowired
	private HttpSession session;

	@RequestMapping("test")
	public String test(Model model, String money, String name, String email) {
		model.addAttribute("email", email);
		model.addAttribute("money", money);
		model.addAttribute("name", name);
		return "tutor/payMain";
	}
	
	//튜티 결제
	@RequestMapping("payMain")
	public String payMain(Model model, int parent_seq, String title) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		TuteeDTO ttdto = new TuteeDTO();
		ttdto.setId(mdto.getId());
		ttdto.setName(mdto.getName());
		ttdto.setEmail(mdto.getEmail());
		ttdto.setPhone_country(mdto.getPhone_country());
		ttdto.setPhone(mdto.getPhone());
		ttdto.setBank_name(mdto.getBank_name());
		ttdto.setAccount(mdto.getAccount());
		ttdto.setSysname(mdto.getSysname());
		ttdto.setAddress(mdto.getAddress());
		ttdto.setTitle(title);
		ttdto.setParent_seq(parent_seq);
		
		model.addAttribute("ttdto", ttdto);
		return "/tutor/payMain";
	}

	@RequestMapping(value="complete", produces="application/json; charset=utf8")
	@ResponseBody
	public String complete(String imp_uid) {
//		imp_uid = extract_POST_value_from_url("imp_uid"); //post ajax request로부터 imp_uid확인
//		
//		payment_result = rest_api_to_find_payment(imp_uid); //imp_uid로 아임포트로부터 결제정보 조회
//		
//		amount_to_be_paid = query_amount_to_be_paid(payment_result.merchant_uid); //결제되었어야 하는 금액 조회. 가맹점에서는 merchant_uid기준으로 관리
//
//		if(payment_result.status == "paid" && payment_result.amount == amount_to_be_paid) {
//			success_post_process(payment_result)
//		} //결제까지 성공적으로 완료
//		else if(payment_result.status == 'ready' AND payment.pay_method == 'vbank') {
//			vbank_number_assigned(payment_result) //가상계좌 발급성공
//		}
//		else {{
//			fail_post_process(payment_result)
//		} //결제실패 처리
		return new Gson().toJson(imp_uid);
		}

		@RequestMapping("paySuccess")
		public String paySuccess(Model model, String msg) {
			model.addAttribute(msg);
			return "tutor/paySuccess";
		}

		@RequestMapping("payFail")
		public String payFail() {
			return "tutor/payFail";
		}
	}
