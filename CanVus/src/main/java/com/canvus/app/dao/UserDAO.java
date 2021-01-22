package com.canvus.app.dao;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.canvus.app.dao.mapper.BookmarkMapper;
import com.canvus.app.dao.mapper.UserMapper;
import com.canvus.app.vo.BookmarkVO;
import com.canvus.app.vo.UserVO;

import jdk.internal.org.jline.utils.Log;

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
	
	/**
	 * 생성하려는 북마크를 db에 저장하는 메소드
	 * 작성일: 2021.01.22 / 완성일: / 검증일:
	 * 작성자: 이한결
	 * @param inputInfo
	 * @return
	 */
	@Transactional(rollbackFor = {Exception.class})
	public boolean makeFolder(BookmarkVO inputInfo) {
		logger.info("북마크 생성 dao 메소드 진입");

		boolean check = false;
		
		try {
			BookmarkMapper mapper = session.getMapper(BookmarkMapper.class);
			check = mapper.makeFolder(inputInfo);
			
		} catch (Exception e) {
			logger.info("폴더만들기 SQL 오류");
		}
		
		return check;
	}

	/**
	 * 북마크를 생성하기 전 이름 중복을 체크하는 메소드
	 * 작성일: 2021.01.22 / 완성일: / 버그검증:
	 * 작성자: 이한결
	 * @param inputInfo
	 * @return
	 */
	public BookmarkVO checkDoubleNameOfBookmark(BookmarkVO inputInfo) {
		logger.info("북마크 중복체크 dao 메소드 진입");
		BookmarkVO dbData = null;
		
		try {
			BookmarkMapper mapper = session.getMapper(BookmarkMapper.class);
			dbData = mapper.checkDoubleNameOfBookmark(inputInfo);
		} catch (Exception e) {
			logger.info("북마크 중복체크 SQL 오류");
		}
		
		return dbData;
	}

}
