package com.canvus.app.vo;

import lombok.Data;

@Data
public class UserVO {
	private String user_id;
	private String nickname;
	private String sign_in_date;
	private String profile_photo;
	private String email;
	private String given_name; // first name
	private String family_name;// last name
	private int pixel;
	private int accumulatedpixels;
	private String introduction;
	private String idToken;
}
