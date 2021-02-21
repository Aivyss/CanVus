package com.canvus.app.dao;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.canvus.app.dao.mapper.BookmarkMapper;
import com.canvus.app.dao.mapper.TransactionPixelMapper;
import com.canvus.app.dao.mapper.UserMapper;
import com.canvus.app.vo.BookmarkVO;
import com.canvus.app.vo.CanVusVOFactory;
import com.canvus.app.vo.CanVusVOType;
import com.canvus.app.vo.TransactionPixelVO;
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
	/**
	 * db에 있는 북마크 정보를 제거하는 메소드
	 * 작성일: 2021.01.22 / 완성일: / 버그검증:
	 * 작성자: 이한결
	 * @param 
	 * @return
	 */
	public boolean deleteFolder(int folder_id) {
		logger.info("북마크 폴더 제거 dao 메소드 진입");
		boolean check = false;
		
		try {
			BookmarkMapper mapper = session.getMapper(BookmarkMapper.class);
			check = mapper.deleteFolder(folder_id);
		} catch (Exception e) {
			logger.info("북마크 제거 SQL오류");
		}
		
		return check;
	}

	/**
	 * 픽셀을 선물하는 메소드
	 * 작성일: 2021.02.08 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param transPx
	 * @return
	 */
	@Transactional(rollbackFor = {Exception.class})
	public boolean presentPixel(TransactionPixelVO transPx) {
		boolean check = false;
		UserVO sender = CanVusVOFactory.newInstance(CanVusVOType.UserVO);
		UserVO receiver = CanVusVOFactory.newInstance(CanVusVOType.UserVO);
		sender.setUser_id(transPx.getSender());
		sender.setPixels(transPx.getPixels_amount());
		receiver.setUser_id(transPx.getReceiver());
		receiver.setPixels(transPx.getPixels_amount());
		
		try {
			TransactionPixelMapper transPxMapper = session.getMapper(TransactionPixelMapper.class);
			UserMapper userMapper = session.getMapper(UserMapper.class);
			userMapper.withdrawPixel(sender);
			userMapper.depositPixel(receiver);
			check = transPxMapper.presentPixel(transPx);
		} catch (Exception e) {
			logger.info("픽셀 선물 sql오류");
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
