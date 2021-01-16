package com.canvus.app.controller;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.canvus.app.service.UserService;
import com.canvus.app.vo.UserVO;

@Controller
@RequestMapping(value="/user")
public class UserViewController {
	private static final Logger logger = LoggerFactory.getLogger(UserViewController.class);
	@Autowired
	private UserService service;

	
	@RequestMapping(value="/loginForm", method=RequestMethod.GET)
	public String login() {
		logger.info("로그인 폼으로 이동");
		return "user/loginForm";
	}
	
	
	@RequestMapping(value="/loginProcess", method=RequestMethod.POST)
	public String loginProcess(UserVO vo, HttpSession session, Model model) {
		logger.info("로그인 프로세스 진입");

		String id = null;
		String idToken = vo.getIdToken();
		String url = null;
		
		id = service.login(idToken);
		
		if (id == null) {// 로그인 시도결과 로그인이 아닌 경우 -> 회원가입
			logger.info("회원이 아님 회원가입 프로세스 진행");
			model.addAttribute("idToken", idToken);
			url = "/user/signup";
		} else {// 로그인인 경우
			session.setAttribute("userId", id);
			url = "redirect:/main";
		}
		
		return url;
	}
	
	@RequestMapping(value="/signupSubmit", method=RequestMethod.POST)
	public String signupSubmit(UserVO vo, HttpSession session) {
		vo = service.signup(vo);
		String url = "redirect:/";
		
		if (vo != null) { // 회원가입 완료 validation check
			session.setAttribute("userId", vo.getUser_id());
			url = "redirect:/main";
		} else { // 회원가입 실패
			session.removeAttribute("userId");
		}
		
		return url;
	}
	
	@RequestMapping(value="/bookmarks", method=RequestMethod.GET)
	public String bookmarks() {
		logger.info("bookmark로 이동");
		
		return "user/bookmarks";
	}
	
	@RequestMapping(value="/pixelManagement", method=RequestMethod.GET)
	public String pixelManagement() {
		logger.info("pixel management로 이동");
		
		return "user/pixelManagement";
	}
	
	@RequestMapping(value="/settings", method=RequestMethod.GET)
	public String settings() {
		logger.info("settings로 이동");
		
		return "user/settings";
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout() {
		
		return "redirect:/";
	}
}
