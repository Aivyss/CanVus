package com.canvus.app.socket.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.drawing.dao.DrawingDAO;
import com.canvus.app.drawing.vo.DrawingUserVO;
import com.canvus.app.socket.vo.MessageVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class StompService {
	@Autowired
	private DrawingDAO drawingDAO;
	/**
	 * 해당 방의 유저리스트를 반환하는 메소드 (미완)
	 * 작성일: 2021.02.06 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @return
	 */
	public MessageVO getUserList(String room_Id) {
		List<DrawingUserVO> userList = drawingDAO.getUserList(room_Id);
		Map<String, Object> json = new HashMap<String, Object>();
		MessageVO message = new MessageVO();
		
		message.setRoom_Id(room_Id);
		json.put("userList", userList);
		message.setMessage(json);
		
		return message;
	}
	
}
