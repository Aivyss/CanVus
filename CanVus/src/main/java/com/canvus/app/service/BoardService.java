package com.canvus.app.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.dao.BoardDAO;
import com.canvus.app.dao.FollowDAO;
import com.canvus.app.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BoardService {
	@Autowired
	private BoardDAO boardDAO;
	@Autowired
	private FollowDAO followDAO;
	
	/**
	 * 보드를 불러오는 메소드
	 * 작성일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param id
	 * @return
	 */
	public Map<String, Object> board(String id) {
		Map<String, UserVO> followList = followDAO.getFollowFolloer(id);
		
		return null;
	}
}
