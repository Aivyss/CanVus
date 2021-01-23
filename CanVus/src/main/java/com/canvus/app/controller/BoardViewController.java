package com.canvus.app.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.canvus.app.service.BoardService;
import com.canvus.app.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BoardViewController {
	@Autowired
	private UserService userService;
	@Autowired
	private BoardService boardService;
	
	/**
	 * 작성일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/board", method=RequestMethod.GET)
	public String board(String id) {
		// Query string으로 user id 를 받음.
		log.info("홈컨트롤러 보드이동 메소드 진입");
		Map<String, Object> fullInfo = boardService.board(id);
		
		return "board";
	}
}
