package com.canvus.app.drawing.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.canvus.app.drawing.service.DrawingService;
import com.canvus.app.drawing.vo.DrawingRoomVO;
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
			List<Map<String, String>> userList = drawingService.getUserList(roomInfo.getRoomId());
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
	public String createRoom(DrawingRoomVO roomInfo, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
		DrawingRoomVO result = drawingService.createRoom(roomInfo, session);
		List<Map<String, String>> userList = drawingService.getUserList(result.getRoomId());
		
		redirectAttributes.addAttribute("roomInfo", result);
		redirectAttributes.addAttribute("userList", userList);
		
		return "redirect:/drawing/room";
	}
	
	@RequestMapping(value="/room", method=RequestMethod.GET)
	public String room(@RequestParam("roomInfo") DrawingRoomVO roomInfo, 
			@RequestParam("userList") List<Map<String, String>> userList,
			Model model) {
		
		model.addAttribute("roomInfo", roomInfo);
		model.addAttribute("userList", userList);
		
		return "drawing/room";
	}
}
