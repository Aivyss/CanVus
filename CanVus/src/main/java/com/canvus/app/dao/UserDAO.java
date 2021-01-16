package com.canvus.app.dao;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.canvus.app.dao.mapper.UserMapper;
import com.canvus.app.vo.UserVO;

@Repository
public class UserDAO {
	@Autowired
	private SqlSession session;
	
	private static final Logger logger = LoggerFactory.getLogger(UserDAO.class);
	
	/**
	 * 
	 * @param id
	 * @return user id in DB
	 */
	public String login(String id) {
		logger.info("UserDAO 로그인 함수 진입");
		
		String dbId = null;
		
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			dbId = mapper.login(id);
		} catch (Exception e) {
			logger.info("SQL 로그인 오류");
		}
		
		return dbId;
	}
	
	/**
	 * 
	 * @param user info
	 * @return user info in DB
	 */
	public boolean signup(UserVO vo) {
		logger.info("UserDAO 회원가입 함수 진입");
		boolean check = false;
		
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			check = mapper.signup(vo);
		} catch (Exception e) {
			logger.info("SQL 회원가입 오류");
		}
		
		return check;
	}

}
