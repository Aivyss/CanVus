package com.canvus.app.service;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.dao.UserDAO;
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
	private UserDAO dao;
	
	/**
	 * login business logic
	 * @param idToken
	 * @return user id in DB
	 */
	public String login(String idToken) {
		logger.info("로그인 서비스 진입");
		
		Payload payload = loginSignuplogic(idToken);
		
		return dao.login(payload.getSubject());
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
		vo.setUser_id(payload.getSubject());
		
		boolean check = dao.signup(vo);
		
		if (check) {
			output = vo;
		}
		
		return output;
	}
	
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
	
}
