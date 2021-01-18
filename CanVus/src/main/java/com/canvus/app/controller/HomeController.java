package com.canvus.app.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		logger.info("call home page");
		
		return "home";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		logger.info("메인 페이지 이동");
		
		return "main";
	}
	
	@RequestMapping(value="/discovery", method = RequestMethod.GET)
	public String discovery() {
		logger.info("discovery로 이동");
		
		return "discovery";
	}
	
	@RequestMapping(value="/share", method= RequestMethod.GET)
	public String share() {
		logger.info("share로 이동");
		
		return "share";
	}
	
	@RequestMapping(value="/searchResult", method= RequestMethod.GET)
	public String search(String searchText, Model model) {
		logger.info("서치결과 페이지로 이동");
		model.addAttribute("searchText", searchText);
		return "searchResult";
	}
	
	@RequestMapping(value="/drawing", method= RequestMethod.GET)
	public String drawing() {
		logger.info("드로잉 페이지로 이동");
		
		return "drawWith";
	}
	
	@RequestMapping(value="/board", method=RequestMethod.GET)
	public String board() {
		return "board";
	}
	
}