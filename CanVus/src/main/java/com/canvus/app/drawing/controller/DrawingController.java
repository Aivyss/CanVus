package com.canvus.app.drawing.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.canvus.app.drawing.service.DrawingService;
import com.canvus.app.drawing.vo.DrawingRoomVO;
import com.canvus.app.drawing.vo.DrawingUserVO;
import com.canvus.app.drawing.vo.PageVO;
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
	 * 방 생성버튼을 클릭했을 때
	 * 틀 작성일: 2021.01.16
	 * @return
	 */
	@RequestMapping(value="/createRoom", method=RequestMethod.POST)
	public String createRoom(DrawingRoomVO roomInfo, Model model, 
			HttpSession session, RedirectAttributes redirectAttributes) {
		// 값이 잘 들어왔는지 체크용 나중에 지워야함
		log.info("방만들기 controller 시작");
		log.info(roomInfo.getTitle());
		log.info(roomInfo.getPassword());
		log.info(String.valueOf(roomInfo.getUser_no()));
		log.info((String) session.getAttribute("userId"));
		
		// 리다이렉트 분기를 위해 정의한 변수
		String url = "";

		// TODO 방을 생성하고 DB저장후 반환된 방정보
		DrawingRoomVO result = drawingService.createRoom(roomInfo, session);
		
		// TODO 방이 생성됐는지 여부에 따라 분기
		if (result == null) {
			url = "redirect:/main";
		} else {
			url = "redirect:/drawing/room/?room_Id=" + result.getRoom_Id();
		}
		
		
		log.info("방만들기 controller 종료");
		return url;
	}
	
	//
	/**
	 * 방 입장을 위한 메소드
	 * 세션에 비밀번호를 넣은 이유: POST 방식이기 때문에.
	 * room_Id는 포스트 방식이지만 쿼리스트링을 직접 때려넣어 노출시킬 것이다.
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/room", method=RequestMethod.POST)
	public String room(String room_Id, DrawingRoomVO vo, HttpSession session, Model model) {
		log.info("방 입장 컨트롤러 작동");
		String url = null; 
		
		DrawingRoomVO roomInfo = drawingService.getRoomById(room_Id);

		List<DrawingUserVO> userList = drawingService.getUserList(room_Id);
		List<PageVO> pageList = drawingService.getPgs(room_Id);
		
		if(userList.size() <= roomInfo.getUser_no()) {
			url = "redirect:/main";
		}
		
		model.addAttribute("roomInfo", roomInfo);
		model.addAttribute("pwWttnByUser", vo.getPassword());
		model.addAttribute("userList", userList);
		model.addAttribute("pageList", pageList);
		
		return "drawing/room";
	}
	
	/**
	 * 레이어를 데이터베이스에 저장하는 메소드
	 * 작성일 2021.01.21 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param params
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/savePage")
	public boolean savePage(@RequestBody Map<String, Object> params) {
		boolean check = drawingService.savePage(params);
		
		return false;
	}
}
