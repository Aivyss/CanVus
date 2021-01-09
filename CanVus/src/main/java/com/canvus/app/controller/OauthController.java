package com.canvus.app.controller;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.canvus.app.helper.consants.SocialLoginType;
import com.canvus.app.service.social.OauthService;
import com.google.api.client.auth.openidconnect.IdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.LowLevelHttpRequest;
import com.google.api.client.json.jackson2.JacksonFactory;

import lombok.RequiredArgsConstructor;

@RestController
@CrossOrigin
@RequiredArgsConstructor
@RequestMapping(value="/auth")
public class OauthController {
	// 로거객체
	private static final Logger logger = LoggerFactory.getLogger(OauthController.class);
	
	@Autowired
	private final OauthService oauthService;
	
	@GetMapping(value="/{socialLoginType}")
	public void socialLoginType(@PathVariable(name="socialLoginType") SocialLoginType socialLoginType) {
		logger.info("[로그] 사용자로부터 SNS 로그인 요청을 받음 분류:{}", socialLoginType);
		
		oauthService.request(socialLoginType);
	}
	
	@GetMapping(value="/{socialLoginType}/callback")
	public String callback(
			@PathVariable(name="socialLoginType") SocialLoginType socialLoginType,
			@RequestParam(name = "code") String code) {
		HttpTransport transport = null;
		GoogleIdToken token = null;
		
		try {
			transport = GoogleNetHttpTransport.newTrustedTransport();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // (1)
		
		JacksonFactory jsonFactory = JacksonFactory.getDefaultInstance(); // (2)


		logger.info("[로그] 소셜 로그인 API서버로부터 받은 code :{}", code);
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
				.setAudience(Collections.singletonList("1073968802049-evh62jql0f6gblp8din0t6rqv0sobg17.apps.googleusercontent.com")).build();
		
		try {
			
			token = verifier.verify(oauthService.requestAccessToken(socialLoginType, code));
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			logger.info("오류 1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			logger.info("오류 2");
		} catch (Exception e) {
			logger.info("오류 3");
		}
		
		if (token != null) {
			Payload payload = token.getPayload();
			String userId = payload.getSubject();
			logger.info(userId);
		}
		
		return "home";
	}
}
