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
import com.canvus.app.drawing.vo.PageVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
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
		DrawingRoomVO dbData = drawingDAO.enterRoom(drawingRoom.getRoom_Id());
		boolean check = false;
		
		if (dbData.getRoom_Id().equals(drawingRoom.getRoom_Id())) {
			if (dbData.getPassword().equals(drawingRoom.getPassword())) {
				check = true;
			}
		}
		
		return check;
	}
	/**
	 * 제작일: 2021.01.16 / 최종수정일: 2021.01.18
	 * @param roomInfo
	 * @param session 
	 * @return
	 */
	public DrawingRoomVO createRoom(DrawingRoomVO roomInfo, HttpSession session) {
		log.info("방만들기 service 시작");

		// TODO 방 아이디 생성
		UUID one = UUID.randomUUID();		
		log.info(one.toString());
		roomInfo.setRoom_Id(one.toString());
		roomInfo.setAdmin((String) session.getAttribute("userId"));
		
		// SQL 구문 성공여부 체크
		boolean check = drawingDAO.createRoom(roomInfo);
		
		if (!check) {
			roomInfo = null;
		}
		
		return roomInfo;
	}
	public List<DrawingUserVO> getUserList(String roomId) {
		log.info("방 유저리스트 반환 서비스");
		return drawingDAO.getUserList(roomId);
	}
	
	/**
	 * 해당 방의 그림 정보를 가져오는 메소드
	 * 제작일: 2021.01.20 / 완성일: / 버그검증완료:
	 * @param room_Id
	 * @return
	 */
	public List<PageVO> getPgs(String room_Id) {
		
		return drawingDAO.getPgs(room_Id);
	}
	
	/**
	 * 그려진 한 레이어를 저장하는 메소드
	 * 작성일 2021.01.21 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param page
	 * @return
	 */
	public boolean savePage(Map<String, Object> params) {
		PageVO page = new PageVO();
		page.setRoom_Id((String) params.get("room_id"));
		page.setPage_no((Integer) params.get("page_no"));
		page.setLayer_no((Integer) params.get("layer_no"));
		page.setStringify((String) params.get("stringify"));
		
		boolean check = drawingDAO.savePage(page);
		
		return false;
	}
	
	/**
	 * 아이디로 해당 방의 정보를 가져오는 메소드
	 * 작성일: 2021.01.22 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @return
	 */
	public DrawingRoomVO getRoomById(String room_Id) {
		// TODO Auto-generated method stub
		return drawingDAO.getRoomById(room_Id);
	}
	
	/**
	 * 해당 방의 유저의 수를 산출하는 메소드
	 * 작성일: 2021.01.22 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @return
	 */
	public int getUserCount(String room_Id) {
		
		return drawingDAO.getUserCount(room_Id);
	}
	
}
