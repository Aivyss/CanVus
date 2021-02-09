package com.canvus.app.vo;

import lombok.Data;

@Data
public class UserVO implements CanVusVOs {
	private String user_id;
	private String nickname;
	private String profile_photo;
	private String email;
	private String given_name; // first name
	private String family_name;// last name
	private String introduction;

	private String sign_in_date;
	private int pixels;
	private int accumulatedpixels;
	private String idToken;
}
