package com.canvus.app.vo;

import lombok.Data;

@Data
public class UserVO {
	private String id;
	private String given_name;
	private String family_name;
	private String profile_url;
	private String email;
	private String idToken;
	private String nickname;
	private int pixel;
	private String introduction;
}
