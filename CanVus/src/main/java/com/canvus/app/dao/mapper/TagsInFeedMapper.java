package com.canvus.app.dao.mapper;

import com.canvus.app.vo.FeedComponentVO;
import com.canvus.app.vo.TagsInFeedVO;

import java.util.List;

public interface TagsInFeedMapper {

	public boolean inputTags(TagsInFeedVO tif);

	public boolean deleteTags(String feed_id);

    int feedCountReferToTag(String keyword);

	List<FeedComponentVO> getFeedIdBundleByTag(String keyword);
}
