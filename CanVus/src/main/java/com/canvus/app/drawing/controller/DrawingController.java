package com.canvus.app.drawing.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.canvus.app.drawing.vo.FeedVO;
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
import com.canvus.app.vo.CanVusVOFactory;
import com.canvus.app.vo.CanVusVOType;

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
		DrawingRoomVO roomInfoDB = drawingService.createRoom(roomInfo, session);
		
		// TODO 방이 생성됐는지 여부에 따라 분기
		if (roomInfoDB == null) {
			url = "redirect:/main";
		} else {
			session.setAttribute("pwWrttenByUser", roomInfoDB.getPassword());
			url = "redirect:/drawing/room/?room_Id=" + roomInfoDB.getRoom_Id();
		}
		
		log.info("방만들기 controller 종료");
		return url;
	}
	
	/**
	 * 방입장을 위한 메소드
	 * GET방식으로 방 아이디는 노출 시킬 생각이다. 편하게 URL을 공유할 수 있도록.
	 * 방 비밀번호가 필요한 경우에는 세션에 넣어서 전달한다.
	 * 작성일: 2021.01.22 / 수정일: 2021.02.08 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id, session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/room", method=RequestMethod.GET)
	public String room(String room_Id, HttpSession session, Model model) {
		/**
		 * AJAX로 비밀번호를 검증하든 안하든 이 메소드로 들어온다.
		 * 방찾기 페이지에서 AJAX로 검증해서 들어온 유저의 경우
		 * 세션에 roomPassword라는 키로 방 비밀번호를 가지고 있다.
		 * 직접 노출로 들어온 유저는 세션에 pwWrttenByUser라는 값이 없다.
		 * (단 이 전제는 방에 들어올 시 세션에서 pwWrttenByUser키에 대한 값을 초기화한 경우이다.
		 * 다른 방과 비밀번호가 겹칠 수 있으므로 방입장에 성공하면 매번 지워야 한다.)
		 * 하지만 모두 이 메소드로 들어와서 MODEL을 통해 비번값을 방 JSP 로 전달하고
		 * 방 JSP에서는 코어태그로 분기하여 구분한다.
		 * 
		 */
		log.info("방 입장 컨트롤러 작동");
		String url = drawingService.enterSpliter(room_Id, session, model);

		return url;
	}
	
	/**
	 * AJAX통신 방 비밀번호 체크 메소드
	 * 작성일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param params
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/passwordCheck", method=RequestMethod.POST)
	public Map<String, String> passwordCheck(@RequestBody Map<String, String> params, HttpSession session) {
		log.info("비밀번호 검증 컨트롤러 메소드 진입");
		String result = "";
		boolean check = drawingService.passwordCheck(params, session);
		
		if (check) {
			result = "success";
			
		} else {
			result = "fail";
		}
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * 방에 들어올시 세션에 저장된 방 비밀번호를 초기화하는 메소드
	 * 작성일: 2021.01.24 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param session
	 */
	@ResponseBody
	@RequestMapping(value="resetRoomPassword")
	public void resetRoomPassword (HttpSession session) {
		session.removeAttribute("pwWrttenByUser");
	}

	@ResponseBody
	@RequestMapping(value="/makeFeed", method=RequestMethod.POST)
	public String makeFeed(@RequestBody Map<String, Object> params) {
		boolean check = drawingService.makeFeed(params);
		
		return "redirect:/main";
	}
	
	
	/**
	 * 불러오기 시, 모든 페이지-레이어 정보를 불러온다.
	 * json에 방아이디를 넣어야한다.
	 * 작성일: 2021.02.04 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getAllLayers", method=RequestMethod.POST)
	public List<PageVO> selectAllPages(@RequestBody Map<String, Object> params) {
		log.info("모든 페이지-레이어 정보 불러오기 컨트롤러 메소드");
		log.info((String) params.get("room_Id"));
		
		return drawingService.getAllLayers((String) params.get("room_Id"));
	}
}
