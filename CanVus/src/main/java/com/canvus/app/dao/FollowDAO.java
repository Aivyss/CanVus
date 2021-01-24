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
	 * 팔로우 정보를 DB로부터 가져오는 메소드
	 * 작성일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param id
	 */
	public List<FollowingsVO> getFollow(String user_id) {
		List<FollowingsVO> followList = null;
		
		try {
			FollowingsMapper mapper = session.getMapper(FollowingsMapper.class);
			followList = mapper.getFollow(user_id);
		} catch (Exception e) {
			log.info("팔로우 정보 셀렉트 SQL 오류");
		}
		
		return followList;
	}

	public List<FollowingsVO> getFollower(String user_id) {
		List<FollowingsVO> followerList = null;
		
		try {
			FollowingsMapper mapper = session.getMapper(FollowingsMapper.class);
			followerList = mapper.getFollower(user_id);
		} catch (Exception e) {
			log.info("팔로우 정보 셀렉트 SQL 오류");
		}
		
		return followerList;
		
	}
	
	/**
	 * 팔로우한 인원수를 카운트하는 메소드
	 * @param id
	 * @return
	 */
	public int getFollowCount(String user_id) {
		int cnt = 0;
		
		try {
			FollowingsMapper mapper = session.getMapper(FollowingsMapper.class);
			cnt = mapper.getFollowCount(user_id);
		} catch (Exception e) {
			log.info("팔로우 인원수 카운트 sql 오류");
		}
		
		return cnt;
	}
	
	/**
	 * 팔로워 인원수를 카운트하는 메소드
	 * @param id
	 * @return
	 */
	public int getFollowerCount(String user_id) {
		int cnt = 0;
		
		try {
			FollowingsMapper mapper = session.getMapper(FollowingsMapper.class);
			cnt = mapper.getFollowerCount(user_id);
		} catch (Exception e) {
			log.info("팔로워 인원수 카운트 sql 오류");
		}
		
		return cnt;
	}

}
