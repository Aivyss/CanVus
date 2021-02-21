package com.canvus.app.dao.mapper;

import java.util.List;

import com.canvus.app.vo.UserVO;

public interface UserMapper {
	
	public boolean signup(UserVO vo);

	public List<UserVO> userSearch(String search);

	public UserVO getUserInfo(String user_id);

	public boolean withdrawPixel(UserVO sender);

	public boolean depositPixel(UserVO receiver);

    String getUserNickname(String user_id);
}
