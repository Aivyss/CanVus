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
	public String enterRoom(DrawingRoomVO drawingRoom, HttpSession session) {
		boolean check = drawingService.enterRoom(drawingRoom);
		String url ="redirect:/main";
		
		if (check) {
			session.setAttribute("roomId", drawingRoom.getRoomId());
			url = "redirect:/drawing/drawingRoom";
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
	public String createRoom(DrawingRoomVO roomInfo, Model model, HttpSession session) {
		DrawingRoomVO result = drawingService.createRoom(roomInfo, session);
		List<Map<String, String>> userList = drawingService.getUserList(result.getRoomId());
		
		
		model.addAttribute("roomInfo", result);
		model.addAttribute("userList", userList);
		
		return "drawing/room";
	}
}
