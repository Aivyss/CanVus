package com.canvus.app.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
}
