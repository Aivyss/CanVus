package com.canvus.app.dao.mapper;

import com.canvus.app.vo.FollowingsVO;

import java.util.List;

public interface FollowingsMapper {

	public List<FollowingsVO> getFollow(String user_id);

	public List<FollowingsVO> getFollower(String user_id);

    boolean deleteFollowing(FollowingsVO fVO);

	boolean addFollowing(FollowingsVO fVO);
}
