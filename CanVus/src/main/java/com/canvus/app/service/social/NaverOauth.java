package com.canvus.app.service.social;

import org.springframework.stereotype.Component;

@Component
public class NaverOauth implements SocialOauth {
	// 차후 구현
	
	@Override
	public String getOauthRedirectURL() {
		return "";
	}

	@Override
	public String requestAccessToken(String code) {
		// TODO Auto-generated method stub
		return null;
	}

}
