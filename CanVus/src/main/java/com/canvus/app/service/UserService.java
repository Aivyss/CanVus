package com.canvus.app.service;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.dao.UserDAO;
import com.canvus.app.vo.BookmarkVO;
import com.canvus.app.vo.UserVO;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

@Service
public class UserService {
	private final String CLIENT_ID = "1073968802049-evh62jql0f6gblp8din0t6rqv0sobg17.apps.googleusercontent.com";
	private static final Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private UserDAO userDAO;
	
	/**
	 * login business logic
	 * @param idToken
	 * @return user id in DB
	 */
	public String login(String idToken) {
		logger.info("로그인 서비스 진입");
		
		Payload payload = loginSignuplogic(idToken);
		
		return userDAO.login(payload.getSubject());
	}
	
	public UserVO signup(UserVO vo) {
		logger.info("회원가입 서비스 진입");
		
		UserVO output = null;
		Payload payload = loginSignuplogic(vo.getIdToken());
		
		// 정보를 payload로부터 추가, 닉네임은 프론트로부터 받아왔다.
		vo.setEmail(payload.getEmail());
		vo.setFamily_name((String) payload.get("family_name"));
		vo.setGiven_name((String) payload.get("given_name"));
		vo.setProfile_photo((String) payload.get("picture"));
		vo.setUser_id((String) payload.getSubject());
		
		boolean check = userDAO.signup(vo);
		
		if (check) {
			output = vo;
		}
		
		return output;
	}
	
	/**
	 * 구글 Oath 를 이용해 받은 토큰을 파싱하는 메소드
	 * 작성일: 2021.01 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param idToken
	 * @return
	 */
	public Payload loginSignuplogic(String idToken) {
		JacksonFactory jsonFactory = JacksonFactory.getDefaultInstance();
		HttpTransport transport = null;
		GoogleIdToken token = null;
		UserVO vo = new UserVO();
		
		try {
			transport = GoogleNetHttpTransport.newTrustedTransport();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
				.setAudience(Collections.singletonList(CLIENT_ID)).build();
		
		try {
			token = verifier.verify(idToken);
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return token.getPayload();
	}

	/**
	 * 폴더를 생성하기 위한 서비스 메소드
	 * 작성일: 2021.01.22 / 완성일: / 버그검증일:
	 * 작성자: 이한결
	 * @param session
	 * @param inputInfo
	 * @return
	 */
	public BookmarkVO makeFolder(HttpSession session, BookmarkVO inputInfo) {
		logger.info("북마크 생성 service 메소드 진입");
		
		// TODO 아이디를 inputInfo에 추가.
		String user_id = (String) session.getAttribute("userId");
		inputInfo.setUser_id(user_id);
		inputInfo.setFolder_name(inputInfo.getFolder_name().trim()); // 문자열 좌우공백 제거
		
		// TODO 값이 제대로 들어갔는지 체크. 나중에 지워도 됨
		logger.info(inputInfo.getFolder_name());
		logger.info(inputInfo.getUser_id());
		
		// TODO 북마크 이름 중복체크
		BookmarkVO dbData = userDAO.checkDoubleNameOfBookmark(inputInfo);
		
		if (dbData != null) { // 중복된 이름이 있는 경우
			dbData = null;
		} else {
			boolean check = userDAO.makeFolder(inputInfo);
			
			if (check) { // 생성이 완료됐으면 다시 더블첵 메소드를 활용해서 해당 북마크 정보를 불러옴.
				dbData = userDAO.checkDoubleNameOfBookmark(inputInfo);
			}
		}
		
		return dbData;
	}
	
	/**
	 * 북마크 폴더를 제거하는 서비스 메소드
	 * 작성일: 2021.01.22 / 완료일: / 버그검증일:
	 * 작성자: 이한결
	 * @param inputInfo
	 * @param session
	 * @return
	 */
	public boolean deleteFolder(Map<String, Object> params) {
		logger.info("북마크 제거 서비스 메소드 진입");
		
		// TODO 세션의 아이디 정보를 inputInfo에 넣는 과정
		
		return userDAO.deleteFolder((Integer) params.get("folder_id"));
	}
}