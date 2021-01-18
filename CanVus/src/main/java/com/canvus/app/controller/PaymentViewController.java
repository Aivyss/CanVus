package com.canvus.app.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.canvus.app.service.PaymentService;
import com.canvus.app.vo.PaymentCompleteInfo;

@Controller
@RequestMapping(value="/payment")
public class PaymentViewController {
	@Autowired
	PaymentService service;
	
	private static final Logger logger = LoggerFactory.getLogger(PaymentViewController.class);
	
	@RequestMapping(value="/module", method=RequestMethod.GET)
	public String module() {
		logger.info("move to payment module page");

		return "payment/module";
	}
	
	@RequestMapping(value="/complete", method=RequestMethod.POST)
	public String complete(@RequestBody PaymentCompleteInfo info, ModelMap map) {
		logger.info("결제완료 처리 서버단");
		logger.info("{}", info);
		
		return "redirect:payment/complete";
	}
	
	@RequestMapping(value="/parseMerchantUid")
	@ResponseBody
	public Map<String, String> parseMerchantUid(@RequestBody Map<String, String> params) {
		logger.info("파싱 과정 진입");

		Map<String, String> output = new HashMap<String, String>();
		output.put("merchant_uid", service.merchantUidParse(params));
		logger.info(output.get("merchant_uid"));
		
		return output;
	}
	
	@RequestMapping(value="/paymentSubmit")
	@ResponseBody
	public Map<String, String> paymentSubmit(@RequestBody Map<String, String> params) {
		logger.info("결제 승인과정");
		
		String result = "결제실패";
		Map<String, String> output = new HashMap<String, String>();
		
		boolean check = service.paymentSubmit(params);
		
		if (check) {
			result = "결제 성공";
			output.put("result", result);
			logger.info(result);
		} else {
			output.put("result", result);
			logger.info(result);
		}
		
		return output;
	}
	
	@RequestMapping(value="paymentBackEndTest", method=RequestMethod.GET)
	public String paymentBackEndTest() {
		logger.info("결제 백앤드 테스트를 위해서 넣은 것으로 나중에 무조건 빼야함");
		
		return "payment/paymentBackEndTest";
	}
}