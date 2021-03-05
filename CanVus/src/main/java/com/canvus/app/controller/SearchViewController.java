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
		String url = "";
		
		if (type == 0) {
			url = searchService.tagSearch("#"+keyword, model);
		} else {
			url = searchService.userSearch(keyword, model);
		}
		
		return url;
	}

	@RequestMapping(value="/noResult", method = RequestMethod.GET)
	public String noResult() {
		log.info("검색결과가 없어서 가는 페이지");

		return "search/noResult";
	}
}
