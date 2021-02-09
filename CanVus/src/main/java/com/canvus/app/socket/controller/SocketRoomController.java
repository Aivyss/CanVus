package com.canvus.app.socket.controller;

import java.util.HashMap;
import java.util.Map;

import com.canvus.app.socket.service.StompService;
import com.canvus.app.socket.vo.MessageVO;
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
	@Autowired
	private StompService stompService;

	/**
	 * fabric 객체를 DB에 저장 및 방에 입장해 있는 유저에게 전달하는 메소드
	 * 작성일: 2021.02.03 / 완료일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param json
	 * @param headerAccessor
	 * @return
	 */
	@MessageMapping("/drawing/room/{room_Id}/fabric")
	@SendTo("/subscribe/drawing/room/{room_Id}/fabric")
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

	/**
	 * 채팅 메세지를 방에 있는 유저에게 전송하는 메소드.
	 * 드로잉 룸 채팅 메세지는 데이터베이스에 저장하지 않는다.
	 * 작성일: 2021.02.05 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param message
	 * @return
	 */
	@MessageMapping("/drawing/room/{room_Id}/chat")
	@SendTo("/subscribe/drawing/room/{room_Id}/chat")
	public Map<String, Object> sendChat (@DestinationVariable("room_Id") String room_Id, MessageVO message) {
		log.info("채팅 및 기타 기능 컨트롤러");

		return stompService.parser(room_Id, message);
	}
}
