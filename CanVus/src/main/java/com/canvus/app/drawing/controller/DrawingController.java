package com.canvus.app.drawing.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.canvus.app.drawing.service.DrawingService;
import com.canvus.app.drawing.vo.DrawingRoomVO;
import com.canvus.app.drawing.vo.DrawingUserVO;
import com.canvus.app.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/drawing")
public class DrawingController {
	@Autowired
	DrawingService drawingService;
	@Autowired
	UserService userService;
	/**
	 * 틀 작성일: 2021.01.16
	 * @param roomNo
	 * @return
	 */
	@RequestMapping(value="/enterRoom", method=RequestMethod.POST)
	public String enterRoom(DrawingRoomVO roomInfo, HttpSession session,
			RedirectAttributes redirectAttributes) {
		
		boolean check = drawingService.enterRoom(roomInfo);
		String url ="redirect:/main";
		
		if (check) {
			List<DrawingUserVO> userList = drawingService.getUserList(roomInfo.getRoom_Id());
			redirectAttributes.addAttribute("roomInfo", roomInfo);
			redirectAttributes.addAttribute("userList", userList);
			url = "redirect:/drawing/room";
		} else {
			session.setAttribute("alert", "방 비밀번호 입력 오류");
		}
		
		return url;
	}
	
	/**
	 * 방 생성버튼을 클릭했을 때
	 * 틀 작성일: 2021.01.16
	 * @return
	 */
	@RequestMapping(value="/createRoom", method=RequestMethod.POST)
	public String createRoom(DrawingRoomVO roomInfo, Model model, 
			HttpSession session, RedirectAttributes redirectAttributes) {
		log.info("방만들기 controller 시작");
		log.info(roomInfo.getTitle());
		log.info(roomInfo.getPassword());
		log.info(String.valueOf(roomInfo.getUser_no()));
		log.info((String) session.getAttribute("userId"));
		String url = "";
		List<DrawingUserVO> userList = null;
		DrawingRoomVO result = drawingService.createRoom(roomInfo, session);
		
		if (result == null) {
			url = "redirect:/main";
		} else {
			userList = drawingService.getUserList(result.getRoom_Id());
			log.info("제발 여기까지만이라도 와줘");
			url = "redirect:/drawing/room";
		}
		
		// 왠지 모르겠는데 addAttribute는 안먹힘.
		redirectAttributes.addFlashAttribute("roomInfo", result);
		redirectAttributes.addFlashAttribute("userList", userList);
		
		log.info("방만들기 controller 종료");
		return url;
	}
	
	// POST방식 안됨.. 왜 안돼 하 ㅠ
	@RequestMapping(value="/room", method=RequestMethod.GET)
	public String room(HttpServletRequest request, Model model) {
		// 리다이렉트로 값 넘길 때 필요함
		 Map<String, ?> redirectMap = RequestContextUtils.getInputFlashMap(request);  

		
		model.addAttribute("roomInfo", (DrawingRoomVO) redirectMap.get("roomInfo"));
		model.addAttribute("userList", (List<DrawingUserVO>) redirectMap.get("userList"));
		
		return "drawing/room";
	}
}
