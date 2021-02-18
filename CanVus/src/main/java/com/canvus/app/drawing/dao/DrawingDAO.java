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
	 * @param newRoomUser
	 * @return
	 */
	public boolean enterRoom(DrawingUserVO newRoomUser) {
		boolean check = false;
		
		try {
			JoinListMapper mapper = session.getMapper(JoinListMapper.class);
			check = mapper.enterRoom(newRoomUser);
		} catch (Exception e) {
			log.info("enterRoom sql 오류");
			e.printStackTrace();
		}
		
		return check;
	}
	
	/**
	 * 제작일: 2021.01.16
	 * @param roomInfo
	 * @param admin
	 * @return
	 */
	public boolean createRoom(DrawingRoomVO roomInfo) {
		boolean check = false;
		
		try {
			DrawingRoomMapper dRMapper = session.getMapper(DrawingRoomMapper.class);
			check = dRMapper.createRoom(roomInfo);
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
	 * 그려진 한 레이어를 데이터베이스에 저장하는 메소드
	 * 제작일: 2021.01.21 / 완성일: / 버그검증완료:
	 * @param page
	 * @return
	 */
	public boolean createPage(PageVO page) {
		log.info("페이지를 생성하는 dao 메소드 진입");
		boolean check = false;
		
		try {
			PageLayerMapper mapper = session.getMapper(PageLayerMapper.class);
			check = mapper.createPage(page);
		} catch (Exception e) {
			log.info("레이어 생성 sql오류");
			e.printStackTrace();
		}
		
		return check;
	}
	
	/**
	 * 방 아이디로 방의 정보를 가져오는 메소드
	 * 작성일: 2021.01.22 / 완성일: / 버그 검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @return
	 */
	public DrawingRoomVO getRoomById(String room_Id) {
		DrawingRoomVO dbData = null;
		
		try {
			DrawingRoomMapper mapper = session.getMapper(DrawingRoomMapper.class);
			dbData = mapper.getRoomById(room_Id);
		} catch (Exception e) {
			log.info("아이디로 방정보 조회 SQL오류");
		}
		
		return dbData;
	}

	/**
	 * room_Id에 해당하는 그리기 방의 인원수를 산출하는 메소드
	 * 작성일: 2021.01.22 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @return
	 */
	public int getUserCount(String room_Id) {
		int count = 0;
		
		try {
			JoinListMapper mapper = session.getMapper(JoinListMapper.class);
			count = mapper.getUserCount(room_Id);
		} catch (Exception e) {
			log.info("방 인원수 산출 SQL 오류");
		}
		
		return count;
	}
	
	/**
	 * 페이지의 변동사항을 데이터베이스에 업데이트하는 메소드
	 * 작성일: 2021.02.03 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param page
	 * @return
	 */
	public boolean updatePage(PageVO page) {
		log.info("페이지 업데이트 dao 메소드");
		boolean check = false;
		
		try {
			PageLayerMapper mapper = session.getMapper(PageLayerMapper.class);
			check = mapper.updatePage(page);
		} catch (Exception e) {
			log.info("페이지 업데이트 sql오류");
			e.printStackTrace();
		}
		
		return check;
	}
	
	/**
	 * room_Id에 일치하는 모든 페이지 정보를 가져온다
	 * 작성일: 2021.02.04 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @return
	 */
	public List<PageVO> selectAllPages(String room_Id) {
		log.info("모든 페이지 정보를 가져오는 dao메소드");
		List<PageVO> pageList = null;
		
		try {
			PageLayerMapper mapper = session.getMapper(PageLayerMapper.class);
			pageList = mapper.selectAllPages(room_Id);
		} catch (Exception e) {
			log.info("모든 페이지의 정보를 가져오는 sql 오류");
			e.printStackTrace();
		}
		
		return pageList;
	}

	public List<DrawingUserVO> connectUser(String room_Id) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<DrawingUserVO> disconnectUser(String room_Id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 아이디에 해당하는 룸에 접속한 인원수를 산출하는 메소드
	 * 작성일: 2021.02.07 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @return
	 */
	public List<DrawingUserVO> getRoomUserList(String room_Id) {
		List<DrawingUserVO> userList = null;
		
		try {
			JoinListMapper mapper = session.getMapper(JoinListMapper.class);
			userList = mapper.getRoomUserList(room_Id);
		} catch (Exception e) {
			log.info("방 유저 산출 sql 오류");
			e.printStackTrace();
		}
		
		return userList;
	}

	/**
	 * 퇴장한 유저를 방 유저리스트 테이블로부터 삭제하는 메소드
	 * 작성일: 2021.02.08 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param quitedUser
	 * @return
	 */
	public boolean quitRoom(DrawingUserVO quitedUser) {
		boolean check = false;
		log.info("방퇴장 sql 처리과정에 들어오는지 확인");
		
		try {
			JoinListMapper mapper = session.getMapper(JoinListMapper.class);
			check = mapper.quitRoom(quitedUser);
		} catch (Exception e) {
			log.info("퇴장처리 sql오류");
			e.printStackTrace();
		}
		
		return check;
	}

	/**
	 * 레이어를 삭제하는 메소드
	 * 작성일:2021.02.13 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param page
	 * @return
	 */
    public boolean deletePageLayer(PageVO page) {
    	log.info("레이어삭제 dao 메소드 진입");
    	boolean check = false;

    	try {
    		PageLayerMapper mapper = session.getMapper(PageLayerMapper.class);
    		check = mapper.deletePageLayer(page);
		} catch (Exception e) {
    		log.info("레이어 삭제 sql오류");
    		e.printStackTrace();
		}

    	return check;
    }

	/**
	 * 작성일: 2021.02.13 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_id
	 * @return
	 *
	 */
	public List<PageVO> getAllLayers(String room_Id) {
		List<PageVO> layers = null;
		PageVO roomInfo = new PageVO();
		roomInfo.setRoom_Id(room_Id);
		try {
			PageLayerMapper mapper = session.getMapper(PageLayerMapper.class);
			layers = mapper.getAllLayers(roomInfo);
		} catch (Exception e) {
			log.info("전체 레이어 불러오기 sql오류");
			e.printStackTrace();
		}

		return layers;
    }

	/**
	 * DB에 유저 권한 변경을 수행하는 메소드
	 * 작성일: 2021.02.15 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param targetUser
	 * @return
	 */
	public boolean addAuthority(DrawingUserVO targetUser) {
		log.info("권한부여 drawing dao 메소드 진입");
		boolean check = false;

		try {
			JoinListMapper mapper = session.getMapper(JoinListMapper.class);
			check = mapper.addAuthority(targetUser);
		} catch (Exception e) {
			log.info("권한정보 수정 sql 오류");

			e.printStackTrace();
		}

		return check;
	}
}