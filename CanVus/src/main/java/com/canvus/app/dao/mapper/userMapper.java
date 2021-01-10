package com.canvus.app.dao.mapper;

import com.canvus.app.vo.UserVO;

public interface userMapper {
	
	public String login(String id);
	public boolean signup(UserVO vo);

}
