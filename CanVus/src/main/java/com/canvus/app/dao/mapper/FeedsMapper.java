package com.canvus.app.dao.mapper;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.canvus.app.vo.FeedVO;

public interface FeedsMapper {

	public List<FeedVO> getFeedBundle(RowBounds rb, String user_id);

	public boolean createFeedTableRow(FeedVO feedVO);

	public FeedVO selectFeed(String feed_id);

	public boolean updateFeed(FeedVO feed);

}
