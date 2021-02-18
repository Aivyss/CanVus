package com.canvus.app.dao.mapper;

import com.canvus.app.vo.FeedDrawingsVO;

import java.util.List;

public interface FeedDrawingsMapper {

	public boolean createFeedDrawingsRows(FeedDrawingsVO feedDrawings);

    List<FeedDrawingsVO> selectFeedBundle(String feed_id);
}
