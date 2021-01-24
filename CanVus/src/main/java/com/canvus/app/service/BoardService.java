package com.canvus.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.dao.BoardDAO;
import com.canvus.app.dao.FeedDAO;
import com.canvus.app.dao.FollowDAO;
import com.canvus.app.dao.UserDAO;
import com.canvus.app.vo.FeedVO;
import com.canvus.app.vo.FollowingsVO;
import com.canvus.app.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BoardService {
	@Autowired
	private BoardDAO boardDAO;
	@Autowired
	private FollowDAO followDAO;
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private FeedDAO feedDAO;
	
	/**
	 * 가장 처음 보드를 불러오는 메소드
	 * 작성일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param id
	 * @return
	 */
	public Map<String, Object> loadBoard(String user_id) {
		int countPerPage = 12;
		int startRecord = 0;
		
		Map<String, Object> boardInfo = new HashMap<String, Object>();
		int followCount= followDAO.getFollowCount(user_id);
		int followerCount = followDAO.getFollowerCount(user_id);
		UserVO userInfo = userDAO.getUserInfo(user_id);
		List<FeedVO> feedBundle = feedDAO.getFeedBundle(user_id, startRecord, countPerPage);
		
		boardInfo.put("followCount", followCount);
		boardInfo.put("followerCount", followerCount);
		boardInfo.put("userInfo", userInfo);
		
		
		return null;
	}
}
