package com.canvus.app.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.canvus.app.service.FeedService;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpSession;

@Controller
@Slf4j
@RequestMapping(value="/feed")
public class FeedController {
	@Autowired
	private FeedService feedService;

	@RequestMapping(value="/view", method= RequestMethod.GET)
	public String readFeed(String feed_id, HttpSession session, Model model){
		log.info("피드 뷰 컨트롤러 메소드 진입");
		String url = "";

		url = feedService.readFeed(feed_id, session, model);

		return url;
	}

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
	 * 작성자: 이한결
	 * @param params
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/readFeed")
	public Map<String, Object> readFeed(@RequestBody Map<String, String> params) {
		
		return null;
	}

	/**
	 * AJAX 통신
	 * 해당 피드에 like를 추가하는 메소드
	 * 작성일: 2021.02.22
	 * 작성자: 이한결
	 * @param params
	 */
	@ResponseBody
	@RequestMapping(value="/addLike", method= RequestMethod.POST)
	public void addLike(@RequestBody Map<String, Object> params) {
		log.info("like 증가 메소드 진입");
		feedService.addLike(params);
	}

	/**
	 * AJAX 통신
	 * 해당 피드에 like를 제거하는 메소드
	 * 작성일: 2021.02.22
	 * 작성자: 이한결
	 * @param params
	 */
	@ResponseBody
	@RequestMapping(value="/deleteLike", method=RequestMethod.POST)
	public void deleteLike(@RequestBody Map<String, Object> params) {
		log.info("like 증가 메소드 진입");
		feedService.deleteLike(params);
	}
}
