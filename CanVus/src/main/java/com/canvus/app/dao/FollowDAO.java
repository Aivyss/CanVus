package com.canvus.app.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.canvus.app.dao.mapper.FollowingsMapper;
import com.canvus.app.vo.FollowingsVO;
import com.canvus.app.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class FollowDAO {
	@Autowired
	SqlSession session;
	
	/**
	 * BOARD의 팔로우, 팔로워 정보를 DB로부터 가져오는 메소드
	 * 작성일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param id
	 */
	public Map<String, UserVO> getFollowFolloer(String id) {
		Map<String, UserVO> followList = new HashMap<String, UserVO>();
		
		try {
			FollowingsMapper mapper = session.getMapper(FollowingsMapper.class);
			List<FollowingsVO> follow = mapper.getFollow(id);
		} catch (Exception e) {
			log.info("팔로잉 팔로워 정보 셀렉트 SQL 오류");
		}
		
		return null;
	}

}
