package com.canvus.app.dao;

import com.canvus.app.vo.UserVO;

public interface userMapper {
	
	public String login(String id);
	public boolean signup(UserVO vo);

}
