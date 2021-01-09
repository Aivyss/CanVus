package com.canvus.app.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/search")
public class SearchViewController {
	private static final Logger logger = LoggerFactory.getLogger(SearchViewController.class);
	
	@RequestMapping(value="/imageSearch", method=RequestMethod.GET)
	public String imageSearch() {
		logger.info("AI 이미징 서치로 이동");
		
		return "search/imageSearch";
	}

}
