package com.canvus.app.drawing.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.canvus.app.drawing.mapper.DrawingRoomMapper;
import com.canvus.app.drawing.mapper.JoinListMapper;
import com.canvus.app.drawing.mapper.PageLayerMapper;
import com.canvus.app.drawing.vo.DrawingRoomVO;
import com.canvus.app.drawing.vo.DrawingUserVO;
import com.canvus.app.drawing.vo.PageVO;

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
	@Transactional(rollbackFor = {Exception.class})
	public boolean createRoom(DrawingRoomVO roomInfo, DrawingUserVO admin) {
		boolean check1 = false;
		boolean check2 = false;
		
		try {
			DrawingRoomMapper dRMapper = session.getMapper(DrawingRoomMapper.class);
			JoinListMapper jLMapper = session.getMapper(JoinListMapper.class);
			
			check1 = dRMapper.createRoom(roomInfo);
			check2 = jLMapper.addUser(admin);
		} catch (Exception e) {
			log.info("방생성 sql 오류");
			System.out.println(check1);
			System.out.println(check2);
		}
		
		return check1 && check2;
	}
	
	/**
	 * 제작일: 2021.01.16
	 * @param roomId
	 * @return
	 */
	public List<DrawingUserVO> getUserList(String roomId) {
		log.info("방 유저리스트 반환 dao");

		List<DrawingUserVO> userList = null;
		
		try {
			JoinListMapper mapper = session.getMapper(JoinListMapper.class);
			userList = mapper.getUserList(roomId);
		} catch (Exception e) {
			log.info("방 유저리스트를 불러오는 sql문 오류");
		}
		
		log.info(userList.toString());
		return userList;
	}
	
	/**
	 * 해당 방의 그림 정보를 가져오는 메소드
	 * 제작일: 2021.01.20 / 완성일: / 버그검증완료:
	 * @param room_Id
	 * @return
	 */
	public List<PageVO> getPgs(String room_Id) {
		List<PageVO> dbData = null;
		
		try {
			PageLayerMapper mapper = session.getMapper(PageLayerMapper.class);
			dbData = mapper.getPgs(room_Id);
		} catch (Exception e) {
			log.info("getPgs SQL오류");
		}
		
		return dbData;
	}
	
	/**
	 * 그려진 한 레이어를 데이터베이스에 저장하는 메소드
	 * 제작일: 2021.01.21 / 완성일: / 버그검증완료:
	 * @param page
	 * @return
	 */
	public boolean savePage(PageVO page) {
		boolean check = false;
		
		try {
			PageLayerMapper mapper = session.getMapper(PageLayerMapper.class);
			check = mapper.savePage(page);
		} catch (Exception e) {
			log.info("레이어 저장 sql오류");
		}
		
		return check;
	}

	public DrawingRoomVO passwordCheck(DrawingRoomVO roomInfo) {
		// TODO Auto-generated method stub
		return null;
	}

	public DrawingRoomVO getRoomById(String room_Id) {
		// TODO Auto-generated method stub
		return null;
	}

}
