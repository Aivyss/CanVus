package com.canvus.app.service.social;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.canvus.app.helper.consants.SocialLoginType;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor // SocialOauth타입 객체들이 list 형태로 인젝션 되도록 함
public class OauthService {
	private static final Logger logger = LoggerFactory.getLogger(OauthService.class);
	
	// social Oauth
	private final List<SocialOauth> socialOauthList;


	private final HttpServletResponse response;
	
	public void request(SocialLoginType socialLoginType) {
		SocialOauth socialOauth = this.findSocialOauthByType(socialLoginType);
		String redirectURL = socialOauth.getOauthRedirectURL();
		
		try {
			response.sendRedirect(redirectURL);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String requestAccessToken(SocialLoginType socialLoginType, String code) {
		SocialOauth socialOauth = this.findSocialOauthByType(socialLoginType);
		String token = socialOauth.requestAccessToken(code);
		
		return token;
	}
	
	private SocialOauth findSocialOauthByType(SocialLoginType socialLoginType) {
		SocialOauth output = socialOauthList.stream().filter(x ->x.type() == socialLoginType)
				.findFirst()
				.orElseThrow(() -> new IllegalArgumentException("알 수 없는 소셜 로그인 형식"));
		
		return output;
	}
}
