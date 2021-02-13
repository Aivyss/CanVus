package com.canvus.app.socket.controller;

import java.util.Map;

import com.canvus.app.socket.service.StompService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.canvus.app.drawing.service.DrawingService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SocketRoomController {
	@Autowired
	private DrawingService drawingService;
	@Autowired
	private StompService stompService;

	/**
	 * 채팅 메세지를 방에 있는 유저에게 전송하는 메소드.
	 * 드로잉 룸 채팅 메세지는 데이터베이스에 저장하지 않는다.
	 * 작성일: 2021.02.05 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param json
	 * @return
	 */
	@MessageMapping("/drawing/room/{room_Id}")
	@SendTo("/subscribe/drawing/room/{room_Id}")
	public Map<String, Object> sendChat (@DestinationVariable("room_Id") String room_Id, Map<String, Object> json) {
		log.info("채팅 및 기타 기능 컨트롤러");
		return stompService.parser(room_Id, json);
	}
}
