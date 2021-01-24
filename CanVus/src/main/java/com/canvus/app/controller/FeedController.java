package com.canvus.app.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.canvus.app.service.FeedService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value="/feed")
public class FeedController {
	@Autowired
	private FeedService feedService;
	
	/**
	 * AJAX 통신
	 * 수정버튼을 클릭할 시 해당 피드 context를 불러온다.
	 * 작성일: 2021.01.24 / 완료일: 2021.01.24/ 버그검증일:
	 * 작성자: 이한결
	 */
	@ResponseBody
	@RequestMapping(value="/getContext")
	public Map<String, String> getContext (@RequestBody Map<String, String> params) {
		log.info("getContext 컨트롤러 메소드 진입");
		
		return feedService.getContext(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/updateFeed")
	public Map<String, String> updateFeed (@RequestBody Map<String, String> params) {
		log.info("피드 수정 메소드 진입");
		
		return feedService.updateFeed(params);
	}
	
	/**
	 * AJAX 통신
	 * 피드를 읽을 때 정보를 불러오는 메소드.
	 * 작성일: 2021.01.24 / 완료일:
	 * @param params
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/readFeed")
	public Map<String, Object> readFeed(@RequestBody Map<String, String> params) {
		
		return null;
	}
}
