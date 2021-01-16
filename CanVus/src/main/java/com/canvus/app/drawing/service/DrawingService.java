package com.canvus.app.drawing.service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.drawing.dao.DrawingDAO;
import com.canvus.app.drawing.vo.DrawingRoomVO;
import com.canvus.app.drawing.vo.DrawingUserVO;
import com.canvus.app.drawing.vo.UserType;

@Service
public class DrawingService {
	@Autowired
	private DrawingDAO drawingDAO;
	/**
	 * 제작일: 2021.01.16
	 * @param drawingRoom
	 * @return
	 */
	public boolean enterRoom(DrawingRoomVO drawingRoom) {
		DrawingRoomVO dbData = drawingDAO.enterRoom(drawingRoom.getRoomId());
		boolean check = false;
		
		if (dbData.getRoomId().equals(drawingRoom.getRoomId())) {
			if (dbData.getPassword().equals(drawingRoom.getPassword())) {
				check = true;
			}
		}
		
		return check;
	}
	/**
	 * 제작일: 2021.01.16
	 * @param roomInfo
	 * @param session 
	 * @return
	 */
	public DrawingRoomVO createRoom(DrawingRoomVO roomInfo, HttpSession session) {
		UUID one = UUID.randomUUID();
		
		DrawingUserVO admin = new DrawingUserVO();
		admin.setUser_id(Integer.parseInt((String)session.getAttribute("loginId")));
		admin.setUser_type(UserType.ADMIN.name());
		
		roomInfo.setRoomId(one.toString());
		roomInfo.setUser_no(1);
		
		boolean check = drawingDAO.createRoom(roomInfo, admin);
		
		if (!check) {
			roomInfo = null;
		}
		
		return roomInfo;
	}
	public List<Map<String, String>> getUserList(String roomId) {
		
		return drawingDAO.getUserList(roomId);
	}
	
}
