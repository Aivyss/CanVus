package com.canvus.app.socket.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.drawing.dao.DrawingDAO;
import com.canvus.app.drawing.service.DrawingService;
import com.canvus.app.drawing.vo.DrawingUserVO;
import com.canvus.app.socket.vo.MessageVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class StompService {
	@Autowired
	DrawingService drawingService;
	
	/**
	 * 메세지 파서
	 * 작성일: 2021.02.28 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param message
	 * @return
	 */
	public Map<String, Object> parser(String room_Id, MessageVO message) {
		log.info("메세지 파서 메소드 진입");
		String type = message.getType();
		Map<String, Object> container = new HashMap<String, Object>();
		
		if (type.toUpperCase().equals("COMMONCHAT")) {
			container = commonChat(message);
		} else if (type.toUpperCase().equals("ENTER")) {
			container = enter(room_Id, message);
		} else if (type.toUpperCase().equals("QUIT")) {
			container = quit(room_Id, message);
		} else if (type.toUpperCase().equals("CREATEPAGELAYER")) {
			container = createPageLayer(room_Id, message);
		}
		
		return container;
	}
	
	/**
	 * 일반 채팅을 처리하는 서비스 메소드
	 * 작성일: 2021.02.28 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param message
	 * @return
	 */
	private Map<String, Object> commonChat(MessageVO message) {
		Map<String, Object> container = new HashMap<String, Object>();
		
		container.put("header", "COMMONCHAT");
		container.put("message", message);
		
		return container;
	}
	
	/**
	 * 방입장을 처리하는 서비스 메소드. 방 안의 유저리스트를 반환한다.
	 * 작성일: 2021.02.28 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param message
	 * @return
	 */
	private Map<String, Object> enter(String room_Id, MessageVO message) {
		// message에 있어야할 내용: 없음
		Map<String, Object> container = new HashMap<String, Object>();
		List<DrawingUserVO> userListInRoom = drawingService.getRoomUserList(room_Id);
		
		container.put("header", "ENTER");
		container.put("userListInRoom", userListInRoom);
		
		return container;
	}
	
	/**
	 * 방퇴장을 처리하는 서비스 메소드. 방에서 유저 정보를 삭제하고 방 리스트를 반환한다.
	 * 작성일: 2021.02.28 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param message
	 * @return
	 */
	private Map<String, Object> quit(String room_Id, MessageVO message) {
		// message에 있어야할 내용 : 퇴장하는 유저의 아이디	
		String userId = message.getMessage();
		Map<String, Object> container = new HashMap<String, Object>();
		List<DrawingUserVO> userListInRoom = null;
		// 방을 퇴장시킨다.
		boolean quitSuccess = drawingService.quitRoom(room_Id, userId);
		
		if (quitSuccess) {
			userListInRoom = drawingService.getRoomUserList(room_Id);
			container.put("header", "QUIT");
			container.put("userListInRoom", userListInRoom);
		}
		
		return container;
	}
	
	/**
	 * 페이지-레이어를 생성하는 서비스 메소드
	 * 작성일: 2021.02.08 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param message
	 * @return
	 */
	private Map<String, Object> createPageLayer(String room_Id, MessageVO message) {
		// 있어야할 내용: 페이지-레이어 번호(스트링 값으로 줘야함)
		String[] pageLayerSet = message.getMessage().split("-");
		Map<String, Object> container = new HashMap<String, Object>();
		
		int page_no = Integer.parseInt(pageLayerSet[0]);
		int layer_no = Integer.parseInt(pageLayerSet[1]);		
		container.put("room_Id", room_Id);
		container.put("page_no", page_no);
		container.put("layer_no", layer_no);
	
		drawingService.createPage(container);
		
		return container;
	}
}
