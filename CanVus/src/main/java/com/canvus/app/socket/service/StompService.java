package com.canvus.app.socket.service;

import com.canvus.app.drawing.service.DrawingService;
import com.canvus.app.drawing.vo.DrawingUserVO;
import com.canvus.app.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class StompService {
	@Autowired
	DrawingService drawingService;
	@Autowired
	UserService userService;
	
	/**
	 * 메세지 파서
	 * 작성일: 2021.02.28 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param
	 * @return
	 */
	public Map<String, Object> parser(String room_Id, Map<String, Object> json) {
		log.info("메세지 파서 메소드 진입");
		String type = (String) json.get("type");
		type = type.toUpperCase();
		Map<String, Object> container = null;

		if (type.equals("COMMONCHAT")) {
			container = commonChat(json);
		} else if (type.equals("ENTER")) {
			container = enter(room_Id, json);
		} else if (type.equals("QUIT")) {
			container = quit(room_Id, json);
		} else if (type.equals("CREATEPAGELAYER")) {
			container = createPageLayer(room_Id, json);
		} else if (type.equals("PRESENTPIXEL")) {
			container = presentPixel(json);
		} else if (type.equals("DRAWING")) {
			container = drawing(room_Id, json);
		} else if (type.equals("DELETEPAGELAYER")) {
			container = deletePageLayer(room_Id, json);
		} else if (type.equals("ADDAUTHORITY")) {
			container = addAuthoity(room_Id, json);
		} else if (type.equals("CLOSEROOM")) {
			container = closeRoom(room_Id, json);
		}
		
		return container;
	}

	/**
	 * 피드를 작성하여 모든 유저를 나가게 하고 데이터베이스 상에서 방을 삭제하는 메소드
	 * 작성일: 2021.02.22
	 * 작성자: 이한결
	 * @param room_id
	 * @param json
	 * @return
	 */
	private Map<String, Object> closeRoom(String room_Id, Map<String, Object> json) {
		log.info("방 폭파 소켓서비스 메소드");
		drawingService.closeRoom(room_Id);

		return json;
	}

	/**
	 * 드로잉 권한부여 처리과정 --> 비동기
	 * 작성일: 2021.02.15 / 완성일: / 버그검증일: 
	 * 작성자: 이한결
	 * @param room_id
	 * @param json
	 * @return
	 */
	public Map<String, Object> addAuthoity(String room_Id, Map<String, Object> json) {
		log.info("권한부여 소켓 서비스 진입");
		drawingService.addAuthoity(room_Id, json);

		return json;
	}

	/**
	 * 레이어를 지우는 메소드 -> 비동기
	 * 작성일: 2021.02.13 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_id
	 * @param json
	 * @return
	 */
	public Map<String, Object> deletePageLayer(String room_Id, Map<String, Object> json) {
		log.info("레이어를 지우는 소켓 서비스메소드 진입");

		json.put("room_Id", room_Id);
		
		drawingService.deletePageLayer(room_Id, json);

		return json;
	}

	/**
	 * 드로잉을 처리하는 메소드 -> 비동기
	 * @param room_Id
	 * @param json
	 * @return
	 */
	public Map<String, Object> drawing(String room_Id, Map<String, Object> json) {
		log.info("드로잉을 처리하는 서비스 메소드");

		drawingService.updatePage(json, room_Id);

		return json;
	}

	/**
	 * 일반 채팅을 처리하는 서비스 메소드
	 * 작성일: 2021.02.28 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param message
	 * @return
	 */
	public Map<String, Object> commonChat(Map<String, Object> json) {

		return json;
	}
	
	/**
	 * 방입장을 처리하는 서비스 메소드. 방 안의 유저리스트를 반환한다.
	 * 작성일: 2021.02.28 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param message
	 * @return
	 */
	public Map<String, Object> enter(String room_Id, Map<String, Object> json) {
		// message에 있어야할 내용: 아이디, 닉네임
		List<DrawingUserVO> userListInRoom = drawingService.getRoomUserList(room_Id);

		json.put("userListInRoom", userListInRoom);
		
		return json;
	}
	
	/**
	 * 방퇴장을 처리하는 서비스 메소드. 방에서 유저 정보를 삭제하고 방 리스트를 반환한다.
	 * 작성일: 2021.02.28 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param message
	 * @return
	 */
	public Map<String, Object> quit(String room_Id, Map<String, Object> json) {
		log.info("퇴장 처리 서비스 메소드 진입");
		
		// TODO message에 있어야할 내용 : 퇴장하는 유저의 아이디
		Map<String, Object> message = (Map) json.get("message");
		String userId = (String) message.get("userId");
		List<DrawingUserVO> userListInRoom = null;

		// TODO 방을 퇴장시킨다.
		drawingService.quitRoom(room_Id, userId);

		// TODO 방 인원수를 다시 산출한다
		userListInRoom = drawingService.getRoomUserList(room_Id);

		json.put("userListInRoom", userListInRoom);

		return json;
	}
	
	/**
	 * 페이지-레이어를 생성하는 서비스 메소드 --> 비동기
	 * 작성일: 2021.02.08 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param message
	 * @return
	 */
	public Map<String, Object> createPageLayer(String room_Id, Map<String, Object> json) {
		// 있어야할 내용: 페이지-레이어 번호(스트링 값으로 줘야함)
		log.info("페이지 생성하는 소켓서비스 메소드 진입");
		
		drawingService.createPageLayer(room_Id, json);
		
		return json;
	}
	
	/**
	 * 픽셀 선물하기를 반영하는 메소드 (프론트로 이것을 전달하면 프론트는 데이터를 채팅창에 뿌린다)
	 * 작성일: 2021.02.08 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param message
	 * @return
	 */
	public Map<String, Object> presentPixel(Map<String, Object> json) {
		// 있어야할 내용: 보낸사람-받는사람-픽셀수
		// 전송은 이미 AJAX로 해서 DAO를 거치지 않아도 된다.
		return json;
	}
}
