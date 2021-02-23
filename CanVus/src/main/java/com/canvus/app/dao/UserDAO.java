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
	 * 로그인이나 유저 정보가 필요한 경우에 사용하는 dao메소드
	 * 최초작성일: 2021.01.01(?) / 수정일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param id
	 * @return user id in DB
	 */
	public UserVO getUserInfo(String id) {
		logger.info("UserDAO 유저정보 얻기 메소드 진입");
		
		UserVO dbData = null;
		
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			dbData = mapper.getUserInfo(id);
		} catch (Exception e) {
			logger.info("유저정보 얻기 sql오류");
		}
		
		return dbData;
	}
	
	/**
	 * 
	 * @param
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
			e.printStackTrace();
		}
		
		return check;
	}

	/**
	 * 유저 아이디로 유저 닉네임 셀렉하는 메소드(일단 막코딩 시간이 엄따)
	 * 작성일: 2021.02.21
	 * 작성자: 이한결
	 * @param user_id
	 * @return
	 */
	public String getUserNickname(String user_id) {
		String nickname = null;

		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			nickname = mapper.getUserNickname(user_id);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("유저 닉네임 셀렉 sql오류");
		}

		return nickname;
	}
}
