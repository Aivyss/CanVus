package com.canvus.app.dao.mapper;

import java.util.List;

import com.canvus.app.vo.FollowingsVO;

public interface FollowingsMapper {

	public List<FollowingsVO> getFollow(String id);

}
