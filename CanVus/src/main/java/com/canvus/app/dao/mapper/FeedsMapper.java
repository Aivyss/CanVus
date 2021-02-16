package com.canvus.app.dao.mapper;

import java.util.List;

import com.canvus.app.drawing.vo.FeedVO;
import org.apache.ibatis.session.RowBounds;

public interface FeedsMapper {

	public List<FeedVO> getFeedBundle(RowBounds rb, String user_id);

	public boolean createFeedTableRow(FeedVO feedVO);

	public FeedVO selectFeed(String feed_id);

	public boolean updateFeed(FeedVO feed);

}
