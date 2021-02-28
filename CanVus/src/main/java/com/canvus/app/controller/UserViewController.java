package com.canvus.app.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;
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

@Slf4j
@Controller
@RequestMapping(value="/user")
public class UserViewController {
	@Autowired
	private UserService userService;

	
	@RequestMapping(value="/loginForm", method=RequestMethod.GET)
	public String loginForm() {
		log.info("로그인 폼으로 이동");
		return "user/loginForm";
	}

	@RequestMapping(value="/loginProcess", method=RequestMethod.POST)
	public String loginProcess(UserVO vo, HttpSession session, Model model) {
		log.info("로그인 프로세스 진입");

		UserVO userInfo = null;
		String idToken = vo.getIdToken();
		String url = null;
		
		userInfo = userService.login(idToken);
		
		if (userInfo == null) {// 로그인 시도결과 로그인이 아닌 경우 -> 회원가입
			log.info("회원이 아님 회원가입 프로세스 진행");
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
	public String board(String user_id, Model model, HttpSession session) {
		String url = userService.board(user_id, model, session);

		return url;
	}

	/**
	 * 더보기 버튼을 누를 시 피드 번들을 하나 더 가지고 오는 메소드
	 * 20210225
	 * 이한결
	 * @param params
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/board/seeMore", method=RequestMethod.POST)
	public Map<String, Object> restSeeMore(@RequestBody Map<String, Object> params) {
		log.info("더불러오기 컨트롤러 메소드 진입");

		return userService.restSeeMore(params);
	}
	
	@RequestMapping(value="/pixelManagement", method=RequestMethod.GET)
	public String pixelManagement() {
		log.info("pixel management로 이동");
		
		return "user/pixelManagement";
	}

	/**
	 * 로그아웃 메소드
	 * 작성일: 2021.02.23
	 * 작성자: 이한결
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("userId");
		session.removeAttribute("userVO");
		
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
		log.info("픽셀 선물하기 컨트롤러");
		
		return userService.presentPixel(params);
	}

	/**
	 * 현재 보유중인 픽셀 수를 얻어내는 메소드
	 * 20210228
	 * 이한결
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/getPixelAmount", method=RequestMethod.POST)
	public Map<String, Object> getPixelAmount(HttpSession session){

		return  userService.getPixelAmount(session);
	}

	/**
	 * 회원가입시 닉네임 중복체크
	 * 20210226
	 * 이한결
	 * @param params
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/checkDuplicateNickname", method=RequestMethod.POST)
	public Map<String, Object> checkDuplicateNickname(@RequestBody Map<String, Object> params) {
		params.put("isDuplicate", userService.checkDuplicateNickname(params));

		return params;
	}
}
