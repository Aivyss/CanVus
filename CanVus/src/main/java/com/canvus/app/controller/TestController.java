package com.canvus.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.canvus.app.service.PaymentService;
import com.canvus.app.service.SearchService;
import com.canvus.app.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/test")
@Slf4j
/**
 * 제작일: 2021.01.13
 * 기능: 테스트용 컨트롤러
 * @author 이한결
 */
public class TestController {
	@Autowired
	private UserService userService;
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private SearchService searchService;

	@RequestMapping(value="testStation", method=RequestMethod.GET)
	public String testStation() {
		log.info("테스트 스테이션으로 이동");
		
		return "test/testStation";
	}
	
	/**
	 * 틀 제작일: 2021.01.14 / 완성일:  / 버그 검증완료:
	 * 작성자: 이한결
	 * @return
	 */
	@RequestMapping(value="writeForm", method=RequestMethod.GET)
	public String writeForm() {
		log.info("테스트 피드작성으로 이동");
		return "test/writeForm()";
	}
}
