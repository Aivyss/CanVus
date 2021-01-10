package com.canvus.app.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.canvus.app.vo.PaymentCompleteInfo;

@Controller
@RequestMapping(value="/payment")
public class PaymentViewController {
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
	public void parseMerchantUid(@RequestParam Map<String, String> param, HttpServletRequest request, Model model) {
		logger.info("파싱 메소드 진입");
		String merchantUid = request.getParameter("merchant_uid");
		logger.info(merchantUid);
		model.addAttribute("merchant_uid", merchantUid);
	}
}
