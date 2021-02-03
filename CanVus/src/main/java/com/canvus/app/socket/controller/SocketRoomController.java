package com.canvus.app.socket.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;

import com.canvus.app.drawing.service.DrawingService;
import com.canvus.app.socket.vo.SocketJson;
import com.canvus.app.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SocketRoomController {
	@Autowired
	private DrawingService drawingService;

	@MessageMapping("/test/room/{room_Id}/fabric")
	@SendTo("/subscribe/test/room/{room_Id}/fabric")
	public Map<String, Object> fabric(@DestinationVariable("room_Id") String room_Id,
			Map<String, Object> json, SimpMessageHeaderAccessor headerAccessor){
		log.info("fabric 객체 stringify 컨트롤러");
		
		log.info(json.toString()); // 객체 제대로 들어왔는지 확인해보자 으으으
		
		// fabric 객체가 있는 json을 db에 넣는 프로세스
		boolean check = drawingService.updatePage(json, room_Id);
		
		if (!check) {
			// 성공하지 못했다면 json 보내지마
			json = null;
		}
		
		return json;
	}
}
