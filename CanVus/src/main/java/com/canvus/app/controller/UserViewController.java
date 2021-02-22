package com.canvus.app.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.canvus.app.service.UserService;
import com.canvus.app.vo.BookmarkVO;
import com.canvus.app.vo.UserVO;

@Controller
@RequestMapping(value="/user")
public class UserViewController {
	private static final Logger logger = LoggerFactory.getLogger(UserViewController.class);
	@Autowired
	private UserService userService;

	
	@RequestMapping(value="/loginForm", method=RequestMethod.GET)
	public String login() {
		logger.info("로그인 폼으로 이동");
		return "user/loginForm";
	}
	
	
	@RequestMapping(value="/loginProcess", method=RequestMethod.POST)
	public String loginProcess(UserVO vo, HttpSession session, Model model) {
		logger.info("로그인 프로세스 진입");

		UserVO userInfo = null;
		String idToken = vo.getIdToken();
		String url = null;
		
		userInfo = userService.login(idToken);
		
		if (userInfo == null) {// 로그인 시도결과 로그인이 아닌 경우 -> 회원가입
			logger.info("회원이 아님 회원가입 프로세스 진행");
			model.addAttribute("idToken", idToken);
			url = "/user/signup";
		} else {// 로그인인 경우
			session.setAttribute("userId", userInfo.getUser_id());
			session.setAttribute("userVO", userInfo);
			url = "redirect:/";
		}
		
		return url;
	}
	
	@RequestMapping(value="/signupSubmit", method=RequestMethod.POST)
	public String signupSubmit(UserVO vo, MultipartFile photo_upload, HttpSession session) {
		vo = userService.signup(vo, photo_upload);
		String url = "redirect:/";
		
		if (vo != null) { // 회원가입 완료 validation check
			session.setAttribute("userId", vo.getUser_id());
			session.setAttribute("userVO", vo);
			url = "redirect:/";
		} else { // 회원가입 실패
			session.removeAttribute("userId");
			session.removeAttribute("userVO");
		}
		
		return url;
	}

	/**
	 * 특정 회원의 보드로 이동하는 메소드
	 * 작성일: 2021.02.18 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param user_id
	 * @return
	 */
	@RequestMapping(value="/board", method=RequestMethod.GET)
	public String board(String user_id, Model model) {
		String url = userService.board(user_id, model);

		return url;
	}
	
	@RequestMapping(value="/bookmarks", method=RequestMethod.GET)
	public String bookmarks() {
		logger.info("bookmark로 이동");
		
		return "user/bookmarks";
	}
	
	/**
	 * 북마크를 생성하는 프로세스로 진입. ajax 통신방식으로 생성
	 * 작성일: 2021.01.22 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * 
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/bookmarks/makeFolder", method=RequestMethod.POST)
	public BookmarkVO makeFolder(BookmarkVO inputInfo, HttpSession session) {
		logger.info("북마크 생성 프로세스 진입 controller");
	
		// TODO 북마크 생성 (중복체크 실시 후 중복이 없을 시 생성)
		BookmarkVO bookmark = userService.makeFolder(session, inputInfo);
		
		return bookmark;
	}
	
	/**
	 * 기존에 존재하는 북마크를 제거하는 메소드
	 * 작성일: 2021.01.22 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param inputInfo
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/bookmarks/deleteFolder", method=RequestMethod.POST)
	public Map<String, String> deleteFolder(@RequestBody Map<String, Object> params) {
		logger.info("북마크 폴더삭제 컨트롤러 메소드 진입");
		
		// TODO 북마크 폴더 제거
		boolean check = userService.deleteFolder(params);
		
		Map<String, String> result = new HashMap<String, String>();
		if (check) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}

//	@ResponseBody
//	@RequestMapping(value="/bookmarks/addFeed", method=RequestMethod.POST)
//	public void addFeedToBookmark(@RequestBody Map<String, Object> params) {
//
//	}
	
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
	
	/**
	 * 픽셀을 선물하는 메소드
	 * 작성일: 2021.02.08 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param params (key: sender, receiver, pixel)
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/presentPixel", method=RequestMethod.POST)
	public Map<String, Object> presentPixel(@RequestBody Map<String, Object> params) {
		logger.info("픽셀 전물하기 컨트롤러");
		
		return userService.presentPixel(params);
	}
	
}
