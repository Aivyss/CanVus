package com.canvus.app.dao;

import com.canvus.app.dao.mapper.UserMapper;
import com.canvus.app.vo.UserVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Slf4j
@Repository
public class UserDAO {
	@Autowired
	private SqlSession session;

	/**
	 * 로그인이나 유저 정보가 필요한 경우에 사용하는 dao메소드
	 * 최초작성일: 2021.01.01(?) / 수정일: 2021.01.23 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param id
	 * @return user id in DB
	 */
	public UserVO getUserInfo(String id) {
		log.info("UserDAO 유저정보 얻기 메소드 진입");
		
		UserVO dbData = null;
		
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			dbData = mapper.getUserInfo(id);
		} catch (Exception e) {
			log.info("유저정보 얻기 sql오류");
		}
		
		return dbData;
	}
	
	/**
	 * 
	 * @param
	 * @return user info in DB
	 */
	public boolean signup(UserVO vo) {
		log.info("UserDAO 회원가입 함수 진입");
		boolean check = false;
		
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			check = mapper.signup(vo);
		} catch (Exception e) {
			log.info("SQL 회원가입 오류");
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
			log.info("유저 닉네임 셀렉 sql오류");
		}

		return nickname;
	}

	/**
	 * 닉네임 중복검사 서비스 메소드
	 * 20210227
	 * 이한결
	 * @param nickname
	 * @return boolean
	 */
    public boolean checkDuplicateNickname(String nickname) {
    	boolean check = true;

    	try {
    		int cnt = 0;
    		UserMapper mapper = session.getMapper(UserMapper.class);
    		cnt = mapper.checkDuplicateNickname(nickname);

    		if(cnt == 0) {
    			check = false;
			}
		} catch (Exception e) {
    		e.printStackTrace();
    		log.info("Duplicate Check SQL error");
		}

    	return check;
    }

	/**
	 * 프로필 파일 변경 DB반영
	 * 20210306
	 * 이한결
	 * @param userVO
	 */
	public void updateProfile(UserVO userVO) {
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			mapper.updateProfile(userVO);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("프로필 파일 변경 sql 오류");
		}
	}

	/**
	 * 자기소개 수정 db반영
	 * 20210306
	 * 이한결
	 * @param userVO
	 */
	public void updateIntro(UserVO userVO) {
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			mapper.updateIntro(userVO);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("자기소개 수정 sql 오류");
		}
	}
}
