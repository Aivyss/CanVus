package com.canvus.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.canvus.app.service.SearchService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/search")
@Slf4j
public class SearchViewController {
	@Autowired
	SearchService searchService;
	
	/**
	 * 작성자: 이한결
	 * 작성일: 2021.01.14 / 완성일: 2021.01.14 / 버그 검증완료:
	 * 검색을 수행하는 컨트롤러
	 * @param
	 * @return
	 */
	@RequestMapping(value="/result", method=RequestMethod.GET)
	public String search(String keyword, int type, Model model) {
		log.info("s-controller 서치 실행메소드");
		log.info(keyword);
		
		if (type == 0) {
			model.addAttribute("searchTagList", searchService.tagSearch(keyword));
		} else {
			model.addAttribute("searchUserList", searchService.userSearch(keyword));
		}
		
		return "/search/result";
	}
	
	/**
	 * 테스트를 위해 만든 메소드로 차후에 지움.
	 */
	@RequestMapping(value="/imageSearch", method=RequestMethod.GET)
	public String imageSearch() {
		log.info("AI 이미징 서치로 이동");
		
		return "search/imageSearch";
	}

}
