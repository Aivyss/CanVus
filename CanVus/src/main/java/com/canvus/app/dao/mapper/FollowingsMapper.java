package com.canvus.app.dao.mapper;

import java.util.List;

import com.canvus.app.vo.FollowingsVO;

public interface FollowingsMapper {

	public List<FollowingsVO> getFollow(String user_id);

	public List<FollowingsVO> getFollower(String user_id);

	public int getFollowCount(String user_id);
	
	public int getFollowerCount(String user_id);

}
