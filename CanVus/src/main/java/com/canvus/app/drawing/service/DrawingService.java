package com.canvus.app.drawing.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.dao.FeedDAO;
import com.canvus.app.dao.TagDAO;
import com.canvus.app.drawing.dao.DrawingDAO;
import com.canvus.app.drawing.vo.DrawingRoomVO;
import com.canvus.app.drawing.vo.DrawingUserVO;
import com.canvus.app.drawing.vo.PageVO;
import com.canvus.app.util.Base64ToImgDecoder;
import com.canvus.app.util.Helper;
import com.canvus.app.vo.FeedDrawingsVO;
import com.canvus.app.vo.FeedVO;
import com.canvus.app.vo.TagsInFeedVO;

import lombok.extern.slf4j.Slf4j;

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
	 * 제작일: 2021.01.16
	 * 
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
	 * 
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
	 * 해당 방의 그림 정보를 가져오는 메소드 제작일: 2021.01.20 / 완성일: / 버그검증완료:
	 * 
	 * @param room_Id
	 * @return
	 */
	public List<PageVO> getPgs(String room_Id) {

		return drawingDAO.getPgs(room_Id);
	}

	/**
	 * 그려진 한 레이어를 저장하는 메소드 작성일 2021.01.21 / 완성일: / 버그검증일: 작성자: 이한결
	 * 
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

		if (password.equals(roomInfo.getPassword())) {
			
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
		String room_Id = (String) params.get("room_Id");

		// index 0번이 피드의 주인
		@SuppressWarnings("unchecked")
		List<String> drawers = (List<String>) params.get("drawers");
		// 피드의 텍스트
		String context = (String) params.get("context");
		// 그림내용
		@SuppressWarnings("unchecked")
		List<String> pages = (List<String>) params.get("pages");
		
		// TODO 값이 들어왔는지 체크 (나중에 지워야 함)
		log.info(room_Id);
		log.info(drawers.toString());
		log.info(context);
		log.info(pages.toString());

		// TODO DB에 피드 로우 생성
		boolean check = this.createFeedTableRow(room_Id, drawers, context);

		if (check) {
			// TODO 만든 피드정보에 그림을 삽입하도록 한다.
			check = this.createFeedDrawingsRows(room_Id, pages);
			
			if (check) {
				// TODO 만든 피드정보에 태그를 추출하여 삽입한다.
				TagsInFeedVO tif = Helper.tagParse(room_Id, context);
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
	public boolean createFeedTableRow(String room_Id, List<String> drawers, String context) {
		FeedVO feedVO = new FeedVO();

		feedVO.setFeed_id(room_Id);
		feedVO.setUser_id1(drawers.get(0));
		feedVO.setUser_id2(drawers.get(1));
		feedVO.setUser_id3(drawers.get(2));
		feedVO.setUser_id4(drawers.get(3));
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
			Base64ToImgDecoder.decoder(pages.get(i), "/userPicture", room_Id + "--divide--" + i, "png");

			// db에 저장하기 위해서 파일이름으로 값을 바꾼다.
			page_file[i] = room_Id + "--divide--" + i + ".png";
		}
		
		// TODO 데이터베이스로 정보를 넘기기 위해 DTO 객체 생성
		FeedDrawingsVO feedDrawings = new FeedDrawingsVO();
		feedDrawings.setFeed_id(room_Id);
		feedDrawings.setPage_file(page_file);
		
		// TODO 객체를 넘겨 데이터베이스에 삽입
		return feedDAO.createFeedDrawingsRows(feedDrawings);

	}
	
	/**
	 * 저장된 문자열로부터 해시태그를 파싱하여 데이터베이스에 저장하는 메소드.
	 * 기능을 분리하였다.
	 * 작성일: 2021.01.24 / 완성일: / 버그검증일
	 * 작성자: 이한결
	 * @param room_Id
	 * @param context
	 * @return
	 */
	private boolean tagParse(String room_Id, String context) {
		List<String> tagList = new ArrayList<String>();
		
		// TODO 해시태그 추출
		Pattern pattern = Pattern.compile("([#][a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣぁ-ゔァ-ヴー々〆〤一-龥]*)");
		Matcher matcher = pattern.matcher(context);
		while (matcher.find()) {
			System.out.println(matcher.group(1));
			
		    if(matcher.group(1) ==  null) {
		    	break;
		    } else {
		    	tagList.add(matcher.group(1));
		    }
		}
		
		// TODO 데이터베이스로 보내기 위해 VO 객체 생성
		String[] tag_name = new String[tagList.size()];
		for (int i=0; i<tagList.size(); i++) {
			tag_name[i] = tagList.get(i);
		}
		TagsInFeedVO tif = new TagsInFeedVO();
		tif.setTag_name(tag_name);
		tif.setFeed_id(room_Id);
		
		// TODO 데이터베이스에 등록
		return tagDAO.inputTags(tif);
	}

}
