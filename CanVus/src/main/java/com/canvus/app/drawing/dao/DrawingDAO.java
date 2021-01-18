package com.canvus.app.drawing.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.canvus.app.drawing.mapper.DrawingRoomMapper;
import com.canvus.app.drawing.mapper.JoinListMapper;
import com.canvus.app.drawing.vo.DrawingRoomVO;
import com.canvus.app.drawing.vo.DrawingUserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class DrawingDAO {
	@Autowired
	private SqlSession session;
	
	/**
	 * 제작일: 2021.01.16
	 * @param roomId
	 * @return
	 */
	public DrawingRoomVO enterRoom(String roomId) {
		DrawingRoomVO dbData = null;
		try {
			DrawingRoomMapper mapper = session.getMapper(DrawingRoomMapper.class);
			dbData = mapper.enterRoom(roomId);
		} catch (Exception e) {
			log.info("enterRoom sql 오류");
		}
		
		return dbData;
	}
	
	/**
	 * 제작일: 2021.01.16
	 * @param roomInfo
	 * @param admin
	 * @return
	 */
	public boolean createRoom(DrawingRoomVO roomInfo, DrawingUserVO admin) {
		boolean check = false;
		
		try {
			DrawingRoomMapper dRMapper = session.getMapper(DrawingRoomMapper.class);
			JoinListMapper jLMapper = session.getMapper(JoinListMapper.class);
			
			check = dRMapper.createRoom(roomInfo);
			check = jLMapper.addUser(admin);
		} catch (Exception e) {
			log.info("방생성 sql 오류");
		}
		
		return check;
	}
	
	/**
	 * 제작일: 2021.01.16
	 * @param roomId
	 * @return
	 */
	public List<Map<String, String>> getUserList(String roomId) {
		List<Map<String, String>> userList = null;
		
		try {
			DrawingRoomMapper mapper = session.getMapper(DrawingRoomMapper.class);
			userList = mapper.getUserList(roomId);
		} catch (Exception e) {
			log.info("방 유저리스트를 불러오는 sql문 오류");
		}
		
		return userList;
	}

}
