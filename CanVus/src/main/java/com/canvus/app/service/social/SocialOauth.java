package com.canvus.app.service.social;

import com.canvus.app.helper.consants.SocialLoginType;

public interface SocialOauth {
	public String getOauthRedirectURL();
	
	public String requestAccessToken(String code);
	
	default SocialLoginType type() {
		SocialLoginType type;
		
		if (this instanceof GoogleOauth) {
			type = SocialLoginType.GOOGLE;
		} else if (this instanceof FacebookOauth) {
			type = SocialLoginType.FACEBOOK;
		} else if (this instanceof NaverOauth) {
			type = SocialLoginType.NAVER;
		} else if (this instanceof KakaoOauth) {
			type = SocialLoginType.KAKAO;
		} else {
			type = null;
		}
		
		return type;
	}
}
