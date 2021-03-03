package com.canvus.app.drawing.service;

import java.util.*;

import javax.servlet.http.HttpSession;

import com.canvus.app.drawing.vo.FeedVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.canvus.app.dao.FeedDAO;
import com.canvus.app.dao.TagDAO;
import com.canvus.app.drawing.dao.DrawingDAO;
import com.canvus.app.drawing.vo.DrawingRoomVO;
import com.canvus.app.drawing.vo.DrawingUserVO;
import com.canvus.app.drawing.vo.PageVO;
import com.canvus.app.util.Base64ToImgDecoder;
import com.canvus.app.util.Helper;
import com.canvus.app.vo.CanVusVOFactory;
import com.canvus.app.vo.CanVusVOType;
import com.canvus.app.vo.FeedDrawingsVO;
import com.canvus.app.vo.TagsInFeedVO;
import com.canvus.app.vo.UserVO;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;

@Slf4j
@Service
public class DrawingService {
	@Autowired
	private DrawingDAO drawingDAO;
	@Autowired
	private FeedDAO feedDAO;
	@Autowired
	private TagDAO tagDAO;

	/**
	 * 제작일: 2021.01.16 / 최종수정일: 2021.01.18
	 * 
	 * @param roomInfo
	 * @param session
	 * @return
	 */
	public DrawingRoomVO createRoom(DrawingRoomVO roomInfo, HttpSession session) {
		log.info("방만들기 service 시작");

		// TODO 방 아이디 생성
		roomInfo.setRoom_Id(Helper.uniqueIdGenerator()); // 오라클 30자 초과하면 안돼..
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
	 * 그려진 한 레이어를 저장하는 메소드 작성일 2021.01.21 / 완성일: / 버그검증일: 작성자: 이한결
	 * @param params
	 * @return
	 */
	@Async("threadPoolTaskExecutor")
	public void createPageLayer(String room_Id, Map<String, Object> json) {
		PageVO page = CanVusVOFactory.newInstance(CanVusVOType.PageVO);
		Map<String, Object> message = (Map) json.get("message");
		// 페이지를 만들 당시 프론트 단에서는 페이지 넘버와 레이어 넘버를 주어야 한다.
		page.setRoom_Id(room_Id);
		page.setPage_no((Integer) message.get("page_no"));
		page.setLayer_no((Integer) message.get("layer_no"));
		page.setStringify("{\"version\":\"4.3.0\",\"objects\":[]}");

		drawingDAO.createPage(page);
	}

	/**
	 * 아이디로 해당 방의 정보를 가져오는 메소드 작성일: 2021.01.22 / 완성일: / 버그검증일: 작성자: 이한결
	 * 
	 * @param room_Id
	 * @return
	 */
	public DrawingRoomVO getRoomById(String room_Id) {
		// TODO Auto-generated method stub
		return drawingDAO.getRoomById(room_Id);
	}

	/**
	 * 해당 방의 유저의 수를 산출하는 메소드 작성일: 2021.01.22 / 완성일: / 버그검증일: 작성자: 이한결
	 * 
	 * @param room_Id
	 * @return
	 */
	public int getUserCount(String room_Id) {

		return drawingDAO.getUserCount(room_Id);
	}

	/**
	 * 방 비밀번호를 체크하기 위한 메소드 작성일: 2021.01.23 / 완성일: / 버그검증일: 작성자: 이한결
	 * 
	 * @param params
	 * @return
	 */
	public boolean passwordCheck(Map<String, String> params, HttpSession session) {
		String room_Id = params.get("room_Id");
		String password = params.get("pwWrttenByUser");
		boolean check = false;
		DrawingRoomVO roomInfo = drawingDAO.getRoomById(room_Id);

		if (roomInfo.getPassword().equals(password)) {
			// 비밀번호가 일치하여 세션에 방 비밀번호를 넣는 처리
			session.setAttribute("pwWrttenByUser", roomInfo.getPassword());
			check = true;
		}

		return check;
	}

	/**
	 * 방에서 그림을 그리기를 완성하고 feed로 변환하는 작업 작성 시작일: 2021.01.23 / 완성일: / 버그검증일: 작성자: 이한결
	 * 
	 * @param params
	 * @return
	 */
	public boolean makeFeed(Map<String, Object> params) {
		log.info("피드작성 서비스 메소드 진입");
		// 방번호
		String feed_id = (String) params.get("feed_id");
		List<String> drawers = (List<String>) params.get("drawers");
		drawers.add(0, (String) params.get("admin"));

		// 피드의 텍스트
		String context = (String) params.get("context");

		// 그림내용
		List<String> pages = (List<String>) params.get("pages");


		// TODO DB에 피드 로우 생성
		boolean check = this.createFeedTableRow(feed_id, drawers, context);

		if (check) {
			// TODO 만든 피드정보에 그림을 삽입하도록 한다.
			check = this.createFeedDrawingsRows(feed_id, pages);
			
			if (check) {
				// TODO 만든 피드정보에 태그를 추출하여 삽입한다.
				TagsInFeedVO tif = Helper.tagParse(feed_id, context);
				check = tagDAO.inputTags(tif);
			}
		}
		
		
		return check;
	}

	
	/**
	 * 피드 작성을 하는데 있어서 피드 테이블의 row를 추가하는 메소드. 기능을 분리하였다.
	 * 1차 테스트 완료
	 * 작성일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param drawers
	 * @param context
	 * @return
	 */
	public boolean createFeedTableRow(String feed_id, List<String> drawers, String context) {
		FeedVO feedVO = new FeedVO();

		log.info(feed_id);
		log.info(drawers.toString());
		log.info(context);
		int listSize = drawers.size();

		// VO에 값을 넣는 프로세스
		feedVO.setFeed_id(feed_id);
		feedVO.setUser_id1(drawers.get(0));
		if (listSize >= 2) {
			feedVO.setUser_id2(drawers.get(1));
		}
		if (listSize >= 3) {
			feedVO.setUser_id3(drawers.get(2));
		}
		if (listSize >= 4) {
			feedVO.setUser_id4(drawers.get(3));
		}
		feedVO.setContext(context);

		return feedDAO.createFeedTableRow(feedVO);
	}

	/**
	 * feeds 테이블에 추가된 row를 바탕으로 base24를 디코딩하여 resources 폴더에 저장하고
	 * 저장한 이름을 feeddrawings 테이블에 추가하는 메소드. 기능을 분리하였다.
	 * 작성일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param pages
	 * @return
	 */
	public boolean createFeedDrawingsRows(String room_Id, List<String> pages) {
		String[] page_file = new String[pages.size()];
		
		// TODO base64 디코딩, 저장된 파일이름 배열 생성
		for (int i = 0; i < pages.size(); i++) {
			// 디코딩 후 해당 위치에 파일을 저장하고
			Base64ToImgDecoder.decoder(pages.get(i), "/userPicture", room_Id + "--divide--" + (i+1), "png");

			// db에 저장하기 위해서 파일이름으로 값을 바꾼다.
			page_file[i] = room_Id + "--divide--" + (i+1) + ".png";
		}
		
		// TODO 데이터베이스로 정보를 넘기기 위해 DTO 객체 생성
		FeedDrawingsVO feedDrawings = CanVusVOFactory.newInstance(CanVusVOType.FeedDrawingsVO);
		feedDrawings.setFeed_id(room_Id);
		feedDrawings.setPage_file(page_file);
		
		// TODO 객체를 넘겨 데이터베이스에 삽입
		return feedDAO.createFeedDrawingsRows(feedDrawings);

	}
	
	/**
	 * 각 레이어의 변경 사항을 DB에 저장하는 메소드
	 * 작성일: 2021.02.03 / 완료일: / 버그검증일:
	 * 작성자: 이한결
	 * @param json
	 * @param room_Id
	 * @return
	 */
	@Async("threadPoolTaskExecutor")
	public void updatePage(Map<String, Object> json, String room_Id) {
		log.info("페이지-레이어 업데이트");
		Map<String, Object> message = (Map) json.get("message");
		PageVO page = CanVusVOFactory.newInstance(CanVusVOType.PageVO);
		
		page.setRoom_Id(room_Id);
		page.setPage_no((Integer) message.get("page_no"));
		page.setLayer_no((Integer) message.get("layer_no"));
		page.setStringify((String) message.get("stringify"));

		drawingDAO.updatePage(page);
	}

	/**
	 * 현재 해당 방에 얼마나 유저가 있는지 산출하는 메소드
	 * 작성일: 2021.02.07 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @return
	 */
	public List<DrawingUserVO> getRoomUserList(String room_Id) {
		
		return drawingDAO.getRoomUserList(room_Id);
	}

	/**
	 * 비밀번호 검증에 성공하여 유저를 방리스트에 넣는 메소드.
	 * @param room_Id
	 * @param session
	 * @param user_type
	 * @return
	 */
	public boolean enterRoom(String room_Id, HttpSession session, String user_type) {
		log.info("유저를 방에 입장시키는 메소드");
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		DrawingUserVO newRoomUser = CanVusVOFactory.newInstance(CanVusVOType.DrawingUserVO);
		
		newRoomUser.setRoom_Id(room_Id);
		newRoomUser.setUser_id(userVO.getUser_id());
		newRoomUser.setRoom_Id(room_Id);
		newRoomUser.setUser_type(user_type);
		
		boolean isEntered = drawingDAO.enterRoom(newRoomUser);
		
		return isEntered;
	}

	/**
	 * 퇴장된 유저를 리스트 테이블에서 삭제하는 메소드
	 * 작성일: 2021.02.08 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param userId
	 * @return
	 */
	public void quitRoom(String room_Id, String userId) {
		log.info("해당 유저를 퇴장시키는 서비스 메소드 진입");
		
		DrawingUserVO quitedUser = CanVusVOFactory.newInstance(CanVusVOType.DrawingUserVO);
		quitedUser.setRoom_Id(room_Id);
		quitedUser.setUser_id(userId);
		
		log.info("vo에 값넣는지 확인 : {}", quitedUser.toString());
		
		drawingDAO.quitRoom(quitedUser);
	}
	/**
	 * 방입장을 유저의 상태에 따라 분리하는 서비스 메소드
	 * 작성일: 2021.02.08 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_Id
	 * @param session
	 * @param model
	 * @return
	 */
	public String enterSpliter(String room_Id, HttpSession session, Model model) {
		log.info("방입장 스플리터 서비스 메소드 진입");
		// TODO 이동해야하는 URL
		String url = null;
		// TODO room_Id로 방정보를 받아옴
		DrawingRoomVO roomInfo = getRoomById(room_Id);
		// TODO room_Id로 현재 방인원수를 산출함
		int userCount = getUserCount(room_Id);
		// TODO 방에 입장한 유저 리스트 산출
		List<DrawingUserVO> userList = getRoomUserList(room_Id);
		// TODO 입장하려는 유저의 아이디
		String userId = (String) session.getAttribute("userId");

		// TODO 해당 유저가 방에 있는지 체크한다.
		// 있을 시 방에 추가하는 행위는 하지 않아도 되기 때문.
		boolean isMember = false;
		for (DrawingUserVO user : userList) {
			if (userId.equals(user.getUser_id())) {
				isMember = true;
				break;
			}
		}

		// TODO 이미 멤버인지 아닌지 확인
		if (isMember) {
			// TODO 기존 방 멤버이다. 기존 방 멤버는 하나의 창만 들어갈 수 있다.
			url = "redirect:/";
		} else {
			model.addAttribute("room_Id", room_Id);
			model.addAttribute("adminId", roomInfo.getAdmin());
			// 기존 방 멤버가 아니다.
			if (roomInfo.getUser_no() > userCount) { // TODO 방인원수가 초과했는지 확인
				// TODO 비밀번호가 필요한지 확인
				if (roomInfo.getPassword() == null) {
					if (userId.equals(roomInfo.getAdmin())) {
						enterRoom(room_Id, session, "ADMIN");
					} else {
						enterRoom(room_Id, session, "VISITOR");
					}

					// 방 비번이 필요 없으니까 통일한다.
					model.addAttribute("pwWrttenByUser", "None");
					model.addAttribute("dbPassword", "None");
					url = "drawing/room";
				} else {
					// TODO 비밀번호 검증

					Map<String, String> params = new HashMap<String, String>();
					params.put("pwWrttenByUser", (String) session.getAttribute("pwWrttenByUser"));
					params.put("room_Id", room_Id);
					boolean isCorrect = passwordCheck(params, session);

					if (userId.equals(roomInfo.getAdmin())) {
						enterRoom(room_Id, session, "ADMIN");

						// 어드민은 비밀번호 검증이 필요 없다.
						model.addAttribute("pwWrttenByUser", "None");
						model.addAttribute("dbPassword", "None");
					} else if (isCorrect) {
						enterRoom(room_Id, session, "VISITOR");

						// TODO 해당 방 아이디와 입력한 비밀번호, db상 방비밀번호를 모델에 넣는다.
						model.addAttribute("pwWrttenByUser", (String) session.getAttribute("pwWrttenByUser")); // 유저가 입력한 비번
						model.addAttribute("dbPassword", roomInfo.getPassword()); // 방 비번
					} else {
						//비밀번호가 틀렸다.
						session.removeAttribute("pwWrttenByUser");
						model.addAttribute("dbPassword", roomInfo.getPassword());
					}

					url = "drawing/room";
				}
			} else {
				// 방인원수를 초과했다. 입장불가.
				url = "redirect:/";
			}
		}

		return url;
	}

	/**
	 * 방에 입장할 때 필요한 레이어 정보를 모두 가져온다.
	 * 작성일: 2021.02.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param room_id
	 * @return
	 */
	public List<PageVO> getAllLayers(String room_Id) {
		log.info("레이어 정보 가져오기 서비스 메소드 진입");

		return drawingDAO.getAllLayers(room_Id);
	}

	/**
	 * 레이어를 지우는 서비스 메소드
	 * 작성일: 2021.02.13 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param json
	 * @return
	 */
	@Async("threadPoolTaskExecutor")
	public void deletePageLayer(String room_Id, Map<String, Object> json) {
		log.info("레이어를 지우는 서비스 메소드 진입");
		Map<String, Object> message = (Map) json.get("message");

		PageVO page = CanVusVOFactory.newInstance(CanVusVOType.PageVO);
		page.setRoom_Id(room_Id);
		page.setPage_no((Integer) message.get("page_no"));
		page.setLayer_no((Integer) message.get("layer_no"));

		drawingDAO.deletePageLayer(page);
	}

	/**
	 * 그리기 권한을 부여하는 메소드로 DB에 권한을 재설정한다.
	 * 작성일: 2021.02.15 / 완성일: / 버그검증일:"
	 * 작성자: 이한결
	 * @param room_id
	 * @param json
	 * @return
	 */
	@Async("threadPoolTaskExecutor")
	public void addAuthoity(String room_Id, Map<String, Object> json) {
    	log.info("권한부여 드로잉 서비스 메소드 진입");
    	DrawingUserVO targetUser = new DrawingUserVO();
    	Map<String, Object> message = (Map) json.get("message");
    	targetUser.setRoom_Id(room_Id);
    	targetUser.setUser_id((String) message.get("targetId"));
    	targetUser.setUser_type("DRAWER");
    	log.info(targetUser.toString());

    	drawingDAO.addAuthority(targetUser);
    }

	/**
	 * 10분 간격으로 1번 페이지를 저장하는 메소드 썸네일에 쓸 용도로 만들어진 메소드
	 * 따로 데이터베이스에는 저장하지 않는다.
	 * 작성일: 2021.02.22
	 * 작성자: 이한결
	 * @param params
	 */
    public void saveThumbnail(Map<String, Object> params) {
		log.info("썸네일 전용 1page 저장 서비스 메소드 진입");
		String png = (String) params.get("encodedStr");
		String room_Id = (String) params.get("room_Id");
		Base64ToImgDecoder.decoder(png, "/roomThumbnail", room_Id + "--Thumbnail--", "png");
    }

	/**
	 * 피드를 작성하여 모든 유저를 나가게 하고 데이터베이스 상에서 방을 삭제하는 메소드
	 * 작성일: 2021.02.22
	 * 작성자: 이한결
	 * @param room_Id
	 * @param json
	 * @return
	 */
	public void closeRoom(String room_Id) {
		log.info("방폭파 드로잉 서비스 메소드 진입");
		drawingDAO.closeRoom(room_Id);
	}
}
